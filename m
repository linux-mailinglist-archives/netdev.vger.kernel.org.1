Return-Path: <netdev+bounces-290719-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGs7BIoSEGryTAYAu9opvQ
	(envelope-from <netdev+bounces-290719-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:23:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AE65B07D5
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EAB630621DE
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 08:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221293A71AA;
	Fri, 22 May 2026 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+yijezQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED43A6F0C;
	Fri, 22 May 2026 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438143; cv=none; b=TfnqK+9AjWuiRltsIVYGCNF6KhRMKBjQ4lZLxa7FK8HhRdqt1mESB2VdEPo/NZNs4ZHFB6ECumT7mW2wyQmZWufpVyO7J7vJC9uLn+CtaydXeNC3+7EhD9HzDmgvQq9I4ELWzJSrcilcUvc/6kG61G2nX+TOKMrlx7wrGacUZ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438143; c=relaxed/simple;
	bh=Gaiiz+IZDH5noZ4hjHUdHGUKZSATfQw00+iuBYAzzRU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Odby/kNlJvSEKKYYOdFo20pWelfD/rsWzjxU8rMMc7CpL5UAmcp8HCO4kgZ4R06rFbAWdXTdxywBGP0nxjlrpA4DL0pfVRoOZI/9u968vYcLW37P/2DbBDCY0jz+FIkzbPTMdHbbxsJFDGmKcpAPrQ1AjC3/xe42iiclNow2DJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+yijezQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401C41F000E9;
	Fri, 22 May 2026 08:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779438141;
	bh=uglbIFHHQy2ryBVfyMo/CXYPOKjc5dRxb8rx3hfcCdQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=h+yijezQDhv5zpXErW9JxB4WEhkYiCx8N06OBbtLFvH+GE86VX8qQ2LZmFxTHKz7J
	 OvCYduZEVQZzsTrIYJmuxasbM3xUQ21d1nGNRX3zKwzT//WWpiDGepyPg5iTF70YF0
	 WcgTWU44rOn3++CDgoZ/4iYPZ5kUZVyOcKsi5ajMYRFFv1K9bJee+g5AWQ2bpdBxTN
	 Fi9Wski0Xaa+zi8bfOj3IG0hTUdX/7wSaSbX4885aaIaQ+cH5Hu8AkLeYma6Ffw9c1
	 xJ6mOgt7AMwkYpAV/5bPWGRhwS7YDmeI6sHanZiTHcbFJQVB3/Y9xDwp3VDuj9WMgQ
	 L4I63CcTeJpCA==
Content-Type: multipart/mixed; boundary="===============8360733971623066269=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6c6b45f7ff66adefe9d470c2f2c9f0f3664877afc3f019249d1a92e8bd9125c8@mail.kernel.org>
In-Reply-To: <20260522074601.1658705-2-kuniyu@google.com>
References: <20260522074601.1658705-2-kuniyu@google.com>
Subject: Re: [PATCH v2 bpf-next 01/11] selftest: bpf: Use BPF_SOCK_OPS_ALL_CB_FLAGS + 1 for bad_cb_test_rv.
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@google.com,ncardwell@google.com,willemb@google.com,ukyab@berkeley.edu,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 22 May 2026 08:22:21 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290719-lists,netdev=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C2AE65B07D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============8360733971623066269==
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
> index 6935f32eeb8f..e30cb1fab079 100644
> --- a/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tcpbpf_kern.c
> @@ -92,7 +92,8 @@ int bpf_testcb(struct bpf_sock_ops *skops)
>  		break;
>  	case BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB:
>  		/* Test failure to set largest cb flag (assumes not defined) */
> -		global.bad_cb_test_rv = bpf_sock_ops_cb_flags_set(skops, 0x80);
> +		global.bad_cb_test_rv = bpf_sock_ops_cb_flags_set(skops,
> +								  BPF_SOCK_OPS_ALL_CB_FLAGS + 1);

Could BPF_SOCK_OPS_ALL_CB_FLAGS + 1 break on future kernels?

When this test is compiled, BPF_SOCK_OPS_ALL_CB_FLAGS + 1 evaluates to a
hardcoded value. If the compiled test runs on a future kernel where this
value is supported, the helper will successfully set the flag and return 0,
causing the test to fail.

The test also assumes contiguous bitmasks. If a flag is ever deprecated or
skipped, adding 1 could overlap with valid bits.

Would a safely distant bit like 1 << 30 be more robust for forward
compatibility?

(Reference: https://lore.kernel.org/bpf/20260508190227.AFAE9C2BD00@smtp.kernel.org/)

>  		/* Set callback */
>  		global.good_cb_test_rv = bpf_sock_ops_cb_flags_set(skops,
>  						 BPF_SOCK_OPS_STATE_CB_FLAG);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26275674572
--===============8360733971623066269==--

