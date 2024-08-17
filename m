Return-Path: <netdev+bounces-119437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5FD955954
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 20:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3879F1F21AF8
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 18:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D22824AF;
	Sat, 17 Aug 2024 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vk/Y/hUw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D4E22334;
	Sat, 17 Aug 2024 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723920713; cv=none; b=VNuQj4d3nmD5VYH20bgfgBEwMs3vPltxXgWIKtJMLiJ2z3jGSC2BmEAUiJ50tDkbZ2WAQBd1cQDCabG/ONcNH7SSXU2QVOznIkFVvV927JBA2KXwYBkRY3YnD4Vxygei/xGmKgOMj8TwSyJIbJA91b/3Tf2+z90jbk01PtCkqDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723920713; c=relaxed/simple;
	bh=c/SbaZ8x8OsMfuRgKNON1OgcMSSUgW2l1+MSWww3kSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNFPqH39KdWeZzNLJiNw3XZ00n/zYmeo/7xNNJbMlLrsG2a6tsmOECN+WXj6A1vnEasEutaHfcKPEsun5vnSBdQu/lgjQRTZRXsmqcyU/mEB1fa8YefusZhVjFCZa5qOK7itjcfOF0nnhMHbjWI80zoqwJoB39XV5XW/3Aj/Ao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vk/Y/hUw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lNNG0WXTN4gYKN+1wnKPmHN9YnLnyg65WgzItrIJeMs=; b=vk/Y/hUw91D1LFP8pXyEdCx0Fq
	VtTCgvJMEX0wMansNupAk25gPenHXbjEUkOrirj4DzwOH3Ck99gyvbsBgqI7MLqFd4hnhfGHnmzyh
	CYH2RQI0TrXrk6JI8GEUy7by+h9BGxxrz1kYNVE6RblX341gzmf3EO25GEjB2XUG5Exo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sfOWj-0050fz-BL; Sat, 17 Aug 2024 20:51:49 +0200
Date: Sat, 17 Aug 2024 20:51:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com,
	benno.lossin@proton.me, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 6/6] net: phy: add Applied Micro QT2025 PHY
 driver
Message-ID: <9a7c687a-29a9-4a1a-ad69-39ce7edad371@lunn.ch>
References: <20240817051939.77735-1-fujita.tomonori@gmail.com>
 <20240817051939.77735-7-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240817051939.77735-7-fujita.tomonori@gmail.com>

> +    fn read_status(dev: &mut phy::Device) -> Result<u16> {
> +        dev.genphy_read_status::<C45>()
> +    }

Probably a dumb Rust question. Shouldn't this have a ? at the end? It
can return a negative error code.

	Andrew

