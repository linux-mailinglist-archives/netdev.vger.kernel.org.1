Return-Path: <netdev+bounces-97839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B8A8CD730
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 17:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2EBC1C21B43
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 15:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A374611711;
	Thu, 23 May 2024 15:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SGe5+DXX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C0125C1
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478547; cv=none; b=UpSgMm8TMZ/PEswHSbjS3XO/Twxxv6pG5VnB6mYjF0a+hUthVzRPFOdkvAtC8QvnYWvMCBFCBjlTx8FPTTjSfyFBNNPA7gYF+oKSJUErllpnAMQwsBGthvhTvayYGO5IAaCFKCdvStafO8+gzDRDaa5qnYbr5+CGuDycET3yFIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478547; c=relaxed/simple;
	bh=0AygUOOfb7Jmkd09bgF12TrFzYdmLy1WVQlgpNnZmjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTgp5b9deGeHJskpeTOeg+a85bH4V2JJ56LUXEfj0tuFugZnEq3diu5QorBqMslLqd5CKw0Eyvfq4lIfaW3KFJ1yEsM7Hm63eNSVbJVxaHapuAEOnTj70x3k8YNGOpnDLfPlI02abA21zV1theXp3dwLI1flyhjqhYz6KmpzcWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SGe5+DXX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=w9KG2jwfUz29bQgrc0zfowgb4vcxljBfubkOWGE3Y74=; b=SGe5+DXXN6DyksybK9D9inDvTw
	wtJzaGB8eSbl2pbBnU3SB6frau3fJAr7O/cJgG+xMiceL3C4aUue/qf98YHpDlO+plrvQRbOnP/iB
	6Q7Ip9+B/alLdlUfsgLQ+xZh6dIPlXPFVpTUVKCJhdc+U3kmPYYoqik0+ht820hZ/e2s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sAATl-00Fu39-0k; Thu, 23 May 2024 17:35:41 +0200
Date: Thu, 23 May 2024 17:35:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>
Cc: Ido Schimmel <idosch@nvidia.com>, Michal Kubecek <mkubecek@suse.cz>,
	Moshe Shemesh <moshe@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	tariqt@nvidia.com
Subject: Re: "netlink error: Invalid argument" with ethtool-5.13+ on recent
 kernels due to "ethtool: Add netlink handler for getmodule (-m)" -
 25b64c66f58d3df0ad7272dda91c3ab06fe7a303, also no SFP-DOM support via
 netlink?
Message-ID: <de8f9536-7a00-43b2-8020-44d5370b722c@lunn.ch>
References: <9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl>
 <apfg6yonp66gp4z6sdzrfin7tdyctfomhahhitqmcipuxkewpw@gmr5xlybvfsf>
 <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
 <7nz6fvq6aaclh3xoazgqzw3kzc7vgmsufzyu4slsqhjht7dlpl@qyu63otcswga>
 <3d6364f3-a5c6-4c96-b958-0036da349754@ans.pl>
 <0d65385b-a59d-4dd0-a351-2c66a11068f8@lunn.ch>
 <c3726cb7-6eff-43c6-a7d4-1e931d48151f@ans.pl>
 <Zk2vfmI7qnBMxABo@shredder>
 <f9cec087-d3e1-4d06-b645-47429316feb7@lunn.ch>
 <1bee73de-d4c3-456d-8cee-f76eee7194b0@ans.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bee73de-d4c3-456d-8cee-f76eee7194b0@ans.pl>

> > Before you do that, please could you work on ethtool. I would say it
> > has a bug. It has been provided with 256 bytes of SPF data. It should
> > be able to decode that and print it in human readable format. So the
> > EINVAL should not be considered fatal to decoding.
> 
> Yes, I was also thinking this way. Luckily, similar to the situation with the mlx4 driver, all the logic is there - sff8636_dom_parse() checks if map->page_03h is set and if not, just returns gracefully.
> 
> So, all we need to do is modify sff8636_memory_map_init_pages():
> @@ -1038,7 +1039,7 @@
>         sff8636_request_init(&request, 0x3, SFF8636_PAGE_SIZE);
>         ret = nl_get_eeprom_page(ctx, &request);
>         if (ret < 0)
> -               return ret;
> +               return 0;
>         map->page_03h = request.data - SFF8636_PAGE_SIZE;

Nice. Please submit a patch.

I see there is a discussion about if there should be a warning here or
not. The problem we have is that some NICs offload getting data from
the SFP to firmware, and the firmware does not support more than
getting the first page. The IOCTL API returned whatever the was
available, and ethtool would decode what it was given. With the change
to the newer API, ethtool can ask for any page. Those devices using
limited firmware cannot fulfil the request, and are going to return an
error, either -EOPNOTSUPP, or maybe -EINVAL. We don't want ethtool to
regress, so being silent is probably the correct thing to do.

It does however hide bugs in drivers, but we can maybe find them via
testing. It would be nice to have CI/CD test which runs ethtool using
both the IOCTL interface and the netlink and compares the output. The
IOCTL output should be a subset of the netlink output. In this case,
it clearly is not a subset.

> Finally, as I was looking at the code in fallback_set_params() I started thinking if the length check is actually correct?
> 
> I think instead of:
>  if (offset >= modinfo->eeprom_len)
> we may want:
>  if (offset + length > modinfo->eeprom_len)
> 

> I don't know if it is safe to assume we always read a single page
> and cross page reads are not allowed and even if so, that we should
> rely on this instead of checking the len explicitly? What do you
> think?

Cross page reads are not allowed by the netlink API. SFPs do funny
things when you do a cross page read. I forget the details, but it is
something like it wraps around within the same 1/2 page. However, SFPs
vendors like to ignore the standard, don't feel they need to conform
to it, and i would not be surprised if some do continue the read in
the next page because that is simpler, or they could not be bothered
to read the standard in detail. By defining the API to not allow cross
page reads, or even cross 1/2 page reads, we avoid this mess. This
validation should happen at a higher level, where the netlink
parameters are validated for the call.

You can probably test this:

       ethtool -m|--dump-module-eeprom|--module-info devname [raw on|off]
              [hex on|off] [offset N] [length N]

You probably need hex on, and then can then set offset and length and
see if the validation works.

    Andrew

