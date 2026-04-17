Return-Path: <netdev+bounces-279293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP2mCqwH4mna0QAAu9opvQ
	(envelope-from <netdev+bounces-279293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:13:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F29F419F2E
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 12:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0896B3018585
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 10:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF65C3AB281;
	Fri, 17 Apr 2026 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgLmOHsn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA32733B6C6;
	Fri, 17 Apr 2026 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776420601; cv=none; b=ELEzST0B5L1B39psrunKLBVoovmvk01fJ7f6QT6HYqAzNW5CEI318urqHHirm0uUQBgkqFSzGxADJowcFvMOAl6jUi50FmGV+d3C2LU+A0mAWYNCW/1dOO6tWrKhNjXA4Z67kRbWkrqi8EvFzp/Cc1anPqPmM3GL+3SKmNVwxV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776420601; c=relaxed/simple;
	bh=DS/BrD9NVZLl9n2YbrPgzBv+89D0hS++LNwbEDuReb4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=r1ikt+E+eRIwx7Lf7HDyoUzRnNBN3vEW78563sp7WyugyFS0g5pXNRn7QphpqORkVFhkoB18+vABoe4pUfd0iW19IgruBgpBZsBOf5K5aN03Ci8au8wdQg8XxDKKDhbLAIvST/vIfQD0NoDkzmExf4QVqPl+wTvET3PU5fn3txo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgLmOHsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF93BC19425;
	Fri, 17 Apr 2026 10:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776420601;
	bh=DS/BrD9NVZLl9n2YbrPgzBv+89D0hS++LNwbEDuReb4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=MgLmOHsn31f2/5kSsyRZ+2nkau6AuWbUQYpMsN7UxWp1HHueq8DES7KlS8Gpc6R4q
	 /4KVz3Ff+MngDdZlthzn88qTd2V+m0LGFdmgqwD4shNZeKrHgBlxl40QllUHZfI+aC
	 DvB+kX3Wj5T6uvGkyzQqY8VRVhKO62aux6p0Gcd3L9bZ9upFXrFkeJ5CDCnSK05hKm
	 ZLW0xNeQuvDsx2dlgrHG1b/eNeX/yhgz8BxR9LPjP5QOMCEgJ+JVMuj1n4aBNLvqLI
	 +KdjESuQwldMAYJ3ASoRHMwAsvPqyqL4bE7EJz3jJVEcwUHeezUj7aYS1afCqS7tw3
	 9BINj2Y2a98ng==
Content-Type: multipart/mixed; boundary="===============6727964678341861361=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5fea6b5e9d1a13e72edf8222a8ebe50cbb660b37e62b87b65dab6f6f317943ec@mail.kernel.org>
In-Reply-To: <20260417092035.2299913-2-kafai.wan@linux.dev>
References: <20260417092035.2299913-2-kafai.wan@linux.dev>
Subject: Re: [PATCH bpf v3 1/2] bpf: Reject TCP_NODELAY in TCP header option callbacks
From: bot+bpf-ci@kernel.org
To: kafai.wan@linux.dev,martin.lau@linux.dev,daniel@iogearbox.net,john.fastabend@gmail.com,sdf@fomichev.me,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org,jiayuan.chen@linux.dev,kafai.wan@linux.dev,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org
Cc: 2022090917019@std.uestc.edu.cn,dddddd@hust.edu.cn,M202472210@hust.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Apr 2026 10:10:00 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279293-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[std.uestc.edu.cn,hust.edu.cn,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F29F419F2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============6727964678341861361==
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

Does this fix also need to block TCP_CORK? When bpf_setsockopt() is called
with SOL_TCP and TCP_CORK where the value is 0 (disabling cork), the call
path goes through:

bpf_sock_ops_setsockopt()
  -> _bpf_setsockopt()
    -> __bpf_setsockopt()
      -> sol_tcp_sockopt()
        -> do_tcp_setsockopt()
          -> __tcp_sock_set_cork(sk, false)

In __tcp_sock_set_cork() at net/ipv4/tcp.c, when cork is disabled, it
unconditionally calls tcp_push_pending_frames(sk):

net/ipv4/tcp.c:__tcp_sock_set_cork() {
    ...
    tcp->nonagle |= TCP_NAGLE_OFF|TCP_NAGLE_PUSH;

    tcp_push_pending_frames(sk);
}

This triggers the same recursion chain described in the commit message:

tcp_push_pending_frames()
  -> tcp_current_mss()
    -> tcp_established_options()
      -> bpf_skops_hdr_opt_len()
        -> BPF_CGROUP_RUN_PROG_SOCK_OPS_SK (re-enters with
           op=BPF_SOCK_OPS_HDR_OPT_LEN_CB)

causing unbounded recursion and kernel stack overflow. Note that enabling
TCP_CORK (val=1) is safe since it doesn't call tcp_push_pending_frames(),
only disabling it (val=0) does.


>  	return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optlen);
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24558395229
--===============6727964678341861361==--

