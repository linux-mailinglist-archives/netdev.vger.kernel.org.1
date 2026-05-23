Return-Path: <netdev+bounces-291073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BgqVMCBuEWoLmAYAu9opvQ
	(envelope-from <netdev+bounces-291073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 11:06:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC605BE1B9
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 11:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95F433004F22
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 09:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F6E383337;
	Sat, 23 May 2026 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANJ879tc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C234037648D;
	Sat, 23 May 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779527198; cv=none; b=Ct7ISnSnIxlxZOMeqTMx/JIXpn2mplhM9Y/pJCLW3rky1bS0BLz6HWJwNixfrRtoWWBiK9eIiCIBC+Tqie/nBkR32AhKc3nxF5U5vEkNYq8MyGi5/e+Z3NGaa7Z6/pBVv2DLe+CjaEmYnyxaiTWU2AU1pLAPHrYlwf6VBv92Zfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779527198; c=relaxed/simple;
	bh=5l6abIQ7HNGT2ZBSyGjD9jIV1/NsXpd4VXJXx+IX+s4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=PxouBp7G5uKiFAZN/F32TynCyol+pQkaj+4HUgnDXMby/QHjBKkPj0qNMw85p0Nx4KCM03QT4E11bWjrlenca1cSE09XTQCTY6+cjvLgW3b5ues6B83JzlAj0X/zfGr2OBQkV/ClBxsyh5gXwOpqU8i2GzK8gUty3lj3izgujms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANJ879tc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA11E1F000E9;
	Sat, 23 May 2026 09:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779527196;
	bh=9rITIiaTLuvKKcwDlr54X1faBMmyRX9mCNb905DOPBs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ANJ879tcUzInPJTrjMcVh0cRtLVa+ps0oVcGGl6YIZTgHBkpKpu/aXYQjUP7EZF2s
	 2ffGVgSFJAdQ46MZdkH5Falk4OitMCCeJD8lrqNnqOEC+AlyD3BC4Q1hykTiaj7Jqc
	 mBz54OPochkUkl90NNzxOP7XwjR9+uBH/e9og1Xd9lC6bL6N3QTwbqAEVWj5Cuo2/f
	 EnpE5pXf3DnERmybD7k8D6AALMRJAvPy+TpKHmSdzzbYVmfeKoQvI70ckB31VbaDIX
	 AnhoeTBuwDIgNzZfyDDuhovQgL9RynuFvxkyc3kwp2Z7+S1n2pEH1ejkJBkAK3TpMy
	 7EyxUqHzDMV6A==
Content-Type: multipart/mixed; boundary="===============0315934236863334226=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <62e1fa8bbaec28d58c3f2e1f21eb5e75e306c9299b8e95d08d5ec48cb4c1508b@mail.kernel.org>
In-Reply-To: <20260523083001.2911931-6-kuniyu@google.com>
References: <20260523083001.2911931-6-kuniyu@google.com>
Subject: Re: [PATCH v3 bpf-next 05/11] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
From: bot+bpf-ci@kernel.org
To: kuniyu@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,edumazet@google.com,ncardwell@google.com,willemb@google.com,ukyab@berkeley.edu,kuniyu@google.com,kuni1840@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sat, 23 May 2026 09:06:35 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-291073-lists,netdev=lfdr.de,bpf-ci];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5CC605BE1B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============0315934236863334226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index fa8a7c7d86eb..3608036632a8 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12388,6 +12388,22 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
>  #endif
>  }
>
> +__bpf_kfunc int bpf_sock_ops_tcp_set_rcvlowat(struct bpf_sock_ops_kern *skops,
> +					      int rcvlowat)
> +{
> +#ifdef CONFIG_INET
> +	if (skops->op != BPF_SOCK_OPS_RCVQ_CB)
> +		return -EOPNOTSUPP;
> +
> +	if (rcvlowat < 0)
> +		rcvlowat = INT_MAX;
> +
> +	return __tcp_set_rcvlowat(skops->sk, rcvlowat, !skops->skb);

Should this kfunc prevent operation on MPTCP subflows? Bjorn Topel
raised this concern in v1, noting the issue that commit fcf4692fa39e
("mptcp: prevent BPF accessing lowat from a subflow socket.") was
designed to prevent.

You acknowledged this and stated you would drop MPTCP support for now,
mentioning that a subsequent patch (patch 7 in the v3 series: "bpf:
mptcp: Don't support BPF_SOCK_OPS_RCVQ_CB.") would disable the callback
for MPTCP.

However, the current code lacks any MPTCP check. Without either disabling
BPF_SOCK_OPS_RCVQ_CB for MPTCP subflows in the callback registration or
adding a check like:

	if (sk_is_mptcp(skops->sk))
		return -EOPNOTSUPP;

couldn't a BPF program invoke this kfunc on MPTCP subflows and trigger
the same problem that fcf4692fa39e was designed to prevent?

Reference: https://lore.kernel.org/bpf/87ik8ujfa1.fsf@all.your.base.are.belong.to.us/

> +#else
> +	return -EOPNOTSUPP;
> +#endif
> +}
> +
>  __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
>  					      u64 flags)
>  {
> @@ -12539,6 +12555,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
>
>  BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
>  BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
> +BTF_ID_FLAGS(func, bpf_sock_ops_tcp_set_rcvlowat)
>  BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
>
>  static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26328541814
--===============0315934236863334226==--

