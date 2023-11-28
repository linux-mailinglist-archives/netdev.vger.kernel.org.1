Return-Path: <netdev+bounces-51568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BC77FB322
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 08:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA75281E15
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 07:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C3B14264;
	Tue, 28 Nov 2023 07:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tf3HDo8P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2d8p37jw"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1F9C1
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 23:49:11 -0800 (PST)
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1701157750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmL5CR8zibxfhiUX9MHRDXtBuY7eM7PtZ3gjs/r7JEM=;
	b=tf3HDo8Pcxdn2zZGTCzvHX5WdaOdAE98Gt7/uQybYZJgLZcsv/eNzmAjKdViaopJ0nAa9V
	8YRSFtXavP/pvc9cTte5IDVOFg6Jo3K4829mrXKBRMCtmN12Q1pRh+6fgfzUn+nCG8kKId
	nT48wmYbW0ZZfz/s22fKQj9DbQtYX3KjHdr/ssIlKsiyoi0wkHl/lvg9w+hY++R3RAZj3t
	W1RQ6nDSyLOfMnn15cJ0JCZmJt3mUVdUehSFnE4nfper6X544Pq0nA0DAEhEDkGkH821GL
	r3iJR+QIfLMfCB+UnUbdyOufaDTQZq1B/tjSRhJzQ/A9r8UkV/UPAsG2gzWfSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1701157750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CmL5CR8zibxfhiUX9MHRDXtBuY7eM7PtZ3gjs/r7JEM=;
	b=2d8p37jwNTwJtuS/sWIm14SQk0yQvChVx1l3325ynf1+hSxRM24O7UI4pzV1Cv3Ms0oV86
	AKz/2R3AWKl1dyBA==
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH net-next 1/5] igc: Use reverse xmas tree
Date: Tue, 28 Nov 2023 08:48:45 +0100
Message-Id: <20231128074849.16863-2-kurt@linutronix.de>
In-Reply-To: <20231128074849.16863-1-kurt@linutronix.de>
References: <20231128074849.16863-1-kurt@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use reverse xmas tree coding style convention in igc_add_flex_filter().

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 61db1d3bfa0b..d4150542a5c5 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -3577,9 +3577,9 @@ static bool igc_flex_filter_in_use(struct igc_adapter *adapter)
 static int igc_add_flex_filter(struct igc_adapter *adapter,
 			       struct igc_nfc_rule *rule)
 {
-	struct igc_flex_filter flex = { };
 	struct igc_nfc_filter *filter = &rule->filter;
 	unsigned int eth_offset, user_offset;
+	struct igc_flex_filter flex = { };
 	int ret, index;
 	bool vlan;
 
-- 
2.39.2


