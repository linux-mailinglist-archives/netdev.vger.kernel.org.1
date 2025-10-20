Return-Path: <netdev+bounces-230986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ACABF2F85
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 20:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF3A4637F6
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 18:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743DF2C08CC;
	Mon, 20 Oct 2025 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="mQiMOLcd"
X-Original-To: netdev@vger.kernel.org
Received: from mx08lb.world4you.com (mx08lb.world4you.com [81.19.149.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551492D24AC;
	Mon, 20 Oct 2025 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760985552; cv=none; b=pcBPeonJjn55tPdKAWl6c3fHMJxS4zc+wWSNlDbrHErSXcsZg9uXtWNgPdrEw4u9hyhw+HT91w1kkBa8P/qHYDW74xaGmdiwFapaTnAlT5vXOMXiNz4pEMobtJY8BBQMRoM+PT7HWC2MAY7BD6zKyyjPeo1xgsYEMsGeLDVgr44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760985552; c=relaxed/simple;
	bh=SBMDeTaCv/976anlGN+OIzcwQrNgTmJYV8dD+LmgGNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aq72QyfkkNzktXHuRr/NJGpVtREnycE9RgiqW9qdaeoi2BrTw5RekE3OyN7fUPLK7rI+XzroYzIhASkNw54pqAAXk1jVbCUt4JODq0dsSqtbeSpK1L6aiEE+BgxLjvuS5n/pw6vbsZi1OA7TWslt1GKTHeAK36j9pN5AGebMj4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=mQiMOLcd; arc=none smtp.client-ip=81.19.149.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bMHVdS4koP0XUIuhg8cOzB47/6S7GYtGHXP9n2t5x7g=; b=mQiMOLcdI693+zuAUWYaNNZd1+
	a6WOs1hjSphjpWzpEUO+Y44m0ApVdYrODHV1hbv6cdckxh7iUtlQoPCIC/bjEAfkDUCrWisUCfGh6
	WGpXBLLiFiYNH4sLIqWPGf3odlG0FrMdphaQWXSfnEdR3kkVxL4119IojUvXL/rrJESA=;
Received: from [178.191.104.35] (helo=[10.0.0.160])
	by mx08lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vAuLi-000000005Wv-3IOc;
	Mon, 20 Oct 2025 20:11:14 +0200
Message-ID: <e0a8830e-6267-4b2a-b1fa-f3cbe34bd3ba@engleder-embedded.com>
Date: Mon, 20 Oct 2025 20:11:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for non PTP SKUs
 for lan8814
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com
References: <20251017074730.3057012-1-horatiu.vultur@microchip.com>
 <79f403f0-84ed-43fe-b093-d7ce122d41fd@engleder-embedded.com>
 <20251020063945.dwqgn5yphdwnt4vk@DEN-DL-M31836.microchip.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20251020063945.dwqgn5yphdwnt4vk@DEN-DL-M31836.microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 20.10.25 08:39, Horatiu Vultur wrote:
> The 10/17/2025 23:15, Gerhard Engleder wrote:

...

>>>
>>> +/* Check if the PHY has 1588 support. There are multiple skus of the PHY and
>>> + * some of them support PTP while others don't support it. This function will
>>> + * return true is the sku supports it, otherwise will return false.
>>> + */
>>
>> Hasn't net also switched to the common kernel multiline comment style
>> starting with an empty line?
> 
> I am not sure because I can see some previous commits where people used
> the same comment style:
> e82c64be9b45 ("net: stmmac: avoid PHY speed change when configuring MTU")
> 100dfa74cad9 ("net: dev_queue_xmit() llist adoption")

The special coding style for multi line comments for net and drivers/net 
has been removed with
82b8000c28 ("net: drop special comment style")

But I checked a few mails on the list and also found the old style in
new patches.

Gerhard


