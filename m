Return-Path: <netdev+bounces-198769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3263ADDB57
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 20:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D30667A8285
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F452EBBB7;
	Tue, 17 Jun 2025 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGzs0c9z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2F82EBB90;
	Tue, 17 Jun 2025 18:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750185089; cv=none; b=na/a1W6i1QpKRzjapW3MAKE+Nh9Nimb7ZvG9MUMco7zexQD9jouGSXdU5fi627ANWoeB2H4QKCBy678kH6EiZqOKHMVuTU55sKDWUuEO4m0wan/+kDwrZnq+n7U6wzksi+U50WUSCc857+DcFYEGyd/N+AVJEeNuT62qFph+6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750185089; c=relaxed/simple;
	bh=XPD0E6xQgTVH4IjnsmJ69h+bHt2lmoQrqOhiXIJh0lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEwiJwr+pp/SDFOg3CYWfzyyXheZKwOQ2KCJfnkMhB6B0g98+SpCPMcol5hSsdekGIJOyJ7tCOpP89yLEtrINGKAvqmkkwf/2LtC3APdFRENApzSBU+Z7emrtJKZy4czOgEHalYYJ8Z//j/rEvbp566CVYFKoAD1v62bWM5ouKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGzs0c9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAB0C4CEE3;
	Tue, 17 Jun 2025 18:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750185089;
	bh=XPD0E6xQgTVH4IjnsmJ69h+bHt2lmoQrqOhiXIJh0lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGzs0c9zcn8nIQ04zNDLudS0oQ1e7abWV+d2fLy4Lb4213uYypwIOg3rBd4iu2D2c
	 qo5k3v+YOwSZ5AAO5qYdoRcvPBOW10DmPb1ZrH/qA0An1IkJYtkxZ0lr9XH6FOXjQ4
	 XiQIyuRCgQbTg3JPOv010FSL+2nx7bS3V+DcsrMwFiFj97ohDAbTA0GagBEe5iygUy
	 SUsS8DwATC0Ew1NUGwPZ6otGRb9XgMQYTbolhWWVk+zrzaybPa7NLce165NaZoERQm
	 HwLMRCa899had9//Q0JTHjX9y1RgVUZV9gawy/AjaEvC2bQsw5LEhRJ3Yj+VZWyEWU
	 d3eb6qaaaaLaA==
Date: Tue, 17 Jun 2025 19:31:24 +0100
From: Simon Horman <horms@kernel.org>
To: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-doc@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, skhan@linuxfoundation.com,
	jacob.e.keller@intel.com, alok.a.tiwari@oracle.com
Subject: Re: [PATCH v2 1/2] docs: net: sysctl documentation cleanup
Message-ID: <20250617183124.GC2545@horms.kernel.org>
References: <20250614225324.82810-1-abdelrahmanfekry375@gmail.com>
 <20250614225324.82810-2-abdelrahmanfekry375@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614225324.82810-2-abdelrahmanfekry375@gmail.com>

On Sun, Jun 15, 2025 at 01:53:23AM +0300, Abdelrahman Fekry wrote:
> I noticed that some boolean parameters have missing default values
> (enabled/disabled) in the documentation so i checked the initialization
> functions to get their default values, also there was some inconsistency
> in the representation. During the process , i stumbled upon a typo in
> cipso_rbm_struct_valid instead of cipso_rbm_struct_valid.

Please consider using the imperative mood in patch discriptions.

As per [*] please denote the target tree for Networking patches.
In this case net-next seems appropriate.

  [PATCH net-next v3 1/2] ...

[*] https://docs.kernel.org/process/maintainer-netdev.html

And please make sure the patches apply cleanly, without fuzz, on
top of the target tree: this series seems to apply cleanly neither
on net or net-next.

The text below, up to (but not including your Signed-off-by line)
doesn't belong in the patch description. If you wish to include
notes or commentary of this nature then please do so below the
scissors ("---"). But I think the brief summary you already
have there is sufficient in this case - we can follow
the link to v1 for more information.

> 
> Thanks for the review.
> 
> On Thu, 12 Jun 2025, Jacob Keller wrote:
> > Would it make sense to use "0 (disabled)" and "1 (enabled)" with
> > parenthesis for consistency with the default value?
> 
> Used as suggested.
> 
> On Fri, 13 Jun 2025, ALOK TIWARI wrote:
> > for consistency
> > remove extra space before colon
> > Default: 1 (enabled)
> 
> Fixed. 
> 
> On Sat, 14 Jun 2025 10:46:29 -0700, Jakub Kicinski wrote:
> > You need to repost the entire series. Make sure you read:
> > https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
> > before you do.
> 
> Reposted the entire series, Thanks for you patiency.
> 
> Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
> ---
> v2:
> - Deleted space before colon for consistency
> - Standardized more boolean representation (0/1 with enabled/disabled)
> 
> v1: https://lore.kernel.org/all/20250612162954.55843-2-abdelrahmanfekry375@gmail.com/
> - Fixed typo in cipso_rbm_struct_valid
> - Added missing default value declarations
> - Standardized boolean representation (0/1 with enabled/disabled)
>  Documentation/networking/ip-sysctl.rst | 47 ++++++++++++++++++++------
>  1 file changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
> index 0f1251cce314..68778532faa5 100644
> --- a/Documentation/networking/ip-sysctl.rst
> +++ b/Documentation/networking/ip-sysctl.rst
> @@ -8,14 +8,16 @@ IP Sysctl
>  ==============================
>  
>  ip_forward - BOOLEAN
> -	- 0 - disabled (default)
> -	- not 0 - enabled
> +	- 0 (disabled)
> +	- not 0 (enabled)
>  
>  	Forward Packets between interfaces.
>  
>  	This variable is special, its change resets all configuration
>  	parameters to their default state (RFC1122 for hosts, RFC1812
>  	for routers)
> +
> +	Default: 0 (disabled)
>  
>  ip_default_ttl - INTEGER
>  	Default value of TTL field (Time To Live) for outgoing (but not
> @@ -75,7 +77,7 @@ fwmark_reflect - BOOLEAN
>  	If unset, these packets have a fwmark of zero. If set, they have the
>  	fwmark of the packet they are replying to.

Maybe it would be more consistent to describe this in terms
of enabled / disabled rather than set / unset.

>  
> -	Default: 0
> +	Default: 0 (disabled)
>  
>  fib_multipath_use_neigh - BOOLEAN
>  	Use status of existing neighbor entry when determining nexthop for
> @@ -368,7 +370,7 @@ tcp_autocorking - BOOLEAN
>  	queue. Applications can still use TCP_CORK for optimal behavior
>  	when they know how/when to uncork their sockets.
>  
> -	Default : 1
> +	Default: 1 (enabled)

For consistency, would it make sense to document the possible values here.

>  
>  tcp_available_congestion_control - STRING
>  	Shows the available congestion control choices that are registered.
> @@ -407,6 +409,12 @@ tcp_congestion_control - STRING
>  
>  tcp_dsack - BOOLEAN
>  	Allows TCP to send "duplicate" SACKs.
> +
> +	Possible values:
> +		- 0 (disabled)
> +		- 1 (enabled)

In the case of ip_forward, the possible values are not explicitly named
as such and appear at the top of the documentation for the parameter.

Here they are explicitly named possible values and appear below the
description of the parameter, but before documentation of the Default.
Elsewhere, e.g. ip_forward_use_pmtu, they appear after the documentation of
the Default. And sometimes, e.g. ip_default_ttl, the possible values are
documented at all.

Likewise, indentation and use of blank lines seems inconsistent.

Is there a value in cleaning this up too?

> +
> +	Default: 1 (enabled)
>  

...

-- 
pw-bot: changes-requested

