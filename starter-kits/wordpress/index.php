<?php get_header(); ?>

<main>
	<?php
	if ( have_posts() ) :
		/* Start the Loop */
		while ( have_posts() ) :
			the_post(); ?>

		<article <?php post_class(); ?>>
			<header>
				<h1><?php the_title(); ?></h1>
			</header>
			<div>
				<?php the_content(); ?>
			</div>
		</article>

	<?php
		endwhile;
	else :
	?>
	<h2>No posts found.</h2>
	<?php
	endif;
	?>
</main>

<?php get_footer(); ?>