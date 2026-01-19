Return-Path: <netdev+bounces-251201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0CDD3B461
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 152E3305B5B1
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 17:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB0432936F;
	Mon, 19 Jan 2026 17:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNN+NuuS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE0C246782;
	Mon, 19 Jan 2026 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768843967; cv=none; b=iohSJMGF+VffazIsbbRgBPROjwLeH1QCSaMjhDaHxJU4/4yLhMmxU4OpzmVDimqVcjhWYDgmQU1hx9y/dxPUbTT9hsmciGKg3lrNkuW4kROwfxU9FUrFF+qLIS61nFOXvTMt4k1ZUh09VVjTWMPpqKSl/Y/MCnFlQmZMGnBvkSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768843967; c=relaxed/simple;
	bh=MzgYz2ei5YMI3c3oVwoXo7ns5PaAQ6jk5W9GQyBetvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcPw6/V2KfB0IBAkvEd9EPLfWhz0xuCu50+PGQZEysoP7WDUusQwXfqDfHY5W67ezIFoN+Ged5gafuakoX1pzKhfIyPmDTy7vzqKU0590HDR1zYJvQGnArYz/EpPpsn9vB5OnAA1BnYGEYFOkjfij1lgT7cF/bMO9BV4EpsM5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNN+NuuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D639C116C6;
	Mon, 19 Jan 2026 17:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768843966;
	bh=MzgYz2ei5YMI3c3oVwoXo7ns5PaAQ6jk5W9GQyBetvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gNN+NuuSGkr3B8IGo0N0iqWCQOjVVKoPVnCE04Y0pliehP5Sd1H13WALyuHNqdVRH
	 jEHniJE0YD2RyhVfbQGJXldxeUhVGj5Xzz7aMxvqyhWwCAPLjG7UXC67oGf5Tptluq
	 ypc+Rjb0JcWqBxNvwNXscl1O8avJl+H6L9rQdg9ml2WqIHxLDKuPOtMQZwCmLp1Qj3
	 +qrk9nXEbJlE5w7g80qqdg577JX2YuAD7Zc5KGRe7ECXtot2iy6cOE2CRpPCwj5iYE
	 sw7iedYMLvVmwM37GtOILTgudxfkA6NicqqMZpOEQjUpw8/UUBEaDB/vkcF8M/T/d0
	 wG7PG/VWcRXnw==
Date: Mon, 19 Jan 2026 09:32:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [net-next,v4,05/13] octeontx2-af: npc: cn20k: Allocate default
 MCAM indexes
Message-ID: <20260119093245.0544f5ce@kernel.org>
In-Reply-To: <aW2oKKg73zwRNals@rkannoth-OptiPlex-7090>
References: <20260113101658.4144610-6-rkannoth@marvell.com>
	<20260118004024.1044368-1-kuba@kernel.org>
	<aW2oKKg73zwRNals@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 09:12:32 +0530 Ratheesh Kannoth wrote:
> > > -	if (attach->nixlf)
> > > +	if (attach->nixlf) {
> > >  		rvu_attach_block(rvu, pcifunc, BLKTYPE_NIX, 1, attach);
> > > +		if (is_cn20k(rvu->pdev)) {
> > > +			err = npc_cn20k_dft_rules_alloc(rvu, pcifunc);
> > > +			if (err)
> > > +				goto exit;  
> >                         ^^^^
> >
> > When npc_cn20k_dft_rules_alloc() fails after rvu_attach_block() has
> > already attached the NIX LF, the error path jumps to exit without
> > detaching NIX. The caller (otx2_init_rsrc in otx2_pf.c) assumes that on
> > error nothing was attached, so it does not call otx2_detach_resources().
> >
> > Could this leave NIX LF attached without proper cleanup on allocation
> > failure?  
> There is no proper error handling done for rvu_attach_block function (in existing code)
> We can address this later as different patch ?

Different patch, yes, but _before_ these patches are merged.

