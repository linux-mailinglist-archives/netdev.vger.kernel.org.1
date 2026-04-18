Return-Path: <netdev+bounces-279447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBE2NmDq4mm7AAEAu9opvQ
	(envelope-from <netdev+bounces-279447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:20:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F21441FACC
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B72B3057AB0
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 02:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A47F2741B5;
	Sat, 18 Apr 2026 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CYcclKBh"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B9A244675
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 02:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776478814; cv=none; b=Y/GbRNzQG76roLutJooBTkx2cj0NQtFEkqC2TTwbnhU0e+jlzAGt6SkQkccF5iTfm/k3zqmMjmAl5Y53uC+eLCbv2nkYzgfZWUzuPYzK7kD+KpQvKFKZvgEXbgHclfuFr6ZVmc/+DjeNTU61bcrJEqyzVrKBPfd+d/ZA9wf14Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776478814; c=relaxed/simple;
	bh=krIL5LliMFqBdamlfABzrQ1vaROj27CelBXXXZaKlUE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gKpXOWKN0Lx70RXEpQkJJ7krm7Q126LKymC8sGxrLFC7zhSnMsWEWmkSRMf6lFQulTrEvG5MQeK0kHe+bm2i1tlk6cgvAmO/+O9CnKIJ94lxLMyIyt1iKEt3+v8TJB1QQNPKtON0QRTHdmkqBP5VaixbRzPHpWcReDNN/L2+tT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CYcclKBh; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9b3e7c118f5b9105b92f53b66034c1b7884c1372.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776478800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SA5yDEc0vpjcomraIWzfWrwgltOn9HBRTiz9ZPZCEuU=;
	b=CYcclKBh5JweSIQkZS6zq+Q6FHigJgl82BGBIKHjF13EzxDWkw2wB483gTS1fxkhpUNH74
	50eE18xI84dV5rYG8oXuGZzsPQrEGhRd01WtisVhdOdYdtYHOmE03KMfrCf5IVKq9oAlnE
	xtg2sQFeRjxXy275XfVRiVBKMbc10qw=
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Test TCP_NODELAY in TCP hdr
 opt callbacks
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 davem@davemloft.net,  edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org,  shuah@kernel.org,
 jiayuan.chen@linux.dev, bpf@vger.kernel.org,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Date: Sat, 18 Apr 2026 10:19:47 +0800
In-Reply-To: <2026417162132.9MRI.martin.lau@linux.dev>
References: <20260417092035.2299913-1-kafai.wan@linux.dev>
	 <20260417092035.2299913-3-kafai.wan@linux.dev>
	 <2026417162132.9MRI.martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[iogearbox.net,gmail.com,fomichev.me,kernel.org,linux.dev,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-279447-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kafai.wan@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[22];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4F21441FACC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-04-17 at 09:25 -0700, Martin KaFai Lau wrote:
> On Fri, Apr 17, 2026 at 05:20:35PM +0800, KaFai Wan wrote:
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> > b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> > index 56685fc03c7e..7b9dbbb84316 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> > @@ -461,7 +461,7 @@ static void misc(void)
> > =C2=A0	const unsigned int nr_data =3D 2;
> > =C2=A0	struct bpf_link *link;
> > =C2=A0	struct sk_fds sk_fds;
> > -	int i, ret;
> > +	int i, ret, true_val =3D 1;
> > =C2=A0
> > =C2=A0	lport_linum_map_fd =3D bpf_map__fd(misc_skel->maps.lport_linum_m=
ap);
> > =C2=A0
> > @@ -477,6 +477,10 @@ static void misc(void)
> > =C2=A0		return;
> > =C2=A0	}
> > =C2=A0
> > +	ret =3D setsockopt(sk_fds.active_fd, SOL_TCP, TCP_NODELAY, &true_val,=
 sizeof(true_val));
>=20
> Same comment as in v2. Why this setsockopt is needed?

Sorry I miss this.=C2=A0It's from the review of v1, my first version would =
break the syscall setsockopt
and other CB besides HDR_OPT_LEN/WRITE_HDR_OPT. So in the test I check sets=
ockopt() and
bpf_setsockopt() in PASSIVE_ESTABLISHED_CB to make sure patch#1 would not b=
reak=C2=A0user space and other
CB.

> The setsockopt in userspace is unnecessary.=C2=A0

Is bpf_setsockopt() in PASSIVE_ESTABLISHED_CB also unnecessary? I'll respin=
 if they are unnecessary.

> In the future,
> we may need to understand why it is needed here in the first place.

Okay, I'll remember that. Thanks for the review and guidance.

--=20
Thanks,
KaFai

