Return-Path: <netdev+bounces-130275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1ED989CA1
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 10:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337911C20823
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 08:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A051617BED6;
	Mon, 30 Sep 2024 08:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="kMPqPkg4"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C7717B507;
	Mon, 30 Sep 2024 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684416; cv=none; b=RpSY0CKpv06c80riYRWuuQKxZOqvBIjNRrO9THmhN//dtmi0kez4/gNRkiBbYR7vAuAmq44E2b3TV2+Hcp7pRCrJq0Oi8YaWr9Ua/iNcshKf6OdDcJ15VMTzEFOh9LqVZ+nnB0cgBsTv0pzQunGpV14nBqdKEH03PWKMm4daHEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684416; c=relaxed/simple;
	bh=EQUT5VGZUKQ+DkSw4uKBKwFZW48wDSvf6Vi7Vo7zM+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TSnSM5d1FRvRSEMFyR9vHlvfW27esLoi/CNRVKybB7f0sXMUHwJYnYk0lyX8HLXsAsXYhZ+M+pZ5x5gsdVx3Dec7K7cSSnVgYGq/eqFV5K2ZCB+A0YOSSZjrhP6+x7reRTkXu7QZH+5Z3aJh+UFOiGcdUOmvKtPNtKjY5UuHOp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=kMPqPkg4; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 7CFC3A07FF;
	Mon, 30 Sep 2024 10:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=JCcwQRV27W0Smcd9nbgT
	ji9l32zXPJoWVSVvx0sZPlg=; b=kMPqPkg4VLS1YLPt4JrrddpF6s+yJxZvdUOj
	dLvMrlbASFYj+Fx55JMaI5/Qjd6us56fU1XvV39kEEPZs3uB6Y3+A7KZOzYamb/u
	1TSlPp8SM8ytVYaRTaOVvPijlE+TWJ4sVWiveO0wMuLWpDfOSEpLKx1zpAHwKxlb
	CYTE5XahCw05v5Gvlyw0LUxNgXhJ5uWf60fL4O/2KoYGPOyeBsmrciWHlVGL9vq0
	5H0yCGsZg0YhcQR3RrLAHhvckd02ikkubnuqSvx9Ooyd3qLBdFjdDDkSRLJ3BizY
	OJjHK2vKt7KJ6jO00ZitxsPro6Pcl/TtvrToRPgheZquUjN0b2A/JvOwzzfOWSAh
	yc4RBgWIPmvqU91LdxwkS+XKEGjtgVbjx/xzcP8meu3D/UFxOe9ae3c8TFgPhB/+
	wvA3r6gFzyy8whKW6gqZLCNRvWhWx2SYUx+46bUrUoD74VA7DbUu0kud9EQJj927
	NelQbyM7Jg6QULE4kgET3TQkNaVLDYyWGe4TEhuSf8lAhStdVvy05QT8pW24+Tmv
	ws5177AGJHpDF5Mp5//Twtidoh0bh7r5NYm+jN4P9o/jhDVg+ZS9iFrmHJpdbFhi
	EzAiZ5TjVM0LSsEj5nsjfBujdMdovFxuuqOP1d5VJXTGoiHMespQ5v1ztg+wjTUv
	+Fhl+8E=
Message-ID: <6be53466-fd53-44e9-b83a-b714737865dc@prolan.hu>
Date: Mon, 30 Sep 2024 10:20:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: fec: Restart PPS after link state change
To: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240924093705.2897329-1-csokas.bence@prolan.hu>
 <PAXPR04MB8510B574A53DAD7E1256A9E688692@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <PAXPR04MB8510B574A53DAD7E1256A9E688692@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948546C7C62



On 2024. 09. 25. 6:37, Wei Fang wrote:
>> -----Original Message-----
>> From: Csókás, Bence <csokas.bence@prolan.hu>
>> Sent: 2024年9月24日 17:37
>> To: Frank Li <Frank.Li@freescale.com>; David S. Miller
>> <davem@davemloft.net>; imx@lists.linux.dev; netdev@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Cc: Csókás, Bence <csokas.bence@prolan.hu>; Wei Fang <wei.fang@nxp.com>;
>> Shenwei Wang <shenwei.wang@nxp.com>; Clark Wang
>> <xiaoning.wang@nxp.com>; Eric Dumazet <edumazet@google.com>; Jakub
>> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Richard
>> Cochran <richardcochran@gmail.com>
>> Subject: [PATCH net 1/2] net: fec: Restart PPS after link state change
>>
> The "v2" descriptor is missing in the subject, and correct the mail address
> of Frank.

My bad, sorry. get_maintainer.pl spat out the old email address, as that 
was their former committer address, and I wasn't paying attention.

>> +/* Restore PTP functionality after a reset */ void
>> +fec_ptp_restore_state(struct fec_enet_private *fep) {
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&fep->tmreg_lock, flags);
>> +
>> +	/* Reset turned it off, so adjust our status flag */
>> +	fep->pps_enable = 0;
>> +
>> +	spin_unlock_irqrestore(&fep->tmreg_lock, flags);
>> +
>> +	/* Restart PPS if needed */
>> +	if (fep->ptp_saved_state.pps_enable) {
> 
> It's better to put " fep->pps_enable = 0" here so that it does
> not need to be set when PPS is disabled.

It doesn't hurt to set it to 0 when it's already 0, and it saves us 
having to unlock separately in the if {} and else blocks. Plus, after 
reset, PPS will be turned off unconditionally, since the actual HW gets 
reset.

Bence


