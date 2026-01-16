Return-Path: <netdev+bounces-250559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F41BD330F9
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 16:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09B5C30DA59C
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 14:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F94F3939C8;
	Fri, 16 Jan 2026 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ArjrMqz3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF5B3939A4
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768575394; cv=none; b=CobZqGtNlf3KVGjPPOHTk6ZCGVRtXBMeXoZvLvxjAgvpdXJb5PTv2BR1E5v7NZjys2+3bMV5PtnkKiX5uPppwL2okgmqUfnR2eXbxP5zXcbOyvEaBmD9H3a20OO4+x/Hcu+brjRZZldi7/yEbCCeDDCKHrO0WVlvkyg4R//KaWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768575394; c=relaxed/simple;
	bh=G2zYjLC+mWaIMiyFjt+xCWDABJry12gRl+3sQM7aBXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EB/JnIOhYzQVhXNgbu8jVHs4BCJs12xVY5GVb+EoHZpD+s1mIHl4OAD+FTRpKpZbaz3RopAKRZXBQdEEjbjXS6LzlrQ4+yINCzDikUzVtZ5rppECcw6CQDM8xpDUyA61Bw4lU02PN+BUmuqG2QNRVPSm49NY+DG40Cm4AQGAQ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ArjrMqz3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pZaLSwjBwhLnjVfyHqGWYgJq1s9ZezkgbaJ0D//rO7k=; b=ArjrMqz35azQ2qpmNcwP+uxvJ8
	rB+XyOY1s7Su4+jHnldErB3tvWHZYek6P/t44UyjjrU7jHCnffBf7zbPubnJtuvMwgOWDck7NyQ0E
	SfsjR9iN2+auvk4U3e+hzLwCEJ1YHTdzZGWhjg3FVQU1AVQLFCQ2X00kFf04NB9qyIJQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vglFP-0035QU-SK; Fri, 16 Jan 2026 15:56:23 +0100
Date: Fri, 16 Jan 2026 15:56:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: sayantan nandy <sayantann11@gmail.com>
Cc: Benjamin Larsson <benjamin.larsson@genexis.eu>, lorenzo@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	sayantan.nandy@airoha.com, bread.hsu@airoha.com,
	kuldeep.malik@airoha.com, aniket.negi@airoha.com,
	rajeev.kumar@airoha.com
Subject: Re: [PATCH] net: airoha_eth: increase max mtu to 9220 for DSA jumbo
 frames
Message-ID: <fc018e11-3957-4b2e-88a8-777057091923@lunn.ch>
References: <20260115084837.52307-1-sayantann11@gmail.com>
 <e86cea28-1495-4b1a-83f1-3b0f1899b85f@lunn.ch>
 <c69e5d8d-5f2b-41f5-a8e9-8f34f383f60c@genexis.eu>
 <ce42ade7-acd9-4e6f-8e22-bf7b34261ad9@lunn.ch>
 <aded81ea-2fca-4e5b-a3a1-011ec036b26b@genexis.eu>
 <f0683837-73cd-4478-9f00-044875a0da75@lunn.ch>
 <CADJVu8XP_wBudwOrT1OLhcZ3-9Qoci8FQzw+yyxnogiC2Asx5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADJVu8XP_wBudwOrT1OLhcZ3-9Qoci8FQzw+yyxnogiC2Asx5w@mail.gmail.com>

On Fri, Jan 16, 2026 at 08:09:51PM +0530, sayantan nandy wrote:
> Hi all,
> 
> Thanks for the review and comments.
> 
> I checked the AN7581 HW and it does support MTU sizes up to 16K. However, as
> mentioned by Benjamin, larger packets consume more DMA descriptors, and while
> no extra buffers are allocated, this can put pressure on the descriptor rings.

Does the hardware consume DMA descriptors for the full 16K, not just
the number of descriptors needed for the actual received packet size?
That seems like a bad design.

      Andrew

