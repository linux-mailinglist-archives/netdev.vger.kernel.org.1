Return-Path: <netdev+bounces-73603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D2085D582
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49B11C21169
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 10:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9C63DB97;
	Wed, 21 Feb 2024 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc35IEzy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0033B3DB89;
	Wed, 21 Feb 2024 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511337; cv=none; b=Zlbgvco5fRSdq6mSbOkpCnqzL+H+nLoqFQ0KYD+XDn65IW8OF+yg/bOLY0AtjpQKTW6gwizGVKyBeNI3LqpcMZfIvhlAj5CCx9AJy3SP1VvLHBggBbD6UD/jZU1gdaeEqqvbwrZNoeWWd5EMILkH5fchBQkjHDUcBUbeCA834rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511337; c=relaxed/simple;
	bh=bm8u3iY6apdYKRPco8f0Nqv9EVlR63UHDnzkoz1yF1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5ptmHwiPo++aWh4nMGB6mTVDN5tiH+hBFE0Q/FhnFa6vCVQa///vka2sE8cGXCt3pK1TKSEMvYPIWs3KlF81AkPl6mrF3UEl7q4pVnO+MZJtMShFcX0YrDtpms171Yexh6vnJWCq/jhgZ0HTILjHn6n7vZ+LbsB4vOcVVrmJJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc35IEzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54EFC43390;
	Wed, 21 Feb 2024 10:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708511336;
	bh=bm8u3iY6apdYKRPco8f0Nqv9EVlR63UHDnzkoz1yF1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lc35IEzyuobZxeZsjUNEzNQrHDqnOznMP+hUeZWXxQEKxj2NiOKeaQStwwLOW9oSZ
	 GhjZ3wFVTd7CMEjyXU7qgnaqWw2j+wDWJUI7Vxstd4VtThzts68zAmgVIl6tWWRU1I
	 0HKaWvo7q/ZPCUKTvPV/gyfPTeo/X9fwJAU8o+//Rv9wo6yD96YCwS3VHs4f8Ax7b/
	 +qzXuC1tWvRLgYabMF5H48suClus9mAINrjd8bn+shErQKu2frfTGy9Ruvc85QTqwr
	 Cj63MOFxT5MwvSb3XMgibxqhgAIlGUQHpVWkF61Dwd6h9fFraBn3aBL9vN/+tY+R5M
	 3nF62OYp9W7RA==
Date: Wed, 21 Feb 2024 10:28:51 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v4 3/9] net: qlogic: qede: Use linkmode helpers
 for EEE
Message-ID: <20240221102851.GA352018@kernel.org>
References: <20240218-keee-u32-cleanup-v4-0-71f13b7c3e60@lunn.ch>
 <20240218-keee-u32-cleanup-v4-3-71f13b7c3e60@lunn.ch>
 <20240220124405.GB40273@kernel.org>
 <a52361ef-66ab-41bd-b245-ccd26fcbd957@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a52361ef-66ab-41bd-b245-ccd26fcbd957@lunn.ch>

On Tue, Feb 20, 2024 at 03:45:28PM +0100, Andrew Lunn wrote:
> > > +	unsupp = linkmode_andnot(tmp, edata->advertised, supported);
> > 
> > nit: Given the types involved, I might have written this as:
> > 
> > 	unsupp = !!linkmode_andnot(tmp, edata->advertised, supported);
> 
> linkmode_andnot() calls bitmap_andnot():
> 
> static inline bool bitmap_andnot(unsigned long *dst, const unsigned long *src1,
> 			const unsigned long *src2, unsigned int nbits)
> 
> It already returns a bool, so there is no need to force an int to bool
> conversion using !!.

Good point, sorry for missing that.
I assume there is a reason that the return type of
linkmode_andnot is not bool.

