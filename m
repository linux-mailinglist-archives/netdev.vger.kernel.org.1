Return-Path: <netdev+bounces-231969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 513D8BFF1A9
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 06:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 025644E9683
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 04:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7FB1F237A;
	Thu, 23 Oct 2025 04:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zQ2aQK7U"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2201DC988;
	Thu, 23 Oct 2025 04:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761193309; cv=none; b=JLexPdmDTUPNOkOXsMuqchMHYkx8mCUrqq7Cm67GLfgnk7OYtleHFSV0uLg8XDaUcCQhGPGlAEJTZgbg1kf01cbnDEZo4uBR2KScFlSeo8l9ZNhZlAR3xPp11HNhPynB3jLwoKJuf7aJWSvqchjWj63KqH/AmbD2sem+0CNbX5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761193309; c=relaxed/simple;
	bh=I+V1PV1nFcf5G5qvTCXwdQDHsU6tuO5vkHbPQsEDqXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHRZqewU1LPJHaRA5EMR4g0W4oKnCRWGNTnYZ5UzZUc4FKUi+jPvu0KdneSd0irKJTau833wfBjF8A2wldwaaX5EOlXxKBOdVwu+7IJomyeiSiq8fc8E8TuhVkUvwWYohTqwJpYst87xqunHaV/fbduvsTGbmJp7hdEjwT0dbk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zQ2aQK7U; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=qx4CnZyDfgJy/JD9bUk+6VpnrWuN374ZeMjrNMFRnFE=; b=zQ2aQK7UDx81uE1XYfQ9SylUUv
	GTFyX6k9wwzkEm5w1BLUpsF2L7H9AGJj8VSGZxFPfJAN933IcYn+X4mN9AKZ3ssDdG2elVLBzrc/E
	JsVZk7XDjNHeiB1uvn9NBYhAOWM+VoPsftNRjreZnwEsAyYlBI9N1dLDXYASIVdQUowQa33RrUwb5
	ClQQlqa3jlNIaiMGvwewiVBxSx7QDEg07vX45nf5MGKLrQauEPHXLJsI0tI01/UWWpJVv5QwMaroE
	5j6I/ndu4Zo+SEuiIdiSOrN9YSuGl1jD4veJcrvzFA1VS7dg8H2tkpyngXPBSEqVlbckNQJqOcd0X
	rJCsUtbw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBmpc-000000051k8-2BB5;
	Thu, 23 Oct 2025 04:21:44 +0000
Message-ID: <295b96fd-4ece-4e11-be1c-9d92d93b94b7@infradead.org>
Date: Wed, 22 Oct 2025 21:21:43 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] Documentation: ARCnet: Update obsolete
 contact info
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 Avery Pennarun <apenwarr@worldvisions.ca>
References: <20251023025506.23779-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251023025506.23779-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/22/25 7:55 PM, Bagas Sanjaya wrote:
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

The patch LGTM and causes no errors/warnings.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

I'm wondering about one thing in arcnet-hardware.rst:
  it refers to www.arcnet.com.
Did you happen to try that web site?
Looks like it is something about AIoT.
I found the ARCnet Trade Association at
  www.arcnet.cc

> ---
> Changes since v1 [1]:
> 
>   - s/hesistate/hesitate/ (Simon)
> 
> netdev maintainers: Since there is no reply from Avery on v1, can this patch
> be acked and merged into net-next?
> 
> [1]: https://lore.kernel.org/linux-doc/20250912042252.19901-1-bagasdotme@gmail.com/
> 
>  Documentation/networking/arcnet-hardware.rst | 13 +++---
>  Documentation/networking/arcnet.rst          | 48 +++++---------------
>  2 files changed, 17 insertions(+), 44 deletions(-)
> 
> diff --git a/Documentation/networking/arcnet-hardware.rst b/Documentation/networking/arcnet-hardware.rst
> index 3bf7f99cd7bbf0..e75346f112920a 100644
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
> +have, do not hesitate to :ref:`email to netdev <arcnet-netdev>`.
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
> base-commit: 26ab9830beabda863766be4a79dc590c7645f4d9

-- 
~Randy

