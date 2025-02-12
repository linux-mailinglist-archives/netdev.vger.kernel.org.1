Return-Path: <netdev+bounces-165478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D618A3244B
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 12:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06439168D2A
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 11:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3C320969A;
	Wed, 12 Feb 2025 11:07:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE552AF19
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358467; cv=none; b=BhNd02NE9WiNegyflZLQSqDK5JZPOTzPfXhUs1ASTSnDXpPo6wnUMHNDwYHtEK9y/F5xQlF+An0kB6Wqvr0VspJpdsNyPlaSAQW8ldRgmE/j5uxyQKXqCHirobm+K+4wIG0H+BqvaebXkQEsSnJ+3gY8ilA00Ms2LBH4aViQw1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358467; c=relaxed/simple;
	bh=9yMOmhhUFUbA0Fmn5/Y3+71OjXmwesBU1/yM7g3Z14A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WaRbz8SY5n1l4UVnvphasfd4wZaDEqm0Vde11mNJzJEVCtbTroiDlXBuh6lqRthxg5bGZ+0LcuvRRw1bISL8CpiP8X4RAzEP7PHiwtLQLMfUuiWiSLIb963mWSNn+evv3fGhHqfL0oZKMs2Ax1MUgoHN/+C795FCC1FoWh2AjUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz1t1739358426tfb60n7
X-QQ-Originating-IP: t/K+up6rcHS+INyoWcY3EXpQgDOZxLj1uUNx2QvBAQk=
Received: from smtpclient.apple ( [218.72.127.28])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 12 Feb 2025 19:07:03 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12815129633670899812
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
In-Reply-To: <20250211140652.6f1a2aa9@kernel.org>
Date: Wed, 12 Feb 2025 19:06:52 +0800
Cc: netdev@vger.kernel.org,
 jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <DF81ED4C-F36A-4D6C-8993-0389E2F39615@net-swift.com>
References: <20250206103750.36064-1-mengyuanlou@net-swift.com>
 <20250206103750.36064-6-mengyuanlou@net-swift.com>
 <20250207171940.34824424@kernel.org>
 <09EC9A07-7DA7-4D3E-85EE-F56963B54A66@net-swift.com>
 <20250211140652.6f1a2aa9@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N/EN6P+BmEafXVeU8LefB3lyOtpKAbcqPpyNEg4b/mewgE1xGK8RNJFP
	bLYkb7SKm9B5BR0aUUraEp6hqPfR1sKl5AGAH9WuleFK/dH2zBVZf+uD4GS40gOpcSrnznY
	HWZHeHWUqELtRUkVrStlWoxYQXke6TeuWkOtHpvGVHBtmlj0Q5AEiq+/juybK4ZZA4NE01+
	MJeTw41gwM28DSlcRXZMSi60h1Cha0O0fb5oOimZE4XB2lPWVh9xXFyTqOAfUjDIRfkwQg5
	udADuRGIDa5UnVIS+z+MSYPnyb61bjf5PQ2Jx5H8luZSiuDngDWmO+raWb6l14Xc8A8KBqH
	qx9kydaXtu512GJRl22o1Lfj6tBx3w55So5lVTHmCZYcXIDDZIVAbGn4soeKu0Q8ld8idvQ
	x8Dlx0JntGTrQQmu5/4jle4GVOYNZfjdZFedq/bDYwE9NTnI1Ww857otQ7ZkPpEdeK5PYrP
	kRBXxWD89maHBNgOVV/7tBlJwQ0zfDdmNct/dSX70ZujcfR/KXEkarCP7IwzZ5z47MUlkXY
	2Ua2cvsNEl1t3thUWl5QZEk06UhIhoohhVFtoKbCkUxzUIVXvVblPvlJeSsZrs6Itn3nWmF
	fkbYwIeeP/3qxjqHtcT7ZhXXuOJKUPoGQV/t1VU92uYjfej5v4xxbdCi/qHbFeWjfEkXPYK
	JEuSSuhXROA/1sbsHoYDxc15s+sIvtq6XPEKrFs4HtMUwQGZ1ECRq8lyDiD8TBXRelLaErl
	ER6bH46okw4toRVtOtcFTxlWVz/nGzcLPNHyIlcijKul/MnPk6ZGQwiMe7cF++wlqOIOKVq
	EWen1RkknFbmoRFuPooBWUJ0QAmznJMJP+OXFpj3EEe3ZCFqUcXXF4eCLy/GQ1cZehNSGed
	nB/dBihrHqjeTIqoF+MiMwdb7hBEpdkkPVZ3obene3x4S+EG6FYeFFmouiP+xjmTzwLVL2t
	/YdlIB3Z9rpL53h9zkiQl0oj/sU/MQ5dwDlXN7Tgg1GIT+rgH/6AGQ2Gv+nl0tR1X1Wc=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B42=E6=9C=8812=E6=97=A5 06:06=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, 11 Feb 2025 19:14:54 +0800 mengyuanlou@net-swift.com wrote:
>> Due to hardware design, when 6 vfs are assigned.=20
>> +------------------------------------------------------------+
>> |        | pf | pf  | vf5 | vf4 | vf3 | vf2 | vf1 | vf0 | pf |
>> |--------|----|-----|-----|-----|-----|-----|-----|-----|----|
>> | vector | 0  | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8  |
>> +------------------------------------------------------------+
>>=20
>> When 7 vfs are assigned.=20
>> +------------------------------------------------------------+
>> |        | pf | vf6 | vf5 | vf4 | vf3 | vf2 | vf1 | vf0 | pf |
>> |--------|----|-----|-----|-----|-----|-----|-----|-----|----|
>> | vector | 0  | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8  |
>> +------------------------------------------------------------+
>>=20
>> When num_vfs < 7, pf can use 0 for misc and 1 for queue.
>> But when num_vfs =3D=3D 7, vector 1 is assigned to vf6.
>> 1. Alloc 9 irq vectors, but only request_irq for 0 and 8.=20
>> 2. Reuse interrupt vector 0.
>=20
> Do you have proper synchronization in place to make sure IRQs
> don't get mis-routed when SR-IOV is enabled?

+ 	q_vector =3D wx->q_vector[0];
+
+ 	eicr =3D wx_misc_isb(wx, WX_ISB_MISC);
+
+ 	if (eicr & NGBE_PX_MISC_IC_VF_MBOX)
+ 	wx_msg_task(wx);
+
+ 	if (wx->num_vfs =3D=3D 7) {=20
+ 		napi_schedule_irqoff(&q_vector->napi);
+ 		ngbe_irq_enable(wx, true);
+ 	} else {
+ 		/* re-enable the original interrupt state, no lsc, no =
queues */
+ 		if (netif_running(wx->netdev))
+ 			ngbe_irq_enable(wx, false);
+ 	}

 if (wx->num_vfs =3D=3D 7) {=20
	if (!eicr) {
  		napi_schedule_irqoff(&q_vector->napi);
  		ngbe_irq_enable(wx, true);
	} else {
  		if (netif_running(wx->netdev))
  			ngbe_irq_enable(wx, false);
	}
 } else {
  	/* re-enable the original interrupt state, no lsc, no queues */
 	if (netif_running(wx->netdev))
 		ngbe_irq_enable(wx, false);
 }

Use eicr to determine whether it is an msic interrupt or a queue =
interrupt.

> The goal should be to make sure the right handler is register
> for the IRQ, or at least do the muxing earlier in a safe fashion.
> Not decide that it was a packet IRQ half way thru a function called
> ngbe_msix_other

Whether the first way(Alloc 9 irq vectors, but only request_irq for 0 =
and 8) can be better
than reuse vector 0 in the real?

>=20


