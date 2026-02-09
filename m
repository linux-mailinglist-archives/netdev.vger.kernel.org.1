Return-Path: <netdev+bounces-257950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fN3oDc3miWmdDwAAu9opvQ
	(envelope-from <netdev+bounces-257950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 14:53:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B599610FE89
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 14:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3E133006129
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511B1372B40;
	Mon,  9 Feb 2026 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="guMRoYZA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-106103.protonmail.ch (mail-106103.protonmail.ch [79.135.106.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCE62BEC45
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 13:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770645193; cv=none; b=R8PIle79zw9HaQoZKBHBvuO5QYMgGNmWxKzKT3t5lggqw0JNuP4PtbkncCAyIeMEwSXm4L43D7SPRiu9gtiMBkyNFJRoArKxMAixCwtBLhFYbaK43eQ9HJ4apbf+yWKNwqHalIvBb4W5KPZ0eKeK+BFjyZvIZokm1Pm5ih94xeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770645193; c=relaxed/simple;
	bh=QEvDtNp7cOzOy14t3RKclShQEtSTQtGvZMK9m502nDM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQO5mEodrmDXtoPksa3yzX4ysAVlFhHuzIMMOPtqBdBOQlEaRfa4kZh7wPkv3s0jfijUTQdbz91WftJ4NRbbnYkhGUQ78tNemLN2mj6QH5ZArPByzdj9aeYF1P2FZmsfoLqvbDR9M7Vs1hB9djinHHa81CllBJEhdAIi6wucfgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=guMRoYZA; arc=none smtp.client-ip=79.135.106.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1770645184; x=1770904384;
	bh=qThnl6dxB4UHwumD/exDaYaZGRJ42VZRF25cGvkgvOk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=guMRoYZApErmUNOj2HOQ7g3/ICTVH5Gj45YGKdwuGn0tLnn+o9RTbTNNYVAHT5Exb
	 mis281LnYa3EaoYiWodbs/08nCWYFBWexJXC++6IjgEYbAIg6KpzD0/jVq60YOz20C
	 oZ1Cbx1mo8rpG9JkhO4BmBShH9VRiJlSW3Sn8ghg4i+NDbUkjR+yalG+c+6uDfzSl4
	 WNZ0Ql8Qlwfevww3I0D2rrfkC/6xiqk6YpxeQoyzWitQ22gol0Raiu7hT6HTAlIpkb
	 /EjYvzBz98pyt9x0Bs14gmUUfhjk+Y234BO2XXYqjwqreY3fV1GB+XwpffBOdjGjuw
	 TGUM90GuvItpA==
Date: Mon, 09 Feb 2026 13:53:01 +0000
To: Fernando Fernandez Mancera <fmancera@suse.de>
From: longxie86@protonmail.com
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, ncardwell@google.com, kuniyu@google.com, dsahern@kernel.org, idosch@nvidia.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Thorsten Toepper <thorsten.toepper@sap.com>
Subject: Re: [PATCH RFC net-next] inet: add ip_retry_random_port sysctl to reduce sequential port retries
Message-ID: <egIQQeDF4RIP_614tU-XIK-01DgThdPOU3KA253uNHvZv76zymXyBFhey1G7wj5mA2nwHpdT7VBoGuFnATSO-PS0hUb0Qrt0AyN5JNbpATg=@protonmail.com>
In-Reply-To: <d76cd8c3-deb0-4f39-b5b9-a711d155cd5f@suse.de>
References: <20260203175422.4620-1-fmancera@suse.de> <CANn89i+UUWx5OhPnJnDhiCfr53BPTAGedBucgqYwyfqkidf_Cg@mail.gmail.com> <8d94faf9-2fb6-483d-9767-bd665c4a4b9a@suse.de> <1649583d-71c2-425e-a2df-685d5f6dc67d@suse.de> <CANn89iK3Pu2NXxejTSLF-7MhBc03_ZJUjOtZcTC4nMsbsDpbSw@mail.gmail.com> <d76cd8c3-deb0-4f39-b5b9-a711d155cd5f@suse.de>
Feedback-ID: 180095861:user:proton
X-Pm-Message-ID: f67ee07ca1d11e4c9452e88bbab14a77bad85b90
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[protonmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257950-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[longxie86@protonmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[protonmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,protonmail.com:mid,protonmail.com:dkim,0xffsoftware.com:url]
X-Rspamd-Queue-Id: B599610FE89
X-Rspamd-Action: no action

On Monday, February 9th, 2026 at 12:57 PM, Fernando Fernandez Mancera <fman=
cera@suse.de> wrote:

>=20
>=20
> On 2/6/26 6:09 PM, Eric Dumazet wrote:
>=20
> > On Fri, Feb 6, 2026 at 5:28=E2=80=AFPM Fernando Fernandez Mancera
> > fmancera@suse.de wrote:
> >=20
> > > It makes sense. I have tested this approach and we got a more even
> > > distribution of source ports when having thousands of reserved ports.=
 No
> > > difference at all when not using reserved ports.
> > >=20
> > > Please, you can find the distribution graph with the current algorith=
m
> > > [1] and with the random step algorithm [2].
> > >=20
> > > While I understand that this approach is introducing a call to
> > > get_random_u32_below() on every connect, I am wondering if it makes
> > > sense to replace the existing algorithm with this variant. What do yo=
u
> > > think?
> >=20
> > I would ask RFC 6056 experts like Fernando Gont what they think.
> >=20
> > Note that if we use random at each connect(), we defeat one of the prin=
ciples
> > of ephemeral port selection : try very hard to avoid 4-tuple collision.
>=20
>=20
> Right. I will reach out to him and get his opinion. I have plenty of
> time before net-next open again. I am also collecting some metrics
> regarding the 4-tuple collision frequency.
>=20

We have had this problem in AWS for a long time. The patch works on our sys=
tem. What is needed for it to be included in the next Linux release?

Please bring this to the stable versions.

> > > Please, notice the implementation below. I plan to send an official v=
1
> > > once net-next is open. In addition, I am rewriting the commit message=
 as
> > > I find the current one confusing.
> > >=20
> > > [1] https://0xffsoftware.com/port_graph_current_alg.html
> > >=20
> > > [2] https://0xffsoftware.com/port_graph_random_step_alg.html
>=20
> 

