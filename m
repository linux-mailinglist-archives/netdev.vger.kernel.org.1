Return-Path: <netdev+bounces-276672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJmMLUSZ1mmTGggAu9opvQ
	(envelope-from <netdev+bounces-276672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:07:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1FD3BFF48
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55E9D300AEFE
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 18:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522C83D8134;
	Wed,  8 Apr 2026 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzVa9Q+A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA5825A321;
	Wed,  8 Apr 2026 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671615; cv=none; b=dpc22s+eg5oxYv/1ut8Fb8AGA2Lxpy3nDSei9X/9Pyf/xe2PkaKVIrqjSdVtc8aa07v5WXnIzXWlwGtpkedR5BlPbo0tjhDGUrdnj6NkTMe5Awjwb74E1q5n1Y00Qej++SUrlQOssPosatdk3xH8+h8+2xeU54F4V2H57i82Lmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671615; c=relaxed/simple;
	bh=yTJJojJ1BRvn6vlmAnMhN2R4p12NTJOleCeOiC+O+qs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hatgwe5gD563DxJmyImWGiMf6cV7G4h9SLrLMT+CVALVH1F7PogPl0t6TmAiTRz2U18aa0VcB2O23GNV0dWC0nHrgT1e6UQ+C3hpBSG8gCzVUcCsgPx63evhReA4vQf/NtAfHLeGnQ0fgEqi1m45qr0JWPZAtCSEiEXiYdNQq4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzVa9Q+A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB336C19421;
	Wed,  8 Apr 2026 18:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775671614;
	bh=yTJJojJ1BRvn6vlmAnMhN2R4p12NTJOleCeOiC+O+qs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FzVa9Q+A1ZWnfYyE+b6Fw/rwAZfHpG/1h7rpv0M45rFFSO68idqTEeJcOpUDEah7e
	 nOV6PaA+lu6qYQ2FwJpsRGxG+l7ll8yemvprZKI11xxSUvlvacedK55FZ28yj8NChy
	 X5+vXehLSCevafXAQYhmxmINrbXeCRlXbOB6qiU5d16i1G+KSiir25KXRlIZSDB8KN
	 sMyQ1zZzl1KuplJusszfOMp4ndptxFr+W7zvqpQnlHnsS4Gv6SaWvx2zevvNpTINlY
	 iX6tB5lwrpVZ/ST0iKbUEVsKbNlNsWZb5pcbYuQewEZrI6tP2x+9+dzficZLfRpnPk
	 EsiwxD3y2maqA==
Date: Wed, 8 Apr 2026 11:06:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, Pavan
 Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, horms@kernel.org,
 linux-kernel@vger.kernel.org, leon@kernel.org
Subject: Re: [net-next v9 07/10] net: bnxt: Implement software USO
Message-ID: <20260408110652.652e4732@kernel.org>
In-Reply-To: <adaKt/VwrajKraR8@devvm20253.cco0.facebook.com>
References: <20260407220313.3990909-1-joe@dama.to>
	<20260407220313.3990909-8-joe@dama.to>
	<adWR1OiPlQCJ8idj@devvm20253.cco0.facebook.com>
	<adaKt/VwrajKraR8@devvm20253.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276672-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A1FD3BFF48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 8 Apr 2026 10:04:55 -0700 Joe Damato wrote:
> > This is the check I added. AI says this is wrong and netdev_queues.h says:
> > 
> >   * @get_desc must be a formula or a function call, it must always
> >   * return up-to-date information when evaluated!
> > 
> > which I obviously failed to do, so I'm pretty sure I got this wrong.  
> 
> So, there's two options to fix this that I can think of. I am leaning torward
> option 2, but if there are any strong opinions (or other options that I am
> missing) please let me know:
> 
>   1. Allocate the maximum number of slots per ring and eliminate this check
>      entirely. I figured this would be disliked because it potentially wastes
>      memory. The driver would need ring_size / 3 slots, and if we assume the
>      maximum is 2048 and the slot size is 256b, that works out to 175kb per
>      ring. Of course, this only affects NICs with SW USO and the buffer isn't
>      allocated for NICS with HW USO.
> 
>      This is probably simpler, but costs more memory than the existing design.
> 
>    2. Or, keep the smaller buffer that we have now (BNXT_SW_USO_MAX_SEGS (64)
>       * 256b = 16kb per ring) and fix the try_stop like this:
> 
> +static inline u16 bnxt_inline_avail(struct bnxt_tx_ring_info *txr)
> +{
> +       return BNXT_SW_USO_MAX_SEGS -
> +              (u16)(txr->tx_inline_prod - READ_ONCE(txr->tx_inline_cons));
> +}
> +
> 
> -       slots = txr->tx_inline_prod - txr->tx_inline_cons;
> -       slots = BNXT_SW_USO_MAX_SEGS - slots;
> -
> -       if (unlikely(slots < num_segs)) {
> -               netif_txq_try_stop(txq, slots, num_segs);
> +       if (unlikely(bnxt_inline_avail(txr) < num_segs)) {
> +               netif_txq_try_stop(txq, bnxt_inline_avail(txr), num_segs);

I think option 2 makes sense. The point (which I think you got) is that
the condition must be evaluated after the memory barrier.

Since the condition is repeated in your latest snippet - you can
probably use netif_txq_maybe_stop() ?

