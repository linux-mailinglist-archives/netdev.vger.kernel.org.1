Return-Path: <netdev+bounces-243587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 808B6CA4446
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 16:32:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EC5C53005A61
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 15:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D454228C84A;
	Thu,  4 Dec 2025 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="AIh2KbB3"
X-Original-To: netdev@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41FC246778
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764862338; cv=none; b=RCpj9aR9na44/tsQwfC1xElDw2hfvOfXLBHiLXZXVAlHMBgLL9ebPj5JTvWXI8T7Qt+y+rp8c+6pvq2gstaMIhYJ5b2WcOLfAf6gsEeiTy18O6Ro0HhfYMDIGP9zrTNK5xGp6wsiWVE+7g45fW/2A9p4oP2zHjku0WM3oekEAEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764862338; c=relaxed/simple;
	bh=8m+i5nUV7pTtuEdFNdnyYvVweDs0gkoPeTcIYTmvlf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+Nq1Wodkr+XAirbWda7DtQIDGFhG92V5GYfOlGdrfBPxremRIDhRTWHiqeJGn/a6fRd5ljtQS9sH5vAPpQ1KvP7fSzD+LC7gG1IwejaEBcXNSD2S+L+ktbx/stpX1xr2Fxq7wxwyZ+UW3roBU+0b8RQOdEhFe8HvL/0Arh2Jv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=AIh2KbB3; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wC8GBR1ROFC0xqThxULmLQu5cGeg43agkD8VDUUF9CI=; b=AIh2KbB3xtAC6Dy/36rCEv1Jyc
	zCpMMV9wGdvAI4Hcb5qq/n6BT6jGpVqtfqv2TV19pe1gNDTXcdvtL/PcP4dq07oqQ9lXi66FW5GFz
	/o7fJj908lBGvYNVQ5cDAJn9x8HM4dBwtQ3txq+P/gQzsq6dPOafXZt2X674RRXng/7BjsprmQS4p
	54Pdrrf/QmaJ9/UR8m0m1fi/Nbft60s3aGqGCnLnIOWssd8ijDzVdeY+/H80fiYjBHlVvwHpGoS+G
	Do7uxNTH/bfmMgkgy+jUejGLDVX51wl6cuEdb3alTmqyvyg2MJGi6SZ5AzQrH7rYOJZoroHM0oMyR
	Z3qfI8ow==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1vRBJJ-000000000FE-49uB;
	Thu, 04 Dec 2025 16:32:02 +0100
Date: Thu, 4 Dec 2025 16:32:01 +0100
From: Phil Sutter <phil@nwl.cc>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: =?utf-8?B?UmVuw6k=?= Rebe <rene@exactco.de>, netdev@vger.kernel.org,
	nic_swsd@realtek.com
Subject: Re: [PATCH V2] r8169: fix RTL8117 Wake-on-Lan in DASH mode
Message-ID: <aTGpceAK0CRgKDPG@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Rebe <rene@exactco.de>, netdev@vger.kernel.org,
	nic_swsd@realtek.com
References: <20251202.161642.99138760036999555.rene@exactco.de>
 <8b3098e0-8908-46cc-8565-a28e071d77eb@gmail.com>
 <20251202.184507.229081049189704462.rene@exactco.de>
 <b25d0f31-94ef-4baa-9cbb-a949494ac9a7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b25d0f31-94ef-4baa-9cbb-a949494ac9a7@gmail.com>

On Tue, Dec 02, 2025 at 07:06:02PM +0100, Heiner Kallweit wrote:
> On 12/2/2025 6:45 PM, René Rebe wrote:
> > On Tue, 2 Dec 2025 18:19:02 +0100, Heiner Kallweit <hkallweit1@gmail.com> wrote:
[...]
> >> - cc stable
> > 
> > I was under the impression this is automatic when patches are merged
> > with Fixes:, no? Do I need to manually cc stable? Nobody ever asked me
> > for that before.
> > 
> https://docs.kernel.org/process/maintainer-netdev.html
> See 1.5.7

Which points to
https://docs.kernel.org/process/stable-kernel-rules.html#stable-kernel-rules
and the Option 1 instructions read: "Note, such tagging is unnecessary
if the stable team can derive the appropriate versions from Fixes:
tags."

Cheers, Phil

