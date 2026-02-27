Return-Path: <netdev+bounces-261810-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCh/GoNvoWm6swQAu9opvQ
	(envelope-from <netdev+bounces-261810-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:18:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C02EE1B5ED8
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 242AA3115AFF
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8AE30FF36;
	Fri, 27 Feb 2026 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XxxWuBDX"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1CF25FA05
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772187468; cv=none; b=cDN5RMRlyKlklTEXHo2eRmVxaHnSWV2QBnkJl3LFMiRtIcszf5GWn5SRhC9BQDliABHcuj8+6UhZ2j+2cXcTvq3LMA7ylix5VcGE3zH7U/ODu8XUQ6xIHhB9LWi1iBPsPPyFjro5nPqXXjbwrj0dGmC/KAgvfMR3NTCqwVEjF38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772187468; c=relaxed/simple;
	bh=NW4dWVQlwvCzbVWNqt13jaHF92YiUWYLPdc4jid6CmM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=IB6mkkTCkWy8lEiVP2yLHd3PinAngWUlJQZWopmk5/xcZcwVUaClS/xHJ1jlRTUp9ZAGdDA95sKFTx80VAVBA6tU051mSSFusdJ/3MzoSoiI+COCmW62eKNKQANnVXnSsN8nhNBVgDAcQl/oAd19gTZDTL0ITrSy3ISbM+1TJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XxxWuBDX; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772187454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znk0ndRTMwqpetLAuBC2hcTpstjFU2Nmt/SHfAZLZ6k=;
	b=XxxWuBDXbRCk9C6RVmhQfZD3Flut1Pha4sF4gVVP6hm7fMjYYgVOiL320E6HgFV+u/65Im
	fAV5QkkXA11rUstBuJ5flELbDmNK4MUE2QxTz3wlCwTinVkGH414DT5cA0sb605mDKR+G+
	wAsvxNirEG1fVuZaHlfQMQqNn3pUGRU=
Date: Fri, 27 Feb 2026 10:17:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <4cc373b555ec3d6ff57037c569d12966a8b701db@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v2 1/2] bonding: fix null-ptr-deref in
 bond_rr_gen_slave_id()
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, jiayuna.chen@linux.dev, jiayuna.chen@shopee.com,
 "Jiayuan Chen" <jiayuan.chen@shopee.com>,
 syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com, "Jay Vosburgh"
 <jv@jvosburgh.net>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Jesper Dangaard Brouer"
 <hawk@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "KP Singh"
 <kpsingh@kernel.org>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Jussi
 Maki" <joamaki@gmail.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
In-Reply-To: <20260227094558._Fna2iSe@linutronix.de>
References: <20260227092254.272603-1-jiayuan.chen@linux.dev>
 <20260227092254.272603-2-jiayuan.chen@linux.dev>
 <20260227094558._Fna2iSe@linutronix.de>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261810-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,shopee.com,syzkaller.appspotmail.com,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,goodmis.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C02EE1B5ED8
X-Rspamd-Action: no action

2026/2/27 17:45, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de mailt=
o:bigeasy@linutronix.de?to=3D%22Sebastian%20Andrzej%20Siewior%22%20%3Cbig=
easy%40linutronix.de%3E > wrote:


>=20
>=20On 2026-02-27 17:22:49 [+0800], Jiayuan Chen wrote:
>=20
>=20>=20
>=20> --- a/drivers/net/bonding/bond_main.c
> >  +++ b/drivers/net/bonding/bond_main.c
> >  @@ -6458,6 +6458,12 @@ int bond_create(struct net *net, const char *=
name)
> >  dev_net_set(bond_dev, net);
> >  bond_dev->rtnl_link_ops =3D &bond_link_ops;
> >=20=20
>=20>  + res =3D bond_create_init(bond);
> >=20
>=20Wouldn't it be better to put into bond_init()?
>=20
>=20I haven't look into it but when can the bond_mode be changed?
>=20
>=20Sebastian
>

Thanks! bond_init() (ndo_init) is indeed a better fit, it is called by re=
gister_netdevice()
and naturally covers both bond_create() and bond_newlink() without a sepa=
rate helper.

bond_mode can be changed after device creation via sysfs or netlink, a bo=
nd created
in active-backup mode can later be switched to round-robin, which means t=
he allocation
must not be conditional on the mode at creation time.

