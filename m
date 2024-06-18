Return-Path: <netdev+bounces-104328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6A890C2EC
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 06:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC238282BB2
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 04:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5ED847A;
	Tue, 18 Jun 2024 04:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="fUwcSHOR"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2F753A9;
	Tue, 18 Jun 2024 04:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718686094; cv=none; b=BuOlaGVtWi0LkU/dCMFKv3P3sdkcwryQ3NRLf/tKd5laaSnJ7ss710ekJmuxogVL4sGMN76BL/BMElNCnWtddeT+Ab+M24ysEb2ed4F6mec3WPt1muAti93U4kBLJdEbO5YEjsGfXxWL/pn/2qbgilfm0rfTOqcQGWiHQgX26fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718686094; c=relaxed/simple;
	bh=zmvDLkScg73a7Uy+pTBMt27bcXzj/6hEZbBD/5EAv9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BO5DXTtRzwehmYDSd+7twD8GyVsjIIRpZadqmYdzZhTXrARc7KMXjOFHZDX6VboN33rdjdkmTQi3RNw4Oaj+M8HUcpCnSJ089gZ/u63vUsuT0GGtRiDgGy0UVE9Zg0nsGYUk7/HM+aMdekPRudBbNxJ02OOIRBdBNWWkz9xA5UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=fUwcSHOR; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 60A05C0002;
	Tue, 18 Jun 2024 04:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1718686090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7eoG87lpKHygI/hoj/AcOkMNGo9t/VxMJbEW0DRK/g=;
	b=fUwcSHORmHty6Dm5gHlhI4nkyC50zcXGuZhVE6qise2i7+ptZ7H3xU7U3CF3Osv4Ptp+JZ
	0NkkZ6aU4F7tVZ5kutiYhJUAunMO3fTqry1ukSTISwjVMrLIr+6pkv6oZEfX65EFeZM8AW
	UBEUDxVytLb8qUDj+skoV/a2zPsa8g3Rp3MgBhdlXxWm/HKt8TdvDHGtAVX110HLxRjCTm
	69iPUqjdbvYwkSyi0uWC5Uy/RO5NMdYTWm8/5noPbcEf8IrlxZvXTEZJuxvZFcV7Y07FMi
	KwtA+nmr/QCV4wOequ3tg7DAgmSncmy+GyTV75KwoPMYneq+4TzhlaKqfvvlfg==
Message-ID: <555b23dc-e054-426b-a26b-6313f260064f@arinc9.com>
Date: Tue, 18 Jun 2024 07:48:02 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mt7530: factor out bridge
 join/leave logic
To: Matthias Schiffer <mschiffer@universe-factory.net>,
 Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <378bc964b49f9e9954336e99009932ac22bfe172.1718603656.git.mschiffer@universe-factory.net>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <378bc964b49f9e9954336e99009932ac22bfe172.1718603656.git.mschiffer@universe-factory.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 17/06/2024 21.30, Matthias Schiffer wrote:
> As preparation for implementing bridge port isolation, move the logic to
> add and remove bits in the port matrix into a new helper
> mt7530_update_port_member(), which is called from
> mt7530_port_bridge_join() and mt7530_port_bridge_leave().
> 
> No functional change intended.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>

I see that my review of the previous version of this patch was completely
ignored. Why?

Arınç

