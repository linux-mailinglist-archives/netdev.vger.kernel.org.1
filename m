Return-Path: <netdev+bounces-246418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B883CEBACE
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 10:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25FAF3005BAE
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 09:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18A8224B05;
	Wed, 31 Dec 2025 09:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="OhZAcd7+"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406FA21D3E8
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172655; cv=none; b=H+UeHaTIlQ9x2P5vaBy+mh4N/L7RnG2jFTKcyNJ8Qe7x2/VIcSoIDIauWTi2PABSH02+RidRM4baqmDs1S9dPCJjyh5cTwAWf1GIgxpZzhYjabZ8/XMx+Jo2q2PwXqo1pD+6MB2tQ7m9EjhmIwXknta9M+rdao4mjzf47sqAZVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172655; c=relaxed/simple;
	bh=okXhNQRx/FlyAs70DcZf8I+MwoaWVyhUj4mI2G66yo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkOYmE6/B76SnXWp+TNvlttSt5HKhxel9YnWPK4ePB5QTHQorfog+8spWJNUx4mEXw2QsZUe5JPQM524b9D4FucmVEZ68JHbMUs2WADZN2SMQut+yUZGd8F1HBxsL//gV8yCqpC2CBEH2GV4jc017SkTBPpcfZ6tCVM9xoH4tGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=OhZAcd7+; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PyZhZJMtkwb7uKlxPnE81Q7jkLhzBPwv8RQT64xh0ZU=; b=OhZAcd7++1VrHLCuokUVtqdw0A
	wXM9Rbhx1lfPCkYHgWn35wwPyNF5rIkhJbWiaFk/0pkFmK/UKXoTm1XARnY+uUhI/+HEoOuyvSwEq
	U9sLiVNFCtd7Q7UcjekJn30OpVS9Wb+U/XkGRUGbPqkQ/oinOCymwwfEgVApXEkkOB+A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vasKf-000wJh-9w; Wed, 31 Dec 2025 10:17:29 +0100
Date: Wed, 31 Dec 2025 10:17:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com,
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net
Subject: Re: [PATCH net-next 0/2] tls: Add TLS 1.3 hardware offload support
Message-ID: <58a92263-47cb-4920-82eb-2400005b0335@lunn.ch>
References: <20251230224137.3600355-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230224137.3600355-1-rjethwani@purestorage.com>

> Tested on the following hardware:
> - Broadcom BCM957608 (Thor 2)
> - Mellanox ConnectX-6 Dx (Crypto Enabled)
> 
> Both TX and RX hardware offload verified working with:
> - TLS 1.3 AES-GCM-128
> - TLS 1.3 AES-GCM-256

You don't patch any broadcom driver. Does that mean it just works? The
changes to the core are all that are needed for BCM957608?

    Andrew

