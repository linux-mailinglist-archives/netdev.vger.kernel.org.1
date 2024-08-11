Return-Path: <netdev+bounces-117477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEB794E14A
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 15:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C8341F21026
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 13:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331CD13A86E;
	Sun, 11 Aug 2024 13:01:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-13.us.a.mail.aliyun.com (out198-13.us.a.mail.aliyun.com [47.90.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F054A19;
	Sun, 11 Aug 2024 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723381315; cv=none; b=UD5sKZlriojzMEDCV4Qw/lr6cKS2zhuFeRSfvdMLA9nbAdnhu0KFRE+KGfRcFPpU8h5Arc/nQtHhR1fBcwQEnf/FHitVgWeHSma2fU/gyP+vTe/zFaqTgzI0MUcVXlEcMg5KRKjiWem76ViuM/aJlb64fGu8LXutNupxAeA0Bmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723381315; c=relaxed/simple;
	bh=qwx95SS+vwLHflrTH4z9pVjl/IkS2r7GSaN6JZ7wCs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grV+kcYLxuI+2i+7tU5JmEAHoYUR9UmjUfA+326cZ94Oi98oJbmAtzKt5wB7xnxIr+A4SyIKjQujGZqBwDo47vPJf+h94xBL/aQhqQGjfUuuVc0MduUNlu/YlnGOYv9fTFIgJdMJy+LjpJWpGyn6tHcu7YBZ4krTH7L1/uuunHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from 192.168.208.130(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.YoALJT6_1723380346)
          by smtp.aliyun-inc.com;
          Sun, 11 Aug 2024 20:45:48 +0800
Message-ID: <6f630ae9-60a3-437e-973e-7743f8dd6352@motor-comm.com>
Date: Sun, 11 Aug 2024 05:45:45 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: motorcomm: Add chip mode cfg
To: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 yuanlai.cui@motor-comm.com, hua.sun@motor-comm.com,
 xiaoyong.li@motor-comm.com, suting.hu@motor-comm.com, jie.han@motor-comm.com
References: <20240727092009.1108640-1-Frank.Sae@motor-comm.com>
 <ac84b12f-ae91-4a2f-a5f7-88febd13911c@kernel.org>
 <830d0003-ac0b-427d-a793-8e42091c4ff2@lunn.ch>
Content-Language: en-US
From: "Frank.Sae" <Frank.Sae@motor-comm.com>
In-Reply-To: <830d0003-ac0b-427d-a793-8e42091c4ff2@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/27/24 04:07, Andrew Lunn wrote:
> On Sat, Jul 27, 2024 at 11:25:25AM +0200, Krzysztof Kozlowski wrote:
>> On 27/07/2024 11:20, Frank.Sae wrote:
>>>   The motorcomm phy (yt8821) supports the ability to
>>>   config the chip mode of serdes.
>>>   The yt8821 serdes could be set to AUTO_BX2500_SGMII or
>>>   FORCE_BX2500.
>>>   In AUTO_BX2500_SGMII mode, SerDes
>>>   speed is determined by UTP, if UTP link up
>>>   at 2.5GBASE-T, SerDes will work as
>>>   2500BASE-X, if UTP link up at
>>>   1000BASE-T/100BASE-Tx/10BASE-T, SerDes will work
>>>   as SGMII.
>>>   In FORCE_BX2500, SerDes always works
>>>   as 2500BASE-X.
> When the SERDES is forced to 2500BaseX, does it perform rate
> adaptation? e.g. does it insert pause frames to slow down the MAC?
>
> Maybe look at air_en8811h.c.
>
>        Andrew

Yes, when the serdes is forced to 2500base-x, it inserts pause frames to
perform rate adaptation to slow down the MAC.


