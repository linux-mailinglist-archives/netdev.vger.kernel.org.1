Return-Path: <netdev+bounces-135908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BDA99FC2B
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 01:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B08285A34
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 23:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DBE1D2B34;
	Tue, 15 Oct 2024 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YRQmHPrh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A69821E3DB
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 23:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034176; cv=none; b=B9vW36PgU4BQjoCkc3ysLE166dej7JXRj3aR+Bwad/tS9++kuYXJTGrq3aaGZw6VmJ/ULFJ+2gfgqr+irU5/SwYSWOr/Kku6607nFYstxc2KgWyOQjn0NE5iocvpNpiXafPYYPXH1uKfUWcKeA4HerzOZw9vMhKyX9YwTAK0Wnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034176; c=relaxed/simple;
	bh=vk8yO4pFScpbl/Ledf0tqp1tF9D+vUch6eKqK9XMXmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0GSb6+Mq8b4CLk8jMbpnxItAi7Xpj70Cv29UxRrIz/tZuvQHBpIudSuzleznhR/HY10h1a5lY11lKkgpVDDeQqpEwJSjN+dFx9523k43ztM7/OS1gRrUve2i/z+B93207i2c9evH6LllmyM7DSHEbObSFK1sAklDnfEgqfVwCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YRQmHPrh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=pooP/T+gZMgU4Fi3d4C4lEo/4vwjjRQTNZ0ez/2oZZs=; b=YR
	QmHPrhHn1ogEMm/JXJVnj62UX/n0pGWGAvBs50gMah2lNZEqtr3n7KpbUdi+FliY3FA6IHARpSDot
	uCdlQY2giQc6w+eDg92l+uUmbGqtAd1Z2e5MqkdGHmd2BLB5SfSFygemG0YPlYyG5gOgezXZNqgGH
	Shg1GKvNvOz5NqA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t0qlu-00A5Lm-Tj; Wed, 16 Oct 2024 01:16:10 +0200
Date: Wed, 16 Oct 2024 01:16:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, idosch@nvidia.com,
	danieller@nvidia.com
Subject: Re: [RFC ethtool] ethtool: mock JSON output for --module-info
Message-ID: <816b36d3-7e12-4b58-8b99-4e477e76372c@lunn.ch>
References: <7d3b3d56-b3cf-49aa-9690-60d230903474@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d3b3d56-b3cf-49aa-9690-60d230903474@gmail.com>

> 6. vendor info is displayed as byte arrays.

> Vendor name                               : Arista Networks
> Vendor PN                                 : QDD-400G-XDR4
> Vendor SN                                 : XKT242211481

>     "vendor_name" : [65, 114, 105, 115, 116, 97, 32, 78, 101, 116, 119, 111,
> 114, 107, 115, 32],
>     "vendor_pn" : [81, 68, 68, 45, 52, 48, 48, 71, 45, 88, 68, 82, 52],
>     "vendor_sn" : [88, 75, 84, 50, 52, 50, 50, 49, 49, 52, 56, 49],

Why use byte arrays? String, maybe UTF-8, would be more natural.

	Andrew

