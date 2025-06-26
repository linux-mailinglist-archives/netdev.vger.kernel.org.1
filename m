Return-Path: <netdev+bounces-201631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 173F0AEA268
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50021884E99
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691502E718D;
	Thu, 26 Jun 2025 15:14:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE292E7623
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750950890; cv=none; b=JUVXZhB4l/EvHKIvdVg+zgn9I7cQDBPfOtt/4xC0G7iGd8N1utPmfYAIDXoRAKW+zWuvOoZkShnteO0dxvq9UEmZZWg8OEHHrNC8sy5tm0CbX4H92BUgxbFG4OqLdwf3tvVtsEBguomD8eK8OIp/Y3uhZOLbscM0v/2magU25G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750950890; c=relaxed/simple;
	bh=HW4E2BblhSbmb5x/+dqdaUPg1kCK+EoOLlmPzy5ZV6A=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=q4EAPNrgnTm/uu+o/d+64jIoA+PN3xhGLclwzmqSzyW3czBmPQsH/A20fCTyID0E1fk8C5Ywonw9vFs1McrMYaZVH88VDKAMcj+UO5H5oeda9YwjJ3e4KsyoFuLuPH/dbLJrF+J3P7ulCsV1M40xZN0phAttZTNE15ANjLLuBeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz1t1750950855t19e150ea
X-QQ-Originating-IP: f7QwoxwxRraIcTaLOZwt5L2254wyXj/rE4GHiG6DR9Q=
Received: from smtpclient.apple ( [111.201.145.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Jun 2025 23:14:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6969059538934707343
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [net-next v7 3/3] net: bonding: send peer notify when failure
 recovery
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <46fe8f22-48a5-4593-827d-3b59e9aee7e0@redhat.com>
Date: Thu, 26 Jun 2025 23:14:03 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FADC88E5-0A83-47E7-9B24-E8CDE61F0035@bamaicloud.com>
References: <cover.1750642572.git.tonghao@bamaicloud.com>
 <6965bf859a08214da53cad17ea6ed1be841618fa.1750642573.git.tonghao@bamaicloud.com>
 <77694cec-af8e-4685-8918-4fd8c12ba960@redhat.com>
 <EA1E6A18-1A83-43B8-B91F-5755EB553766@bamaicloud.com>
 <46fe8f22-48a5-4593-827d-3b59e9aee7e0@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N83erINCyABsr/gEPy5da7kfO+lbN5uUq6RjVQ15uT53ns2WDnhE4xsh
	1DyX2fIY18YhbQ/kD1AxLN7x+c0nirffMI5dSFuK70KWdqtPimzUlNmZ8IVy5KCcT4SiD+U
	00KYqs915IaFDrn3Zn/ak7rKRxauIhN6wbWMyIKdCR6GvO7gRMa1NNau3UcqPBOSQxAt7Zg
	D+urdrAkEy6zy+4L4De2SY1NWscNz204Qw1yjHZMK8arAwUsHZzPARKsXV0HO9hzHTMGeCQ
	r1peViktC+iRgKRibfz4kolOoKTSI4NMtDCRsop/J0oS7Pko+5CnzEKDdGLMfJ4wLPLUUv1
	Pb87IPvYkXGHBNiYwqzd/YXdu5iJyKRQtTpjesfG0I5HOVlLJppUVEpGmYT8B0z5Vg9TUnO
	3k2InhNa27dCYh2As1KhujhzjNBA19yR3WTWwnKlH/CnEy8q+MV/sZdkBywczGvWZtPZfuP
	w5wI8APeaGccg0MPFBr9Be+7bWmWUgrkdd/MIkFmrLoB7bXSXDtDuTk2W6htfPSHtCmQU7s
	0K4ugWYGo6Lw7qbR4L3kp8h8iraoa4ITy4RNfrS3dR1ywU5s9reOnaxNoQ4yHjOwkAF8DiK
	RIFgTX479m1FkI/fcLYEkMbKKQdW/ErPDueWRMBB79w4K/g4OO5fmq2LuW+2CxbP+WSpl+E
	6rLIsz41iuhh2dGqSJUQpsbm9G0LPFgRrAPrz/EjM3lRy/UU972Zy/0RWtV/saUFpUCMw7J
	s+goAZ5l/zzCyfQ8R5Rq6Lv0RAv3LpQURpk2TPKdK5Ag9ZjKgsG/LURXBFw1/XL5qwz659t
	n7l5brXRaECciMoOnFDd2NY36BFnBoTs8vSLo9+SQSfGYCJsnPGRRd6BdEGI4wGePrgXqyF
	mc/CqTSLTefGjKgccPxirecU4+dEf1V8atXuJVeb4TKVmTQQpr0dSfiWLmur0r1XtjEQblB
	dLJU2irKkoUYSy+IDCqWLseINLSIRq5tbDGugfBXIK1jX9neXlvoezG2n5UTYclyXat9eVt
	dJlMGbfQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B46=E6=9C=8826=E6=97=A5 21:41=EF=BC=8CPaolo Abeni =
<pabeni@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 6/26/25 1:36 PM, Tonghao Zhang wrote:
>>> 2025=E5=B9=B46=E6=9C=8826=E6=97=A5 19:16=EF=BC=8CPaolo Abeni =
<pabeni@redhat.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>=20
>>> On 6/24/25 4:18 AM, Tonghao Zhang wrote:
>>>> diff --git a/drivers/net/bonding/bond_main.c =
b/drivers/net/bonding/bond_main.c
>>>> index 12046ef51569..0acece55d9cb 100644
>>>> --- a/drivers/net/bonding/bond_main.c
>>>> +++ b/drivers/net/bonding/bond_main.c
>>>> @@ -1237,17 +1237,28 @@ static struct slave =
*bond_find_best_slave(struct bonding *bond)
>>>> /* must be called in RCU critical section or with RTNL held */
>>>> static bool bond_should_notify_peers(struct bonding *bond)
>>>> {
>>>> - struct slave *slave =3D =
rcu_dereference_rtnl(bond->curr_active_slave);
>>>> + struct bond_up_slave *usable;
>>>> + struct slave *slave =3D NULL;
>>>>=20
>>>> - if (!slave || !bond->send_peer_notif ||
>>>> + if (!bond->send_peer_notif ||
>>>>   bond->send_peer_notif %
>>>>   max(1, bond->params.peer_notif_delay) !=3D 0 ||
>>>> -    !netif_carrier_ok(bond->dev) ||
>>>> -    test_bit(__LINK_STATE_LINKWATCH_PENDING, &slave->dev->state))
>>>> +    !netif_carrier_ok(bond->dev))
>>>> return false;
>>>>=20
>>>> + if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD) {
>>>=20
>>> I still don't see why you aren't additionally checking
>>> broadcast_neighbor here. At least a code comment is necessary (or a =
code
>> checking broadcast_neighbor is unnecessary, because send_peer_notif =
is set when bond is in BOND_MODE_8023AD mode and broadcast_neighbor is =
enabled.
>=20
> I see. send_peer_notif is cleared on mode changes, so we can't reach
> here with a non zero value after changing the mode to something else.
>=20
> IMHO the scenario is not trivial, a comment here is deserved (at very
> least because I already asked it 3 times ;).
Ok, thanks Paolo.
>=20
> Thanks,
>=20
> Paolo



