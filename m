Return-Path: <netdev+bounces-119118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F4A95418D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 08:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B885C1C20CC8
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 06:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD36D75817;
	Fri, 16 Aug 2024 06:12:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.124.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B2A2E859
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 06:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.124.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723788752; cv=none; b=r2M+h6exmjA6w8PjAytzfD5rAKcLtP6ZSwRCXCyxB0A9KZXBD+3X/F3EDOQjOcpkRl55cDhc1qSGSg5BnJtt89ZsXoHxUU8V9LrRqlo/njp46XBmvdqwtsQHfl6o/IWnW53BgUTwYrs5Ir4nO2+PTCCVs7siS+eKmmlncRXgnbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723788752; c=relaxed/simple;
	bh=/N3WX58BkkzP6R4xKCsLS1brjnsluqSd2oBCd5mY8UA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bqJIE+6yiF+vxa9zWGnwRcG0tO7+OoHqG50PcdC0Xz5G4q6+jAPLMAbdYLi8k8dC2R6EfMtvYj5QO83a4SOdTMMpMOqv5DXvQQwjILbbRWREMcDDz76bIb/ilXlUA3tAcshlobsiS72JGRKXIDF/zgH4BTYzzDPxCTHgMSAIqZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=114.132.124.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz7t1723788700th72ngq
X-QQ-Originating-IP: +/7T7bF9ShvXZlwFGC5zzC4n3xn8V5K2n2NRUobjm+E=
Received: from smtpclient.apple ( [122.233.171.117])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 Aug 2024 14:11:38 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16364876400258828432
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
In-Reply-To: <f7fdecaf-c3c4-4770-9e03-d1f15fd093fa@redhat.com>
Date: Fri, 16 Aug 2024 14:11:27 +0800
Cc: netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com,
 andrew@lunn.ch,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <BE3FAE32-CA6E-4F00-996A-738B9AF07E8C@net-swift.com>
References: <E9C427FDDCF0CBC3+20240812103025.42417-1-mengyuanlou@net-swift.com>
 <f7fdecaf-c3c4-4770-9e03-d1f15fd093fa@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3814.100.5)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0



> 2024=E5=B9=B48=E6=9C=8815=E6=97=A5 18:15=EF=BC=8CPaolo Abeni =
<pabeni@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 8/12/24 12:30, Mengyuan Lou wrote:
>> The MAC only has add the TX delay and it can not be modified.
>> MAC and PHY are both set the TX delay cause transmission problems.
>> So just disable TX delay in PHY, when use rgmii to attach to
>> external phy, set PHY_INTERFACE_MODE_RGMII_RXID to phy drivers.
>> And it is does not matter to internal phy.
>> Fixes: a1cf597b99a7 ("net: ngbe: Add ngbe mdio bus driver.")
>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>> ---
>> v2:
>> -Add a comment for the code modification.
>> -Add the problem in commit messages.
>> v1:
>> =
https://lore.kernel.org/netdev/C1587837D62D1BC0+20240806082520.29193-1-men=
gyuanlou@net-swift.com/
>>  drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c =
b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
>> index ba33a57b42c2..0876b2e810c0 100644
>> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
>> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_mdio.c
>> @@ -215,10 +215,14 @@ int ngbe_phy_connect(struct wx *wx)
>>  {
>>   int ret;
>>  + /* The MAC only has add the Tx delay and it can not be modified.
>> +  * So just disable TX delay in PHY, and it is does not matter to
>> +  * internal phy.
>> +  */
>>   ret =3D phy_connect_direct(wx->netdev,
>>    wx->phydev,
>>    ngbe_handle_link_change,
>> -  PHY_INTERFACE_MODE_RGMII_ID);
>> +  PHY_INTERFACE_MODE_RGMII_RXID);
>>   if (ret) {
>>   wx_err(wx, "PHY connect failed.\n");
>>   return ret;
>=20
> Does not apply cleanly to net since:
>=20
> commit bc2426d74aa35cd8ec9c97a253ef57c2c5cd730c
> Author: Jiawen Wu <jiawenwu@trustnetic.com>
> Date:   Wed Jan 3 10:08:49 2024 +0800
>=20
>    net: ngbe: convert phylib to phylink
>=20
> Please rebase

I Know there has something changed in this commit.

If I want to send this patch to fix the code between this two commits.
> commit: a1cf597b99a7 ("net: ngbe: Add ngbe mdio bus driver.")

> commit: bc2426d74aa3 (=E2=80=9Cnet: ngbe: convert phylib to phylink")

Should I add the stable tag flag like 6.6 or do something else.

Thanks,
Mengyuan Lou.



