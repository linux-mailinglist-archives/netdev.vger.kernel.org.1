Return-Path: <netdev+bounces-300120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I7WQLRt4MmrJ0QUAu9opvQ
	(envelope-from <netdev+bounces-300120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:34:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B18969887A
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 12:34:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CnyzbjZt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300120-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300120-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10C1D304AE5F
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 10:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D423F5BC0;
	Wed, 17 Jun 2026 10:31:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A763F39EA;
	Wed, 17 Jun 2026 10:31:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781692270; cv=none; b=LRXZq4PTQuoBDo41P15d4WVnooRQZ4CRoBCY4P44gxBl7pkKh13EWgXEAqYx0iQe+ikKBsKfVBL6zTZiCjAGs68IGW8sKho5ga3J4zlDCndMRqE64UFgFfMiyvDC96Yd4/30PTsDQnUoxjuflRLyXirhw2prUtIlQ6NZbxATRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781692270; c=relaxed/simple;
	bh=bepZvFwC0kuKVlHrcnGIZVDYxk3YMdG2buaGxwd2CvM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PPKd6ItbQNKuZ4+FDqOB/qFrqkX6cP9YN10sa6KDh2yI9UzS7rFlmbhiYmTGp7ukmd227vIqr7mAdjmWcKpzu3PJKb96b2wC9AcawgNUnUVx1Z/12ADqQCBwOW8VyLpaLWWLx3k0CUYgKvux9h1QmCk+CAKhF9Eahgw/QaeOm2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnyzbjZt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4621B1F000E9;
	Wed, 17 Jun 2026 10:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781692269;
	bh=4s8B06hQ1rOc/7iH9nprTQEQF8ufGwjXXUdHj5x0TCs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CnyzbjZtGuF/6gdPW7lMycDU4SZO4IcXziYsHEThVqK11jpusegvDd3+2KvQgM67A
	 gqezhFH9DgwFxksLVboLCIkxXgTvOy05v1/TyOLygKgX2Z5A9TMibduMm4DNbaaiRn
	 UgePUvkKdV7WxODY3i9H7kFVO4fmIR//dZpj4hErX2VaIdQH0NVlSvllS9NY5kcPV5
	 0mQCWr28tgt2AX7Jkdi016MrkmcgL8wp2UgeulVXnLWkVSLSMwXcz/pCMC63s6ZIKZ
	 KLi2CxKWgIZMZ6ghcFT2P3UIwQK6H/p7oNMkEwI4t+hNkxkO5ij6TjqbwEatm0gzBr
	 GR5sviGA0gjmA==
Content-Type: multipart/mixed; boundary="===============8536718724851256273=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2dad9b5c184fa101d7cffa1d8f5eea5b5df60f53533d98c68175c9e3ec5ee6ac@mail.kernel.org>
In-Reply-To: <20260617093557.63880-3-sun.jian.kdev@gmail.com>
References: <20260617093557.63880-3-sun.jian.kdev@gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Cover partial copy of non-linear test_run output
From: bot+bpf-ci@kernel.org
To: sun.jian.kdev@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,toke@redhat.com,lorenzo@kernel.org,paul.chaignon@gmail.com,sun.jian.kdev@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 17 Jun 2026 10:31:08 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	TAGGED_FROM(0.00)[bounces-300120-lists,netdev=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,google.com,redhat.com,fomichev.me,meta.com];
	FORGED_RECIPIENTS(0.00)[m:sun.jian.kdev@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:toke@redhat.com,m:lorenzo@kernel.org,m:paul.chaignon@gmail.com,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:sunjiankdev@gmail.com,m:johnfastabend@gmail.com,m:paulchaignon@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B18969887A

--===============8536718724851256273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> index 01f1d1b6715a..9cc898e6a9f7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> +++ b/tools/testing/selftests/bpf/prog_tests/prog_run_opts.c
> @@ -4,6 +4,10 @@
>
>  #include "test_pkt_access.skel.h"
>
> +#define NONLINEAR_PKT_LEN 9000
> +#define NONLINEAR_LINEAR_DATA_LEN 64
> +#define SHORT_OUT_LEN 100
> +

[ ... ]

> @@ -20,6 +24,69 @@ static void check_run_cnt(int prog_fd, __u64 run_cnt)
>  	      "incorrect number of repetitions, want %llu have %llu\n", run_cnt, info.run_cnt);
>  }
>
> +static void init_pkt(__u8 *pkt, size_t len)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < len; i++)
> +		pkt[i] = i & 0xff;
> +}

A question was raised on v2 about whether pkt_v4 could be reused by
reducing the linear area to ETH_HLEN, rather than introducing a custom
init_pkt() with a 9000-byte stack packet.

Can't we reuse pkt_v4 here by reducing the linear area to ETH_HLEN?
The v3 still adds init_pkt() and the NONLINEAR_PKT_LEN packet, so this
doesn't seem to have been picked up.

> +
> +static void test_skb_nonlinear_data_out_partial(struct test_pkt_access *skel)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	__u8 pkt[NONLINEAR_PKT_LEN];
> +	__u8 out[SHORT_OUT_LEN];
> +	struct __sk_buff skb = {};
> +	int prog_fd, err;
> +
> +	init_pkt(pkt, sizeof(pkt));
> +
> +	skb.data_end = NONLINEAR_LINEAR_DATA_LEN;
> +
> +	topts.data_in = pkt;
> +	topts.data_size_in = sizeof(pkt);
> +	topts.data_out = out;
> +	topts.data_size_out = sizeof(out);
> +	topts.ctx_in = &skb;
> +	topts.ctx_size_in = sizeof(skb);
> +
> +	prog_fd = bpf_program__fd(skel->progs.tc_pass_prog);

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_pkt_access.c b/tools/testing/selftests/bpf/progs/test_pkt_access.c
> index bce7173152c6..cd284401eebd 100644
> --- a/tools/testing/selftests/bpf/progs/test_pkt_access.c
> +++ b/tools/testing/selftests/bpf/progs/test_pkt_access.c
> @@ -150,3 +150,15 @@ int test_pkt_access(struct __sk_buff *skb)
>
>  	return TC_ACT_UNSPEC;
>  }
> +
> +SEC("tc")
> +int tc_pass_prog(struct __sk_buff *skb)
> +{
> +	return TC_ACT_OK;
> +}
> +
> +SEC("xdp.frags")
> +int xdp_frags_pass_prog(struct xdp_md *ctx)
> +{
> +	return XDP_PASS;
> +}

A related suggestion on v2 was that, once pkt_v4 is reused, the existing
BPF program could be reused instead of adding new pass-through programs.

Could tc_pass_prog and xdp_frags_pass_prog be dropped in favour of the
existing program? The v3 still adds both of these, so this point also
seems to be open.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27680511802
--===============8536718724851256273==--

