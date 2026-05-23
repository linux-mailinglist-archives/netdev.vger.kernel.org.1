Return-Path: <netdev+bounces-291077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iB8/CoNxEWq5mAYAu9opvQ
	(envelope-from <netdev+bounces-291077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 11:21:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCD65BE2CA
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 11:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1D663007515
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 09:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15980385D91;
	Sat, 23 May 2026 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8y2TV6t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFDB3859E9;
	Sat, 23 May 2026 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779528054; cv=none; b=pGs6iN1vwgVCONB++3oq3zwIepKczqaPn7uDgnrIZnvCiBIfSkinWvfqJge0KLTy2k6KkCfMgmXqZdtKgHTssugJJTjCKbq9y8LdkVJ2or7mrnD5I4AliE//Z/3RRpMqHF8fJFvdvXo3cE7Q1QorOwywhPEaPSGmYHkAAOu/w8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779528054; c=relaxed/simple;
	bh=0Bo391fQLc8HvX5KY/9fQS1og9DlFVijIbtn5gxFwM0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=VO5YzACNOIuyygIkKdpEDPnA2Jichn2NAFIkmv6rT2jMA6W+qePjKzmHxKc29hb0koHlAX++Wqf+CCMBWza/i2owsnmWqZsNxSXzjWB/ICE+ct92dZs1JRMqIToRREmwR8xONxgzcjBO25c1N2fz9Rkqk7lQASZidJDFldA+Afs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8y2TV6t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ECE1F00A3D;
	Sat, 23 May 2026 09:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779528051;
	bh=o4GCMZQCtKTmkJr7KIm5wGVtLoy3y9Uu3eGH/9pW5ok=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=A8y2TV6tDlQLkpdXE2tjKGqvo2ip0UkzMVwwNdclMScW6z1kR4micEgUt+nGfaRk+
	 MZ/5t2fZ9Dn+TIS08liCXHVMnfPyYCb89S+MD90r3ixb+XhFLeuPjqT1jvOo36QD4I
	 GJRvSPjcU6lcv8YeUSe1M8BpeeMztkLHAgZiYExbje0CqPtV2mXjw5ZtIjbmC6p89u
	 /E5L/0c1+LUsJ7A/xAYDh8iIHn05iGvkj71Q/96jpqnYt+rwOsK8RZaMSswtNhIiDs
	 YUPSltJ/A0WgLbX5qq4DQVGLqzSinlYFxKOpeNrrXlGB3u6xxOZjO2nZhyCYILjOUo
	 IhmJsOPi+wpEw==
Content-Type: multipart/mixed; boundary="===============3434856789991386713=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0c3701f35cdef6411722a91c596d736cc9e88e3d7a14564caf5354302eb92d98@mail.kernel.org>
In-Reply-To: <20260523083001.2911931-7-kuniyu@google.com>
References: <20260523083001.2911931-7-kuniyu@google.com>
Subject: Re: [PATCH v3 bpf-next 06/11] bpf: tcp: Make BPF_SOCK_OPS_RCVQ_CB and SOCKMAP mutually exclusive.
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@google.com,ncardwell@google.com,willemb@google.com,ukyab@berkeley.edu,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 23 May 2026 09:20:51 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291077-lists,netdev=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BCCD65BE2CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============3434856789991386713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index c6a6853909c4..bc95d8e7b62e 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2853,6 +2853,7 @@ struct sk_msg;
>  struct sk_psock;
>
>  #ifdef CONFIG_BPF_SYSCALL
> +bool tcp_in_sockmap(const struct sock *sk);
>  int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore);
>  void tcp_bpf_clone(const struct sock *sk, struct sock *newsk);
>  #ifdef CONFIG_BPF_STREAM_PARSER
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3608036632a8..1fb63b264b18 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -5382,12 +5382,34 @@ static int bpf_sol_tcp_getsockopt(struct sock *sk, int optname,
>  	return 0;
>  }
>
> +static int __bpf_sock_ops_cb_flags_set(struct sock *sk, int val)
> +{
> +	if (!(val & BPF_SOCK_OPS_RCVQ_CB_FLAG) ||
> +	    tcp_sk(sk)->bpf_sock_ops_cb_flags & BPF_SOCK_OPS_RCVQ_CB_FLAG) {
> +		tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
> +		return 0;
> +	}
> +
> +	write_lock_bh(&sk->sk_callback_lock);
> +
> +	if (unlikely(tcp_in_sockmap(sk))) {
> +		write_unlock_bh(&sk->sk_callback_lock);
> +		return -EBUSY;
> +	}
> +
> +	tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
> +
> +	write_unlock_bh(&sk->sk_callback_lock);
> +
> +	return 0;
> +}
> +

[ ... ]

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6..7e7966b095f9 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -705,6 +705,16 @@ int tcp_bpf_strp_read_sock(struct strparser *strp, read_descriptor_t *desc,
>  }
>  #endif /* CONFIG_BPF_STREAM_PARSER */
>
> +bool tcp_in_sockmap(const struct sock *sk)
> +{
> +	const struct proto *prot = sk->sk_prot;
> +
> +	lockdep_assert_held(&sk->sk_callback_lock);
> +
> +	return &tcp_bpf_prots[0][0] <= prot &&
> +		prot <= &tcp_bpf_prots[TCP_BPF_NUM_PROTS - 1][TCP_BPF_NUM_CFGS - 1];
> +}
> +
>  int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
>  {
>  	int family = sk->sk_family == AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_IPV4;
> @@ -729,6 +739,8 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
>  			sock_replace_proto(sk, psock->sk_proto);
>  		}
>  		return 0;
> +	} else if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RCVQ_CB_FLAG)) {
> +		return -EBUSY;
                   ^^^^

A subsystem pattern flags this as potentially concerning: the commit
message explains that write_lock_bh(&sk->sk_callback_lock) is taken to
synchronise with tcp_bpf_update_proto(), but does tcp_bpf_update_proto()
actually take sk->sk_callback_lock?

Looking at the call chain, tcp_bpf_update_proto() is invoked from the
SOCKMAP path through:

sock_map_link() in net/core/sock_map.c
  -> sock_map_init_proto()
     -> tcp_bpf_update_proto()

In sock_map_link(), sk_callback_lock is acquired after sock_map_init_proto()
completes, not before. The lock is taken when setting sk_user_data to the
psock, but sock_map_init_proto() runs outside the lock and calls
sock_replace_proto() to write sk->sk_prot without holding sk_callback_lock.

Is there a race here? Consider this interleaving (the commit message
acknowledges sock_map_update_elem only holds bh_lock_sock(), so it can run
concurrently with setsockopt that holds the socket lock):

  CPU 0 (sockmap path)                   CPU 1 (BPF setsockopt RCVQ_CB)
  sock_map_link():                       __bpf_sock_ops_cb_flags_set():
    sk_psock_init():                       (val has RCVQ_CB, current=0)
      lock sk_callback_lock
      set sk_user_data = psock
      unlock sk_callback_lock
    sock_map_init_proto():
      tcp_bpf_update_proto():
        BPF_SOCK_OPS_TEST_FLAG: 0
        (no flag yet, check passes)
                                           write_lock_bh(sk_callback_lock)
                                           tcp_in_sockmap(sk): sk_prot
                                           still old, returns false
                                           tp->bpf_sock_ops_cb_flags = val
                                           (RCVQ_CB set)
                                           write_unlock_bh
        sock_replace_proto(sk,
          &tcp_bpf_prots[][])
        (sk_prot now in tcp_bpf_prots)

Final state: sk_prot is in tcp_bpf_prots[][] AND bpf_sock_ops_cb_flags has
BPF_SOCK_OPS_RCVQ_CB_FLAG. Both features are now enabled, which violates the
mutual exclusion goal.

The validation checks in tcp_bpf_update_proto() and __bpf_sock_ops_cb_flags_set()
each check shared state before the exclusion point, not under common exclusion.
Running a lockset analysis on the two shared variables:

  bpf_sock_ops_cb_flags: written by __bpf_sock_ops_cb_flags_set under
  sk_callback_lock; read by tcp_bpf_update_proto with no lock.
  Lockset intersection = {sk_callback_lock} intersect {} = {}.

  sk->sk_prot: read by tcp_in_sockmap under sk_callback_lock; written by
  sock_replace_proto (called from tcp_bpf_update_proto) with no lock.
  Lockset intersection = {} intersect {sk_callback_lock} = {}.

Could the synchronization be strengthened so both paths access both variables
under the same lock?

>  	}
>
>  	if (sk->sk_family == AF_INET6) {


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26328541814
--===============3434856789991386713==--

