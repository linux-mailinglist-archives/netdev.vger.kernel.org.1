Return-Path: <netdev+bounces-138386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFC99AD425
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 20:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE241F221D8
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 18:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1BC1D1F69;
	Wed, 23 Oct 2024 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5XlZ2kY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED41D1F50;
	Wed, 23 Oct 2024 18:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708937; cv=none; b=aiiUpk0rqxZWzaABLzgYDQAQTQO0+rqhLekQ/qfZoE/ln3IxZKnGCy9+nBBMf3m1VS61VUD1Mbpm/bEnD5enlXuWXtmCAw8Il9Moqadf0dG4LhJ6lLzobRjoPYyxEzhWcrGUqAvFDek03KJtmZAprtCK5QqYls24k+H5Qtgdd8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708937; c=relaxed/simple;
	bh=g9jeU1utYRcRbcLKMIBvO3gTlDKM3cDHrA4mbhO74dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLDlRhfVs11jkgqURt4YkPcBbtYyNVu2sSqNaz52RRymLOcJtMksuYBojmxlq3zhWVfgyRHLpi6bMY8tshIlbC+BVYc+sl6KjzQhqbvxKifHrYHMwl2w4NSYkyiP9HErw4sKJZjMIY8hPk9JAvbGZpBpD6XZJk55Z+V8Yt11DSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5XlZ2kY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41188C4CEC6;
	Wed, 23 Oct 2024 18:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729708936;
	bh=g9jeU1utYRcRbcLKMIBvO3gTlDKM3cDHrA4mbhO74dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l5XlZ2kYZwRBllH7L/Ewz6G3u2jfnMHP2YrzoJtiFvOzzjYaRImrzVbKaYYw6huoQ
	 Ny87E8ZXjufZBnFR3XY68wHaxJ40GJ9YrjlFewndSViMDrZDcq884t6zBynXzKLuOl
	 R453FcVd4Ayl/amrZvMWXw1zx9fBw1I+B9tfHohz63iVn9ZEHTvZYV8Cl3NTXgVMR7
	 w//wj7xfzCJXNgKHN2YIizkAp3Mvvb4T00Fxqqoxz48k/Zw7OsM5XVtJlDAp77tR2D
	 EfgFUUbvHucGjhBavGP+hCSKvm2Bfz/cYbh8lz+gKTQdlNSyvr62+LQkzevH25hoyT
	 XBTWo9fmbEjZQ==
Date: Wed, 23 Oct 2024 19:42:11 +0100
From: Simon Horman <horms@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:" <llvm@lists.linux.dev>
Subject: Re: [PATCH net-next v2 1/2] net: systemport: Remove unused txchk
 accessors
Message-ID: <20241023184211.GA402847@kernel.org>
References: <20241021174935.57658-1-florian.fainelli@broadcom.com>
 <20241021174935.57658-2-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021174935.57658-2-florian.fainelli@broadcom.com>

On Mon, Oct 21, 2024 at 10:49:34AM -0700, Florian Fainelli wrote:
> Vladimir reported the following warning with clang-16 and W=1:
> 
> warning: unused function 'txchk_readl' [-Wunused-function]
> BCM_SYSPORT_IO_MACRO(txchk, SYS_PORT_TXCHK_OFFSET);
> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> 
> warning: unused function 'txchk_writel' [-Wunused-function]
> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> 
> warning: unused function 'tbuf_readl' [-Wunused-function]
> BCM_SYSPORT_IO_MACRO(tbuf, SYS_PORT_TBUF_OFFSET);
> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> 
> warning: unused function 'tbuf_writel' [-Wunused-function]
> note: expanded from macro 'BCM_SYSPORT_IO_MACRO'
> 
> The TXCHK and RBUF blocks are not being accessed, remove the IO macros
> used to access those blocks. No functional impact.
> 
> Reported-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>

