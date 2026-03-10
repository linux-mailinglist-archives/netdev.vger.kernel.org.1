Return-Path: <netdev+bounces-265816-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wL1OGotor2myXgIAu9opvQ
	(envelope-from <netdev+bounces-265816-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:40:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B61D924315A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93A6E30DC0CE
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405F2222590;
	Tue, 10 Mar 2026 00:40:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0571199D8;
	Tue, 10 Mar 2026 00:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773103211; cv=none; b=Zr6jQky6lOtbQ7NC3hx1uP/vg4wcH+YZFRWQNsCe37Y/Mgk3W+rX0MWQOpP3w9xaH22Imdrf9DviPmZ1M+6N6Aqlk5q2NdUArWf090yF4kZH9mST+cHjhryK3rWANIVbllGPldUCWLhTRAjNz5XzEd5Z5BdLdqYad3ooIuzvo44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773103211; c=relaxed/simple;
	bh=GHsGgmPUBDJG3onS2N656xtqJ2TLX/SIkWmYQyOulck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZwvlXu/rLWcDr0rFS9v13T5vmlX1qdb4vbF86JOX8cCnW8JBYp9BQGsJO8sxyPQdCkRxVoNiE+Env3l4ECINAugTYR+n8l1QnACayCHXmOQYnqunJTCmwR8LVoNvY4RXSTSpb/m3GnJtbyVmxYYl82+VIqeJuZGiOUCkrcaG2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1vzl8o-0000000083B-24ls;
	Tue, 10 Mar 2026 00:40:06 +0000
Date: Tue, 10 Mar 2026 00:40:03 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next v2 1/2] dsa: tag_mxl862xx: set
 dsa_default_offload_fwd_mark()
Message-ID: <79f5d0ac2f956b67bf2e285030e1b824cf0afdde.1773102942.git.daniel@makrotopia.org>
References: <cover.1773102942.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1773102942.git.daniel@makrotopia.org>
X-Rspamd-Queue-Id: B61D924315A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265816-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[makrotopia.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.704];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

The MxL862xx offloads bridge forwarding in hardware, so set
dsa_default_offload_fwd_mark() to avoid duplicate forwarding of
packets of (eg. flooded) frames arriving at the CPU port.

Link-local frames are directly trapped to the CPU port only, so don't
set dsa_default_offload_fwd_mark() on those.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: don't set dsa_default_offload_fwd_mark() on link-local frames

 net/dsa/tag_mxl862xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/dsa/tag_mxl862xx.c b/net/dsa/tag_mxl862xx.c
index 01f2158682718..ec949d44fc91c 100644
--- a/net/dsa/tag_mxl862xx.c
+++ b/net/dsa/tag_mxl862xx.c
@@ -92,6 +92,9 @@ static struct sk_buff *mxl862_tag_rcv(struct sk_buff *skb,
 	skb_pull_rcsum(skb, MXL862_HEADER_LEN);
 	dsa_strip_etype_header(skb, MXL862_HEADER_LEN);
 
+	if (likely(!is_link_local_ether_addr(eth_hdr(skb)->h_dest)))
+		dsa_default_offload_fwd_mark(skb);
+
 	return skb;
 }
 
-- 
2.53.0

