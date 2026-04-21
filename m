Return-Path: <netdev+bounces-280195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJk/BNCs52kM/AEAu9opvQ
	(envelope-from <netdev+bounces-280195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:58:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2FA43DAD4
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51D08307100D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7DA37C0FA;
	Tue, 21 Apr 2026 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IL8BIx6E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF29E303A04;
	Tue, 21 Apr 2026 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790316; cv=none; b=tiQkrzj2nAnuaTR7b5zKhgPSSJt+WNXd1xtTLJb71aZDcMUeCPY2C5VRa9CmX+ydy9q0hmlwKYFOfgPsNlSC4IiCpZt9KkH5kU/L6nsjQ0Nvpoq1406Y3UIqWoodNIAvyPHGRwr2ilvD6t5ibeKoDInooJwEBiBG9ny5vl+oRlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790316; c=relaxed/simple;
	bh=Uj4yLnfolWi0joGL37a4KRLKuEFr9kz2JSlGsbIgul4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YoP80GBiZQjTW8rz5um02aeqQpIxn1qCYMgUQ/9EHBtrJ6I5Mo90k1x5MQoVuEGafd1yeRAWLwCjyEbtdlzvO9/RL98DSplBiKiqgVlix8sSFNusBRdIRKrrKGCXYX4LioHBm6RukI4eKdx5Frov3KsCnETOaCA9de+j7hcYVqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IL8BIx6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD5DC2BCB3;
	Tue, 21 Apr 2026 16:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776790315;
	bh=Uj4yLnfolWi0joGL37a4KRLKuEFr9kz2JSlGsbIgul4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=IL8BIx6EfyKoEYPygkPr6xjPzls/EX0SAlTv0iEimorpFNhzSRIa3gqLhfhsf89Jh
	 5+AkVSNGpABXjSsQMs6E7Xx5IS4t7tOgpXePRZ8Uc8VzUz31roXN2zlj5fvKmT+7Tz
	 Z85nMo1H9U5uVbYVwYslqwiRBvL6jFdlhqB617Q3pXy8jJKQVKs4I61NtAyLD6ZJNG
	 atsbkvWXtAxTi15HwQshlyrRj8tsr0ZhDj5rYUHFB60V86injZ2dL1QycZtpPP9IGx
	 aDiSCFI/DY3DfTQrpOkrddmJjtRDTlJZL1RKnOd7Hf8UAFN8QICYZE8ilvGJVPsXuD
	 jN5Xztjn+3hxQ==
Content-Type: multipart/mixed; boundary="===============2527023340673005569=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <158599be54ab5be12aa6394a30c5d1e8f155abf8f580214ea78103a2ff8cfe3e@mail.kernel.org>
In-Reply-To: <20260421155804.135786-2-kafai.wan@linux.dev>
References: <20260421155804.135786-2-kafai.wan@linux.dev>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Reject TCP_NODELAY in TCP header option callbacks
From: bot+bpf-ci@kernel.org
To: kafai.wan@linux.dev,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,sdf@fomichev.me,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,dsahern@kernel.org,shuah@kernel.org,ihor.solodrai@linux.dev,kafai.wan@linux.dev,jiayuan.chen@linux.dev,hoyeon.lee@suse.com,ameryhung@gmail.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,linux-kselftest@vger.kernel.org
Cc: 2022090917019@std.uestc.edu.cn,dddddd@hust.edu.cn,M202472210@hust.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 21 Apr 2026 16:51:55 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280195-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[std.uestc.edu.cn,hust.edu.cn,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,fomichev.me,davemloft.net,google.com,redhat.com,suse.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E2FA43DAD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============2527023340673005569==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 5fa9189eb772..96849f4c1fbc 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5833,6 +5833,12 @@ BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_sock,
>  	if (!is_locked_tcp_sock_ops(bpf_sock))
>  		return -EOPNOTSUPP;
>
> +	/* TCP_NODELAY triggers tcp_push_pending_frames() and re-enters these callbacks. */
> +	if ((bpf_sock->op == BPF_SOCK_OPS_HDR_OPT_LEN_CB ||
> +	     bpf_sock->op == BPF_SOCK_OPS_WRITE_HDR_OPT_CB) &&
> +	    level == SOL_TCP && optname == TCP_NODELAY)
> +		return -EOPNOTSUPP;
> +

Does this same recursion vulnerability exist for BPF TCP congestion
control algorithms using BPF_PROG_TYPE_STRUCT_OPS?

If a BPF congestion control algorithm invokes bpf_setsockopt(TCP_NODELAY)
from its cwnd_event callback when handling CA_EVENT_TX_START, could it
trigger unbounded recursion through this path:

BPF_PROG_TYPE_STRUCT_OPS cwnd_event callback (CA_EVENT_TX_START)
  -> bpf_setsockopt(TCP_NODELAY)
    -> tcp_push_pending_frames()
      -> tcp_write_xmit()
        -> tcp_transmit_skb()
          -> tcp_event_data_sent()
            -> cwnd_event()
              -> BPF congestion control cwnd_event callback

The author confirmed this issue in the v3 discussion thread and Martin
KaFai Lau suggested creating a new func_proto
(bpf_sk_setsockopt_nodelay_proto) to reject TCP_NODELAY for all struct_ops
programs, but this patch only addresses BPF_SOCK_OPS callbacks.

Reference: https://lore.kernel.org/bpf/20260418092235.98444C19424@smtp.kernel.org/


Does this fix also need to block TCP_CORK when the value is 0?

When bpf_setsockopt() is called with SOL_TCP and TCP_CORK with value 0
(disabling cork), the call path goes through __tcp_sock_set_cork() in
net/ipv4/tcp.c, which unconditionally calls tcp_push_pending_frames(sk)
when cork is disabled:

__tcp_sock_set_cork()
  -> tcp_push_pending_frames()
    -> tcp_current_mss()
      -> tcp_established_options()
        -> bpf_skops_hdr_opt_len()
          -> BPF_SOCK_OPS_HDR_OPT_LEN_CB

This triggers the same recursion chain described in the commit message,
but the patch only blocks TCP_NODELAY, not TCP_CORK with value 0.

Reference: https://lore.kernel.org/bpf/5fea6b5e9d1a13e72edf8222a8ebe50cbb660b37e62b87b65dab6f6f317943ec@mail.kernel.org/

>  	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optlen);
>  }
>


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24733356810
--===============2527023340673005569==--

