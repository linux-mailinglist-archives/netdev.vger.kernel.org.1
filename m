Return-Path: <netdev+bounces-228744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A777FBD3879
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 16:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 502894F341F
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 14:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACE5268C42;
	Mon, 13 Oct 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SRzXEQWu"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC58A24A044
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760365896; cv=none; b=rR9ll13eBm7BtviCZ9HII/8cRG+ttctcBj48zEwIMtVZK9srA9f1u+6i4B9IdVAxOnXJZYEJRZpzlF2E4A+EYhEeKJfIme1dD23mXHBz7sQFzPoTFZs/iqBYdRN6FWuJBdW4kFa7izhWn6EKXjo+rN5UlFBrDOFDvHtfhOEC0bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760365896; c=relaxed/simple;
	bh=aQ1c98XzivlAObmVlDQknLGiHR9pCq3YGTOQGSuDWhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UndGXvOgqrFId1S8P8HMFt8VLa4nR/qqDSJLeKXlbKgAf/IxtaA4AyS0zX6R7E43F/3iA+7AGqeNnh/Rkpffvf2TBpQ/L3jrB7oEBRcGEKbTSlPET+gfOr8WejzX/wnTJDHp7i0H++i9MVzGKpJtTBFBhmXqSkSqQjD2wtRCTAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SRzXEQWu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D15F54E41064;
	Mon, 13 Oct 2025 14:31:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9EE1D606C6;
	Mon, 13 Oct 2025 14:31:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A18B102F226E;
	Mon, 13 Oct 2025 16:31:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760365891; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=QeXIbWW6PvkJg/zzCSvtGFpwQ/L35gN1j/tUzRFnQUg=;
	b=SRzXEQWuZJ2KdcMLcPYOCkQinK+SFfNWtvJjc6khBaxZUgMYj0mN+8fk/4/EzYu+bHaYyR
	VPXx8oHYZz7zkmC1g5TZ7aJ6/3ZQqa0iscBJzl0c8/NGgXrt0u59FjZt9syBht5hNi6uju
	dqFaRgMmcN7I6tG6gvAcx+ysRrHbHwbaVxjKzkPjjc1bUxvbksE2zJjp18lFCYDOdsDD2F
	xNhchEgMwKPU+KKXz1F8H7f6qWHgdqZhTwLGbVS8cspLgErr4uNbT+37udjtUShSHtbU8V
	suRrsY7flooTXai/T/pqFLhjrpDP+1YSrpEFZgccJH8iYb8OTsH0eY3C4y60vg==
Message-ID: <e4dbb9e0-4447-485a-8b64-911c6a3d0a29@bootlin.com>
Date: Mon, 13 Oct 2025 16:31:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: mdio: reset PHY before attempting to access
 registers in fwnode_mdiobus_register_phy
To: Buday Csaba <buday.csaba@prolan.hu>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013135557.62949-1-buday.csaba@prolan.hu>
 <20251013135557.62949-2-buday.csaba@prolan.hu>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251013135557.62949-2-buday.csaba@prolan.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 13/10/2025 15:55, Buday Csaba wrote:
> When the ID of an ethernet PHY is not provided by the 'compatible'
> string in the device tree, its actual ID is read via the MDIO bus.
> For some PHYs this could be unsafe, since a hard reset may be
> necessary to safely access the MDIO registers.
> This patch makes it possible to hard-reset an ethernet PHY before
> attempting to read the ID, via a new device tree property, called:
> `reset-phy-before-probe`.
> 
> There were previous attempts to implement such functionality, I
> tried to collect a few of these (see links).
> 
> Link: https://lore.kernel.org/lkml/1499346330-12166-2-git-send-email-richard.leitner@skidata.com/
> Link: https://lore.kernel.org/all/20230405-net-next-topic-net-phy-reset-v1-0-7e5329f08002@pengutronix.de/
> Link: https://lore.kernel.org/netdev/20250709133222.48802-4-buday.csaba@prolan.hu/
> Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>

This should probably be accompanied by a DT binding update,
with some justification that this is indeed HW description
and not OS confguration.

At least the use of the term "probe" in the property makes this
sound like OS configuration, maybe something like :
  "phy-id-needs-reset" ?

Maxime


