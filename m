Return-Path: <netdev+bounces-218670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7DEB3DDF6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0DCA188CDD6
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792AD30E0D8;
	Mon,  1 Sep 2025 09:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="sna/2XrI"
X-Original-To: netdev@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B1130DD35;
	Mon,  1 Sep 2025 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718376; cv=none; b=QU2Mn/DEchw4bOVSoaTLV/MvIpGeOmRdRej5d5ySCKCpM1RfhwaIs83Yq0CGlIZhap/Hu8+TySCpLPRtBljGJVe2Uzo4cOLwgOWHM76iD203b2VY+Qq3L357oFijkCIvp3Z90NBUIjZX0Gts2oRwsJU7eS46Td2PeHYxvEcL5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718376; c=relaxed/simple;
	bh=seAwFb1pRSmeCrbvQb9oUa6u3MvmgtF4/2so/uIwfac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ngikMNQmAspZ5tJliRXiH+nD6Gsg8nRd2pjDtHnRS3qOpc8D0wUs742EoFo9qBCg7DDWL4RTbbSUOy96duc0XeWOGWwjPnVezLdT9PRj0A+O9xNVjLq4CAfIWd0dUdoDcFy8xAeQr4HyzFaAV+mLQBPM2jjPYt78x0PVdEAdxrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=sna/2XrI; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5818pONx025374;
	Mon, 1 Sep 2025 11:18:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	dei44I0hfhVVUg9MgxJwwosNqNNi8XOiFSG509rDLXg=; b=sna/2XrIhy6V1SRw
	AmSKTHZy+MK7eyUgmlFdrihWgRHVH8zqmBg9MwHQVGDzotGtyIaJYbmsyXpsgMHB
	rlaSXRwhwrEabTMNywBMTa4EZOxkHgABRoLctN10wMQ3tuzJYmgO55rH0/isHRhx
	e6QF5TdOHY8L88JItN7iiCEypPVWlN9Bq15gG62S5mvPy7Tp8ZpyTUK6GlyFDBZ/
	QKXGx9pKp8/vC0ybVgJQmcf7mfBQG1ABGI4PRnZglrOncJ6aVoOPPP5nLOSVhV+A
	DFsDOC10bRzPy4CansReLnOWlFTPD5QDpdYZRxWPmcrRCjUWgvAchhitdlkoghJV
	iJFbaw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48vav2c021-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 11:18:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D15D14004B;
	Mon,  1 Sep 2025 11:17:41 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0339276652B;
	Mon,  1 Sep 2025 11:16:38 +0200 (CEST)
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 1 Sep
 2025 11:16:37 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Mon, 1 Sep 2025 11:16:28 +0200
Subject: [PATCH net-next v4 2/3] drivers: net: stmmac: handle start time
 set in the past for flexible PPS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250901-relative_flex_pps-v4-2-b874971dfe85@foss.st.com>
References: <20250901-relative_flex_pps-v4-0-b874971dfe85@foss.st.com>
In-Reply-To: <20250901-relative_flex_pps-v4-0-b874971dfe85@foss.st.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Gatien Chevallier
	<gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_04,2025-08-28_01,2025-03-28_01

In case the time arguments used for flexible PPS signal generation are in
the past, consider the arguments to be a time offset relative to the MAC
system time.

This way, past time use case is handled and it avoids the tedious work
of passing an absolute time value for the flexible PPS signal generation
while not breaking existing scripts that may rely on this behavior.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 34 +++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index 3767ba495e78d210b0529ee1754e5331f2dd0a47..ecbff20771f4ecd50b34ab3f84a279ba6a7939c5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -10,6 +10,8 @@
 #include "stmmac.h"
 #include "stmmac_ptp.h"
 
+#define PTP_SAFE_TIME_OFFSET_NS	500000
+
 /**
  * stmmac_adjust_freq
  *
@@ -171,7 +173,11 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 	u32 acr_value;
 
 	switch (rq->type) {
-	case PTP_CLK_REQ_PEROUT:
+	case PTP_CLK_REQ_PEROUT: {
+		struct timespec64 curr_time;
+		u64 target_ns = 0;
+		u64 ns = 0;
+
 		/* Reject requests with unsupported flags */
 		if (rq->perout.flags)
 			return -EOPNOTSUPP;
@@ -180,6 +186,31 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 
 		cfg->start.tv_sec = rq->perout.start.sec;
 		cfg->start.tv_nsec = rq->perout.start.nsec;
+
+		/* A time set in the past won't trigger the start of the flexible PPS generation for
+		 * the GMAC5. For some reason it does for the GMAC4 but setting a time in the past
+		 * should be addressed anyway. Therefore, any value set it the past is considered as
+		 * an offset compared to the current MAC system time.
+		 * Be aware that an offset too low may not trigger flexible PPS generation
+		 * if time spent in this configuration makes the targeted time already outdated.
+		 * To address this, add a safe time offset.
+		 */
+		if (!cfg->start.tv_sec && cfg->start.tv_nsec < PTP_SAFE_TIME_OFFSET_NS)
+			cfg->start.tv_nsec += PTP_SAFE_TIME_OFFSET_NS;
+
+		target_ns = cfg->start.tv_nsec + ((u64)cfg->start.tv_sec * NSEC_PER_SEC);
+
+		stmmac_get_systime(priv, priv->ptpaddr, &ns);
+		if (ns > TIME64_MAX - PTP_SAFE_TIME_OFFSET_NS)
+			return -EINVAL;
+
+		curr_time = ns_to_timespec64(ns);
+		if (target_ns < ns + PTP_SAFE_TIME_OFFSET_NS) {
+			cfg->start = timespec64_add_safe(cfg->start, curr_time);
+			if (cfg->start.tv_sec == TIME64_MAX)
+				return -EINVAL;
+		}
+
 		cfg->period.tv_sec = rq->perout.period.sec;
 		cfg->period.tv_nsec = rq->perout.period.nsec;
 
@@ -190,6 +221,7 @@ static int stmmac_enable(struct ptp_clock_info *ptp,
 					     priv->systime_flags);
 		write_unlock_irqrestore(&priv->ptp_lock, flags);
 		break;
+	}
 	case PTP_CLK_REQ_EXTTS: {
 		u8 channel;
 

-- 
2.25.1


