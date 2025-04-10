Return-Path: <netdev+bounces-181045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1281AA836EC
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0426C46393E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1F1196D90;
	Thu, 10 Apr 2025 02:56:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F168BEA
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 02:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744253794; cv=none; b=AdXNHqyPKeA66YZIZyL6h8HTE+0Nn+cug6WUWDe60eDLoGvOSGmHOLbKm0oiyR6ljOtwh3LRjE04W7i5KjjcINTiKHxG1dJuHKdSztCaSqc6tvTM79PNJ4PpDrBm/XIASWZAKiJdeZklHrBG0bnHVM8gaNc0dcGJIQDUbdfmwyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744253794; c=relaxed/simple;
	bh=DLHPzizKrKGvvdpHsC8oiHyKDaQBgUHrJv4AIndz4eE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YXIKuE/10uYhlsT29w1XJHS3kdZ598hBMgadIJSC7ibmg4/4WhIty/UGTpfIsI1c9k5k2o6zUmWTVP/KzFCemSj+ygm0ZriG+6YfZjfJDIigY2uXzer6QMJ9DcjL21ew0cIIQ2eCrgv/34EiFWI4RwbiOt8+X2uxUO3UCTX243w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz5t1744253727ta84989
X-QQ-Originating-IP: 0YhxBvJHPTHVThMtVq29tLqO8A9oHwqDr6hOgeYsm7c=
Received: from smtpclient.apple ( [220.184.249.159])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Apr 2025 10:55:25 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15953888489178677383
EX-QQ-RecipientCnt: 6
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH net-next v10 0/6] add sriov support for wangxun NICs
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20250409193037.78aeb8ae@kernel.org>
Date: Thu, 10 Apr 2025 10:55:14 +0800
Cc: netdev@vger.kernel.org,
 horms@kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com,
 linglingzhang@trustnetic.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <C0EBCA5B-222E-42EB-8619-654B70E9F08E@net-swift.com>
References: <341CBF68787F2620+20250408091556.9640-1-mengyuanlou@net-swift.com>
 <20250409193037.78aeb8ae@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M00FGg+OziDjH+l/qTGBixLTFk8TjWNN5n1Zhg0f9fYv7VRIvWYNDgFe
	kghr5aBVpxG0rLMUTWFno8vrVl+KIxcIFJrm1IjcaWmoK/WhBZ6O1zwbDl/wQTrL+YPf9LV
	yRcCkoEgBcFXKkqcbWSzBS2fk9S1IglF/gsyfg2qtKd27FamW3HcdxlJk8LM/wDOdQdqz1W
	DeDrZBe8fmzUMODX1uXsFC/5cZ909yFLG+U5WUDKUQTpP3fBKwV7e57RLF+sE1EkYUldpQF
	it5G2e9R0FYkcQHAh55SPyg/QFAuMpJ9qg7/R0Ckk0jcjnF90LPmmnS2geTQAdnE87P44+a
	Djs9yiCPTkjdISeNMiOZxRJGoHO/gSnf7+80xHj6CPEd5Kpk4Y04L+yCIdHEFtmhh5uC86u
	3oOejlPPSn/5xNqfpOkVn1DAj119XJUUkEL9OqwAl1naSG8IWx5YfkScoZBlcs14iMN/rRb
	A96W7q+IJjkMrcCQlrmXSkVPg6YGX9b13EK8tha9L2yidewiGm5K4F7N58Pk2MF1g37zNfU
	PdjA1Yyh8DJt6iFfM777s1umC1EaOh9cngu2bE83VOnsvyiXeQ3i3rGuQ9/OfZBREFx0s+O
	DX/xTAH5EYLbltGqkDohinv7S1KHlFoTFr2Aphpy6sChbtKOI3hT3ku3fHFaAXzj8rxJ4h8
	xLipxXBi0UQXIpqM2FV8sz30/QBncsZfOIFbabv3ibFwXbftfjfZ43VHYpzOt6P2Yvs1JuY
	C7uoDOosId4PFTrfbYB8Hh6vfCP9FfkWvyub5iKt5M9u4IIEIZpix4kZd7PRFk8gRYAzve8
	1etqyu/j/UPgO0+Yo9xRL0WAunhvUSXBUMsB9cfVdTSvl2XVg0O4Nx/9wz/wKVswdzhWrDJ
	hUuCr1S5x4WuiQtxwAJT0ZUvxo2gEYzdsxQUr9HFHYgbxStDzYw+I2MnS1FbmqU6KODxYjS
	ww52g7+0UcXHhnBx493ccWRmZuhzCE/RrAghFnGpimpXci0XgM63trdp/HDgswUs+RuBWK0
	flCBU0VZrjTsA6v4z+zGMdMvku5/FYmIhSDPn+XrxyxQtZtSxHby5jWj6lpKspWyGLuYhPz
	ICZMkTNdxGeaIGdwdPztXkB0pkD+qtOTE4xlqzwsJKu4l75/3D8HLs=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B44=E6=9C=8810=E6=97=A5 10:30=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue,  8 Apr 2025 17:15:50 +0800 Mengyuan Lou wrote:
>> add sriov support for wangxun NICs
>=20
> In the future please make sure the patches are sent in reply to=20
> the cover letter. git send-email should use --thread IIRC.
>=20
>=20

I will check it.
Thanks.=

