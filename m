Return-Path: <netdev+bounces-263626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uP+hDw3fp2lnkgAAu9opvQ
	(envelope-from <netdev+bounces-263626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:28:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CCD1FB961
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94E743022967
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 07:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B77359A99;
	Wed,  4 Mar 2026 07:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpNGUtLO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B151A351C13;
	Wed,  4 Mar 2026 07:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772609245; cv=none; b=d0IcDO5wHx927IQHZswCmdr6T1BKBCPHojqCUMYBB0Gu3RX4vpRI5azCWdRNQevhH9JdsDKVRZktVXdupf673SZo1DRsIEyCS7ZfwgniCTFjwCHrqC0j1xmkpN9S4t3Qqys68ZWZ3q4DV4gxs9UKkbdgIbLYyuW7CyUdVsgzy3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772609245; c=relaxed/simple;
	bh=AMtw0pjrXtq1GRS+1bfRCOMN9annLt3Tak8oZjmbG7o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SmXSpcSGTVnedwLICJadrO3ZaKN9+6AmMKztw2SOowOi4aCPIY45wVAf3xz6yYuQXzR/Wwya+kvFf8m4a5ApVtKEX4QPzXYVYtqkOSAVcSkIrkVhXkelxnCatZ+iaGEXa3fzZZhEsYsv/aKqDat+sOZYq4XiqxYukuv/CGux8+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpNGUtLO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1BCC19423;
	Wed,  4 Mar 2026 07:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772609245;
	bh=AMtw0pjrXtq1GRS+1bfRCOMN9annLt3Tak8oZjmbG7o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=OpNGUtLO0D5qbdbg/ZEwNqPA1InZooEFYZyxyjuNe/5L+KALJYgH7P9aHTR2xPAyP
	 UzyJpY4Pm7R10Uk3Xu7kkTB4EC8f4Yk+Dm/bsmLnZjujEE1Fy8ys40W8l85uT7dfVi
	 daz4E/RorSHzjD3RbC+W25eJgt/l7UK4hghmFa5ODWByct66pgk5D7wir0jDXWJTOq
	 QD4sb1uJXV1tiDVhbg1NRzOMvntg409Vm87kwWcxtCNw1Mc2EyBWhzfCfEeFcR+93x
	 C7/SrnRqMwfpDyyrUPX4mZwwKwt2LMEBimcjRaL/ClfgEEkviRPXuEZqXhQ2nO9n2C
	 8Y4Mz81uktr8Q==
Content-Type: multipart/mixed; boundary="===============1770799269804699519=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f141f5786f2492de54972838d823f02b44300458b1ec78fc61f34cdfac87b183@mail.kernel.org>
In-Reply-To: <20260304063643.14581-5-jiayuan.chen@linux.dev>
References: <20260304063643.14581-5-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf-next v1 4/7] tcp_bpf: add splice_read support for sockmap
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org,john.fastabend@gmail.com,jakub@cloudflare.com
Cc: jiayuan.chen@linux.dev,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,kuniyu@google.com,willemb@google.com,dsahern@kernel.org,ncardwell@google.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,jiapeng.chong@linux.alibaba.com,ihor.solodrai@linux.dev,mhal@rbox.co,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Mar 2026 07:27:24 +0000 (UTC)
X-Rspamd-Queue-Id: 96CCD1FB961
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263626-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,fomichev.me,linux.alibaba.com,rbox.co,vger.kernel.org,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,vger.kernel.org,gmail.com,cloudflare.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Action: no action

--===============1770799269804699519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -445,6 +445,16 @@ int sk_msg_read_core(struct sock *sk, struct sk_psock *psock,
>  				copy = actor(actor_arg, page,
>  					     sge->offset, copy);
>  			if (!copy) {
> +				/*
> +				 * The loop processes msg_rx->sg entries
> +				 * sequentially and prior entries may
> +				 * already be consumed. Advance sg.start
> +				 * so the next call resumes at the correct
> +				 * entry, otherwise it would revisit
> +				 * zero-length entries and return -EFAULT.
> +				 */
> +				if (!peek)
> +					msg_rx->sg.start = i;
>  				copied = copied ? copied : -EFAULT;
>  				goto out;

The sg.start fix looks correct for the mid-way failure case.

When the splice actor (below) fails on the very first sg entry, copied
is still 0, so this returns -EFAULT to the caller. For the recvmsg
actor, -EFAULT is the right error because copy_page_to_iter() returning
0 means a genuine fault. But for the splice actor, 0 can mean the pipe
is full (add_to_pipe() returned -EAGAIN) or memory allocation failed.

Would it make sense for sk_msg_splice_actor() to propagate the actual
error, or for the callers to translate -EFAULT into the appropriate
errno for their context? Right now the splice path returns -EFAULT to
userspace for a pipe-full condition, where standard tcp_splice_read()
would return -EAGAIN:

tcp_bpf_splice_read()
  -> __tcp_bpf_recvmsg()
    -> sk_msg_read_core() with sk_msg_splice_actor
      -> add_to_pipe() returns -EAGAIN (pipe full)
      -> actor returns 0
      -> copied = 0 ? 0 : -EFAULT
    returns -EFAULT
  returns -EFAULT to userspace

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c

[ ... ]

> +static int sk_msg_splice_actor(void *arg, struct page *page,
> +			       unsigned int offset, size_t len)
> +{
> +	struct tcp_bpf_splice_ctx *ctx = arg;
> +	struct pipe_buffer buf = {
> +		.ops = &nosteal_pipe_buf_ops,
> +	};
> +	ssize_t ret;
> +
> +	buf.page = alloc_page(GFP_KERNEL);
> +	if (!buf.page)
> +		return 0;
> +
> +	memcpy(page_address(buf.page), page_address(page) + offset, len);
> +	buf.offset = 0;
> +	buf.len = len;
> +
> +	/*
> +	 * add_to_pipe() calls pipe_buf_release() on failure, which
> +	 * handles put_page() via nosteal_pipe_buf_ops, so no explicit
> +	 * cleanup is needed here.
> +	 */
> +	ret = add_to_pipe(ctx->pipe, &buf);
> +	if (ret <= 0)
> +		return 0;
> +	return ret;
> +}

Both the alloc_page failure and the add_to_pipe failure return 0 here.
Since sk_msg_read_core() converts actor-returning-0 into -EFAULT when
no bytes have been copied yet, this means userspace can see -EFAULT for
what is actually -ENOMEM (allocation failure) or -EAGAIN (pipe full).
The alloc_page case under memory pressure seems particularly confusing,
as -EFAULT gives no indication that backing off might help.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22658462977
--===============1770799269804699519==--

