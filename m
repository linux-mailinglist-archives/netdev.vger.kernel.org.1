Return-Path: <netdev+bounces-263990-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EL7MALl8qGmHuwAAu9opvQ
	(envelope-from <netdev+bounces-263990-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:40:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E738206859
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3587F304A302
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 18:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B92361660;
	Wed,  4 Mar 2026 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="toNHnHWE"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5593379960
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648637; cv=none; b=NW9TOSVkpYkbFC1tmmi95RGDmrfJRh3YWNAMzyeAAjx3f4g/uYRwgumjyoWtQBde72cxcMyD3bu27GLFSp++XxIMJIwLVEQzoILdPyynOgUzhI4nkE6RAJ5U3L92nQF1bNVEOVfMd03MvVkR8hlKbpyftZmQJkLpovI0CZlIAnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648637; c=relaxed/simple;
	bh=jc1QvlY1lbLpIbI076nir2ZaedngSe7jeRQsBJr4Czg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=c2pFrQdAie1I5G5Vfslopv2hEMjlX1en+m2df911SHozrR+KkKHhA6OMiM3khhriEYhxlnL8X0WgQWbKWLlsuSbxPVmcSylfEnZxrC9Cp1sRTSkA+gXSl/0G6jSu4UyuNoxYesN7P4Ms/6WNwGIBlYETJpBsYaRbJW7QLzKzdpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=toNHnHWE; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 188044E4253B;
	Wed,  4 Mar 2026 18:23:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D4EA95FF5C;
	Wed,  4 Mar 2026 18:23:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C1E30103694F8;
	Wed,  4 Mar 2026 19:23:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772648631; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=JMu61Yoxk/4le6cWj2PnfG+Kc9s7gnyiyKLhI5011RY=;
	b=toNHnHWElMgVD9FRR4Dkz1DKPOK/qa01pvC5bvgtKh5BedjA1Q1sLylPGR8khnv76BqaCW
	Ary+R9oo9kgrnTWpyjhFwSf5Vpl5HTvWIocLWa1xpDQf3RQh4f4vx2eRlicwYx9kL75mtP
	7wr6q7SIVInvbEZj8J6Cu+nR4DdbXQBfp2QDh/kAYPc414HiYaG6LqMXchQkROnrRfDqly
	8QYQPmYO+RiMvY3XatQzjwZ62UrRMB/U7dIE6M8BSd352AeZ+/WW+LFLskOPvgS2Y53EPI
	RTnDd00hB8T4gECewUqf9w+K6EdBMvQGEGqFEJvuOlH1vhGxE8A8xQvTqh/vRg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net-next 0/8] net: macb: add XSK support
Date: Wed, 04 Mar 2026 19:23:43 +0100
Message-Id: <20260304-macb-xsk-v1-0-3d036076abf5@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBuwKSW6SrQom2qILFRCiO6et
 Hzw+Q8E9sIBuuIBz7cEOV1GVRZgt9GtjDJnAykyikjjMdoJU9ix0WSVbRU1tYGcX54XSf+qB8c
 RHacIw/t+bYm9UWQAAAA=
X-Change-ID: 20260225-macb-xsk-452c0c802436
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 5E738206859
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263990-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[microchip.com,tuxon.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Action: no action

Add XSK support to the MACB/GEM driver.
Tested on Mobileye EyeQ5 (MIPS) evaluation board.
Applies on top of net-next (4ad96a7c9e2c) and Paolo's XDP work [0].

I don't have good Rx benchmark numbers yet, sorry, mostly because of
userspace tooling issues around eBPF/XDP and MIPS. In copy mode it only
means slowdowns, but in zero-copy, as we work with a fixed amount of
buffers, it causes allocation errors.

--

The bulk of the work is dealing with a second allocator. Throughout, we
now use queue->page_pool or queue->xsk_pool. The former gives us raw
buffers which we need to wrap inside xdp_buff and the latter allocates
xdp_buff, meaning less work.

To simplify the implementation, attaching an XSK pool implies closing
and reopening the interface. It could be improved over time as
currently attaching AF_XDP socket in zero-copy mode means we
close/reopen twice: once for the XDP program, once for the XSK pool.

First three patches are cleanup.

   [PATCH net-next 1/8] net: macb: make rx error messages rate-limited
   [PATCH net-next 2/8] net: macb: account for stats in Rx XDP codepaths
   [PATCH net-next 3/8] net: macb: account for stats in Tx XDP codepaths

Then comes preparation work.

   [PATCH net-next 4/8] net: macb: drop handling of recycled buffers in gem_rx_refill()
   [PATCH net-next 5/8] net: macb: move macb_xdp_submit_frame() body to helper function

And finally the XSK codepaths.

   [PATCH net-next 6/8] net: macb: add infrastructure for XSK buffer pool
   [PATCH net-next 7/8] net: macb: add Rx zero-copy AF_XDP support
   [PATCH net-next 8/8] net: macb: add Tx zero-copy AF_XDP support

Thanks,
Have a nice day,
Théo

[0]: https://lore.kernel.org/netdev/20260302115232.1430640-1-pvalerio@redhat.com/

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
Théo Lebrun (8):
      net: macb: make rx error messages rate-limited
      net: macb: account for stats in Rx XDP codepaths
      net: macb: account for stats in Tx XDP codepaths
      net: macb: drop handling of recycled buffers in gem_rx_refill()
      net: macb: move macb_xdp_submit_frame() body to helper function
      net: macb: add infrastructure for XSK buffer pool
      net: macb: add Rx zero-copy AF_XDP support
      net: macb: add Tx zero-copy AF_XDP support

 drivers/net/ethernet/cadence/macb.h      |   2 +
 drivers/net/ethernet/cadence/macb_main.c | 668 +++++++++++++++++++++----------
 2 files changed, 468 insertions(+), 202 deletions(-)
---
base-commit: 06d25a140f34f5879d0731117d4d62a7dd3824a9
change-id: 20260225-macb-xsk-452c0c802436

Best regards,
-- 
Théo Lebrun <theo.lebrun@bootlin.com>


