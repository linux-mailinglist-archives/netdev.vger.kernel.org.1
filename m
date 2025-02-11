Return-Path: <netdev+bounces-165130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF99A309B0
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 12:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4C0188B62E
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937561FAC46;
	Tue, 11 Feb 2025 11:15:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E001FBEA6
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272530; cv=none; b=WlEYor/bDwIWQ2v0q3Lm8uMpqLIxO2iSfAFZebF8nvbfiJE4XW49lmogZWCnSXQ14bVRtnkddSjyve4b6NBXbseamVcvF+mfxYyBo0QaB1ebXNDfiEoRxDvYJoH11r2LkwLfeJmetn34eFR0Ni0dmi1Ns9vSy9/9uBkq5hP/qQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272530; c=relaxed/simple;
	bh=LHemEMoW2QqciL82UVmk2u2J2dvnJEll3D6qgiwN0YM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=CYG91MHFo+rfEpWW1xLpPxoIe6bdpWQyhHEl/qZKHjZqwVJikzfQ+Gzn1jT1sb7bteFpE9HotIm9E8pK4/GSuU+s6LVbRckHtY2yaZG3807+dhVrBWrdTD2j7X1i18BbZvUgks+fImY7m6DbFxCeA/HSqwmby6tlZEozAd+hDKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp91t1739272492tjgl56go
X-QQ-Originating-IP: 6MR0UON6wQfHi2tkRU9zMgoaxhI3IK8U7HUziHQrWj4=
Received: from smtpclient.apple ( [183.157.104.65])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Feb 2025 19:14:50 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17477912342045423734
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH net-next v7 4/6] net: libwx: Add msg task func
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20250207171739.7ab11585@kernel.org>
Date: Tue, 11 Feb 2025 19:14:39 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <43A1F6A5-2F22-4A4B-ACAE-EEEC8A5B889A@net-swift.com>
References: <20250206103750.36064-1-mengyuanlou@net-swift.com>
 <20250206103750.36064-5-mengyuanlou@net-swift.com>
 <20250207171739.7ab11585@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NZPGd4zC89cpUEnBHKTGRYnjYG0RK+TyTdF7f8D/vL06SGmIk8PNXoSV
	5gBYVAPM/XgKhVVq0FwFfyqldaTLhE27cOAVlUqgC2SspqVf+/WyHG5WPi8h0J3JIHCf1fg
	Vr/MYzFu3FGzUcb+Fuaunz4Ty5hwIpmQW4bEzl7ohjdpBRDeAodN0RKUN864wCdy7Q2IgZZ
	FAQuo/FH25hkCjASdA7NgXJPJp6tr8MFCHQ80gNkOTUrrrxePxj/RoABzDpw5p1fmthsHe2
	XPSknlKBpEG9tD2yl2QJnv+V/0jWW+YQuqJwKBsWUcMQhPXq/bwSNG/SSi6TyIEF5ESSx2i
	/u+N93uvdFYFtf32Wfwl9SQEatCojGwySEXbu3XxOltbJvlbbL6nEQO1sm2NPLz8sq/VyBw
	afIM6ATzO8LjjVsyiGWwTA9PuZ92L5t+Ss5mSnY+iDaLDeM0dx4u1/TivfDVNPImx6cDxJX
	unLPncgN0lVSwP3Zln0UwCgLexbXb15C510/SsBEPk9+2HXTqfWjCLdhBPp+pz+U8NVH9+F
	xzwVVii8hLLU/mERpqwi6SF9aP3pQVGfBelOp1qgAU3ocmhpWng2kKv7xgFXo5tft8ER4oD
	Lc6mueJPbCu8yQmhbIedJGNW6++tTLLqssU+B0WALi///XjUglYvpL6arGsKhQqFPgsoLSp
	ltPJ9yHGvaHf6y7Epvn3kvMqGPOkPG1IOSyicPnvoWWdi983XLTVZV3RsTRZyqlGf8so88a
	EwaO0/YsA1el8p10mcUU6202bWUkOcxGclKekq2qiZ2fkTL8IUjWwdNSrdX73Sqbkg/1S7/
	74+M66PJdjKM3XSDNXaYAmrL29N+BzEU0sLoO2VQXFrSH4r5rU1R+JQgNEwjCX9pBvU9r5a
	t+qV6PiQm+IwEjNJ3qBU7zCIEflnXrWrv5b0pHFI+sa/Ds0pVt2LwU8ZOdAl0bY7GKFM+I6
	ihw2zihBZJU4fs4E9Gmj6vZStRRMxAu4OgaOvaXwW5F6WAIZ8uLM8FASX/z5kUgCds37Lcn
	yDBfFaJHr64XAygO5JHwnciajoF0K6LJnsUlzIddZEgZYWaJ01CdT5I5RwnA4UKVBT0X/jB
	g==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B42=E6=9C=888=E6=97=A5 09:17=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu,  6 Feb 2025 18:37:48 +0800 mengyuanlou wrote:
>> +static int wx_negotiate_vf_api(struct wx *wx, u32 *msgbuf, u32 vf)
>> +{
>> + int api =3D msgbuf[1];
>> +
>> + switch (api) {
>> + case wx_mbox_api_10 ... wx_mbox_api_13:
>> + wx->vfinfo[vf].vf_api =3D api;
>> + return 0;
>> + default:
>> + wx_err(wx, "VF %d requested invalid api version %u\n", vf, api);
>> + return -EINVAL;
>> + }
>> +}
>=20
> How "compatible" is your device with IXGBE?
>=20

The pfvf mailbox flow is similar to IXGBE.
But compatibility with the previous api seems not to be required,
because inbox has been refactored.=20


> static int ixgbe_negotiate_vf_api(struct ixgbe_adapter *adapter,       =
        =20
>                                  u32 *msgbuf, u32 vf)                  =
       =20
> {                                                                      =
        =20
>        int api =3D msgbuf[1];                                          =
         =20
>=20
>        switch (api) {                                                  =
       =20
>        case ixgbe_mbox_api_10:                                         =
       =20
>        case ixgbe_mbox_api_11:                                         =
       =20
>        case ixgbe_mbox_api_12:                                         =
       =20
>        case ixgbe_mbox_api_13:                                         =
       =20
>        case ixgbe_mbox_api_14:                                         =
       =20
>                adapter->vfinfo[vf].vf_api =3D api;                     =
         =20
>                return 0;                                               =
       =20
>        default:                                                        =
       =20
>                break;                                                  =
       =20
>        }                                                               =
       =20
>=20
>        e_dbg(drv, "VF %d requested unsupported api version %u\n", vf, =
api);   =20
>=20
>        return -1;                                                      =
       =20
> }                                                                      =
        =20
>=20
>=20


