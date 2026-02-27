Return-Path: <netdev+bounces-261817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH1PGpB0oWkPtQQAu9opvQ
	(envelope-from <netdev+bounces-261817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:40:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C255F1B6160
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1CC43164A38
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE2039E6F1;
	Fri, 27 Feb 2026 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KFPxY4wr"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00C928150F
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772188694; cv=none; b=tjcqUOPBeU8/TH9+dx3xxG2uPrGGpGoOfmB6oZnmvk6gHJnzMzWTmW4lH1KP57cyG6dnjPtmqoknNfC4C2mPePvtMxX5/a4kUgp+7tuDMVXdc1bkDIEr+fGmP4IAKPgTmRmPfFQG3p8K0wIcbGQfZ7Eackd0HDLgQpKjlFqaln8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772188694; c=relaxed/simple;
	bh=D3CdrNY4TsQ8Ul99vMmmtRJORamGT+H7QEgjAxUZKzo=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=acJofL+1PFz1jitlb8nsZnj/vOxaeYQe+mpyypg4jpn5elqMYghiGxS/nmP+QiDiK8uiC9kJa8HYjlbKBh/fyRT1ERJNsbhA8uGOVxdmCbnIZ9kNKhdBgJE/Pm3rCPlNMvlIolc1Ab5kXrbUvTSmKWiuDaEqRPU9mpkgas97FQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KFPxY4wr; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772188680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrLRonMsnCVotmFrNK03+GHGpA++SDG71WGkPi8yPUk=;
	b=KFPxY4wrVLe1pzTCXQJdmsq7Vw6WG25wRwoCHbbfDRCtwF+6uNzM+L/2zsuudMhw1TQP2P
	2bJCYw3puk/13mBr/5RjofiPUOlnZSPMPaVu5/6K8cnglINchOpsgLcWTaYpH2ejgMprLl
	cm0puH6mRPydK84hPGNbyd4NLt6k20k=
Date: Fri, 27 Feb 2026 10:37:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <faed6bde8e7a96021bc9d55176b764c592f6ce08@linux.dev>
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
In-Reply-To: <20260227102149.10ZgLF-t@linutronix.de>
References: <20260227092254.272603-1-jiayuan.chen@linux.dev>
 <20260227092254.272603-2-jiayuan.chen@linux.dev>
 <20260227094558._Fna2iSe@linutronix.de>
 <4cc373b555ec3d6ff57037c569d12966a8b701db@linux.dev>
 <20260227102149.10ZgLF-t@linutronix.de>
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
	TAGGED_FROM(0.00)[bounces-261817-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,shopee.com,syzkaller.appspotmail.com,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,goodmis.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,80e046b8da2820b6ba73];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linutronix.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C255F1B6160
X-Rspamd-Action: no action

February 27, 2026 at 18:21, "Sebastian Andrzej Siewior" <bigeasy@linutron=
ix.de mailto:bigeasy@linutronix.de?to=3D%22Sebastian%20Andrzej%20Siewior%=
22%20%3Cbigeasy%40linutronix.de%3E > wrote:


>=20
>=20On 2026-02-27 10:17:29 [+0000], Jiayuan Chen wrote:
>=20
>=20>=20
>=20> bond_mode can be changed after device creation via sysfs or netlink=
, a bond created
> >  in active-backup mode can later be switched to round-robin, which me=
ans the allocation
> >  must not be conditional on the mode at creation time.
> >=20
>=20Must the device be in down state or can this be also changed while th=
e
> device is up?
>=20
>=20Sebastian
>

The mode change requires the device to be DOWN. BOND_OPT_MODE is defined =
with BOND_OPTFLAG_IFDOWN,
and bond_opt_check_flags() enforces this:

if ((opt->flags & BOND_OPTFLAG_IFDOWN) && (bond->dev->flags & IFF_UP))
  return -EBUSY;

The same restriction applies to the netlink path as well. Both sysfs and =
netlink go
through __bond_opt_set() =E2=86=92 bond_opt_check_deps(), which enforces =
BOND_OPTFLAG_IFDOWN
for mode change. Attempting to change the mode while the device is UP ret=
urns -EBUSY
regardless of how the change is requested.

So unconditional allocation in bond_init() covers all cases: whether the =
device is created in
round-robin mode, or switched to round-robin later
(which requires being DOWN, meaning bond_open() hasn't been called with t=
he new mode yet).

Thanks,

