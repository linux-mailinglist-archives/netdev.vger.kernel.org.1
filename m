Return-Path: <netdev+bounces-271177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFEwLBXBwmmjlQQAu9opvQ
	(envelope-from <netdev+bounces-271177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:51:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8928E319685
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDBAC3069279
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2EE3F7A8F;
	Tue, 24 Mar 2026 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RBPNLUhO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GXSHEnLW"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AB73EF0DD
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370304; cv=none; b=rE6MfPVNHUx6lR+/f5Y9WU11aWpP+Aj9EO1g1ET13zxt06+HN7TMK1HEMi5TV0e+jh1ENQ2Mb6ejAnpvIXNLbjqloaCtA0oT7TNoAZsZn2oZHtrOJQlht6eOMguOZeW4sPuZxzS/mkrmA9J6MHBWNveviW3lWLma3ybBQ5H6VIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370304; c=relaxed/simple;
	bh=9nsFY7QyMnvQRCi1ZhAg0AmwNAl4qNb2zJwv+6wvvb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLFfJ1/Wy5tBpMUEdH2uxnM4gOWljEuslh9aJPIBHHsKaaQlZhzJ5EW27PEMUVjICoyBv91OZuM2QVjL/9T4JI7Q6LUe9X+n2z6nrt6astaZ0jjoFD5akMzzpNHhdPAICvhi2l9YICM5ysIZn3QMAdxDvdrpFwn5Ma2odRWWjNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RBPNLUhO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GXSHEnLW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Mar 2026 17:38:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1774370301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4OwcY17kG5h3GJj8hGqhZl+mr4nThdAAmN0om3fgan0=;
	b=RBPNLUhONgKgV8L/Ko1uutpVFGL+QUyAYE72RJxD1g9c6uTc/+7xTiME6s5zu964bUlNph
	j6VIb4OBDSVGLiXE1GZUWLnFOib73wnXC+DInnEhs1Q9r0CietvAvSxaTz5PJ9Lyyughrt
	eA0ipl883ZViW6DdY7nzi7w5uWv+qwLQka4z3M7O9TpvO0vtIwSC392z48g6onQ70LwpS1
	S1JF54XE6oUz1OTWPCPjjwlmTFJdZC7erVwLbM7MclLeyrBeuOjN3UL1zOkdSPAJ13JPtt
	07+XWmDPsOh3z5hqus0TPbc99YZMKvh9QY3UVBLLVmHVmQ1BAZi1vHV00ZFNiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1774370301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4OwcY17kG5h3GJj8hGqhZl+mr4nThdAAmN0om3fgan0=;
	b=GXSHEnLWBbHV2bv7iDnZGbeT6zXWKMixSBKWQ/f04qzmrhpVkykh63HfZmrIU8QAE60Zho
	RBuaDAG8nvDsnBBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH RFC net-next v2 2/2] af_packet: Add port specific
 handling for HSR
Message-ID: <20260324163820.p9M2z27W@linutronix.de>
References: <willemdebruijn.kernel.3693c9aa8271@gmail.com>
 <20260312154253.UC-QUPvD@linutronix.de>
 <willemdebruijn.kernel.be379ee17449@gmail.com>
 <20260313092226.SscHp2zQ@linutronix.de>
 <20260313160410.LEhav8Xz@linutronix.de>
 <willemdebruijn.kernel.1fbf050c50d62@gmail.com>
 <20260317172906.eG2LxlZ7@linutronix.de>
 <willemdebruijn.kernel.17068ce38efa5@gmail.com>
 <20260319142613.KHz32I-V@linutronix.de>
 <willemdebruijn.kernel.8e323262df61@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.8e323262df61@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271177-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,ti.com,davemloft.net,lunn.ch,google.com,redhat.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 8928E319685
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-19 12:27:57 [-0400], Willem de Bruijn wrote:
> 
> Right, so this is simple without hardware offload. Does this HW
> offload exist, or is this aspirational. At least for infrequent PTP
> it does not sound important.

The snippet below was for the icssg driver as-is and it works with
updated firmware to ignore PTP packets while HW offloading is enabled.

The hardware offload in general forwards the packets without linux so if
a packet arrives on port A, the HW forwards it on port B and the linux
networking stack receives one copy and does not need to forward it
anymore.
This "cut-through" forwarding is beneficial because the packet is
forwarded instantly without getting delayed by the software stack.

For PTP packets I don't want any of this because the forwarding breaks
the timestamp information. So I need to tell the driver not do any of
the offloading while sending and the updated firmware does the same for
incoming packets.

There is no HW-offloading of PTP related packets.

With the skb_ext I had, the mechanism was mostly the same but it relied
only on the skb_ext data. Now it has to look at skb->mark.

Sebastian

