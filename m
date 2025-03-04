Return-Path: <netdev+bounces-171792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C99A4EC98
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 20:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E77A68E5949
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 18:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8171E23A9AE;
	Tue,  4 Mar 2025 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rHGP8AcQ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761351EDA1F
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110908; cv=none; b=aKrwatzPPEIfHU9myfkf5jThykAEagqg98T85m+9ZmBAqOk8sJa2z4GwHRcsAcm6rnXHLjhe6blok5x0KY5LmY9XbhJ522Eu6osZ1MKrU15GhF8Wv2xxIq7pbQceOi+YHSKVmaXfKqutRMXyKnJDq6g706aTOiiszPypCq/qnMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110908; c=relaxed/simple;
	bh=NgDm4NxUNuE897VJ4AT9FDgBqi+ZeWV07xVHrY8yzxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgVP/hDHVQV0nNhBNO0UyEV1b+uGfJlXAPNhPuWJnwewrFHwpwiDc0L5at/RmDOC4GMTqzMlza/TcfRSk1pXczqtIPzlov5kNEWs96I/MHduLW6csVkG7L0ngwPeMDGbMnQgYxDeyr6QaNpEDrLNzJ7SxnYnUf6XtXhBkjBfqRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rHGP8AcQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VnChm/5rDEpIFBvHJjQaqI3SSXHc3Ggh87mPlEmLtDs=; b=rHGP8AcQAF0tkRS5DLM02BTYEF
	LQ/FWmLWlLnQnd4VHnScgP3U85HbUzYGB92+dhuMsI6h6Oe/Lt/8ZHW8K5FA/bn145nzGIx2a7/r2
	9hFeQ3aMVqEEnq3wnTfOzF2ADZ1pA1DVxaqYhTFyhHKL+QfwnRhS2CN3WwrqXD6jj3uk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tpWTu-002DcL-Ky; Tue, 04 Mar 2025 18:55:02 +0100
Date: Tue, 4 Mar 2025 18:55:02 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Max Schulze <max.schulze@online.de>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, hfdevel@gmx.net,
	netdev@vger.kernel.org
Subject: Re: tn40xx / qt2025: cannot load firmware, error -2
Message-ID: <9aede328-4050-4505-83a5-c0eeb67d1fc5@lunn.ch>
References: <5f649558-b6a0-4562-b8e5-713cb8138d9a@online.de>
 <20250304.214223.562994455289524982.fujita.tomonori@gmail.com>
 <89515e61-6aeb-4063-bc47-52a9ea982a26@lunn.ch>
 <b2296450-74bb-4812-ac1a-6939ef869741@online.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2296450-74bb-4812-ac1a-6939ef869741@online.de>

> Shouldn't ethtool -m report something?

> > $ sudo ethtool -m enp3s0
> > netlink error: Operation not supported

That ethtool op is missing, along with a lot more, in order to get
full support of the hardware. 

> Does it really only support 10GBe, and not 1GBe or 100BaseSX ?
> > $ sudo ethtool enp3s0
> > Settings for enp3s0:
> > 	Supported ports: [  ]
> > 	Supported link modes:   10000baseSR/Full
> > 	Supported pause frame use: No
> > 	Supports auto-negotiation: No
> > 	Supported FEC modes: Not reported
> > 	Advertised link modes:  10000baseSR/Full
> > 	Advertised pause frame use: No
> > 	Advertised auto-negotiation: No
> > 	Advertised FEC modes: Not reported
> > 	Speed: 10000Mb/s
> > 	Duplex: Full
> > 	Auto-negotiation: off
> > 	Port: Twisted Pair
> > 	PHYAD: 1
> > 	Transceiver: external
> > 	MDI-X: Unknown
> > 	Link detected: yes

From my reading of the PHY datasheet, it can do 1000Base-KX, but there
is no mention of 100BaseSX. There is also limited access to the i2c
eeprom in the SFP, so ethtool -m could be implemented.

       Andrew

