Return-Path: <netdev+bounces-275970-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJteO07w1GkjywcAu9opvQ
	(envelope-from <netdev+bounces-275970-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:53:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECA53ADF97
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF0AF3047438
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE943A63F6;
	Tue,  7 Apr 2026 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EenWegPn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F46394786;
	Tue,  7 Apr 2026 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562742; cv=none; b=SWyNEbEccBjNdtccB26RK7g5/XVureBeL6Wk7H4QoUvqCLjCwx4M304V7garSiq+93ek+N1y4jfMOQJgUCH8AFGfdv5Fl2TAtNfPcPwvEubLjgSWp16NIsJOJixMEqi9q3iB0j5mHVpR4gjx66VNAY5EtbQCQXPLKXBPIIbNZy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562742; c=relaxed/simple;
	bh=uiNZibcrpanS2tAKwNcCtp5oMpTDwmPdO98fIwbT4rw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qGbOma6wDYiRLrM4S8AXf5PDuSH3l9hvJ3PSAB73YCpfpi57gY8x0gId/gS+u9hBbm4Dr3p1nHZkxtnBBg36UBgIknJiDfkI87vh2yVR1WLYRiWSreODV1ibYN5O2fa8IY+FkJDa8wAlRLS7tj3HFOyoEhuBz99eiENTqKyggyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EenWegPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4111DC116C6;
	Tue,  7 Apr 2026 11:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775562742;
	bh=uiNZibcrpanS2tAKwNcCtp5oMpTDwmPdO98fIwbT4rw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=EenWegPnPLymwI3Zd+2paaOXSnNisTgOga3YK1xwKYGERgzQ+h+xiOD3Omkbfs82g
	 OP/cbIv/uPvynoW+jLvcwmMZXjQ/egLKOrMVX2s/gLLBtuOiy0bBBucxyxuiq/9hTo
	 rr/rCQWl7ue5dqd8A8AoreQ/YIFAh7JojKM1N+ktM83LAAVllJ+cOgU3I7DTW8xzC6
	 jq0pSrk2n1W0hnrgUEiixzTr/y/5OVd2Qe8F2Gc6f+R28r3a7ngedmPgPYL2XRAV+F
	 UP0UE3j5c9blDYtzV/M6VmBHXaMNwqBKDtwN///wJFvSPzbu8+exctfSU7MZ28rOTY
	 dWEA1ArJlwa/Q==
Content-Type: multipart/mixed; boundary="===============5828004932034665690=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4ab24b8c12f6594ff4bf5df1d05d1b8ada3c913e55000f86e15ec7e7ee980b54@mail.kernel.org>
In-Reply-To: <20260407105005.1639815-6-nhudson@akamai.com>
References: <20260407105005.1639815-6-nhudson@akamai.com>
Subject: Re: [PATCH bpf-next v3 5/6] bpf: clear decap tunnel GSO state in skb_adjust_room
From: bot+bpf-ci@kernel.org
To: nhudson@akamai.com,bpf@vger.kernel.org,netdev@vger.kernel.org,willemb@google.com,martin.lau@linux.dev
Cc: nhudson@akamai.com,mtottenh@akamai.com,aglasgal@akamai.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  7 Apr 2026 11:52:22 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[akamai.com,kernel.org,iogearbox.net,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org,linux.dev,meta.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-275970-lists,netdev=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+,1:+];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26]
X-Rspamd-Queue-Id: 8ECA53ADF97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============5828004932034665690==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 7f8d43420afb..04059d07d368 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3667,6 +3667,46 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>  		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
>  			skb_increase_gso_size(shinfo, len_diff);
>
> +		/* Selective GSO flag clearing based on decap type.
> +		 * Only clear the flags for the tunnel layer being removed.
> +		 */
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
> +		    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +					 SKB_GSO_UDP_TUNNEL_CSUM |
> +					 SKB_GSO_TUNNEL_REMCSUM)))
> +			shinfo->gso_type &= ~(SKB_GSO_UDP_TUNNEL |
> +					      SKB_GSO_UDP_TUNNEL_CSUM |
> +					      SKB_GSO_TUNNEL_REMCSUM);

[ ... ]

> +
> +		/* Clear encapsulation flag only when no tunnel GSO flags remain */
> +		if (flags & (BPF_F_ADJ_ROOM_DECAP_L4_MASK |
> +			     BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)) {

[ ... ]

> +
> +			if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) {
> +				skb->encap_hdr_csum = !!(shinfo->gso_type & SKB_GSO_UDP_TUNNEL_CSUM);
> +				skb->remcsum_offload = !!(shinfo->gso_type & SKB_GSO_TUNNEL_REMCSUM);

The L4_UDP clearing block above unconditionally clears
SKB_GSO_UDP_TUNNEL_CSUM and SKB_GSO_TUNNEL_REMCSUM from
shinfo->gso_type. By the time these two assignments execute,
both flags are always zero, so these expressions always
evaluate to 0.

The kernel's own __skb_udp_tunnel_segment() in udp_offload.c
uses the same !!() pattern:

    need_csum = !!(skb_shinfo(skb)->gso_type & SKB_GSO_UDP_TUNNEL_CSUM);
    skb->encap_hdr_csum = need_csum;
    remcsum = !!(skb_shinfo(skb)->gso_type & SKB_GSO_TUNNEL_REMCSUM);
    skb->remcsum_offload = remcsum;

but there the flags are still live. Here they have already been
cleared, so the conditional form is misleading. Would it be
clearer to just assign 0 directly?

> +			}
> +		}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24079111128
--===============5828004932034665690==--

