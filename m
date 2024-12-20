Return-Path: <netdev+bounces-153751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8DF9F9905
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 19:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2378D166D26
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 18:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C793621CA16;
	Fri, 20 Dec 2024 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b="Fct8SPxt"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633E31A072C
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716954; cv=none; b=Clw2BE50Ckl7P2ct8h+IcrsqdC4fZZIs6O09eJ50Y/buysDDoOxtYKCXT1OkdWr/Qn8+hfvsKdGgW2lnyFlTp1qJt+hP06Z04WW0CMhF9DavG4YfZqQrcDBkclbolWGZwewoqvelL+laI3kM45PZSNRQMjisbY9RHBSbk2aZ0EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716954; c=relaxed/simple;
	bh=K98m4zNVDyefaUndlyrdmPvP/H/yy8VIJo96tE8aN4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWNf/5WPGmmhbbvpVEY9fi1uE35Hp9e4IV3FylqLvwLEf8ogQKtOy0+CT/+79hCu7jsBHP57WaaPRiQW08+8Cbiz/ldCdG7LV7J8tZ7fGKWN+FeRuRpftUARLbeEQNZqkaeVRzZMVAoMjmLpJusc3Qs6NFZGs/lhk+dVzDgQM2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=hfdevel@gmx.net header.b=Fct8SPxt; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1734716937; x=1735321737; i=hfdevel@gmx.net;
	bh=BfpnPC7fwmJTYpjs9IeXrw+VryP9Nb4v+CbGXMc5rLU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Fct8SPxtYDblX79tN9PzhhZL1s2aM8ifxNAYDvPzP5LH5QeWPJT4ztGnmqm6PQ4k
	 OVO5GvFjrHvCm7fXf+dB9Ewj+UZ+qaMve5dhjeJHQqjmdiSCpcBdqDbLFwR0OTRKA
	 nnrGko8TlgiOwZlA0r5F4CffDB6rzaKSjYThCwq6h48O0WNWWeKUeyYk7/9u2Tn7U
	 8Vm18yc0HxktlPExdHBxMHmhDXHSsIbtocWAjtGIs2nctzoXjJCXJhRpnj/FlCl9v
	 mevtaXlIEhi+R56BnRWcnFOTIy7n9Z4AL51kk04HhpIBF86YlQslIoVJozzRIdbDy
	 vaOnRCjMhc0FSP0nhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.0.0.23] ([77.33.175.99]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1tLdf423Y7-003leY; Fri, 20
 Dec 2024 18:48:57 +0100
Message-ID: <33fbefb0-8b4f-4429-95a9-180b658e7914@gmx.net>
Date: Fri, 20 Dec 2024 18:48:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/7] net: tn40xx: create software node for
 mdio and phy and add to mdiobus
To: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 devnull+hfdevel.gmx.net@kernel.org
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
References: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
 <20241217-tn9510-v3a-v3-5-4d5ef6f686e0@gmx.net>
 <20241220.102408.968249477814979263.fujita.tomonori@gmail.com>
Content-Language: en-US
From: Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <20241220.102408.968249477814979263.fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ldY01dgDoqWK4UPsCu2oy6Coh/VN1bdudPeB/q2/2VEtF91+bM8
 vbmtpOhG96y1UqBcfyyYj1Z0KKNo6PgqHdtO5HOQotLr2ShOODwt61SzYQhZSmNKLF0kdZi
 c3AFl0CtQG/IylyII7PHcGjBLe8ttqZkrIQaXpc25de2XU19yDUq9MjFNqRGVEhh74KwwRq
 vL1LHBCTwmxnYwP6M7nkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:blC1Tby4kNE=;+KPcuAJta7MHqgrZpi7qVPUlU5r
 DfQVE3YPGXuXx4yVXCgwYMp9t815ga/kmfBvp7/u6639FsTx6fHz4cTpAmDwik9g8zAxQc9nw
 np+xNeERPqwYzRjv6d5+RIz9+wjU7LF5/O51cEZ2pkeJq4H348CDclFEtNjkfGT4xqn49+6Vx
 dpDvFnyCRK5TAPCQIk1A/0H0mb59EKjt7vgyAEPc46BOnncthXaHBCeE2N+WcjBjW1p5hqtI0
 Do0nMumPuUv0G5fXWzGqR2hHLo6lhRW69r0RXchWnws29iNAm1ngrUh9OD4DQ4CXicqB8rUUO
 O48/HT+U2gmWeAk5eLjdEdsx94P35oOWxyTl5j9vwlbBbSg5wna271uAzHLf2p+ZNoC6DIlC4
 JpiCUvme4se+ykucXaivFLAvz6V69Zejwz0T82nYbsiL0duEdG2gTSMTtA8k4+ybOBpm58hzw
 UVZkroiuO01DwO+y+erwKqhd/BjKqySd3vV6qXMiAE6Ro+kUS5LXkYEZWUYkEuAxy0jJJxx34
 mugnjremNfhxJlpMDZK5PfuqKMwETDqA/vIgnljuzDLhL0rd8E3oawA1BSrvIjl0ppJstRj9K
 v1+PNRbr0oT0zo0iXtlKXVt1Kr76hh84THFJma69zApuLYBPUwoIA+cn5eUxyQS0XILg7lhWC
 wXJecTuM9wvqmpC74YX30gdhpM8vnrM5OJkXrlU4yVSe2WJ+qdLV6L8bznnrasoDBfmjC/jCq
 Oe8u/Xnqvo8dGewcZ72kl8B3OOWEPDsm8Eq1gAkj/KWeof2NNv5dfn2168xH39g1IlyS/RVqL
 pSqFW0vPSOtNv8xUZjGKjntEh7a6wEgQ9m4ri7BWNLmzHG6z15kvr08e3yvAEXErmnhqKYVJf
 oP6ea6Q1B5VRfujocqgaIuymzlCwkuOdhNJUnlLCDjBfPnAYOfTS62zTsJNBPsa0qNpfMwRtf
 yxTy1lW/xA8EegZHwIs7j9ST7YsIeeHjaIg8+6Qg/HpYYOA5+JiTl7BXb6lvNrIZty93KVzQi
 LEX9P7abE/V3A45dsoyghY3FsXWAwkQplKQIrgyz3jNaHtN8aIbS9/bO6AWIyC8ydEOzttTye
 d/IW+PfjVBpgXjfi4MYnsBgoj2pRKO

On 20.12.2024 02.24, FUJITA Tomonori wrote:
> On Tue, 17 Dec 2024 22:07:36 +0100
> Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org> wrote:
>
>> From: Hans-Frieder Vogt <hfdevel@gmx.net>
>>
>> Create a software node for the mdio function, with a child node for the
>> Aquantia AQR105 PHY, providing a firmware-name (and a bit more, which may
>> be used for future checks) to allow the PHY to load a MAC specific
>> firmware from the file system.
>>
>> The name of the PHY software node follows the naming convention suggested
>> in the patch for the mdiobus_scan function (in the same patch series).
>>
>> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
>> ---
>>   drivers/net/ethernet/tehuti/tn40.c      | 10 ++++-
>>   drivers/net/ethernet/tehuti/tn40.h      | 30 +++++++++++++++
>>   drivers/net/ethernet/tehuti/tn40_mdio.c | 65 ++++++++++++++++++++++++++++++++-
>>   3 files changed, 103 insertions(+), 2 deletions(-)
> Boards with QT2025 also creates a software node for AQR105 PHY?
Yes, that's the idea. Of course, creation of the software node could be made
dependent on the actual device, but creating it unconditionally just makes
things a bit easier.
Would you rather prefer to have the software node only created for a device
that is likely to need it?

