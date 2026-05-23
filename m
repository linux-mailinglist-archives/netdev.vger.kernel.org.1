Return-Path: <netdev+bounces-291074-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPDOAEBuEWoLmAYAu9opvQ
	(envelope-from <netdev+bounces-291074-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 11:07:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8321E5BE1C8
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 11:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF546301BC1A
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 09:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D7F38398C;
	Sat, 23 May 2026 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSrHfWfS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72812F8EB0;
	Sat, 23 May 2026 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779527200; cv=none; b=IaDp9UXJl3iP+tgjFzo7rD4WhRxwFq/ngJAYeI1rZBgKzR5RJTNtzggRFHxY7TN9UcQTm4xC1nD5L4xUd7W/F5U0xeLAY+B4ZE/oJqaA2UxlW4sxEl43zOlYs+yyftgsYu4tdcoPg/LG7wB4+YCGIx7MytQtXwHc2NRiISciQ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779527200; c=relaxed/simple;
	bh=MWnytlhU1lVJTCM2BFRVZivM7gEIGDI1V/Q5V0B7FjA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jK2TPyhPx6s1l0A0Fkz/YUNp8vfFjco4e/zcmpZ84HdFGu4zWN1M5BAd3LASZ7FDClWbJiQ51VKOWglwwiwsGUifeumqZwK0pp1aph/lAzZKWd9oIg+OnZJZ05nvf4LXZfeZWrXw5IModpVibCgtyZXjsl0VePLp3bvDAfcF1Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSrHfWfS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788711F00A3C;
	Sat, 23 May 2026 09:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779527197;
	bh=OzCysc5Vp3US0AcCir5Nf0/1jRChQdoMpQmsHhUAwnM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=lSrHfWfSgI0ON0E6zwXAe3bFYJRpZW7tIj3W7eb3FC2I64S00TYpPfoXsDWm6eJy5
	 Q1BAEp2xCifjeCjOIV8pdcR2gLXqODluKjmYN2+3o2kvsFo2MlCzrCoxUDKTKF7ikU
	 x6tr1w0lclScApJd46+pSMh+5RWtjfXHHQEP7v+obg7sh53UEqf6bajZZAJ/f0eKfA
	 15MqDVlsXq5AjM0PBkg1GaXGv2KihZwUKhC2xx6eQ1AvNUJw9XZ2/7FjYg1td8i6Se
	 nFvXcFb4kkHEoCb8i7aQs7k6lZcLjwnLusXN0q41vH86lNzfBXuZL0QGTni/YmrPw5
	 fxBidr0eRm1kg==
Content-Type: multipart/mixed; boundary="===============3664743730976238922=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cb2abe0f8b44840acdccfc922f9afddf38a0e05b036ef43e906889379c740f86@mail.kernel.org>
In-Reply-To: <20260523083001.2911931-2-kuniyu@google.com>
References: <20260523083001.2911931-2-kuniyu@google.com>
Subject: Re: [PATCH v3 bpf-next 01/11] selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS + 1 for bad_cb_test_rv.
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@google.com,ncardwell@google.com,willemb@google.com,ukyab@berkeley.edu,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 23 May 2026 09:06:37 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291074-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org,kernel.org,iogearbox.net,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,kernel.org,iogearbox.net,linux.dev,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 8321E5BE1C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============3664743730976238922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> index 7e8fe1bad03f..e4849d2a2956 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tcpbpf_user.c
> @@ -26,7 +26,8 @@ static void verify_result(struct tcpbpf_globals *result)
>  	ASSERT_EQ(result->bytes_acked, 1002, "bytes_acked");
>  	ASSERT_EQ(result->data_segs_in, 1, "data_segs_in");
>  	ASSERT_EQ(result->data_segs_out, 1, "data_segs_out");
> -	ASSERT_EQ(result->bad_cb_test_rv, 0x80, "bad_cb_test_rv");
> +	ASSERT_EQ(result->bad_cb_test_rv, BPF_SOCK_OPS_ALL_CB_FLAGS + 1,
> +		  "bad_cb_test_rv");
>  	ASSERT_EQ(result->good_cb_test_rv, 0, "good_cb_test_rv");
>  	ASSERT_EQ(result->num_listen, 1, "num_listen");
>

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
> index 6935f32eeb8f..e4cb1fab079 100644
> --- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
> @@ -92,7 +92,8 @@ int bpf_testcb(struct bpf_sock_ops *skops)
>  		break;
>  	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
>  		/* Test failure to set largest cb flag (assumes not defined) */
> -		global.bad_cb_test_rv = bpf_sock_ops_cb_flags_set(skops, 0x80);
> +		global.bad_cb_test_rv = bpf_sock_ops_cb_flags_set(skops,
> +								  BPF_SOCK_OPS_ALL_CB_FLAGS + 1);

Multiple reviewers raised concerns about forward compatibility with this
approach. When the test is compiled, BPF_SOCK_OPS_ALL_CB_FLAGS + 1 becomes
a hardcoded value. If this compiled test runs on a future kernel where that
value becomes a valid flag, the helper will successfully set the flag and
return 0, causing the test to fail unexpectedly.

Additionally, this assumes contiguous bitmasks. If a flag is ever deprecated
or skipped, adding 1 could overlap with valid bits.

Would it be better to use a safely distant bit, such as 1 << 30, to guarantee
the flag remains unsupported and the test doesn't break in the future?

Reference: https://lore.kernel.org/bpf/20260508190227.AFAE9C2BD00@smtp.kernel.org/

This concern was raised by sashiko-bot@kernel.org in v1 and v2, and also
flagged by bot+bpf-ci@kernel.org in v2. The author's v1 response indicated
the test is not supposed to run on older kernels, but the reviewers are
concerned about FUTURE kernels, not older ones.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26328541814
--===============3664743730976238922==--

