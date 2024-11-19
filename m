Return-Path: <netdev+bounces-146356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0898C9D305E
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 23:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB167283C3B
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 22:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CCE1D043F;
	Tue, 19 Nov 2024 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="WerwblkY"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4FB188704;
	Tue, 19 Nov 2024 22:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732054919; cv=none; b=Sk0ilprGot6hWoNlJBQg6bz/l9KtVJG5HKUueVg5gW97d7MGgDj87+IETaUZCdbGQMUpTj9lIv5YmkeCvl0Q7GpbS1OSYrwmTKOBw10dkhndOfm9Q/cHiOAF4TOKk+CFnlTnL09wQae0oQVEvBZTlGPxwmcjjJJ1JQ3SnqJcHME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732054919; c=relaxed/simple;
	bh=cF1iOYXgx7EUZBi/kFYrkWmAEw8t0MrdXPp2O/hCa+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TkEGOuguRAC+lNKMJl4UaVbk3GYoSz6gAm3e9pjq8TgNo2Vdl0btYoDs26X6o0I2MYr3M8btvvfqCnQeArOsVNwLX88tWUEq6BrTGXAi0Ea+PVP43idXhMS0IRm89jTCypyGdMpEy2tiQ6cwLAvkId+u9dExy/KKELt928i3rbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=WerwblkY; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from ubuntu.home (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 62B9B200CCF3;
	Tue, 19 Nov 2024 23:21:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 62B9B200CCF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1732054910;
	bh=to687Gkwrc1hnQQoEgmLYx3ysEJ7wdMxa7NT5CZGMhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WerwblkYCjfYkSMiAfJdKYlb3ZEkL1aXboxG3JjQQNo2IVyfSDc2v6B6r2WkXkrWn
	 9vUxRtdr3InrhOSsBPPhbkotK4G1TU1emw5LFLge97hNA8quu+eI57hVxkasSaAU+e
	 E/ZJrUf3RlfKogS58f7s2QBWgs8Cu45kpUBzZCMOVE9Rx1pYovwbJZCIcpcOO4kvif
	 fARCPu44F50f8/EWxFYVcLa+UKB0ejetM8MCJEO6+fXbel9viBfhgaK93IFzAWJpUT
	 +7fMkn9jReq57K9WHfOINuoutJGP44rFE3fBmOZpyg/Kok29Eard++3MFHl2XFjldi
	 p1KS8LscOkv9A==
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
Subject: [PATCH net-next v5 1/4] include: net: add static inline dst_dev_overhead() to dst.h
Date: Tue, 19 Nov 2024 23:21:36 +0100
Message-Id: <20241119222139.14338-2-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119222139.14338-1-justin.iurman@uliege.be>
References: <20241119222139.14338-1-justin.iurman@uliege.be>
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
 include/net/dst.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/net/dst.h b/include/net/dst.h
index 0f303cc60252..08647c99d79c 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -440,6 +440,15 @@ static inline void dst_set_expires(struct dst_entry *dst, int timeout)
 		dst->expires = expires;
 }
 
+static inline unsigned int dst_dev_overhead(struct dst_entry *dst,
+					    struct sk_buff *skb)
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


