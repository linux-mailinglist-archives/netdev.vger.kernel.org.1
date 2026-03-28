Return-Path: <netdev+bounces-272817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nwtSNO47yGm/igUAu9opvQ
	(envelope-from <netdev+bounces-272817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 21:37:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C7534FEE2
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 21:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F2F0300A5B6
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 20:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3C833F597;
	Sat, 28 Mar 2026 20:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="avU0OdIG"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD82040DFDA;
	Sat, 28 Mar 2026 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774730207; cv=none; b=b6C0JNJ1RhXKwjfVg74v+h0v7nXVkA9u5ISm+roFJ+gYfnjDBM50q+0JkhOclhfT6TrbFFRkezx6REt2qoUqP2PblxEG2v7CSHYnXqdpp+n4G08RD7qrMg6jb/Vkis8Jcas1aP0ecMFdxkzVR5i6xW7/KJWFnweTbr6UXC/FOlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774730207; c=relaxed/simple;
	bh=nIL0XDMlVefhqrVUWMCYBuniRXD307UvHlLbMTelUkM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KaSM8f8n9E/rEC5j/905IVn3MlBc9q59vO9gHxbS+Jcx9Gh4VhOuAAR/W5hHy2F9jihngqUeJ4zj6mbIOMP5mynGRqDSo+YmbHJsojKJBD7yVdGjA21S5X8CmohrbuslWlS3O2tZvnjPnmM0n33jlR/B3mJqrUVB/y3j7qfV0SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=avU0OdIG; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3038FA5842;
	Sat, 28 Mar 2026 21:36:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774730182; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=j5ffpPEEKmpVzD289rkZzzPLyWoX4V35qWw/m0tK9D8=;
	b=avU0OdIGB2HBb557hov0Tu4evt0t6gxr1mT9ezgsErhao5GSH4/B85QCTHHXkEGVZeGCx7
	YvAqIYXdPdo3R0xVC55aWwZ2P0H7Kw5kfAIfltJUNAhSQB6cc9lepg0MwBUZqOkoYxtiK5
	x+xSMlNFyaGLQVA1X3NtcLex8ftx7eM3zg8ZcRdRb73+GhXvtSDLgatbDhoMFqls6pC0hz
	oqSkOsaLihvbqxPovXXeOyL4qVoPjaCjP1ANXkeUz1I8eXHOpVONKMfj/LiR6ksUd12zaY
	BdNJa+rekM19iMOgko1SIduwXsnqQkwxxmb57WqjB+j8M3Df3Xm6M1kAVg+YhQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 28 Mar 2026 21:36:18 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>, Simon
 Horman <horms@kernel.org>, Doug Berger <opendmb@gmail.com>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/6] net: bcmgenet: add XDP_TX support
In-Reply-To: <20260324210342.61b0b5f8@kernel.org>
References: <20260323120539.136029-1-nb@tipi-net.de>
 <20260323120539.136029-5-nb@tipi-net.de>
 <20260324210342.61b0b5f8@kernel.org>
Message-ID: <b6dc5c465a05fcac74b3979327d12daf@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272817-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39C7534FEE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 25.3.2026 05:03, Jakub Kicinski wrote:
> On Mon, 23 Mar 2026 13:05:33 +0100 Nicolai Buchwitz wrote:
>> Implement XDP_TX using ring 16 (DESC_INDEX), the hardware default
>> descriptor ring, dedicated to XDP TX for isolation from SKB TX queues.
>> 
>> Ring 16 gets 32 BDs carved from ring 0's allocation. TX completion is
>> piggybacked on RX NAPI poll since ring 16's INTRL2_1 bit collides with
>> RX ring 0, similar to how bnxt, ice, and other XDP drivers handle TX
>> completion within the RX poll path.
>> 
>> The GENET MAC has TBUF_64B_EN set globally, requiring every TX buffer
>> to start with a 64-byte struct status_64 (TSB). For local XDP_TX, the
>> TSB is prepended by backing xdp->data into the RSB area (unused after
>> BPF execution) and zeroing it. For foreign frames redirected from 
>> other
>> devices, the TSB is written into the xdp_frame headroom.
>> 
>> The page_pool DMA direction is changed from DMA_FROM_DEVICE to
>> DMA_BIDIRECTIONAL to allow TX reuse of the existing DMA mapping.
> 
> drivers/net/ethernet/broadcom/genet/bcmgenet.c:2420:27: warning: 
> variable 'tx_ring' set but not used [-Wunused-but-set-variable]
>  2420 |         struct bcmgenet_tx_ring *tx_ring;
>       |                                  ^

Missed during the refactoring (should be part of patch 5). I will 
address this in the next version of this series.

Thanks
Nicolai

