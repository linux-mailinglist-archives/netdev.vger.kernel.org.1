Return-Path: <netdev+bounces-281127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHD0AsU27Wl/gwAAu9opvQ
	(envelope-from <netdev+bounces-281127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 23:48:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1A6467E90
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 23:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3476300CE57
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 21:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9983161AD;
	Sat, 25 Apr 2026 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b="EkNZ3VcG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b="q0Tq/clK"
X-Original-To: netdev@vger.kernel.org
Received: from acj35aaf123.lhr1.oracleemaildelivery.com (acj35aaf123.lhr1.oracleemaildelivery.com [130.35.116.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BEE3016E1
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 21:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.35.116.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777153720; cv=none; b=qUlkfodkKjjsr2tERGQU1wWJwHvEQwZ1Vs0p0MM3eUjkvLre00kb4Uu18pc8XFKG5egz5c5E6j0ObtT0DdYsfLlZp6N/o7jJeAZe55qbaTMdyV99PVgFbtAGlzIwylgi210BHPygXsLDaKBpIiE7uO7swzvnPIJopDN38uS2uA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777153720; c=relaxed/simple;
	bh=fCNW8vHxLGHPNlY8yV7CFJ69YAV1qDI58cXP8B9+1bg=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version:Content-type; b=YzabQhDrMm1AWi+4qsEbVAKB/n426PEAYzHmIIH7RMkpFrM4xilwDbwaKst0gtloslM1TvZnPz+jC8pM+i8Jyz8yJ5hglqQdGGxhVcpzFgRVZphwN4baTqKsgccGJU4CTlO0nHxkkuIla3Vw3ZT8L2adgle4cke1rkRF7NM6G9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=raczylo.com header.i=@raczylo.com header.b=EkNZ3VcG; dkim=pass (2048-bit key) header.d=lhr1.rp.oracleemaildelivery.com header.i=@lhr1.rp.oracleemaildelivery.com header.b=q0Tq/clK; arc=none smtp.client-ip=130.35.116.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raczylo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lhr1.rp.oracleemaildelivery.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oracle-uk-012026;
 d=raczylo.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=t9CQ5m3wOhmUWV8If1GVflZNLT7+4pTChH+YanoajiM=;
 b=EkNZ3VcGfiRWCkqk6kyK7eeHLrLQphTy6OTsYG2WanMLmaVZ2nwdR7EtJNiELMa5JCzQLLSIcZNb
   +WYkbuluWHxA/d6g9BdhVQ9arpfoA4QH8bcjP8clWhfuADWKNqgydsGUqJwe0HvLz7Qgq0QBjHN7
   LwUYAKLRj/gQ0ktlwi3uSxYoTuBWq0HvEnkqDWAx8uAip+IHEaJQBhmF6ExOOGj0eBIgcvIZIRWL
   SG/7enFy4pj+4De9YWgQMCjIl3D3axDP1n1Gvg1SKPypXOKGa/y11o58d0Mih0C4fY82s3Bcmpo6
   5fugg6t6eyIgDikxvJ0ZLDHiF1P0Uxb6ycSn2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-lhr-20191104;
 d=lhr1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=t9CQ5m3wOhmUWV8If1GVflZNLT7+4pTChH+YanoajiM=;
 b=q0Tq/clKdT0FqBof2Qrl5StSEq/Y0CyusJHGNjbx+eNdanOtsnONrPbbo1+iCIfNhWawkBdtzm3z
   Mh9DlKVnQTLEnXX1OfEQngXxLOTTDJZFttX9X2xZkHL/hXqw/aCUSS3FaX0yV79Bi3dD8e8ATuxh
   kuPpfjZL6ZIFq/RVZ23eQXWk/8njz8Oy0JJY5AqkwL9N13Ri4w6dRhoImoBOT9Ve86LumHNAlJtw
   7vKylNGiS5UawIrvYU6RFzh8RtzpE9aeJFHtsly+G84Mv65cOVU1JFtmBdKN58kZtTtzg6U66DHM
   sDCZZTxf13bipM1FmCSSRdGNUWv558WYMkDX1Q==
Received: by omta-ad2-fd1-401-uk-london-1.omtaad2.vcndplhr.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260212 64bit (built Feb 12
 2026))
 with ESMTPS id <0TE200LEQKKZ1CD0@omta-ad2-fd1-401-uk-london-1.omtaad2.vcndplhr.oraclevcn.com> for
 netdev@vger.kernel.org; Sat, 25 Apr 2026 21:48:35 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Lukasz Raczylo <lukasz@raczylo.com>
To: netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH net-next 0/3] net: macb: candidate fixes for silent TX
 stall on BCM2712/RP1
Date: Sat, 25 Apr 2026 22:48:25 +0100
Message-id: <20260425214825.31390-1-lukasz@raczylo.com>
X-Mailer: git-send-email 2.54.0
In-reply-to: <cover.1777064117.git.lukasz@raczylo.com>
References: <cover.1777064117.git.lukasz@raczylo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGFHUMHCyhz/Y5E0y2VFlm0i9zvAyzdLN9Op57gLgDDSYmpEyUmc63P+pWevRkF
 S/s8SFa5KPNQyr+28RldTqXqgFU1A33tbQMLtH44ph0MHcSd7XYi61E+0jA+QcQd
 NE04JaKOvebiYuMMecd3jyvZP/aqo9iH4YU6ORBc67kTkzz/DhCslHS+jBhj4uUe
 456vb9uhJe+k+C/wHGkVIyP/XX9uukb3o124apWhiUp/rRyZ3fvUK5CtXf9lL3U5
 hPjqyfZdQUqoq7O9a7mkFRV4xDyU07OYE4ZR23AyRSB1JsgMybfXM/Z9qEPElOTC
 c/UVque39CNjafOS+/ok+NL8CX47QYdGV23xMHVN40Mh9HEfKZvOCafWxX/8oXG3
 oHdTIJtxHuLwAN7GtRt8S0lTVzlKY28rPpNxtoERZ0MwayFjycfR5d47gNfw
X-Rspamd-Queue-Id: 9F1A6467E90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[raczylo.com : SPF not aligned (relaxed),reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[raczylo.com:s=oracle-uk-012026,lhr1.rp.oracleemaildelivery.com:s=prod-lhr-20191104];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-281127-lists,netdev=lfdr.de];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz@raczylo.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[raczylo.com:-,lhr1.rp.oracleemaildelivery.com:-];
	NEURAL_HAM(-0.00)[-0.974];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[raczylo.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

A follow-up runtime data point on this series.

Fleet state at 2026-04-25 21:46 UTC:

  * Patched uptime (since staggered rollout 2026-04-24 18:10-19:20 UTC):
    - shortest: 26h 26m   (last master upgraded)
    - longest:  27h 34m   (canary)
    - cumulative across 24 nodes: ~651 node-hours

  * Macb-attributable event counts (out-of-band userspace watchdog;
    the [tx-stall] detector watches /sys/class/net/end0/statistics/
    tx_packets + qdisc backlog every 1 s and would have fired
    ip link down/up if any node's TX path froze):
    - RECOVER trigger=tx-stall (actual stalls caught):    0
    - partial [tx-stall] markers (transient 1 s freezes): 0

  * Separately: 40 RECOVER events with trigger=ping fired in this
    window across the fleet, attributable to a brief upstream-network
    outage (gateway / switch event); each node simultaneously lost ping
    to gateway, VIP, and NAS within seconds of each other, then
    recovered.  These are unrelated to the macb hang the patch series
    targets — distinguishing them from a real TX stall is exactly what
    the trigger= tag in the watchdog log is for.

At the pre-patch rate referenced in the cover letter (50 stalls in
95 node-hours observed in our 2026-04-24 14:00-18:10 UTC reference
window, ~0.5 per node-hour), the projected stall count in
651 node-hours is on the order of 342;
observed is 0.

Same observability runs forward; will reply again after a full week
of uptime unless something changes.

--
Lukasz Raczylo

