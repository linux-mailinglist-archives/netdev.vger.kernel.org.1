Return-Path: <netdev+bounces-258143-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QE52LRBxi2lhUQAAu9opvQ
	(envelope-from <netdev+bounces-258143-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:55:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9874B11E268
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B751301951C
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5453A38B7DE;
	Tue, 10 Feb 2026 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IV5HWXkc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD4438A9CF;
	Tue, 10 Feb 2026 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770746102; cv=none; b=QGS8C8lF2PdJlFCJJOiMOJ7uuL0vxXHX11nfGl+9/EaUsU0HYKebpm4c3k7Y8HN0OTHysdsL21o8+sFm2jv5KWQrJ7DyA0L9UFUhl2b443gAEgZYBVaUoN1h9h71DTpvZIr1CCoprcmGwbXkS+OP4NGM92fsflIrrhrKkYePW+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770746102; c=relaxed/simple;
	bh=oakjD26/4tkGvWqhilxMCc4hiHX5ft4jQ4Iq6CfC8Ok=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Vlcwarck/nxOkijC9qquUww3WHFA0xddfS8Z0IDcUwd/DbaBKv8UE3GvXko5qdYSnT2Dc13GF+CsFVHfivxMEXeMZI9I1qA8EKaDCWD+wT7XbY+bdafMNqud6AEXChXpnL/wBROD7Hd0J7rt9pDQoVD3UhrDLWidrxaBhjLRLKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IV5HWXkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E45DC116C6;
	Tue, 10 Feb 2026 17:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770746102;
	bh=oakjD26/4tkGvWqhilxMCc4hiHX5ft4jQ4Iq6CfC8Ok=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=IV5HWXkc/FCiRpLej35EorMs268YVetMhHEcMuM8RZrQDwNon4ujlVriIsWMItPQO
	 EqpPqMEeYxMCD6O4YFIrEvdJEAaFfqIGPwZOjfLqaxtmbteFvtM06iSeex9Dz5XBgO
	 eId3ASq6UbrOQNwrEjse/Tdi30l18VlSWm7BlPWh5mf4t33MAhtXT3IbgjW51LF+r9
	 vzEBdcZkI3eZTjdO3Q29eABxls3qZxt/DDPJl5+t8fLfEvnhAh5SbzAkjEx5m1VN5S
	 rM53+ku47GAnrwJMK4bvWMODcdVtJF+2hO0GTGelBaK5cYQfywiYVchoItLmFSR3p/
	 OS8Eizj1vbL9A==
Content-Type: multipart/mixed; boundary="===============7295902335523839857=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8d3fe8a5425f2e6af5a75f8d1a26d1b460719b1e904b6e1499747ca479b73832@mail.kernel.org>
In-Reply-To: <20260210-bpf-xdp-meta-rxcksum-v1-4-e5d55caa0541@kernel.org>
References: <20260210-bpf-xdp-meta-rxcksum-v1-4-e5d55caa0541@kernel.org>
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Add selftest support for bpf_xdp_metadata_rx_checksum
From: bot+bpf-ci@kernel.org
To: lorenzo@kernel.org,donald.hunter@gmail.com,kuba@kernel.org,davem@davemloft.net,edumazet@google.com,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,andrew+netdev@lunn.ch,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,aleksander.lobakin@intel.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,maciej.fijalkowski@intel.com
Cc: jakub@cloudflare.com,netdev@vger.kernel.org,bpf@vger.kernel.org,intel-wired-lan@lists.osuosl.org,linux-kselftest@vger.kernel.org,lorenzo@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 10 Feb 2026 17:55:01 +0000 (UTC)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev];
	FREEMAIL_CC(0.00)[cloudflare.com,vger.kernel.org,lists.osuosl.org,kernel.org,iogearbox.net,gmail.com,linux.dev,meta.com];
	TAGGED_FROM(0.00)[bounces-258143-lists,netdev=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[40];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9874B11E268
X-Rspamd-Action: no action

--===============7295902335523839857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> index 09bb8a038d52..ef6a5584a187 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c

[ ... ]

> @@ -98,6 +98,7 @@ int rx(struct xdp_md *ctx)
>  	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
>  	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_proto,
>  				     &meta->rx_vlan_tci);
> +	bpf_xdp_metadata_rx_checksum(ctx, &meta->ip_summed, &meta->cksum_meta);

Is there a missing extern declaration for bpf_xdp_metadata_rx_checksum()?
The other kfuncs used in this file have extern declarations with __ksym:

extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
                                         __u64 *timestamp) __ksym;
extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
                                    enum xdp_rss_hash_type *rss_type) __ksym;
extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
                                        __be16 *vlan_proto,
                                        __u16 *vlan_tci) __ksym;

Without a similar declaration for bpf_xdp_metadata_rx_checksum(), the BPF
program may fail to compile or link.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21875603263

AI-authorship-score: low
AI-authorship-explanation: The code follows standard BPF selftest patterns and appears to be written by a domain expert familiar with XDP metadata kfuncs.
issues-found: 1
issue-severity-score: medium
issue-severity-explanation: Missing extern declaration for bpf_xdp_metadata_rx_checksum kfunc will cause BPF program build failure.

--===============7295902335523839857==--

