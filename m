Return-Path: <netdev+bounces-136317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D6A9A1513
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 23:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ED8BB24E84
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 21:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF1E1D2B39;
	Wed, 16 Oct 2024 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5TCosLKZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1821D2B1A;
	Wed, 16 Oct 2024 21:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115015; cv=none; b=Jo4FPFZRo07jYcozm3t+WRHf71xY2JMQ0YbsDD9KpMkeYzqu3P5FemrgZPHrUOWy7qycGbs7yaqMxZlzJCv3IwqWwPBmerAC2RlSDtZ9hQJNx/G4TatFiUezf1/ogZZn+LfAWxE0pX66grJw3CEcOUVuxActnfjkTIO8LK0SQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115015; c=relaxed/simple;
	bh=bH7qOTz2Vtn5WPBGUjm3xNk7i0lblsv+Dbj6Rl7u19k=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fawYPanBqkCrjaN6yWNpm5dY5FZQuPaR+TT7UspCqTxBrjLYcucuG8+Fq/0+DhDNWTSYPmyKHiVIF68GxqwIU/i9STRaDE70zFZxJzyjbzVUz5e4khiLchMBlVuv+UdRmZZJh6Ie5etK5MgnyhKSNFsz8CuObAZgt020++GiSmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5TCosLKZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TzUbIZ5MRR7xOv1V+9M4ay/12qz3H9aVPGhSUPM+3Wc=; b=5TCosLKZwsZHny66He7U7Z+vlr
	3ItOH1Uog3IbfbpmgYhioCKubrSw1LRY2Xl5GJd5paoikRqSqbFnTSDLvCKdeVOnDbLNKLXu6nj0p
	Y6f54Ym9Fu15sPytQLrqMpn77dARYc6jmGwxyDHh8jRCUD2RNKdmCVOpZoW4gr6ydHqo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1Bnn-00ABw1-U5; Wed, 16 Oct 2024 23:43:31 +0200
Date: Wed, 16 Oct 2024 23:43:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: micrel ksz8081 RMII phy and clause-22 broadcast
Message-ID: <8bbe2e1a-3ff0-4cf2-8d46-5f806f112925@lunn.ch>
References: <20241016-kissing-baffle-da66ca25d14a@thorsis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-kissing-baffle-da66ca25d14a@thorsis.com>

> Would be happy if anyone could suggest a path forward here?

The hardware is different, so have a different dts file. You can then
list the PHY at is real address, which will stop the phantom broadcast
address PHY being created, and use a phy-handle to point to the real
PHYs, so when the phantom broadcast PHY is disabled, it does not
matter.

I would say that listing multiple PHYS is just an opportunistic hack,
which might work for simple cases, but soon leads to difficulties as
the situation gets complex.

	Andrew

