Return-Path: <netdev+bounces-279222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABURBy+k4Wl1wAAAu9opvQ
	(envelope-from <netdev+bounces-279222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 05:08:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8913041673C
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 05:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EDF83018432
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 03:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04D72E8897;
	Fri, 17 Apr 2026 03:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FJimC2q6"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45D18D636
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 03:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776395306; cv=none; b=KZtMwzxhDnlRKpQZGVssZjV9y5omVino8txR0yBB9GbKnYzqKJjltlNc7JeTBHjfmiS8d3TjOCEIEb8HJDB+jVHXufYS6iyO9tHe28oqGz6yzPl88ymaT1Ivs/6sDgI55Dq3UG96oMKnDx4X6X2ehAxiy0yPhLZSJk8d6G0z5xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776395306; c=relaxed/simple;
	bh=qPlTbEZw35AsBE/G7ZHRttLjCnYveS+K3cvQbHTG8xk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nUKNz5FuCi0S/yTjQgj2SMdQwwGUD1mOvnqsHY4OKrMHIVI2cR8HpkjSywEXg9SowxCBEQnhtkMINYwD2SY7g6XeQVcqsDdzxv7SQfI3ElQOJ6gDTbjWxCQ0nToQMC1Y3KLMrIUqClpG6ehJwKrAezD1iV/6i0KIxxJOaZp/KYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FJimC2q6; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d3560ae4d662400e64b1cc72b84e3836b7bc371a.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776395302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7RBHgDM72E4FFRUPPk/y4OrCekuqa2O/ftWhf5CuOtM=;
	b=FJimC2q6T7NSgxyJH739fNQrfVEGxPCogVc/rCWcdC3Z5b7MkYez+QRdKhbMXJTr3pPEhk
	VGy9xapTeyEHv3OKImdvFDakF8dLrX2x5yxYlCOTMlOBhud8DUA9fuwcVZh1PvhzmBJxc1
	+mAso4Ufu3IYv8aB0QJeeQWU8Ezqs98=
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test TCP_NODELAY in TCP hdr
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
Date: Fri, 17 Apr 2026 11:07:50 +0800
In-Reply-To: <2026416184330.-HAW.martin.lau@linux.dev>
References: <20260416112308.1820332-1-kafai.wan@linux.dev>
	 <20260416112308.1820332-3-kafai.wan@linux.dev>
	 <2026416184330.-HAW.martin.lau@linux.dev>
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
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279222-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[iogearbox.net,gmail.com,fomichev.me,kernel.org,linux.dev,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kafai.wan@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8913041673C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-16 at 12:06 -0700, Martin KaFai Lau wrote:
> On Thu, Apr 16, 2026 at 07:23:08PM +0800, KaFai Wan wrote:
> > index 56685fc03c7e..2d738c0c4259 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> > @@ -513,6 +513,59 @@ static void misc(void)
> > =C2=A0	bpf_link__destroy(link);
> > =C2=A0}
> > =C2=A0
> > +static void hdr_sockopt(void)
> > +{
> > +	const char send_msg[] =3D "MISC!!!";
> > +	char recv_msg[sizeof(send_msg)];
> > +	const unsigned int nr_data =3D 2;
> > +	struct bpf_link *link;
> > +	struct sk_fds sk_fds;
> > +	int i, ret, true_val =3D 1;
> > +
> > +	lport_linum_map_fd =3D bpf_map__fd(misc_skel->maps.lport_linum_map);
> > +
> > +	link =3D bpf_program__attach_cgroup(misc_skel->progs.misc_hdr_sockopt=
, cg_fd);
> > +	if (!ASSERT_OK_PTR(link, "attach_cgroup(misc_hdr_sockopt)"))
> > +		return;
> > +
> > +	if (sk_fds_connect(&sk_fds, false)) {
> > +		bpf_link__destroy(link);
> > +		return;
> > +	}
> > +
> > +	ret =3D setsockopt(sk_fds.active_fd, SOL_TCP, TCP_NODELAY, &true_val,=
 sizeof(true_val));
> > +	if (!ASSERT_OK(ret, "setsockopt(TCP_NODELAY) active"))
> > +		goto check_linum;
> > +
> > +	ret =3D setsockopt(sk_fds.passive_fd, SOL_TCP, TCP_NODELAY, &true_val=
, sizeof(true_val));
>=20
> Why are these two setsockopt(TCP_NODELAY) calls needed?
>=20
> Instead of creating a new "void hdr_sockopt(void)", can the test be done =
in the
> existing "void misc(void)" by doing bpf_setsockopt(TCP_NODELAY) in the
> misc_estab() bpf prog?

Oh, I see.=C2=A0I meant to test on both active and passive side. We can onl=
y test on active side in the
existing "void misc(void)".
>=20
> The PASSIVE_ESTABLISHED_CB can do the bpf_setsockopt(TCP_NODELAY, 0)
> if it wants to keep the same expectation on Nagle. The
> BPF_SOCK_OPS_HDR_OPT_LEN_CB and BPF_SOCK_OPS_WRITE_HDR_OPT_CB
> can do bpf_setsockopt(TCP_NODELAY, 1) to test recursion and
> the error return value.
>=20
> > =C2=A0void test_tcp_hdr_options(void)
> > diff --git a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_option=
s.c
> > b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
> > index d487153a839d..a8cf7c4e7ed2 100644
> > --- a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
> > +++ b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
> > @@ -28,6 +28,12 @@ unsigned int nr_data =3D 0;
> > =C2=A0unsigned int nr_syn =3D 0;
> > =C2=A0unsigned int nr_fin =3D 0;
> > =C2=A0unsigned int nr_hwtstamp =3D 0;
> > +unsigned int nr_hdr_sockopt_estab =3D 0;
> > +unsigned int nr_hdr_sockopt_estab_err =3D 0;
> > +unsigned int nr_hdr_sockopt_len =3D 0;
> > +unsigned int nr_hdr_sockopt_len_err =3D 0;
> > +unsigned int nr_hdr_sockopt_write =3D 0;
> > +unsigned int nr_hdr_sockopt_write_err =3D 0;
>=20
> nr_hdr_sockopt_estab, nr_hdr_sockopt_len, and nr_hdr_sockopt_write
> are unnecessary. These tests have already been covered in some ways.

yes, they are unnecessary in existing misc_estab()
>=20
> Mostly a nit. The new counters are used in both connections. Note the
> existing nr_xxx is exclusively used in either active or passive,
> so there is no parallel counting in practice.
>=20
> Instead of counting, just use a bool nodelay_est_ok,
> nodelay_hdr_len_err, nodelay_write_err and assert them
> to be true in userspace.

indeed. will fix these in next version.

--=20
Thanks,
KaFai

