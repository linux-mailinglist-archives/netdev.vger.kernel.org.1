Return-Path: <netdev+bounces-60247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2276F81E5C2
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 08:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04A1282911
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 07:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0046D4C632;
	Tue, 26 Dec 2023 07:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="vBuMqFYF"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5B54C61E
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703576587; bh=CiicMmIx0APWzq6sNOUP+NQF+kg54apWQ0fTN/fttXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vBuMqFYF23+o4iRsyCJX7JL8vW+/DGhl0KPtqoZjMP54YEfC74U1DxXjSHthIgUFB
	 DhriyoC5lm3xEYP3E60m+nt+2podwQm9mwi0jt9N81wqxtt56Xv0BWozsTbnGLtFeN
	 nsCW1qSIoEcxNfcx7n6qd4S9sSvtewaKnzdAusqc=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 64E8CC40; Tue, 26 Dec 2023 15:25:14 +0800
X-QQ-mid: xmsmtpt1703575514tsxp5k6n6
Message-ID: <tencent_7FC26D7C2FA56EF89584E89EEE52CD20790A@qq.com>
X-QQ-XMAILINFO: NwU0tZNR0OQKsClGszGJVX9Rjo5blKzGqKDnOV5SkKMRy4VN9VhkjIu+mXbw8W
	 FX+XSHxr2/SDVG691khsJHCKA56/nsS+QkgG6J2OcUzftNUwn4b9ejq/TMZNP80wBwqdrorNerwQ
	 iFfHHmOrEOjvtw4lUfU6j4u5VoMAKMadlGveGt2tUxlZTodAY+WSin2vTIV3I5qWoNHI7U6ES2CO
	 DGZk15Br/SYn8s9O/UMCfuxzGcFm3EwzGyR2J1cm0aCWqz/rfCB5+B5wZ2SJXzzLCLQTk+2zp32+
	 tQaG9dBGsyikSJq+grCPeikeJdt6NkaKSr1IUkEkEXYhX87WHao1iMoyJlgsUG6/i2sBbuJ9jmwT
	 g2wBbuSEE9HOeYChW3qe7peuzPuKOBENW0MHdtS1VtUBxt2pWmUYXzkQmQvVz2p0QmuSWdy/U0ig
	 Okn8ql0rNwdwOAYBx+MZUoRk7fPOMejguUtks8OkmdYguNRyzGx7EUCZVPHBzd+iKg92R+oQH2pc
	 YLrqkUAlAW0ueNizDulGsqvmsOGwCZ0q8QFKmKPCFCyLWGpBRuFTaip6LLdDmm9sQjV3IXULI5Vc
	 GEEuM31DPVQQ/U1PoSefhjd/PckVLGyMlMfHjhYNKLNTbHWW7x3po8uc2pWwNnUC2xHTkCcsgMjN
	 t0arJuflRZa3PANqr8r4JxUA3qhkrHUwBYedLLZMrB1iyCPbNxYRdodXEdBiJ+5gurPDBnek+/lf
	 EBSzV3q688fNcOCHxMQarhwGjHTK89gnbCbGoPSK2nVFB5ywGNiXaQ0fiZ/+vGtZgF8ROcdX55pB
	 X06ys8Dz7dzCQaj5mIRhW12YwFd5gDXPewwBsVI5zK1HfbxDkKHi0sAUfO5W1AG9KKa+y1ZWFPD6
	 Y5h5tYm/h59AXtZ3ih8VRnZqqFgh97Hs50CTJ03zmNRCMhFh96d4Pkg8SF+7fs6KvJIvxsaSY+Hu
	 CnNI9r7mJBz6PN4H6fzLhlrIRe9KrBH6ReCL2SY1RMwlf9uL1fLw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	netdev@vger.kernel.org,
	peterz@infradead.org,
	syzkaller-bugs@googlegroups.com,
	xrivendell7@gmail.com
Subject: [PATCH] perf: fix WARNING in perf_event_open
Date: Tue, 26 Dec 2023 15:25:15 +0800
X-OQ-MSGID: <20231226072514.1272529-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000005b23dc060d58ee7a@google.com>
References: <0000000000005b23dc060d58ee7a@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new version of __perf_event_read_size() only has a read action and does not
require a mutex, so the mutex assertion in the original loop is removed.

Fixes: 382c27f4ed28 ("perf: Fix perf_event_validate_size()")
Reported-and-tested-by: syzbot+07144c543a5c002c7305@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 kernel/events/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 9efd0d7775e7..e71e61b46416 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1924,6 +1924,10 @@ static void perf_event__id_header_size(struct perf_event *event)
 	event->id_header_size = size;
 }
 
+#define read_for_each_sibling_event(sibling, event)		\
+	if ((event)->group_leader == (event))			\
+		list_for_each_entry((sibling), &(event)->sibling_list, sibling_list)
+
 /*
  * Check that adding an event to the group does not result in anybody
  * overflowing the 64k event limit imposed by the output buffer.
@@ -1957,7 +1961,7 @@ static bool perf_event_validate_size(struct perf_event *event)
 	if (event == group_leader)
 		return true;
 
-	for_each_sibling_event(sibling, group_leader) {
+	read_for_each_sibling_event(sibling, group_leader) {
 		if (__perf_event_read_size(sibling->attr.read_format,
 					   group_leader->nr_siblings + 1) > 16*1024)
 			return false;
-- 
2.43.0


