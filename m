Return-Path: <netdev+bounces-271390-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKxEIndfw2m1qQQAu9opvQ
	(envelope-from <netdev+bounces-271390-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 05:07:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 337B831F766
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 05:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE7673099EA3
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D2C2EA72A;
	Wed, 25 Mar 2026 04:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCXTVWx/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8902D5950;
	Wed, 25 Mar 2026 04:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411424; cv=none; b=G0HMPnKeZinZukv96VcF3rjZvs4i68gL36/T7oyokPZWPxsi4exKDq4Djkb1mEW4uo8cpzIpH/i7J/BSw4hj7JfKjmSTg9Pa3AqgqRUyRXer460rkea3qBcOGM0HMmUmjufxEhtaVN8PwubS60mS9nqEY9MwqSbOLk9WVGkzygw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411424; c=relaxed/simple;
	bh=rKjBFwTl8y/aFDsfkycqbaBWF5p3amFnYH+OOdOGJH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uiRg3dT1fs58Tzd2Pwpsqwyqv4tQ/f4t6uZ6pxfo+d1d7tN2tbZjOhABp/wOmS8BmjmUsef0+7JR5n7/a8kmoQqb5S+jebQ9ksAhHFZWYoCXcEqTUtx5MylWGbnCHpjabmX2Xzt+Lojek/2Z7Dk4gflwuFmBQLKcrqybaQUQMDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCXTVWx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B43C4CEF7;
	Wed, 25 Mar 2026 04:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774411423;
	bh=rKjBFwTl8y/aFDsfkycqbaBWF5p3amFnYH+OOdOGJH4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eCXTVWx/J7qoyx8JMFP/pZWjXDY3JfisKDEUp5PmU0+XnzZ07ItWe+obtPr53BSBR
	 7ArpBufimHSENmQQLd8Vpb99+nzF5ECvpzOmJQmcq/S6YvmYpzFH7YtAvGm6ndcEia
	 hz8us2dfMdY6LwGxdMOOceS63yzNDmjh6gWsiUdmvcInpQXRInAM6teuwgH4mNGSsn
	 +qBodKTQ+6tfmnmfAFu+yrMbdYH/Atm8YCjrgbzVKdNGSM9fnJuPxzZHeU24dnydou
	 wK/pfopTAu8+BboMoriYTF9zO0c1vuuFbA1uY37UNBHs62QC6ZrCVsU5QsylSgkTzz
	 NRf4n/HUM9S9Q==
Date: Tue, 24 Mar 2026 21:03:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>, Simon
 Horman <horms@kernel.org>, Doug Berger <opendmb@gmail.com>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/6] net: bcmgenet: add XDP_TX support
Message-ID: <20260324210342.61b0b5f8@kernel.org>
In-Reply-To: <20260323120539.136029-5-nb@tipi-net.de>
References: <20260323120539.136029-1-nb@tipi-net.de>
	<20260323120539.136029-5-nb@tipi-net.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271390-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 337B831F766
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 13:05:33 +0100 Nicolai Buchwitz wrote:
> Implement XDP_TX using ring 16 (DESC_INDEX), the hardware default
> descriptor ring, dedicated to XDP TX for isolation from SKB TX queues.
> 
> Ring 16 gets 32 BDs carved from ring 0's allocation. TX completion is
> piggybacked on RX NAPI poll since ring 16's INTRL2_1 bit collides with
> RX ring 0, similar to how bnxt, ice, and other XDP drivers handle TX
> completion within the RX poll path.
> 
> The GENET MAC has TBUF_64B_EN set globally, requiring every TX buffer
> to start with a 64-byte struct status_64 (TSB). For local XDP_TX, the
> TSB is prepended by backing xdp->data into the RSB area (unused after
> BPF execution) and zeroing it. For foreign frames redirected from other
> devices, the TSB is written into the xdp_frame headroom.
> 
> The page_pool DMA direction is changed from DMA_FROM_DEVICE to
> DMA_BIDIRECTIONAL to allow TX reuse of the existing DMA mapping.

drivers/net/ethernet/broadcom/genet/bcmgenet.c:2420:27: warning: variable 'tx_ring' set but not used [-Wunused-but-set-variable]
 2420 |         struct bcmgenet_tx_ring *tx_ring;
      |                                  ^
-- 
pw-bot: cr

