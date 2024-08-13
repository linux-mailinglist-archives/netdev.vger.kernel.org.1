Return-Path: <netdev+bounces-118032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274169505C5
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 14:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13B64B27E68
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDE719CCFC;
	Tue, 13 Aug 2024 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="WnjhTiWo"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A5319B580
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 12:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553782; cv=pass; b=HEVRAxc4l2sMKS004C8T3BqA1Bm/l66A7JBgvGhaRZULJT2ORy7gPShDwBUDywMofHUJiiYCAKaSX/FejE8gc88SkbDdKqlnhRhKy1CTsFEhosOr1u4QCiudkIamyJ3kNDCE2S9DIk0W0QldkQmYPYwyLIUH6jWAoFJJx3FmX0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553782; c=relaxed/simple;
	bh=csLIXwhzVMKXxdpYpS2z2tH4FIquiExDW33a5MAsjlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eLPYP/LoWJqd6uK3wMmxD8ONGw0yVW8E/TDCCZHyCH0g+946WveXDgFqFllL4A2YNlua30cjUMYuvMfV85FxA+OjLo8wjD6B5+YN2wBsKUADlsUaRe6qhVa/xBgxOJMPMlaee2rQK+gK3ilmctQ59Bj4xEJMO8yIWJp6qug5tHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=WnjhTiWo; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
Delivered-To: maciek@machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1723553774; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GM6Ga5kUKy2MIaQMV++lyPuVVJQCHH3citrF6WXZWGTyJoRxkSZ+OLuJE4MfAcpk/hdamp7ehG60nv4SaWtc0yg9TkdU48PJpTs0yqDM0aQnrJWfzwpjmdWSPu8HyRObEliG0l1MiINF9gyfRneazKfRF5OdqHOj53T03PBomgc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723553774; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vMibIEdDAvusM9BkQQAIy/PeiFmeVAawxS4pM2gWLDA=; 
	b=Hm1e3tC4BRXWIHXElhRxm5Y7hen7B1rckec0qlutuCkIf5wcRgndotag5YNe5KauSjdA0m834PMKJ4q7Q+joI6ynGBbALL2NJd1HpZk1IR+F17dB4k6KF2qS/q4UQ5X1g7RAceXP5LGIoUeMhKjRdRXtvRu8c1L1y+z6d3Uz4+4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723553774;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=vMibIEdDAvusM9BkQQAIy/PeiFmeVAawxS4pM2gWLDA=;
	b=WnjhTiWo6UXXrokND5khgeY0cpSrDr+xmSp/dQTGVj+3FAqltYGlt/RiCIP40qHJ
	6x4DNmX0nvwcG3z2t2pEGifILKHOhxkE/C+gp/obJLZsoMWuLzRJtaPUkAym6CIvF/r
	hDhITF4Bc5FWnzPxGSsQIMq1yx3k2U9HYItandcXGzufCWObce+C4ykU7Aa6aCO7dX8
	PPdeCI33Q2654wBbpVoDy0WVc1UgIxF4dtL/78SJ+umBuunVo8hHUQgcEISKH+I0rc8
	rb618h5gJZSIIkzwQR8XvQKFfMLxQ0OViTtBLEb/pPcpeaUEmQffwdWMwdchS+oJwQb
	HXSisM6eWQ==
Received: by mx.zohomail.com with SMTPS id 1723553773143674.3065954727515;
	Tue, 13 Aug 2024 05:56:13 -0700 (PDT)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: maciek@machnikowski.net
Cc: netdev@vger.kernel.org,
	richardcochran@gmail.com,
	jacob.e.keller@intel.com,
	vadfed@meta.com,
	darinzon@amazon.com,
	kuba@kernel.org
Subject: [RFC 2/3] ptp: Implement support for esterror in ptp_mock
Date: Tue, 13 Aug 2024 12:56:01 +0000
Message-Id: <20240813125602.155827-3-maciek@machnikowski.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813125602.155827-1-maciek@machnikowski.net>
References: <20240813125602.155827-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Implement basic example of handling the esterror using
getesterror/setesterror functions of the ptp_clock_info

Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
---
 drivers/ptp/ptp_mock.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/ptp/ptp_mock.c b/drivers/ptp/ptp_mock.c
index e7b459c846a2..1786da790f82 100644
--- a/drivers/ptp/ptp_mock.c
+++ b/drivers/ptp/ptp_mock.c
@@ -35,10 +35,13 @@
 
 struct mock_phc {
 	struct ptp_clock_info info;
+	struct timespec64 sys_ts;
+	struct timespec64 hw_ts;
 	struct ptp_clock *clock;
 	struct timecounter tc;
 	struct cyclecounter cc;
 	spinlock_t lock;
+	long esterror;
 };
 
 static u64 mock_phc_cc_read(const struct cyclecounter *cc)
@@ -100,6 +103,31 @@ static int mock_phc_gettime64(struct ptp_clock_info *info, struct timespec64 *ts
 	return 0;
 }
 
+static int mock_phc_getesterror(struct ptp_clock_info *info, long *esterror,
+				struct timespec64 *hw_ts, struct timespec64 *sys_ts)
+{
+	struct mock_phc *phc = info_to_phc(info);
+
+	*esterror = phc->esterror;
+	if (hw_ts)
+		*hw_ts = phc->hw_ts;
+	if (sys_ts)
+		*sys_ts = phc->sys_ts;
+
+	return 0;
+}
+
+static int mock_phc_setesterror(struct ptp_clock_info *info, long esterror)
+{
+	struct mock_phc *phc = info_to_phc(info);
+
+	phc->esterror = esterror;
+	phc->hw_ts = ns_to_timespec64(timecounter_read(&phc->tc));
+	phc->sys_ts = ns_to_timespec64(ktime_get_raw_ns());
+
+	return 0;
+}
+
 static long mock_phc_refresh(struct ptp_clock_info *info)
 {
 	struct timespec64 ts;
@@ -134,6 +162,8 @@ struct mock_phc *mock_phc_create(struct device *dev)
 		.adjtime	= mock_phc_adjtime,
 		.gettime64	= mock_phc_gettime64,
 		.settime64	= mock_phc_settime64,
+		.getesterror	= mock_phc_getesterror,
+		.setesterror	= mock_phc_setesterror,
 		.do_aux_work	= mock_phc_refresh,
 	};
 
-- 
2.34.1


