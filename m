Return-Path: <netdev+bounces-116730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F6594B7CC
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 09:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9930228C81F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 07:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A4B18786F;
	Thu,  8 Aug 2024 07:24:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3A97A724
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723101888; cv=none; b=EfqJMsmmXSre3rnpf6/iSy4gFpCXzOt5RBKwlWB07mJ8A30lV5PyE8+0402q2ct2VVie8XHxJoilU+yzK65gsufPnFfcIdV7FhDovOJNWqGibMV05lOgs+ejmFoBp0Q5GN8XjV8yHpKg723ie93ciIT+IxV45WqgTapTj9wKcWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723101888; c=relaxed/simple;
	bh=8/g6Nhm0GzJ9zQc2zjMNsvUFQymgftA8MPCKewwX06U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NzymU+5zMR1ihHsok8LGZD8K/PUDQ/LnAIkxCFBUEM/Lmwq+ewIhXj+BCajguBnEvYXQG0zkJoZin4PG7SAE8in0L8iTmCcH+LYsDhZ/xA3b4cY9J63y/HS8fZUOowgBbRSuzVku4UzXBCPiDqosDMdFBDP6fdn9DK3UQTjKhhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp87t1723101850tqpeacff
X-QQ-Originating-IP: OGrqM/Ol+496OQ0Na+uZbvgtt/HbQ8yvHj80NFEUAJU=
Received: from smtpclient.apple ( [60.186.245.110])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 08 Aug 2024 15:24:08 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17466223432688298513
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3814.100.5\))
Subject: Re: [PATCH net] net: ngbe: Fix phy mode set to external phy
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <c98c7d2b-d159-4306-bd26-2999be45e1d0@lunn.ch>
Date: Thu, 8 Aug 2024 15:23:58 +0800
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D0A7F7D6-38F9-4197-A1C4-3F484A8EC543@net-swift.com>
References: <C1587837D62D1BC0+20240806082520.29193-1-mengyuanlou@net-swift.com>
 <1e537389-7f4b-4918-9353-09f0e16af9f8@intel.com>
 <4CF76B28-E242-47B2-B62C-4CB8EBE44E92@net-swift.com>
 <c98c7d2b-d159-4306-bd26-2999be45e1d0@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3814.100.5)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0



> 2024=E5=B9=B48=E6=9C=887=E6=97=A5 20:58=EF=BC=8CAndrew Lunn =
<andrew@lunn.ch> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Aug 07, 2024 at 01:42:06PM +0800, mengyuanlou@net-swift.com =
wrote:
>>=20
>>=20
>>> 2024=E5=B9=B48=E6=9C=886=E6=97=A5 19:13=EF=BC=8CPrzemek Kitszel =
<przemyslaw.kitszel@intel.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On 8/6/24 10:25, Mengyuan Lou wrote:
>>>> When use rgmmi to attach to external phy, set
>>>> PHY_INTERFACE_MODE_RGMII_RXID to phy drivers.
>>>> And it is does matter to internal phy.
>>>=20
>>> 107=E2=94=82  * @PHY_INTERFACE_MODE_RGMII: Reduced gigabit =
media-independent interface
>>> 108=E2=94=82  * @PHY_INTERFACE_MODE_RGMII_ID: RGMII with Internal =
RX+TX delay
>>> 109=E2=94=82  * @PHY_INTERFACE_MODE_RGMII_RXID: RGMII with Internal =
RX delay
>>> 110=E2=94=82  * @PHY_INTERFACE_MODE_RGMII_TXID: RGMII with Internal =
RX delay
>>>=20
>>> Your change effectively disables Internal Tx delay, but your commit
>>> message does not tell about that. It also does not tell about why,
>>> nor what is wrong in current behavior.
>>>=20
>>=20
>> I will add it, when wangxun em Nics are used as a Mac to attach to =
external phy.
>> We should disable tx delay.
>=20
> Why should you disable TX delay?
>=20
> What is providing that delay? Something needs to add a 2ns delay. Does
> the PCB have an extra long clock line?
>=20

Mac only has add the Tx delay=EF=BC=8Cand it can not be modified.

So just disable TX delay in PHY.

Mengyuan Lou=20

>    Andrew



