Return-Path: <netdev+bounces-198512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0FCADC82A
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29650188D4B0
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAA3291C13;
	Tue, 17 Jun 2025 10:26:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8487262B
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750155996; cv=none; b=CnkaHlxWPcW2M1E3hNpZ362EJGbX+D01+2KZre752Dnd8NKZJcVQzflDPPUouq6wKUu8Iba+Tg1HtcBMoxvNZgdDoaoU5Y7JZnREMxuwt/NAd+au3SuHE4f8QB68nf6niADE1lyH0OhqMH2SXhhkRi7LUKRLoS65UqNyT1ma6QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750155996; c=relaxed/simple;
	bh=oCij1Ggt853Fuf+idNfxBlGZT3/JEnF0MYY7UjGItss=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JsyvnO8B+XmVm6Sdi5kv5olnCLHiYJBh+0EZuyfsqSzGc13KWD7f2dE4Nn3KuemrUL67TLtM8GYz38t984InO0MKqowa72vtZFTilwXxX48//6mzryVuCjMDUUPPoMz7p3lW+kYvB+XmcR82njj2dZAnpYwx/QqA71/Rjaco+Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz3t1750155960tbe971f0d
X-QQ-Originating-IP: Lm8akfMBp6+jS6GzwQCy74lykbjwlMggpSuHC0AGiLA=
Received: from smtpclient.apple ( [111.202.70.102])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 17 Jun 2025 18:25:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9586956857377675218
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [net-next v6 1/4] net: bonding: add broadcast_neighbor option for
 802.3ad
From: Tonghao Zhang <tonghao@bamaicloud.com>
In-Reply-To: <20250616160431.2aff8ec6@kernel.org>
Date: Tue, 17 Jun 2025 18:25:47 +0800
Cc: netdev@vger.kernel.org,
 Jay Vosburgh <jv@jvosburgh.net>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Zengbing Tu <tuzengbing@didiglobal.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DC8E2D25-3CEB-4E45-965E-D6A3D2DD4B3D@bamaicloud.com>
References: <cover.1749525581.git.tonghao@bamaicloud.com>
 <ff319dfdedc2bc319431c49d7f71faaa80c42d44.1749525581.git.tonghao@bamaicloud.com>
 <20250616160431.2aff8ec6@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MG1k13TElWXs+zlFe3SnXmJHYimzh4GbY2VXG5f7/ZYwpvsAfYNbKnsO
	CurRmKPrVMk6XNCqumfv+JBOF6jLt5hLgq3yGRwa4vWEp0ID9TYRdbi8bJO1FmKeDDmM8XD
	7QG4vvDivygQQy4u4gPSBdgxRPp+DqtawHk3lzgyDLVkJ+7kN9DFKzWexjSJYmuzOkVOI3U
	NGr2TqNa5sfOOA6dlE/RQ40tUYMAI//zmSFO0w8KFpOIEsVrUJxOJi2zXycl0n5MEMr6i/o
	idFKFSIJXK+AKj378Frchtckcv+GhlJALDAZ4l+v25USoyOKvl1/dxwlEDJHu+TfjJdIYuN
	GxBRLzmplU7tUhdYet83mEBwcjTCVzop1TUDJ1tAks39dVNfh3LW46YMDqJtr34NkukSmq3
	nsLtDEIdup5r+ptwbejh8HWPYe1H3wv5ANx5lUDuZ1QxqeO2mZ6gM33PorFAq62MPrPgutN
	0lyPAdRe4wK8HzyD9tuYl8eqmUNKPIt2vMG758PdLmKzxezMmeW4htWyW9zmtfyCnsYhgOi
	hpdyKte7eNITIh5XQHYuIOooe2gYsaRMNXMvviqCzMktpoLPBq6qa5B30vPQE8sRa8bbAl+
	aTHMO5/AzwOt/93lN/Sb1KLqb9pSPydeLzCGJSH7I3m65TSkct2k4EZErwCwfahLe7MA5jr
	onaWri6oqnNzpuLOSNEWnD6TYiz2bZqelnxNpob8cmFNudvIC5bmRyJASSSc6QLwN3IdnDo
	44GzwQh7uo2JQgc6fQA35ABCsRUismH9A29vigbhMJhVxj27e0jzzE+kQA8VnPP9mdS1HPx
	yvqewU+n18QCO3rCcaUaAQSfOpV/e5qlCoMNesPxMAGk/jUGqjqSQRJwZqAE2zo2wt3R/9v
	PLAQyXndBXEH2eBDDjllnLQnZi2NFBuCu3udsHE8wZ8+nFXCtEJYRLl2XuP4tr3B++PxqxU
	MCiU+HNKOUNqbD594scSAabB5dV1cl6EnAKM=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B46=E6=9C=8817=E6=97=A5 07:04=EF=BC=8CJakub Kicinski =
<kuba@kernel.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, 10 Jun 2025 11:44:42 +0800 Tonghao Zhang wrote:
>> + if (bond->params.broadcast_neighbor)
>> + static_branch_inc(&bond_bcast_neigh_enabled);
>> }
>>=20
>> if (bond_mode_can_use_xmit_hash(bond))
>> @@ -4475,6 +4480,10 @@ static int bond_close(struct net_device =
*bond_dev)
>> bond_alb_deinitialize(bond);
>> bond->recv_probe =3D NULL;
>>=20
>> + if (BOND_MODE(bond) =3D=3D BOND_MODE_8023AD &&
>> +    bond->params.broadcast_neighbor)
>> + static_branch_dec(&bond_bcast_neigh_enabled);
>=20
> is .broadcast_neighbor automatically cleared when mode is changed?
> I don't see it in the code.
No clean this value when changing the mode, this option don=E2=80=99t =
work in other mode.  But it is better to clean up it.
> --=20
> pw-bot: cr
>=20
>=20


