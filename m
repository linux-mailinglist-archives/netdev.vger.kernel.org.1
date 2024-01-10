Return-Path: <netdev+bounces-62795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8F08293DF
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 07:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE98B25D74
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 06:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AA339FCB;
	Wed, 10 Jan 2024 06:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="esNBFFo4"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF0939FC9
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 06:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9713BE0002;
	Wed, 10 Jan 2024 06:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1704869865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTheLAdhTc3ZggiItAcafeS6P55G+6UDbpLThd+uepw=;
	b=esNBFFo4mSPNxfpxZ9+S9bAPHSaXtFCMN7GMIHMxCOexU3lIzIXYwkd2jqU6mHOEHNSeBc
	j20oXOjI2Q18eS3z3Wha7ky7owNPB4zqs5E5XMbgopwVzs9yW2HhSYJAKiIuXa6sgJQI8t
	gVFR9z5DQyXWxk8pSCk9HcpWQzBLikbc+6NnDNLmXYO7777Dd1qlZHzY12uvxK/6S0m6Jb
	u5NBMW7LlbLqK9P46dilWYdjGCm8kcP8O/7uACaeSQEUgFgfutkKbn7tuIGxFvEw/xmL1e
	cr4Yb2UITz0has1jxHI0NHKfYRhtww2xKsTajX2ISY20QixoIPNuiO+1yFq+TQ==
Message-ID: <17e3d536-110c-41d6-be76-5f52002fca26@arinc9.com>
Date: Wed, 10 Jan 2024 09:57:41 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/7] MAINTAINERS: eth: mt7530: move Landen Chao to
 CREDITS
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 Daniel Golle <daniel@makrotopia.org>, Landen Chao
 <Landen.Chao@mediatek.com>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>
References: <20240109164517.3063131-1-kuba@kernel.org>
 <20240109164517.3063131-3-kuba@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20240109164517.3063131-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

On 9.01.2024 19:45, Jakub Kicinski wrote:
> mt7530 is a pretty active driver and last we have heard
> from Landen Chao on the list was March. There were total
> of 4 message from them in the last 2.5 years.
> I think it's time to move to CREDITS.
> 
> Subsystem MEDIATEK SWITCH DRIVER
>    Changes 94 / 169 (55%)
>    Last activity: 2023-10-11
>    Arınç ÜNAL <arinc.unal@arinc9.com>:
>      Author e94b590abfff 2023-08-19 00:00:00 12
>      Tags e94b590abfff 2023-08-19 00:00:00 16
>    Daniel Golle <daniel@makrotopia.org>:
>      Author 91daa4f62ce8 2023-04-19 00:00:00 17
>      Tags ac49b992578d 2023-10-11 00:00:00 20
>    Landen Chao <Landen.Chao@mediatek.com>:
>    DENG Qingfang <dqfext@gmail.com>:
>      Author 342afce10d6f 2021-10-18 00:00:00 24
>      Tags 342afce10d6f 2021-10-18 00:00:00 25
>    Sean Wang <sean.wang@mediatek.com>:
>      Tags c288575f7810 2020-09-14 00:00:00 5
>    Top reviewers:
>      [46]: f.fainelli@gmail.com
>      [29]: andrew@lunn.ch
>      [19]: olteanv@gmail.com
>    INACTIVE MAINTAINER Landen Chao <Landen.Chao@mediatek.com>
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç

