Return-Path: <netdev+bounces-222770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBDBB55FAC
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 10:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3365848B6
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 08:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F286E2E92BB;
	Sat, 13 Sep 2025 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oa71Jcdp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB12E88AA;
	Sat, 13 Sep 2025 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757753970; cv=none; b=QjRxqyp75e1QJntp8JoqRKc65cHuPHaAPOgLFwt9tIUr4MqG0MW1Wkz+bqAEN5fCpQqOQdAiVUyZQeRXdnvDxsWXjjVI8532oRBoDxdzYaq3gOzLQVzsL22oZGO+g29vLNK78FmuB0qtXbiT3xiK6HDv7KQTllOEX+oW3NETSMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757753970; c=relaxed/simple;
	bh=z6400tXlOaqvn/OeP2AKbKd9E6nnWARgxDGZB5IIxKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+8n1TvUwjhNd4c3/5oSHe3I6mklWQXKJD+nyVBokkxEmbs1BT4ejpEduM3fcOPRBT5zVG18AjnPvzNcrIQd5/0Rvqf/PmZFYBTzVE7Trp/UMKTQM7UpBQltW9npHGmE9nF6Xgm+mIPCZufUSjaPJAkaeniZE/mPH4rexn3Yc3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oa71Jcdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AAEEC4CEEB;
	Sat, 13 Sep 2025 08:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757753970;
	bh=z6400tXlOaqvn/OeP2AKbKd9E6nnWARgxDGZB5IIxKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oa71Jcdp1fXXtaPOTUYVKr2P5z7pG71lV04CUBBAg09RhOzdq7tkoa/Nx0f8K/EFH
	 ojM5eo9iBuTekZeMYd09CcMXhMMpYdoRl4lJFn36TSkMdq0QtD04fuD9ZVB9fen7GM
	 t7CuE8Kg/l/X6G/vpukZHJ0I4ydPKrCITY4hForiTq4mMGn6CDAHs14SbsVgoURgdi
	 Z5dTScyASMr34eehfnP8KrMJtXkIQB8J8kBDJTKBtq751rTrprQ30J9H6ryT5BnTv5
	 EmXWPvpHmUQEGGv02+k9mNE3+bMrQOa7fVulfZ0rKFcjln+366h9rqbpWGANkNzrwR
	 MRe3ehRltvpDg==
Date: Sat, 13 Sep 2025 09:59:26 +0100
From: Simon Horman <horms@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Avery Pennarun <apenwarr@worldvisions.ca>
Subject: Re: [PATCH RESEND net-next] Documentation: ARCnet: Update obsolete
 contact info
Message-ID: <20250913085926.GI224143@horms.kernel.org>
References: <20250912042252.19901-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912042252.19901-1-bagasdotme@gmail.com>

+ Avery

On Fri, Sep 12, 2025 at 11:22:52AM +0700, Bagas Sanjaya wrote:
> ARCnet docs states that inquiries on the subsystem should be emailed to
> Avery Pennarun <apenwarr@worldvisions.ca>, for whom has been in CREDITS
> since the beginning of kernel git history and the subsystem is now
> maintained by Michael Grzeschik since c38f6ac74c9980 ("MAINTAINERS: add
> arcnet and take maintainership"). In addition, there used to be a
> dedicated ARCnet mailing list but its archive at epistolary.org has been
> shut down. ARCnet discussion nowadays take place in netdev list.
> 
> Update contact information.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

I think it would be good to get buy-in from Avery (now CCed) on these changes.

> ---
>  Documentation/networking/arcnet-hardware.rst | 13 +++---
>  Documentation/networking/arcnet.rst          | 48 +++++---------------
>  2 files changed, 17 insertions(+), 44 deletions(-)
> 
> diff --git a/Documentation/networking/arcnet-hardware.rst b/Documentation/networking/arcnet-hardware.rst
> index 3bf7f99cd7bbf0..1e4484d880fe67 100644
> --- a/Documentation/networking/arcnet-hardware.rst
> +++ b/Documentation/networking/arcnet-hardware.rst
> @@ -4,6 +4,8 @@
>  ARCnet Hardware
>  ===============
>  
> +:Author: Avery Pennarun <apenwarr@worldvisions.ca>
> +
>  .. note::
>  
>     1) This file is a supplement to arcnet.txt.  Please read that for general
> @@ -13,9 +15,9 @@ ARCnet Hardware
>  
>  Because so many people (myself included) seem to have obtained ARCnet cards
>  without manuals, this file contains a quick introduction to ARCnet hardware,
> -some cabling tips, and a listing of all jumper settings I can find. Please
> -e-mail apenwarr@worldvisions.ca with any settings for your particular card,
> -or any other information you have!
> +some cabling tips, and a listing of all jumper settings I can find. If you
> +have any settings for your particular card, and/or any other information you
> +have, do not hesistate to :ref:`email to netdev <arcnet-netdev>`.

nit: hesitate

...

>  
>  
>  Introduction to ARCnet
> @@ -3226,9 +3228,6 @@ Settings for IRQ Selection (Lower Jumper Line)
>  Other Cards
>  ===========
>  
> -I have no information on other models of ARCnet cards at the moment.  Please
> -send any and all info to:
> -
> -	apenwarr@worldvisions.ca
> +I have no information on other models of ARCnet cards at the moment.
>  
>  Thanks.
> diff --git a/Documentation/networking/arcnet.rst b/Documentation/networking/arcnet.rst
> index 82fce606c0f0bc..cd43a18ad1494b 100644
> --- a/Documentation/networking/arcnet.rst
> +++ b/Documentation/networking/arcnet.rst
> @@ -4,6 +4,8 @@
>  ARCnet
>  ======
>  
> +:Author: Avery Pennarun <apenwarr@worldvisions.ca>
> +
>  .. note::
>  
>     See also arcnet-hardware.txt in this directory for jumper-setting
> @@ -30,18 +32,7 @@ Come on, be a sport!  Send me a success report!
>  
>  (hey, that was even better than my original poem... this is getting bad!)
>  
> -
> -.. warning::
> -
> -   If you don't e-mail me about your success/failure soon, I may be forced to
> -   start SINGING.  And we don't want that, do we?
> -
> -   (You know, it might be argued that I'm pushing this point a little too much.
> -   If you think so, why not flame me in a quick little e-mail?  Please also
> -   include the type of card(s) you're using, software, size of network, and
> -   whether it's working or not.)
> -
> -   My e-mail address is: apenwarr@worldvisions.ca
> +----
>  
>  These are the ARCnet drivers for Linux.
>  
> @@ -59,23 +50,14 @@ ARCnet 2.10 ALPHA, Tomasz's all-new-and-improved RFC1051 support has been
>  included and seems to be working fine!
>  
>  
> +.. _arcnet-netdev:
> +
>  Where do I discuss these drivers?
>  ---------------------------------
>  
> -Tomasz has been so kind as to set up a new and improved mailing list.
> -Subscribe by sending a message with the BODY "subscribe linux-arcnet YOUR
> -REAL NAME" to listserv@tichy.ch.uj.edu.pl.  Then, to submit messages to the
> -list, mail to linux-arcnet@tichy.ch.uj.edu.pl.
> -
> -There are archives of the mailing list at:
> -
> -	http://epistolary.org/mailman/listinfo.cgi/arcnet
> -
> -The people on linux-net@vger.kernel.org (now defunct, replaced by
> -netdev@vger.kernel.org) have also been known to be very helpful, especially
> -when we're talking about ALPHA Linux kernels that may or may not work right
> -in the first place.
> -
> +ARCnet discussions take place on netdev. Simply send your email to
> +netdev@vger.kernel.org and make sure to Cc: maintainer listed in
> +"ARCNET NETWORK LAYER" heading of Documentation/process/maintainers.rst.
>  
>  Other Drivers and Info
>  ----------------------
> @@ -523,17 +505,9 @@ can set up your network then:
>  It works: what now?
>  -------------------
>  
> -Send mail describing your setup, preferably including driver version, kernel
> -version, ARCnet card model, CPU type, number of systems on your network, and
> -list of software in use to me at the following address:
> -
> -	apenwarr@worldvisions.ca
> -
> -I do send (sometimes automated) replies to all messages I receive.  My email
> -can be weird (and also usually gets forwarded all over the place along the
> -way to me), so if you don't get a reply within a reasonable time, please
> -resend.
> -
> +Send mail following :ref:`arcnet-netdev`. Describe your setup, preferably
> +including driver version, kernel version, ARCnet card model, CPU type, number
> +of systems on your network, and list of software in use.
>  
>  It doesn't work: what now?
>  --------------------------
> 
> base-commit: 2f186dd5585c3afb415df80e52f71af16c9d3655
> -- 
> An old man doll... just what I always wanted! - Clara
> 

