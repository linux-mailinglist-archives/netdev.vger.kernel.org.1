Return-Path: <netdev+bounces-272912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FrJ9GTgoyWmxvQUAu9opvQ
	(envelope-from <netdev+bounces-272912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:25:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B17853523A6
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 15:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1E79300C90C
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 13:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DC735B632;
	Sun, 29 Mar 2026 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVPPHOom"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11EA2C21D0;
	Sun, 29 Mar 2026 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774790692; cv=none; b=i47mIzVv275T3utQWMI2jNvnz30y70cnYC0fF9EjDrFHGH3OwdOHtdz8KCZ9G6DJAV3QnxAdnKZdeMmgroBpSW6ursJ93WM7h2nIWYuZkXr8rFDuSfjvTAtuW/F5OzGQi/2HT6ZAWb8oyS41Im0e8c5KmOgFwNgCbAR3OoCShKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774790692; c=relaxed/simple;
	bh=/SRmAgwKlJ2mMP3x1+o6LXZ2eO6lqtSXcSwG14eYe1I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EncAzRJCNSW1oUuENY3ym3zTqyzYqU8gP0GrjirXONvsifkWM8R004KRCVzQNRI8k/9cP6TpjWOFvPRm8DyLroFdnrG0UgWEOld2lT7q+czhmv0En27dwEVjb9dlslq5RK1KW4fr+SHSxnduCqnfLFc9xgY5kXfPr1M83qaPHSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVPPHOom; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4FFC116C6;
	Sun, 29 Mar 2026 13:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774790692;
	bh=/SRmAgwKlJ2mMP3x1+o6LXZ2eO6lqtSXcSwG14eYe1I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=OVPPHOomx6PygljRbWdaCAfYAorVfZmG3uoU0FeGfPCAMbN3hSsyouCgMWNSg+qJj
	 NZk7W+sMzj3B6Ys3fbgd60qbV0h7Jrk+C5tIMJpUcSrn6pXiou8DL/l3HJAtOeH+Aj
	 9SggUpZTSFY22FKU9FQgQn+1E5IjJaq2+C9kZEKrwjpV1GpNwVhSDnmsoyGPnDggf9
	 Mb5rWhw9sZyIH/qBEbzNR2m443zOU/dwrTpPWZ5XkWVS5NT5JRbKfprq2cJUaj9rfx
	 f1NNd1aqsBqVApPEmqzjK7cdQmamgWXUwTXjIFzq04Ijibo9sffr+bCGPhGNQVoIOV
	 2ItO4eVdpk5+g==
Content-Type: multipart/mixed; boundary="===============8405704625733425710=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <129d235b04aca276c0a57c7c3646ce48644458cdc85d9b92b25f405e2d58a9ae@mail.kernel.org>
In-Reply-To: <20260329125056.1909087-1-sun.jian.kdev@gmail.com>
References: <20260329125056.1909087-1-sun.jian.kdev@gmail.com>
Subject: Re: [PATCH] selftests/bpf: Reject malformed IPv4/IPv6 skb test input
From: bot+bpf-ci@kernel.org
To: sun.jian.kdev@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,sun.jian.kdev@gmail.com,syzbot+619b9ef527f510a57cfc@syzkaller.appspotmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 29 Mar 2026 13:24:51 +0000 (UTC)
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
	TAGGED_FROM(0.00)[bounces-272912-lists,netdev=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org,syzkaller.appspotmail.com,iogearbox.net,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,iogearbox.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	NEURAL_HAM(-0.00)[-0.983];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,619b9ef527f510a57cfc];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.kernel.org:mid]
X-Rspamd-Queue-Id: B17853523A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============8405704625733425710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 4cd6b3ea1815..92888af89743 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1135,6 +1135,25 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>  	skb->protocol = eth_type_trans(skb, dev);
>  	skb_reset_network_header(skb);
>
> +	switch (skb->protocol) {
> +	case htons(ETH_P_IP):
> +		if (skb_headlen(skb) < ETH_HLEN + sizeof(struct iphdr)) {

Should this threshold be sizeof(struct iphdr) rather than
ETH_HLEN + sizeof(struct iphdr)?

eth_type_trans() calls eth_skb_pull_mac() which does
skb_pull_inline(skb, ETH_HLEN), advancing skb->data past the
Ethernet header and reducing skb->len by ETH_HLEN. After that
pull, skb_headlen() no longer includes the Ethernet header bytes.

The existing code just below this new block uses the post-pull
value directly:

    if (sizeof(struct iphdr) <= skb_headlen(skb)) {
        sk->sk_rcv_saddr = ip_hdr(skb)->saddr;

With the current check, a 34-byte input (ETH_HLEN + sizeof(iphdr))
gives skb_headlen() == 20 after the pull, which fails the
20 < 14 + 20 comparison and is rejected even though it contains a
complete Ethernet and IPv4 header. The same issue applies to the
IPv6 case below.

> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		break;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case htons(ETH_P_IPV6):
> +		if (skb_headlen(skb) < ETH_HLEN + sizeof(struct ipv6hdr)) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		break;
> +#endif

[ ... ]

This patch fixes a bug that has existed since bpf_prog_test_run_skb()
was first introduced. Should it carry a Fixes: tag?

Fixes: 1cf1cae963c2 ("bpf: introduce BPF_PROG_TEST_RUN command")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23709695537
--===============8405704625733425710==--

