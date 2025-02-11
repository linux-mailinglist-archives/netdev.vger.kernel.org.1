Return-Path: <netdev+bounces-165128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 084E2A309AC
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 12:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62DCA188B581
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 11:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522BF1FA243;
	Tue, 11 Feb 2025 11:15:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A81F9F73
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272524; cv=none; b=F0v6ARPS4PwsTXptydARIbGdTak5dbRmOqH8sDwjR7Gd0CW//+to05Gu8xyyMxCKNLot7GgmnJPN/xCGMljDbHZYzQYbP3J8TARfeQT9jFsbvOtzGaJqyl3Z4a0t7a2zaFYruYts5frdShJmpj0+h86O/H7SHOr44UaCg2Lkgwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272524; c=relaxed/simple;
	bh=Q1cRnnQsuAv/C5OqIWfpYZtQB3e3qqwE/32I7GhrnTc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Bu/F2iAyqZNxpP1gpQWAZdh8N81ZfwTxOyPXDuI2//PvUHrso1FJfx+52wqb19A0iAyN/PK5SBLQgK1D8vCyS+YGq4HP78AkgI7I+LRsThLT9OO3ODzIRkpZMFMmUV7C6WgQAJmsSzMC8edCaVuGtAaeUAc08bvVShkOWxDDOB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp91t1739272505t0afjvfj
X-QQ-Originating-IP: LH6SrNBoJ3gIxz+PHFExP0I/RQUxEJ1UxzPef3Vfgm8=
Received: from smtpclient.apple ( [183.157.104.65])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 11 Feb 2025 19:14:53 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6306663364721193696
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Re: [PATCH net-next v7 5/6] net: ngbe: add sriov function support
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <20250207171940.34824424@kernel.org>
Date: Tue, 11 Feb 2025 19:14:54 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <09EC9A07-7DA7-4D3E-85EE-F56963B54A66@net-swift.com>
References: <20250206103750.36064-1-mengyuanlou@net-swift.com>
 <20250206103750.36064-6-mengyuanlou@net-swift.com>
 <20250207171940.34824424@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NDTr/OXP+ntDmFBPm234AtE7QZ+rKQdW5WBbzoIuWLrgTviqcV371zzb
	L9kVpwvwdS5fyiYZWWdiaJHyBSllTkwQrGQfRwLzLtCIBRZfrck88ndgEQIbp7PdSue1fqt
	7AFKMED6xEPHtQt5D72ujO/o6dKERzA1TfhCOfyy4V/EKDh+0hON+G+9dknR+hbjkfkrjV7
	9ViQE2ldy9hiQDae704Y78sS9tEnJIGilPCELMtEY9wvBA+cgLkAF5rA4zTxTSa3vw6N3iL
	lHFgkAo921oSl1HOJSO6BwUZME+dw57iM0EZXOt1hkFzU3yJOIUr058k14ZIPflrmmuxHLY
	VlGC6u47WQsauLkIAWEbJFUjZfs16aBClD/u8z0Jnf5lgj5div8IsAahyne7k1iyyIhTw/k
	Jy27aPrxBpMD0/xnM58A/g/d4YA/BXgu7PnhRNFntBOqrgclCaqspb2oWP3Dcmtt7dHkNK7
	wfE7knR6/RpfhkEuDWEkmlIJF5/ujQM2OVC9ic/WDZPr88yz33oJiD3q96UuZcUYLfJ2RvM
	EbBdn4s7Ph3SLuqdezvJ9vmZIQbsekdPmsdJheMZD68STYyUOKa/iskY5Fw/OX7l+kR0xvP
	MiQQ7zDIjUjtvuhL1DZzKkgDFNivlHXfXjtR0kKuLDJdLlO70eLN7XsMAtVAtXLsu29dNTZ
	etMICD0EdP+7GfajXMv+NtKI5KNNv7vcgEf8KxZpFDq+OZpNWru+DJPtaKVoT8jSzpMluKv
	DXv+y5qLr6o3MThWdhSMVwMMPGBxT+Mv3PFjUI/Etzr6i+/Lh4iKDnIg9Nr3w9hYQcnJlBY
	KwYILrBH9kcGc6E5L7f6Z4Tn9CUOdanY9fdqqAv0DmheP3BRsC/t9XMCZ6jW/NYrbc6S80a
	OZFH6J+0m5aiXJQmMvr7stIkhTex/UFCrAUPhL9RRZ9WVy8OEEjwUbdpKWXrPC5XeEqWcpt
	g2sPKyJnfb9Ho2ZsaXadzC3uQcmz10HG6iAMbPBz18yDCSn4l4k4ED8+YCTCCILlO8ByAIC
	13/uKGwy0yJHRYeqRlMdUCEHbFR9zqXUoTD3qkMtfz8Di/HUA0WcGurjiOdU8=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B42=E6=9C=888=E6=97=A5 09:19=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Thu,  6 Feb 2025 18:37:49 +0800 mengyuanlou wrote:
>> static irqreturn_t ngbe_msix_other(int __always_unused irq, void =
*data)
>> {
>> - struct wx *wx =3D data;
>> + struct wx_q_vector *q_vector;
>> + struct wx *wx  =3D data;
>> + u32 eicr;
>>=20
>> - /* re-enable the original interrupt state, no lsc, no queues */
>> - if (netif_running(wx->netdev))
>> - ngbe_irq_enable(wx, false);
>> + q_vector =3D wx->q_vector[0];
>> +
>> + eicr =3D wx_misc_isb(wx, WX_ISB_MISC);
>> +
>> + if (eicr & NGBE_PX_MISC_IC_VF_MBOX)
>> + wx_msg_task(wx);
>> +
>> + if (wx->num_vfs =3D=3D 7) {
>> + napi_schedule_irqoff(&q_vector->napi);
>> + ngbe_irq_enable(wx, true);
>> + } else {
>> + /* re-enable the original interrupt state, no lsc, no queues */
>> + if (netif_running(wx->netdev))
>> + ngbe_irq_enable(wx, false);
>> + }
>>=20
>> return IRQ_HANDLED;
>> }
>=20
> You need to explain in the commit message what's happening here.

>=20
> IDK why the num_vfs =3D=3D 7 is special.

Due to hardware design, when 6 vfs are assigned.=20
+------------------------------------------------------------+
|        | pf | pf  | vf5 | vf4 | vf3 | vf2 | vf1 | vf0 | pf |
|--------|----|-----|-----|-----|-----|-----|-----|-----|----|
| vector | 0  | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8  |
+------------------------------------------------------------+

When 7 vfs are assigned.=20
+------------------------------------------------------------+
|        | pf | vf6 | vf5 | vf4 | vf3 | vf2 | vf1 | vf0 | pf |
|--------|----|-----|-----|-----|-----|-----|-----|-----|----|
| vector | 0  | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8  |
+------------------------------------------------------------+

When num_vfs < 7, pf can use 0 for misc and 1 for queue.
But when num_vfs =3D=3D 7, vector 1 is assigned to vf6.
1. Alloc 9 irq vectors, but only request_irq for 0 and 8.=20
2. Reuse interrupt vector 0.


> Also why are you now scheduling NAPI from a misc MSI-X handler?
The code used the second. Misc and queue reuse interrupt vector 0.


> --=20
> pw-bot: cr
>=20


