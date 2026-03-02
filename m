Return-Path: <netdev+bounces-262759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICk4EMDJpWnEFgAAu9opvQ
	(envelope-from <netdev+bounces-262759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 18:32:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8611DDD80
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 18:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD29D3014740
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 17:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3475431280D;
	Mon,  2 Mar 2026 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOCI1e9j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E07B2836A0;
	Mon,  2 Mar 2026 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772472762; cv=none; b=rtZ2pHGzqzTh5NpR3siXjhGlkTH8041UsiXrQGhEY+McfdVN9KYq6shX+qSqRxd5XzpCnXfN+zvCmq1cRSWgvNf7TFAudgCrJt7XHUGBid6tvMQsYx3PJMV36pfpfPswicrjTJhwoCNpYAgVDRS9EyDXxVhK+DlnK9yeN5XRpjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772472762; c=relaxed/simple;
	bh=tnpn0LaJUMgqytRuDhKqOEYHDYHlXW9Sposq8jF6yqc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fZoj5tagoh5B0+RS+AItIaS/yBm8Dc5g5KECCz0/tpAk/wPztqSSV3MbwfgyCEeMKqijyIgGhdO3CTdCnivKC4rmyGHuz3uopL0aZB6CclQuWdx2DtBf32++4suIItUrOzFtNa2NvNAViia36KaPaxBRx25JL+oHTtBuOkvn748=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOCI1e9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05836C19423;
	Mon,  2 Mar 2026 17:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772472761;
	bh=tnpn0LaJUMgqytRuDhKqOEYHDYHlXW9Sposq8jF6yqc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=iOCI1e9j41WFatME/LLVC5T1+T/WcxsPTAnOYO9sprUHt1kELdT+C2dRHK4rFRust
	 x+epksgA5XRcUa7gGWVY1MzYB8CPLAXW8KSCqSKlzgRlBw4D8icLQQuNcNNnLp8V6e
	 +zKAVEaS5gK5BgGkBZ6OfWM6cZAhnkeqaNvkI1Ip0pRwugn9T0W0jJxILMq+QELrxn
	 hcYnbvH3SPn+vWTxasUExKSAfkQlWAj0jl8rPu7QS7u96cKFuJIxCMJdHjOjirfa4L
	 L0jicTT98m6eZAlrsniOazXvil57Ovsu1Bf9RdQCQM7BFSb58lKO0zAHdB+hAnRD7M
	 PylBsJsJjSyVg==
Content-Type: multipart/mixed; boundary="===============7315119925973411465=="
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <392614bc3c9c3a8b2c42e263181431dd0484f5cc41b0b9831e53d1bcdcb4b6ed@mail.kernel.org>
In-Reply-To: <20260302161723.858616-7-larysa.zaremba@intel.com>
References: <20260302161723.858616-7-larysa.zaremba@intel.com>
Subject: Re: [PATCH bpf v4 6/9] i40e: use xdp.frame_sz as XDP RxQ info frag_size
From: bot+bpf-ci@kernel.org
To: larysa.zaremba@intel.com,bpf@vger.kernel.org
Cc: larysa.zaremba@intel.com,claudiu.manoil@nxp.com,vladimir.oltean@nxp.com,wei.fang@nxp.com,xiaoning.wang@nxp.com,andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,anthony.l.nguyen@intel.com,przemyslaw.kitszel@intel.com,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,haoluo@google.com,jolsa@kernel.org,horms@kernel.org,shuah@kernel.org,aleksander.lobakin@intel.com,maciej.fijalkowski@intel.com,bastien.curutchet@bootlin.com,tushar.vyavahare@intel.com,kernelxing@tencent.com,rbm@suse.com,echaudro@redhat.com,lorenzo@kernel.org,toke@redhat.com,imx@lists.linux.dev,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,intel-wired-lan@lists.osuosl.org,linux-kselftest@vger.kernel.org,aleksandr.loktionov@intel.com,dtatulea@nvidia.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin
 .lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  2 Mar 2026 17:32:41 +0000 (UTC)
X-Rspamd-Queue-Id: AE8611DDD80
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.dev,bootlin.com,tencent.com,suse.com,lists.linux.dev,vger.kernel.org,lists.osuosl.org,nvidia.com,meta.com];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-262759-lists,netdev=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	NEURAL_SPAM(0.00)[0.993];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCPT_COUNT_GT_50(0.00)[53];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Action: no action

--===============7315119925973411465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -3567,6 +3567,7 @@ static int i40e_configure_rx_ring(struct i40e_ring *ring)
>  	struct i40e_vsi *vsi = ring->vsi;
>  	u32 chain_len = vsi->back->hw.func_caps.rx_buf_chain_len;
>  	u16 pf_q = vsi->base_queue + ring->queue_index;
> +	u32 xdp_frame_sz = i40e_rx_pg_size(ring) / 2;
>  	struct i40e_hw *hw = &vsi->back->hw;

On PAGE_SIZE < 8192 systems, i40e_rx_pg_size() calls
i40e_rx_pg_order() which checks ring->rx_buf_len:

i40e_txrx.h:i40e_rx_pg_order() {
    #if (PAGE_SIZE < 8192)
        if (ring->rx_buf_len > (PAGE_SIZE / 2))
            return 1;
    #endif
        return 0;
}

At this point in the function, ring->rx_buf_len still holds the
value from the previous configuration. It is not updated until
later in the function body:

i40e_main.c:i40e_configure_rx_ring() {
    ...
    u32 xdp_frame_sz = i40e_rx_pg_size(ring) / 2;  // stale rx_buf_len
    ...
    ring->rx_buf_len = vsi->rx_buf_len;  // updated here, after init
    ...
}

Could this lead to a wrong xdp_frame_sz on 4K page systems when
ring->rx_buf_len changes across the PAGE_SIZE/2 (2048) boundary
between configurations?

For example, after AF_XDP ZC teardown on a standard MTU interface,
the previous rx_buf_len from XSK (~3840 with default 4K chunks) is
above 2048, giving pg_order=1 and xdp_frame_sz=4096. But the new
vsi->rx_buf_len for standard MTU is 1534, which would give
pg_order=0 and the correct xdp_frame_sz=2048.

With frag_size set to 4096 but actual buffers only 2048 bytes,
bpf_xdp_frags_increase_tail() would see frag_size > frame_sz and
return -EOPNOTSUPP.

The previous code computed i40e_rx_pg_size(ring) / 2 at the skip
label, after ring->rx_buf_len was already updated, so this ordering
issue did not exist before.

Would it work to move the computation after the rx_buf_len
assignment, for example:

    ring->rx_buf_len = vsi->rx_buf_len;

    xdp_frame_sz = i40e_rx_pg_size(ring) / 2;

    if (ring->vsi->type != I40E_VSI_MAIN)
        goto skip;

> [ ... ]

> @@ -3616,7 +3618,7 @@
>  	}
>
>  skip:
> -	xdp_init_buff(&ring->xdp, i40e_rx_pg_size(ring) / 2, &ring->xdp_rxq);
> +	xdp_init_buff(&ring->xdp, xdp_frame_sz, &ring->xdp_rxq);

> [ ... ]



---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22586694870

AI-authorship-score: low
AI-authorship-explanation: The commit shows domain-specific driver knowledge, targeted fix with minimal changes, and a natural commit message style consistent with human kernel developers.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Variable initialization order causes wrong xdp_frame_sz on 4K page systems when rx_buf_len crosses the PAGE_SIZE/2 boundary between reconfigurations, leading to bpf_xdp_adjust_tail returning -EOPNOTSUPP incorrectly but no memory corruption.

--===============7315119925973411465==--

