Return-Path: <netdev+bounces-257481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ik6DAuLhWlVDQQAu9opvQ
	(envelope-from <netdev+bounces-257481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 07:32:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9832DFAB30
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 07:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74EF7302D961
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 06:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7177F304BDE;
	Fri,  6 Feb 2026 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3JiF5CH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C306239E9B;
	Fri,  6 Feb 2026 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770359558; cv=none; b=dKUQBplAwHD5y4umuCC/+XVAqd0fEnJcj2PiK9QEMM6Mq9vWpbEfvbl2oO2b1cRsfCRZT061dZoSU8G00QDWfOM3KgXPQvShUV5iafiR/emiwaLHWPlEsNTk5qKZs3A+WTZGAgv0Z2PCIiA7ZBWcelsTtwtjjJ1+jGNT2jPYtJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770359558; c=relaxed/simple;
	bh=B86+/w/Y4PxSyTGA99MIGHYH6HWoVwrAIkWvZ6pFjDg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=TMscb6KOqv55oflHiOSVtrsJ6mH3OIy3vBFR3weZkGUp295dIMTBnIiaCbpt2BYA7SaXQfKp57SOK+jbTcP1iGUZNeP93g/OYWuyzvxSx+LTePSunbbdKSQpCs8G+o2xpAQKr6eMRQNFAsg8Bf001Hk5xY+7JMFJFQoZMd/izxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3JiF5CH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D32C116C6;
	Fri,  6 Feb 2026 06:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770359557;
	bh=B86+/w/Y4PxSyTGA99MIGHYH6HWoVwrAIkWvZ6pFjDg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=A3JiF5CHN58XGJOB6tuJkGjL9AJdi5GAJx6wUIa0ibgAD4jXzrH8K8GcinVpPjUXH
	 QKvDIcWXx+RuFgfN6nep1inV3mWy3x7tcGnbnXq9oxBIOR3QwNBSbkXh25LezxpRB8
	 /0xtnUm6r2W01eoBtQYw8xbwuh7EBHbiJEWua/sz5AeXa/2GK5ntpK1qVOmBtgbEgk
	 WqNVUFgYCIO5YCKepsKaUmQSLrbp2bvQw33SPwb1Aei/n3HTOSAYr0oBrsYG38SvxK
	 LXOEp2xPcB+q9GoFVy+BTDUWOYM8wjql2rB0qfR3Swb/DaeoVVte/wuJuCJ9CRmJEs
	 hu15e/Al8eTeg==
Content-Type: multipart/mixed; boundary="===============3171514973363339314=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e5ea98f963294d7c51801f7ef150d64e2be425b9fdbbf21fd37235c30fc0ca04@mail.kernel.org>
In-Reply-To: <20260206055113.63476-1-yangfeng59949@163.com>
References: <20260206055113.63476-1-yangfeng59949@163.com>
Subject: Re: [PATCH v3] bpf: test_run: Fix the null pointer dereference issue in bpf_lwt_xmit_push_encap
From: bot+bpf-ci@kernel.org
To: yangfeng59949@163.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org
Cc: bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  6 Feb 2026 06:32:37 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257481-lists,netdev=lfdr.de,bpf-ci];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9832DFAB30
X-Rspamd-Action: no action

--===============3171514973363339314==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -989,6 +989,7 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
>  	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>  	struct net *net = current->nsproxy->net_ns;
>  	struct net_device *dev = net->loopback_dev;
> +	struct dst_entry bpf_test_run_lwt_xmit_dst;
>  	u32 headroom = NET_SKB_PAD + NET_IP_ALIGN;

[ ... ]

> @@ -1156,6 +1157,12 @@
>  		skb->ip_summed = CHECKSUM_COMPLETE;
>  	}
>
> +	if (prog->type == BPF_PROG_TYPE_LWT_XMIT) {
> +		dst_init(&bpf_test_run_lwt_xmit_dst, NULL, NULL,
> +			 DST_OBSOLETE_NONE, DST_NOCOUNT);
> +		bpf_test_run_lwt_xmit_dst.dev = dev;
> +		skb_dst_set_noref(skb, &bpf_test_run_lwt_xmit_dst);
> +	}

Will skb_dst_set_noref() trigger a WARN_ON here? Looking at the function
in include/linux/skbuff.h:

    static inline void skb_dst_set_noref(struct sk_buff *skb, struct dst_entry *dst)
    {
        skb_dst_check_unset(skb);
        WARN_ON(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
        ...
    }

This code runs from syscall context in bpf_prog_test_run_skb() before
bpf_test_run() is called. At this point, neither rcu_read_lock() nor
local_bh_disable() is held - local_bh_disable() is only called inside
bpf_test_run().

Should the dst setup be wrapped with rcu_read_lock()/rcu_read_unlock(),
or moved inside bpf_test_run() where RCU-bh context is already held?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21740645384

AI-authorship-score: low
AI-authorship-explanation: The commit shows human authorship with real bug reporters from HUST, actual crash stack trace, self-aware comment using Temporarily, and author from kylinos.cn Linux distribution company.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: WARN_ON will trigger in skb_dst_set_noref due to missing RCU context, causing kernel log warnings but no functional impact.

--===============3171514973363339314==--

