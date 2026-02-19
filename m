Return-Path: <netdev+bounces-259472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCsjBfoYl2nKugIAu9opvQ
	(envelope-from <netdev+bounces-259472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:06:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A155E15F526
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1EB5300E5A8
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C024E3271F0;
	Thu, 19 Feb 2026 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="JZJAE9LD"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B11E33A711
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771510003; cv=pass; b=RZCBAwvry5kbpDsFNDMKVHHpFD6wW/Sai2trgU+5vdAVpgvrfnaokCZmzayPgUrDXpEiP/lshpARYD8mSScEr0okPB/TystuI5CO/C0tX4qLn/7sbx8K08opvo6s/mO2t5ar9tsu8vrkw3saxbZelDIqJKJ2VuRa3+4QRD3rGjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771510003; c=relaxed/simple;
	bh=XryjM1SBT5gWO9DeKexL4uCijKD3njMgm5Dh4yvPHZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egAmEEIB1WvpaC+O7ZGOAuiOyETftpULkaFzE/E5O9DYxp6S8ZljsupGolF+jvcRMlrq+wxB9iX0pkB3QeR4liuFuM/oauaZUQQKFJk3MAiFk+GQcJ+yaqW/kZGcHK68t3KoJeoMJLLXNUIzGCyPQpffZlS2QTuF633JmGhqQ6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=JZJAE9LD; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1771509936; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z/m66Ob+b9/Tow94UvFTS8SOiLN9xAcVjzSL0UmYgBMGRDBOneGppql1ocfsljruwYNTFaakSR83EpVji7afO5a4WUCb25I+uidzRjkzQSU5P7yg0uDZb0lhYGHRtMN1jf0Ps91G9EE0OCX5SQUHHx8bcYCVZi7tHEGthrzAuiU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771509936; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZrQd+/RxeakwqTpJ+GDObyrLIAlOT84itzEuVeMhcVM=; 
	b=WSj4nFKV1PGwvyTkbvPegoNEI5IIDAK0fBZSqXoiOpSWSLYfS0TRURzcPA1DjXUE9al0yJ5Gufxt9p4ctrUrNFWV4IThf3fJdqG03vSNK+NRjBbuqnbCIgUFxD6lUbMYJXdlvfERgL4QtCB+aptPa6UtSoJqd6LvyYG91lDgpsY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771509936;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZrQd+/RxeakwqTpJ+GDObyrLIAlOT84itzEuVeMhcVM=;
	b=JZJAE9LDmDZxZF0GcT7YPXyB46L82l4uVxZ2sKDVRdTrNtnPLgC1GR4DnBw2yXOS
	b2Ul086jHpVNwJHZmAHc2wkQljogk9xjmVA0nKv6Hq/wM5Y4aDTltseIqAYHiYvc4Wg
	/R7BBmGF3JmovtWaVsqp0L2kkCB1AaEQcM1s0TTJghx/UoDl2TV0hifhx5z3TmIC11q
	dCaJyJ7l1lvrQN6VdFR5o3UqmTJS+dUiOmLkP96KRxjCgn/8Djwnezy1fwsQPRaaDjS
	RIb5BzPlOv4lxvi3CScHG1BP2Aa7pY/33OpFQFCNbgqrOKpnMryf0JrG5q6hvlJuMVY
	LgcGIxLEPA==
Received: by mx.zohomail.com with SMTPS id 1771509934895528.5050575041652;
	Thu, 19 Feb 2026 06:05:34 -0800 (PST)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: kuba@kernel.org
Cc: maciek@machnikowski.net,
	richardcochran@gmail.com,
	netdev@vger.kernel.org,
	milena.olech@intel.com
Subject: [PATCH net-next 1/2] ptp: Expose ptp_clock_info to external drivers
Date: Thu, 19 Feb 2026 15:05:29 +0100
Message-ID: <20260219140530.2148-2-maciek@machnikowski.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219140530.2148-1-maciek@machnikowski.net>
References: <20260219140530.2148-1-maciek@machnikowski.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259472-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[machnikowski.net,gmail.com,vger.kernel.org,intel.com];
	DMARC_NA(0.00)[machnikowski.net];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[machnikowski.net:mid,machnikowski.net:dkim,machnikowski.net:email,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A155E15F526
X-Rspamd-Action: no action

Allow exposing the ptp_clock_info of the ptp_mock to the external drivers.
This is a prerequisite for implementing ptp support on netdevsim mock.

Co-developed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Maciek Machnikowski <maciek@machnikowski.net>
---
 drivers/ptp/ptp_mock.c   | 6 ++++++
 include/linux/ptp_mock.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/ptp/ptp_mock.c b/drivers/ptp/ptp_mock.c
index bbd14ce24..0d0936298 100644
--- a/drivers/ptp/ptp_mock.c
+++ b/drivers/ptp/ptp_mock.c
@@ -171,5 +171,11 @@ void mock_phc_destroy(struct mock_phc *phc)
 }
 EXPORT_SYMBOL_GPL(mock_phc_destroy);
 
+struct ptp_clock_info *mock_phc_get_ptp_info(struct mock_phc *phc)
+{
+	return &phc->info;
+}
+EXPORT_SYMBOL_GPL(mock_phc_get_ptp_info);
+
 MODULE_DESCRIPTION("Mock-up PTP Hardware Clock driver");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/ptp_mock.h b/include/linux/ptp_mock.h
index 72eb40103..e33188dec 100644
--- a/include/linux/ptp_mock.h
+++ b/include/linux/ptp_mock.h
@@ -16,6 +16,7 @@ struct mock_phc;
 struct mock_phc *mock_phc_create(struct device *dev);
 void mock_phc_destroy(struct mock_phc *phc);
 int mock_phc_index(struct mock_phc *phc);
+struct ptp_clock_info *mock_phc_get_ptp_info(struct mock_phc *phc);
 
 #else
 
@@ -33,6 +34,10 @@ static inline int mock_phc_index(struct mock_phc *phc)
 	return -1;
 }
 
+static inline struct ptp_clock_info *mock_phc_get_ptp_info(struct mock_phc *phc)
+{
+	return NULL;
+}
 #endif
 
 #endif /* _PTP_MOCK_H_ */
-- 
2.53.0


