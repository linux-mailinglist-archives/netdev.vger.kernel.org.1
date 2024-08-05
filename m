Return-Path: <netdev+bounces-115608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045B89472E2
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 03:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C581F210CA
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 01:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE08B5589B;
	Mon,  5 Aug 2024 01:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cjVUFEEe"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5512B9D4;
	Mon,  5 Aug 2024 01:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722820255; cv=none; b=hhTNxmKLQ5dbavHWMhnHTxCWnFz7960apYc9ztJ2qygQRkjb3yg5RlxgJXS17jDk5fronk8C4G+1he0ZEpIiUct+1kqE9jKglF+INQ7Rpd92DaroYGMetLeZxklcACjkgLKdxaX95c0GTbxYfOmpNeSpgWETEkzV947pWraMU6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722820255; c=relaxed/simple;
	bh=Ntytnd3LjnnSWdcMbN61cNqRWuC4RpkfoypY5EK7dDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUdPesWQraPfvdmzpx9eGYg0a7GgDFoin/qSH9uaBOjSY2PwddFSJIDv2G+nPfLpdicWH9/sn2TLLS48Z3SrHzqMWNyDl36jlJmDmuNmuprQzuCEMvRh2DzNSylUiNKHFvE1v0xBJRiJM8gOBXVQsLmyUIasu/zObwm/LjKSfE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cjVUFEEe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0TelagZdMac9NaG9bZqYHLjxFGgrFK4T4W00FD9MX9E=; b=cjVUFEEeLWDeZdx2G1rpvm1i3z
	zXJzIIi+np3VDjZ7E4Tk7y8N+M+4Xzt483zfRqTwVUuAshei8gfqBaOPwsDvfCA1MpDWtXyEW6nrJ
	Y6u/rPu3HmafRfom5427n4kE+BJvz6wECfdPrXQvDcF/t64knmYlYnO7O7kl4Mb9bq/8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1samFO-004047-ES; Mon, 05 Aug 2024 03:10:50 +0200
Date: Mon, 5 Aug 2024 03:10:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, aliceryhl@google.com
Subject: Re: [PATCH net-next v3 0/6] net: phy: add Applied Micro QT2025 PHY
 driver
Message-ID: <174bf437-5adf-4ebf-b909-036d6443dcf5@lunn.ch>
References: <20240804233835.223460-1-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804233835.223460-1-fujita.tomonori@gmail.com>

On Mon, Aug 05, 2024 at 08:38:29AM +0900, FUJITA Tomonori wrote:
> This patchset adds a PHY driver for Applied Micro Circuits Corporation
> QT2025.
> 
> The first patch adds Rust equivalent to include/linux/sizes.h, makes
> code more readable. The 2-5th patches update the PHYLIB Rust bindings.
> 
> QT2025 PHY support was implemented as a part of an Ethernet driver for
> Tehuti Networks TN40xx chips. Multiple vendors (DLink, Asus, Edimax,
> QNAP, etc) developed adapters based on TN40xx chips. Tehuti Networks
> went out of business and the driver wasn't merged into mainline. But
> it's still distributed with some of the hardware (and also available
> on some vendor sites).
> 
> The original driver handles multiple PHY hardware (AMCC QT2025, TI
> TLK10232, Aqrate AQR105, and Marvell MV88X3120, MV88X3310, and
> MV88E2010). I divided the original driver into MAC and PHY drivers and
> implemented a QT2025 PHY driver in Rust.
> 
> The MAC driver for Tehuti Networks TN40xx chips was already merged in
> 6.11-rc1. The MAC and this PHY drivers have been tested with Edimax
> EN-9320SFP+ 10G network adapter.

Sorry about being slow reviewing this. I will get to it by the middle
of the week.

	Andrew

