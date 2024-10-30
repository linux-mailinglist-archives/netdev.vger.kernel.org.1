Return-Path: <netdev+bounces-140211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6F59B58C1
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 01:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3271C20912
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFF31805A;
	Wed, 30 Oct 2024 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RVl53WKT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C21C36
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 00:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248940; cv=none; b=nPxEBrUOVYjOVgBOFKdy7/TZHLtQ/AGgOi6QDaVkp/qqeozsP64iDHx61sPArTgB4dookVgEuskqCaUh3xm2Y5JMU9iGlZrxgeUJPnf7EqZVcjzFF/MiG/nkvqGJuKIQbG42iVpMBBHAsuZNgQFf9GNZIBTvs17eRr/6vBEgolE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248940; c=relaxed/simple;
	bh=70u4lv9P6bKA2axZeb4kV7nyQXUv8q9L774LPJMcKW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juZDrnqetDrlglgGoFAyXOPZ3IcngcrePQgYvDxcI3clHrIuQ9U/zD4TggA6X2UsdkUM6yzUhl+7tHtZchWvEDqKQeQRzyRR5K6kRp/adVTs17rR+zWCvaW0Kv05/dDmZhveIcCKI4siY4wYmzDs4o4cwlZPKLcZpgVNAkjPkvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RVl53WKT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Eu1JT7R5G4H8Gh94zMKiVyDcb1e3KKgezwrPPSG4tIg=; b=RVl53WKTaz3GEEQerLytVa4MIJ
	VZAuUMpPAgS2kbwb9o722vAB2qs1NFdz478rDJuIl9cmcm3NUZS47/Q6e4c/ay3VIIBdZ/Bh7MIJu
	wZbRdtOosMR9iu/UzBmMOKk7wxCojsLgrbJfMLRG12+6iAp+H0KqKj0rnWSIcDibD/qI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t5wms-00BduL-Ri; Wed, 30 Oct 2024 01:42:14 +0100
Date: Wed, 30 Oct 2024 01:42:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 09/12] net: homa: create homa_outgoing.c
Message-ID: <55bc21b1-2f37-4ade-8233-b30a9e0274c7@lunn.ch>
References: <20241028213541.1529-1-ouster@cs.stanford.edu>
 <20241028213541.1529-10-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028213541.1529-10-ouster@cs.stanford.edu>

> +/**
> + * homa_check_nic_queue() - This function is invoked before passing a packet
> + * to the NIC for transmission. It serves two purposes. First, it maintains
> + * an estimate of the NIC queue length. Second, it indicates to the caller
> + * whether the NIC queue is so full that no new packets should be queued
> + * (Homa's SRPT depends on keeping the NIC queue short).
> + * @homa:     Overall data about the Homa protocol implementation.
> + * @skb:      Packet that is about to be transmitted.
> + * @force:    True means this packet is going to be transmitted
> + *            regardless of the queue length.
> + * Return:    Nonzero is returned if either the NIC queue length is
> + *            acceptably short or @force was specified. 0 means that the
> + *            NIC queue is at capacity or beyond, so the caller should delay
> + *            the transmission of @skb. If nonzero is returned, then the
> + *            queue estimate is updated to reflect the transmission of @skb.

You might want to look into BQL. What you have here i assume only
takes into account homa traffic. BQL, being in the NIC itself, will
tell you about all other traffic as well.

	Andrew

