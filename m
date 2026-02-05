Return-Path: <netdev+bounces-257100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIs0NSBphGlK2wMAu9opvQ
	(envelope-from <netdev+bounces-257100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:55:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59160F112D
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 10:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B893A3016EE1
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 09:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AF23A4F20;
	Thu,  5 Feb 2026 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUW7a+w3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ACD2D6409;
	Thu,  5 Feb 2026 09:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770285300; cv=none; b=GRKZvUvWib21B9N7yGExazorbAkcZIu13bhtSwHciI72X/0xRQ3ghYvADjO80LjHJcHVbKDsKsZIYonCWI75l7zyWjMf94NL9OYwDnyDwgIhYa0JUpI8lUo6H6Jr+M+dH77WaOLSm75m271065D4nfL+S8Jc/tjDB+s3LHQw/BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770285300; c=relaxed/simple;
	bh=P8Ez/5KiqJWkKnxyKsNthtgwrEXnmSki4zkSpe9Khuk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=f3ErN20aUbcX+xc8YnZTcEYABqZZcHwGjWcxjggt9ocFjv4PhdR5j8MdAqRpsAQFy+zIUkwq97rLaxNC19TbcrMNI+ltc+xhQWHeunVs8aCoiy2OfbO3JRqPLlj0auR6CVX44ssJ0IUwhEuroY9dlfGGzIP/y5eHIKyyQTRrU74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUW7a+w3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36ADC4CEF7;
	Thu,  5 Feb 2026 09:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770285300;
	bh=P8Ez/5KiqJWkKnxyKsNthtgwrEXnmSki4zkSpe9Khuk=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=WUW7a+w3VRuLvrWrimtObOGF5O9AIAHs068rVd4DfyK0Ngh30rv1e4InsQrW3Hasy
	 j8EZNXcDHtgLun6wjELo+9vM++piw9l+d/KsbqvgGHVzZrCbfrOvqqcnf0v14kQ9df
	 EhHcs9U19xE+SjG4J4JjPSZzb2PlhyBS7wQmqoWseNnTw0noMQwuC6m6TcoarmE43g
	 qk7kjlhuCT70JqYQ55LFFdP8NRweWWudUBsvLmnl4RNu+fRAFFZSGiLR6TnkRFhdFW
	 Fhg10ySAp88fIYuI5BVdoK8aKnrKCZe9RechdaPiC3pUcR5gnjv+3u23OKaGL0LAA4
	 9bhGbLDR7nTlA==
Content-Type: multipart/mixed; boundary="===============0855396603024733409=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <da02105f8b623cf906cccbc701787aec26bd7603f1855814285493beaa847196@mail.kernel.org>
In-Reply-To: <20260205092227.126665-1-yangfeng59949@163.com>
References: <20260205092227.126665-1-yangfeng59949@163.com>
Subject: Re: [PATCH v2] bpf: test_run: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
From: bot+bpf-ci@kernel.org
To: yangfeng59949@163.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org
Cc: bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  5 Feb 2026 09:54:59 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257100-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[163.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bpf_test_run_lwt_xmit_dst.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59160F112D
X-Rspamd-Action: no action

--===============0855396603024733409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 178c4738e..c05b31cd1 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -982,6 +982,7 @@ static struct proto bpf_dummy_proto = {
>  	.obj_size = sizeof(struct sock),
>  };
>
> +struct dst_entry bpf_test_run_lwt_xmit_dst;

The bpf_test_run_lwt_xmit_dst is a global variable shared by all callers of
bpf_prog_test_run_skb(). If two processes concurrently run LWT_XMIT tests,
could this race?

Process A:
    bpf_test_run_lwt_xmit_dst.dev = dev_A;
    skb_dst_set(skb_A, &bpf_test_run_lwt_xmit_dst);

Process B preempts and runs:
    bpf_test_run_lwt_xmit_dst.dev = dev_B;
    skb_dst_set(skb_B, &bpf_test_run_lwt_xmit_dst);

Now Process A resumes but skb_A's dst_entry has dev_B instead of dev_A.
This could lead to wrong headroom calculation in bpf_lwt_push_ip_encap()
via LL_RESERVED_SPACE(skb_dst(skb)->dev).

Would a per-cpu variable or allocating the dst_entry locally avoid this
race condition?

>  int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>  			  union bpf_attr __user *uattr)
>  {

[ ... ]

> @@ -1156,7 +1157,13 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>  		skb->ip_summed = CHECKSUM_COMPLETE;
>  	}
>
> +	if (prog->type == BPF_PROG_TYPE_LWT_XMIT) {
> +		bpf_test_run_lwt_xmit_dst.dev = dev;
> +		skb_dst_set(skb, &bpf_test_run_lwt_xmit_dst);
> +	}
>  	ret = bpf_test_run(prog, skb, repeat, &retval, &duration, false);
> +	if (prog->type == BPF_PROG_TYPE_LWT_XMIT)
> +		skb_dst_set(skb, NULL);

The skb_dst_set() documentation states: "Sets skb dst, assuming a reference
was taken on dst and should be released by skb_dst_drop()". The global
bpf_test_run_lwt_xmit_dst isn't reference counted and wasn't initialized via
dst_init().

When skb_dst_set(skb, NULL) is called, skb_dst_check_unset() will trigger
DEBUG_NET_WARN_ON_ONCE because the dst was set without the SKB_DST_NOREF bit.

Is this the intended behavior, or should skb_dst_set_noref() be used instead
(which would require holding rcu_read_lock)?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21706325881

AI-authorship-score: low
AI-authorship-explanation: The commit shows characteristics of human-authored code including real bug reporters, kernel crash stack trace from actual testing, and the self-aware comment Temporarily indicating the author knows this is not an ideal fix.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Race condition on global dst_entry when concurrent LWT_XMIT tests run, could cause wrong headroom calculation but unlikely to cause crashes in typical usage scenarios.

--===============0855396603024733409==--

