Return-Path: <netdev+bounces-249847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3AAD1F363
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 14:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C27A0300BFA6
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B44A273D66;
	Wed, 14 Jan 2026 13:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZXn7Weuy"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BBB272813;
	Wed, 14 Jan 2026 13:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768398829; cv=none; b=msyEJ6C32xGf7Od/UTRx5fe0x+aWGQ0UWuPpdzxl/aPFHHeUT7EMtrM6oFUBayGqXx7BDjZeqM3BXEM6Fz0gc4JDt7vW5tLABULaehqhrDE9B3kjodivZ4ysFa3KTTQM1I5Z1s6lWgBW9F43t4g57H41kMBqreJWuL+p7n/MdaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768398829; c=relaxed/simple;
	bh=XPgmQyvI6cGFc0WvyO6vnUWgEW5PVdDqqSEkZIMJkzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuiOIT/0c0tL4/dyVzuTQpaGnGtob8swLNtxiJCJjuEMiLQZbFL5oKu/8EYf+0BWgMO5l8d99FUruBso1z8Mr32huEtsSM+TlBXKpEdk1szpxnWQtAfzoq8vG5Dwe6mK09ktkvEB5swdDJgCppD3ciu0fRiI8eniwoN2z8opbiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZXn7Weuy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1CeDCz/Y0MEmYK7qDLwuxLdvYD4nuNk7xBPi5LXz0MM=; b=ZXn7WeuyfvxWsGbV2eleBjtLJ7
	ZlsxdVHk+pwn29WKvYfDRyZrwCfY8dDoqz0xFBiPfJW9nVpsFNLLf2lEbMWBcafwuf7XA7IKca92B
	emLB52RDEEDEaT3y/FhmpNkElxOYoZO9K/7T3tSFWRmNqr6B+5Tveg/H/dYl4lzVomEY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vg1Jc-002nbg-Ir; Wed, 14 Jan 2026 14:53:40 +0100
Date: Wed, 14 Jan 2026 14:53:40 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] net: dsa: yt921x: Use u64_stats_t for
 MIB stats
Message-ID: <aea64441-9e8b-4a1d-bd7e-cd09148451dc@lunn.ch>
References: <20260114114745.213252-1-mmyangfl@gmail.com>
 <20260114114745.213252-3-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114114745.213252-3-mmyangfl@gmail.com>

> @@ -690,7 +689,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
>  			break;
>  
>  		if (desc->size <= 1) {
> -			u64 old_val = *valp;
> +			u64 old_val = u64_stats_read(&((u64_stats_t *)mib)[i]);

You do seem to like using casts, despite review comments saying they
should be avoided. Look at other users of u64_stats_read(). How many
have casts? Please see if you can get the types correct so this cast
is not needed.

> -	if (res)
> +	if (res) {
>  		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
>  			port, res);
> -	return res;
> +		return res;
> +	}

This is logically a different change. Please put it into a patch of
its own. You want lots of small patches, with good commit messages,
which are obviously correct.

    Andrew

---
pw-bot: cr

