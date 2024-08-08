Return-Path: <netdev+bounces-117006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D76EF94C51D
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 21:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14AA51C21DAA
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 19:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3727D14EC62;
	Thu,  8 Aug 2024 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pappasbrent.com header.i=@pappasbrent.com header.b="C1ZtKlaS"
X-Original-To: netdev@vger.kernel.org
Received: from h7.fbrelay.privateemail.com (h7.fbrelay.privateemail.com [162.0.218.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9CA12C81F;
	Thu,  8 Aug 2024 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.0.218.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723144739; cv=none; b=ScGo60wuj24IIEa+sy9Hrnewap0BQaH+Jlr0V93VTQWMAtu2H/g0XS04LczbAf3jXZCmXdDnNMet/4L+Knc22+MRWdpancAX/Phs9q/Ae28VZPjdMUuyEC0VnLY8VyIx/lfbBQBNoSbvp0oQjn+ixKQ16XzipIgAXNp7XTYVIY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723144739; c=relaxed/simple;
	bh=rgLCQeZ7+U0CpJiowNUqrHoJ5FC9wf4c1MrLH5GyYos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oNFCiVsQfIxiEJwwcTg4EYjsbRkiL37vfw263Wl4eEuqiPMMN6KG8Accr6o8A3DWu6i+Ss8UGFPvG+a3UT2vyk6oTkXpmftwhFGKxuVf7KKMapiB1wwaIbg/fpSl+szYgW/H43hw9Yhrfa3791ZQH1ZpsrNv8gyPsIYc0RlAI08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pappasbrent.com; spf=pass smtp.mailfrom=pappasbrent.com; dkim=pass (2048-bit key) header.d=pappasbrent.com header.i=@pappasbrent.com header.b=C1ZtKlaS; arc=none smtp.client-ip=162.0.218.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pappasbrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pappasbrent.com
Received: from MTA-07-3.privateemail.com (mta-07.privateemail.com [198.54.127.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by h7.fbrelay.privateemail.com (Postfix) with ESMTPSA id EBF2D601A7;
	Thu,  8 Aug 2024 15:06:49 -0400 (EDT)
Received: from mta-07.privateemail.com (localhost [127.0.0.1])
	by mta-07.privateemail.com (Postfix) with ESMTP id 441DF180004F;
	Thu,  8 Aug 2024 15:06:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pappasbrent.com;
	s=default; t=1723144002;
	bh=rgLCQeZ7+U0CpJiowNUqrHoJ5FC9wf4c1MrLH5GyYos=;
	h=From:To:Cc:Subject:Date:From;
	b=C1ZtKlaScFK0/XJGEGa8NgDPjIjHVGUCkZnl+g5XmwGkCZLzuPSEm2LwjjXvA03uQ
	 Z4JA3xKkomnkhaXDEMw9wNzbQBb92ce1TogHaVsNaWcUUFyXRZvR4wy8zNRSqsZo+G
	 X459HRv+FLA9xCPMsIHLWuv4s6dj/I5I+Ot2EwIRLwtjsf4KrTqLR6G0SwoKxJcj+i
	 6EmFdhLYsveM3DvbW53rrzu6y8GWGJIYWagOc/P6qR0BwyThK4fyHDzcAZjpuM8TjE
	 D3HmS9uYYf75DaUsMMbCnwuvvTwAtvxn27XJo641uK5wb2X+IL30/RITA2Qkok8MFI
	 eM7VwxOzGVFtA==
Received: from bpappas-XPS-13-9310.. (65-123-224-58.dia.static.qwest.net [65.123.224.58])
	by mta-07.privateemail.com (Postfix) with ESMTPA;
	Thu,  8 Aug 2024 15:06:33 -0400 (EDT)
From: Brent Pappas <bpappas@pappasbrent.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Brent Pappas <bpappas@pappasbrent.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ipv6: mcast: Add __must_hold() annotations.
Date: Thu,  8 Aug 2024 15:02:55 -0400
Message-ID: <20240808190256.149602-1-bpappas@pappasbrent.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Add __must_hold(RCU) annotations to igmp6_mc_get_first(),
igmp6_mc_get_next(), and igmp6_mc_get_idx() to signify that they are
meant to be called in RCU critical sections.

Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
---
 net/ipv6/mcast.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 7ba01d8cfbae..843d0d065242 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -22,6 +22,7 @@
  *		- MLDv2 support
  */
 
+#include "linux/compiler_types.h"
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/types.h>
@@ -2861,6 +2862,7 @@ struct igmp6_mc_iter_state {
 #define igmp6_mc_seq_private(seq)	((struct igmp6_mc_iter_state *)(seq)->private)
 
 static inline struct ifmcaddr6 *igmp6_mc_get_first(struct seq_file *seq)
+	__must_hold(RCU)
 {
 	struct ifmcaddr6 *im = NULL;
 	struct igmp6_mc_iter_state *state = igmp6_mc_seq_private(seq);
@@ -2882,7 +2884,9 @@ static inline struct ifmcaddr6 *igmp6_mc_get_first(struct seq_file *seq)
 	return im;
 }
 
-static struct ifmcaddr6 *igmp6_mc_get_next(struct seq_file *seq, struct ifmcaddr6 *im)
+static struct ifmcaddr6 *igmp6_mc_get_next(struct seq_file *seq,
+					   struct ifmcaddr6 *im)
+	__must_hold(RCU)
 {
 	struct igmp6_mc_iter_state *state = igmp6_mc_seq_private(seq);
 
@@ -2902,6 +2906,7 @@ static struct ifmcaddr6 *igmp6_mc_get_next(struct seq_file *seq, struct ifmcaddr
 }
 
 static struct ifmcaddr6 *igmp6_mc_get_idx(struct seq_file *seq, loff_t pos)
+	__must_hold(RCU)
 {
 	struct ifmcaddr6 *im = igmp6_mc_get_first(seq);
 	if (im)
-- 
2.46.0


