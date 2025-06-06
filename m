Return-Path: <netdev+bounces-195434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A656FAD029D
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 14:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7325017462E
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2CF2882D0;
	Fri,  6 Jun 2025 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ac6wK9My"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A159328540E
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749214439; cv=none; b=dKhH9cw2436UyiUxQD+iCZpc/SpruUT+OFrRpBL6Brw/O2WjhZOxUyyNpRYDHbkzAqBpdr2G5l6y3ZeOkmFCziYjYXdt+aq/VLdPZOWo+Cc8sj8esp0edWz0kTtiqGcta8RWKds6Kn5J587Si1Ha9Pg32oBrlofzgiPuzv9ro64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749214439; c=relaxed/simple;
	bh=yIVVHMDf6FP2eU0XzZPN8Mx8a6Blb+rDTq8sS92QW7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpT4GqeeN8yXKImmNrKfDdp3Vdcw+1WgrogU8N3G4Yjfb5x6rFvemfZBwDCJsBBZq/FyWtBaEs6cQA/yNd+gV7pmMD+rKV0WjH2yQcbdYiCgRQoY8tdnTW1kmcxFIsp6N0o0iynioxr0/bo3hM361O0zwRNNMZdc6lSeLYkJCyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ac6wK9My; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hA7gdAnGwHKHCbsP0ZiAsGUR/SDZTkF2lmVmn2RGIdE=; b=ac6wK9MyG6MM0m2AGTkuySi6sa
	1KroQJleKETrREDP6k6wqt+sjbrZCIlM9BGVSkZn0QRXpFwGhyE/yEdjvmRf3rAVrauM/TCMmiKUR
	xaXZHb+ASaFag2Jg+0PMMZ1zElriEKZ0S8rtPKleOIEE3wGU5uoRMRlDErHNmtfzmNcc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uNWZu-00Etk1-9a; Fri, 06 Jun 2025 14:53:46 +0200
Date: Fri, 6 Jun 2025 14:53:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: netdev@vger.kernel.org, linux@armlinux.org.uk, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V2] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Message-ID: <ab987609-0cc7-4051-bc51-234e254cbec0@lunn.ch>
References: <20250606022203.479864-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606022203.479864-1-macroalpha82@gmail.com>

On Thu, Jun 05, 2025 at 09:22:03PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add quirk for Potron SFP+ XGSPON ONU Stick (YV SFP+ONT-XGSPON).
> 
> This device uses pins 2 and 7 for UART communication, so disable
> TX_FAULT and LOS. Additionally as it is an embedded system in an
> SFP+ form factor provide it enough time to fully boot before we
> attempt to use it.
> 
> https://www.potrontec.com/index/index/list/cat_id/2.html#11-83
> https://pon.wiki/xgs-pon/ont/potron-technology/x-onu-sfpp/
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
> 
> Changes since V1:
>  - Call sfp_fixup_ignore_tx_fault() and sfp_fixup_ignore_los() instead
>    of setting the state_hw_mask.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You are supposed to wait 24 hours before posting a new version. We are
also in the merge window at the moment, so please post patches as RFC.

Russell asked the question, what does the SFP report about soft LOS in
its EEPROM? Does it correctly indicate it supports soft LOS? Does it
actually support soft LOS? Do we need to force on soft LOS? Maybe we
need a helper sfp_fixup_force_soft_los()?

    Andrew

---
pw-bot: cr

