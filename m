Return-Path: <netdev+bounces-87602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C6D8A3BA5
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 10:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66731C20A17
	for <lists+netdev@lfdr.de>; Sat, 13 Apr 2024 08:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170B4366;
	Sat, 13 Apr 2024 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="njRiwiJz"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7E7F9D4
	for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712997199; cv=none; b=sHI/HomMtAT/GrV22Cmc3JgyCFORdd/aHdkTbSEdI9AzlLG7qzje0FzaTzUzJltLAkSAgLbOtWzC2IzMdpIURtsMkKO5tlPgtlpqiA5i7FU/ZG/mFd1HNvV1cVf0O3wc3pkx/KIvD+QzQOXJgrSbrDK8mjNsPSiKk/lPXQuWeIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712997199; c=relaxed/simple;
	bh=u+r12a7J/I1mBukQY3MjzZzkhNPoRzHT+4g9jviAb/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=feP0I8xepy4hNk1QGQ0fhjEcGbYmkVGtIJSWfo+ttcwlfYaBUuyRLvvRocU5Ly6gQBDjn+KAYGaaIG8QfYuw9MvqRlJcRWAJ3Xl22zwoTWNXZB0jZL2u7bzxbb9pp4meMVaEcm8THFmfAEh8Rcygajf0d1wNH/ven0AimzuKhE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=njRiwiJz; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7D19820005;
	Sat, 13 Apr 2024 08:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1712997188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMuDWobyhc6cTTfs7M8U5paRYn4OZERBL5XjyvqDKH8=;
	b=njRiwiJzcw/zScEsD9X4BYX0AH7AyjMl23+luEYmIYHVA/RSNCW3DzNRO2mHicsTbvn8Wk
	ecK/F2YoDZSxuAPeEsDRjDpzgNWBS+7hVWH322G6HLdOum6MENyuVxnT+JA6yqf788eh9A
	RJv6lIV8F2w6AEakkXxHJ5ErkbMBrwgg5HkaUwHnBBPID7D5V+5iriWZXuLCYQmYc8AJiy
	NL3/EOrhVGfrvqltmbnA2eMHXIYyWAXgNSLq23knxiYqmqpL+uIKwD0e6SoZnrJzKo+WAL
	ppZrlyYaS7nfsv09FzxUdopXBPMeBHNALjz78GXSFdgLN7M82t5UAqfdEkLu5Q==
Message-ID: <aca6d1a6-913f-43f0-a75f-dc2fbdaa6d6a@arinc9.com>
Date: Sat, 13 Apr 2024 11:32:56 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: mt7530: provide own phylink MAC
 operations
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <E1rvIco-006bQu-Fq@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <E1rvIco-006bQu-Fq@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 12.04.2024 18:15, Russell King (Oracle) wrote:
> Convert mt753x to provide its own phylink MAC operations, thus avoiding
> the shim layer in DSA's port.c
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Simple ping test using a user port works fine.

Tested-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Thanks.
Arınç

