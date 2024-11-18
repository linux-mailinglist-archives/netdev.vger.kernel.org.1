Return-Path: <netdev+bounces-145837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D843B9D11BE
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 14:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 753F0B23226
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 13:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E6019D89D;
	Mon, 18 Nov 2024 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="zySOVMKW"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA99199953;
	Mon, 18 Nov 2024 13:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936088; cv=none; b=VLWWP3jsaw3SsVbdT1xpbLgJcDLnuHMxk9v+tphx+dMS45dinxft9zjuVmQ1K0rlpVsBi0DHyGJmX9JrQ+DoW5CeXoFJkzK9tiV1OEjAapEyPDU0DI+ax1nJ0emCc4g2M0ibeJwpoH+KkXQBMrdgFBSPgkiavKpAhAdi1ieC4Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936088; c=relaxed/simple;
	bh=frGXdPDFKBEuHHNSFyTyGguG9oglPOtv2z6cgXk/D+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PRgDGasWNDRZC86cCuqsbszGL8P34vwkqLNYytIOqLWrKohSmcWqbEghgEAP5PI5E7XhVcVyTQFetAE4w+DRFl8gUJYlLifpcB6PZkXb7q4dNNyT7sclWAW8ky4r49Tchnma5CkGiMxWaLlbR/E8OlCwVV9CQdBJ5QDs0NQG2mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=zySOVMKW; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id C7292200DF84;
	Mon, 18 Nov 2024 14:15:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be C7292200DF84
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1731935718;
	bh=I4D19/zw2U0OWpmierA9EawbL81A7CfWDg2OPLzVbVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zySOVMKWUe18p0g3LjHUfxbRfloEgCovSoQHj4Yr33nUyuXBsnVNk7cW0Hg3a0Yq0
	 VPQebdsvTLQ/0K2XDMJLARtMVmnZbojydzBkysJetfMctGqeZyyDhM5O0xo6baE5GZ
	 +4J6kdCXMNDBtwaua2S2l/h8ebH3Q0BXh9sixHKU3i/FZ30qBby/kd3c1F25UZRxYM
	 /WFAGv5qQXs6lvpHMGHoDNFVxPWf9nXsWHORrtxbenzpg0/mzzUPIHXk5F2VuFgg7l
	 Lp2pdlA+p10b36bRkqWtKegKek9FyXrcd3731VApV3HtYzamlonJFROExwv/B9bJ3D
	 ArArYkKNPFmFA==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v4 1/4] include: net: add static inline dst_dev_overhead() to dst.h
Date: Mon, 18 Nov 2024 14:14:59 +0100
Message-Id: <20241118131502.10077-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241118131502.10077-1-justin.iurman@uliege.be>
References: <20241118131502.10077-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add static inline dst_dev_overhead() function to include/net/dst.h. This
helper function is used by ioam6_iptunnel, rpl_iptunnel and
seg6_iptunnel to get the dev's overhead based on a cache entry
(dst_entry). If the cache is empty, the default and generic value
skb->mac_len is returned. Otherwise, LL_RESERVED_SPACE() over dst's dev
is returned.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 include/net/dst.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/net/dst.h b/include/net/dst.h
index 0f303cc60252..ddea596be9a0 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -440,6 +440,14 @@ static inline void dst_set_expires(struct dst_entry *dst, int timeout)
 		dst->expires = expires;
 }
 
+static inline int dst_dev_overhead(struct dst_entry *dst, struct sk_buff *skb)
+{
+	if (likely(dst))
+		return LL_RESERVED_SPACE(dst->dev);
+
+	return skb->mac_len;
+}
+
 INDIRECT_CALLABLE_DECLARE(int ip6_output(struct net *, struct sock *,
 					 struct sk_buff *));
 INDIRECT_CALLABLE_DECLARE(int ip_output(struct net *, struct sock *,
-- 
2.34.1


