Return-Path: <netdev+bounces-156639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C88FA072FB
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B8C3A8958
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8DC217F3D;
	Thu,  9 Jan 2025 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Zhf2frH6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D90217703;
	Thu,  9 Jan 2025 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736418204; cv=none; b=hzST11YTq/ywDetjflM0y8WhS9D8WhYP6tsf6SPFVYXxp4HlB12nFg84BvK6+n6DNAhTAlm0wVvQ34UMOE1pr4Eo+DkjEbAQdpxVlY46kT0+LmXM6hleAfercrCZRXYK3fuGLTLUYilIWNHH9vBfaKWvyXcIrSPb9ho0Gghuyx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736418204; c=relaxed/simple;
	bh=NjRPw8FFcwSsC7GWJw8GpJ1xM0sU7Ro1sLvyXyylXS4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QwPk6Ua2VdRLH29wm4vyu++ma3jrSIX3eXCm5wdkqL++X8uDjFNuLTkPLIR1bMawd+7xBa/ZmBO+co/1oxtKpVrj08RJo4BzKyhxBS95+SMyCmUmThs3+r+Zt2EOsvUUfVGZXmX9pCesGZFV0Df7G7gOwHlXdwGTzhS8FioLa4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Zhf2frH6; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1736418201; x=1767954201;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=NjRPw8FFcwSsC7GWJw8GpJ1xM0sU7Ro1sLvyXyylXS4=;
  b=Zhf2frH6EnxJPJPzoYwoQGLUwsfsZxsJi7zUxywSYJbk6bNv3ZQbf9Vo
   ugZJBbGU7fzs5oH5Mo45IOJuqsGm0QckqSfVhDZmUISyVo4IIf6kn0WkP
   IB41vrYh+/k57W/pCO6n2bL6Cwb+kFoDnTw5IUsWzke43G6OovNYyyDyv
   Qg8N645XjDsWawAkPVfTRfnvRbgHNfoRTtBZdMdeUJOYKOJwQxQ3bcOcd
   JMPhnGXMlvHi2ADqeoiJvM1wnnPBQx1XrTLBYje5ojmZDjiuwv/YsnYlH
   vAHJ0Bk7sGm7AkfSEA9tRLI3SXhygUzcgX01eH4BSa0fsBZOFZwv16Mh7
   w==;
X-CSE-ConnectionGUID: pKZMzjv2RsiFZGF8PKVKgw==
X-CSE-MsgGUID: zcnZhaLzQhmczfwilxqcCg==
X-IronPort-AV: E=Sophos;i="6.12,301,1728975600"; 
   d="scan'208";a="40189023"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jan 2025 03:23:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 9 Jan 2025 03:22:46 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 9 Jan 2025 03:22:42 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v2 3/3] net: phy: microchip_rds_ptp : Add PEROUT feature library for RDS PTP supported phys
Date: Thu, 9 Jan 2025 15:55:33 +0530
Message-ID: <20250109102533.15621-4-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250109102533.15621-1-divya.koppera@microchip.com>
References: <20250109102533.15621-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adds PEROUT feature for RDS PTP supported phys where
we can generate periodic output signal on supported
pin out

Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
v1 -> v2
- Added support of periodic output only for the pinout that is specific
  to PEROUT
---
 drivers/net/phy/microchip_rds_ptp.c | 294 ++++++++++++++++++++++++++++
 1 file changed, 294 insertions(+)

diff --git a/drivers/net/phy/microchip_rds_ptp.c b/drivers/net/phy/microchip_rds_ptp.c
index 2936e46531cf..b32b6ae162b3 100644
--- a/drivers/net/phy/microchip_rds_ptp.c
+++ b/drivers/net/phy/microchip_rds_ptp.c
@@ -54,6 +54,267 @@ static int mchp_rds_phy_set_bits_mmd(struct mchp_rds_ptp_clock *clock,
 	return phy_set_bits_mmd(phydev, PTP_MMD(clock), addr, val);
 }
 
+static int mchp_get_pulsewidth(struct phy_device *phydev,
+			       struct ptp_perout_request *perout_request,
+			       int *pulse_width)
+{
+	struct timespec64 ts_period;
+	s64 ts_on_nsec, period_nsec;
+	struct timespec64 ts_on;
+
+	ts_period.tv_sec = perout_request->period.sec;
+	ts_period.tv_nsec = perout_request->period.nsec;
+
+	ts_on.tv_sec = perout_request->on.sec;
+	ts_on.tv_nsec = perout_request->on.nsec;
+	ts_on_nsec = timespec64_to_ns(&ts_on);
+	period_nsec = timespec64_to_ns(&ts_period);
+
+	if (period_nsec < 200) {
+		phydev_warn(phydev, "perout period small, minimum is 200ns\n");
+		return -EOPNOTSUPP;
+	}
+
+	switch (ts_on_nsec) {
+	case 200000000:
+		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_200MS_;
+		break;
+	case 100000000:
+		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_100MS_;
+		break;
+	case 50000000:
+		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_50MS_;
+		break;
+	case 10000000:
+		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_10MS_;
+		break;
+	case 5000000:
+		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_5MS_;
+		break;
+	case 1000000:
+		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_1MS_;
+		break;
+	case 500000:
+		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_500US_;
+		break;
+	case 100000:
+		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_100US_;
+		break;
+	case 50000:
+		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_50US_;
+		break;
+	case 10000:
+		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_10US_;
+		break;
+	case 5000:
+		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_5US_;
+		break;
+	case 1000:
+		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_1US_;
+		break;
+	case 500:
+		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_500NS_;
+		break;
+	case 100:
+		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_100NS_;
+		break;
+	default:
+		phydev_warn(phydev, "Using default pulse width of 200ms\n");
+		*pulse_width = MCHP_RDS_PTP_GEN_CFG_LTC_EVT_200MS_;
+		break;
+	}
+	return 0;
+}
+
+static int mchp_general_event_config(struct mchp_rds_ptp_clock *clock,
+				     int pulse_width)
+{
+	int general_config;
+
+	general_config = mchp_rds_phy_read_mmd(clock, MCHP_RDS_PTP_GEN_CFG,
+					       MCHP_RDS_PTP_CLOCK);
+	if (general_config < 0)
+		return general_config;
+
+	general_config &= ~MCHP_RDS_PTP_GEN_CFG_LTC_EVT_MASK;
+	general_config |= MCHP_RDS_PTP_GEN_CFG_LTC_EVT_SET(pulse_width);
+	general_config &= ~MCHP_RDS_PTP_GEN_CFG_RELOAD_ADD;
+	general_config |= MCHP_RDS_PTP_GEN_CFG_POLARITY;
+
+	return mchp_rds_phy_write_mmd(clock, MCHP_RDS_PTP_GEN_CFG,
+				      MCHP_RDS_PTP_CLOCK, general_config);
+}
+
+static int mchp_set_clock_reload(struct mchp_rds_ptp_clock *clock,
+				 s64 period_sec, u32 period_nsec)
+{
+	int rc;
+
+	rc = mchp_rds_phy_write_mmd(clock,
+				    MCHP_RDS_PTP_CLK_TRGT_RELOAD_SEC_LO,
+				    MCHP_RDS_PTP_CLOCK,
+				    lower_16_bits(period_sec));
+	if (rc < 0)
+		return rc;
+
+	rc = mchp_rds_phy_write_mmd(clock,
+				    MCHP_RDS_PTP_CLK_TRGT_RELOAD_SEC_HI,
+				    MCHP_RDS_PTP_CLOCK,
+				    upper_16_bits(period_sec));
+	if (rc < 0)
+		return rc;
+
+	rc = mchp_rds_phy_write_mmd(clock,
+				    MCHP_RDS_PTP_CLK_TRGT_RELOAD_NS_LO,
+				    MCHP_RDS_PTP_CLOCK,
+				    lower_16_bits(period_nsec));
+	if (rc < 0)
+		return rc;
+
+	return mchp_rds_phy_write_mmd(clock,
+				      MCHP_RDS_PTP_CLK_TRGT_RELOAD_NS_HI,
+				      MCHP_RDS_PTP_CLOCK,
+				      upper_16_bits(period_nsec) & 0x3fff);
+}
+
+static int mchp_set_clock_target(struct mchp_rds_ptp_clock *clock,
+				 s64 start_sec, u32 start_nsec)
+{
+	int rc;
+
+	/* Set the start time */
+	rc = mchp_rds_phy_write_mmd(clock, MCHP_RDS_PTP_CLK_TRGT_SEC_LO,
+				    MCHP_RDS_PTP_CLOCK,
+				    lower_16_bits(start_sec));
+	if (rc < 0)
+		return rc;
+
+	rc = mchp_rds_phy_write_mmd(clock, MCHP_RDS_PTP_CLK_TRGT_SEC_HI,
+				    MCHP_RDS_PTP_CLOCK,
+				    upper_16_bits(start_sec));
+	if (rc < 0)
+		return rc;
+
+	rc = mchp_rds_phy_write_mmd(clock, MCHP_RDS_PTP_CLK_TRGT_NS_LO,
+				    MCHP_RDS_PTP_CLOCK,
+				    lower_16_bits(start_nsec));
+	if (rc < 0)
+		return rc;
+
+	return mchp_rds_phy_write_mmd(clock, MCHP_RDS_PTP_CLK_TRGT_NS_HI,
+				      MCHP_RDS_PTP_CLOCK,
+				      upper_16_bits(start_nsec) & 0x3fff);
+}
+
+static int mchp_rds_ptp_perout_off(struct mchp_rds_ptp_clock *clock)
+{
+	u16 general_config;
+	int rc;
+
+	/* Set target to too far in the future, effectively disabling it */
+	rc = mchp_set_clock_target(clock, 0xFFFFFFFF, 0);
+	if (rc < 0)
+		return rc;
+
+	general_config = mchp_rds_phy_read_mmd(clock, MCHP_RDS_PTP_GEN_CFG,
+					       MCHP_RDS_PTP_CLOCK);
+	general_config |= MCHP_RDS_PTP_GEN_CFG_RELOAD_ADD;
+	rc = mchp_rds_phy_write_mmd(clock, MCHP_RDS_PTP_GEN_CFG,
+				    MCHP_RDS_PTP_CLOCK, general_config);
+	if (rc < 0)
+		return rc;
+
+	clock->mchp_rds_ptp_event = -1;
+
+	return 0;
+}
+
+static bool mchp_get_event(struct mchp_rds_ptp_clock *clock, int pin)
+{
+	if (clock->mchp_rds_ptp_event < 0 && pin == clock->event_pin) {
+		clock->mchp_rds_ptp_event = pin;
+		return true;
+	}
+
+	return false;
+}
+
+static int mchp_rds_ptp_perout(struct ptp_clock_info *ptpci,
+			       struct ptp_perout_request *perout, int on)
+{
+	struct mchp_rds_ptp_clock *clock = container_of(ptpci,
+						      struct mchp_rds_ptp_clock,
+						      caps);
+	struct phy_device *phydev = clock->phydev;
+	int ret, event_pin, pulsewidth;
+
+	/* Reject requests with unsupported flags */
+	if (perout->flags & ~PTP_PEROUT_DUTY_CYCLE)
+		return -EOPNOTSUPP;
+
+	event_pin = ptp_find_pin(clock->ptp_clock, PTP_PF_PEROUT,
+				 perout->index);
+	if (event_pin != clock->event_pin)
+		return -EINVAL;
+
+	if (!on) {
+		ret = mchp_rds_ptp_perout_off(clock);
+		return ret;
+	}
+
+	if (!mchp_get_event(clock, event_pin))
+		return -EINVAL;
+
+	ret = mchp_get_pulsewidth(phydev, perout, &pulsewidth);
+	if (ret < 0)
+		return ret;
+
+	/* Configure to pulse every period */
+	ret = mchp_general_event_config(clock, pulsewidth);
+	if (ret < 0)
+		return ret;
+
+	ret = mchp_set_clock_target(clock, perout->start.sec,
+				    perout->start.nsec);
+	if (ret < 0)
+		return ret;
+
+	return mchp_set_clock_reload(clock, perout->period.sec,
+				     perout->period.nsec);
+}
+
+static int mchp_rds_ptpci_enable(struct ptp_clock_info *ptpci,
+				 struct ptp_clock_request *request, int on)
+{
+	switch (request->type) {
+	case PTP_CLK_REQ_PEROUT:
+		return mchp_rds_ptp_perout(ptpci, &request->perout, on);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mchp_rds_ptpci_verify(struct ptp_clock_info *ptpci, unsigned int pin,
+				 enum ptp_pin_function func, unsigned int chan)
+{
+	struct mchp_rds_ptp_clock *clock = container_of(ptpci,
+						      struct mchp_rds_ptp_clock,
+						      caps);
+
+	if (!(pin == clock->event_pin && chan == 0))
+		return -1;
+
+	switch (func) {
+	case PTP_PF_NONE:
+	case PTP_PF_PEROUT:
+		break;
+	default:
+		return -1;
+	}
+
+	return 0;
+}
+
 static int mchp_rds_ptp_flush_fifo(struct mchp_rds_ptp_clock *clock,
 				   enum mchp_rds_ptp_fifo_dir dir)
 {
@@ -479,6 +740,16 @@ static int mchp_rds_ptp_ltc_adjtime(struct ptp_clock_info *info, s64 delta)
 					    MCHP_RDS_PTP_CMD_CTL_LTC_STEP_NSEC);
 	}
 
+	mutex_unlock(&clock->ptp_lock);
+	info->gettime64(info, &ts);
+	mutex_lock(&clock->ptp_lock);
+
+	/* Target update is required for pulse generation on events that
+	 * are enabled
+	 */
+	if (clock->mchp_rds_ptp_event >= 0)
+		mchp_set_clock_target(clock,
+				      ts.tv_sec + MCHP_RDS_PTP_BUFFER_TIME, 0);
 out_unlock:
 	mutex_unlock(&clock->ptp_lock);
 
@@ -989,16 +1260,37 @@ struct mchp_rds_ptp_clock *mchp_rds_ptp_probe(struct phy_device *phydev, u8 mmd,
 	clock->mmd		= mmd;
 
 	mutex_init(&clock->ptp_lock);
+	clock->pin_config = devm_kmalloc_array(&phydev->mdio.dev,
+					       MCHP_RDS_PTP_N_PIN,
+					       sizeof(*clock->pin_config),
+					       GFP_KERNEL);
+	if (!clock->pin_config)
+		return ERR_PTR(-ENOMEM);
+
+	for (int i = 0; i < MCHP_RDS_PTP_N_PIN; ++i) {
+		struct ptp_pin_desc *p = &clock->pin_config[i];
+
+		memset(p, 0, sizeof(*p));
+		snprintf(p->name, sizeof(p->name), "pin%d", i);
+		p->index = i;
+		p->func = PTP_PF_NONE;
+	}
 	/* Register PTP clock */
 	clock->caps.owner          = THIS_MODULE;
 	snprintf(clock->caps.name, 30, "%s", phydev->drv->name);
 	clock->caps.max_adj        = MCHP_RDS_PTP_MAX_ADJ;
 	clock->caps.n_ext_ts       = 0;
 	clock->caps.pps            = 0;
+	clock->caps.n_pins         = MCHP_RDS_PTP_N_PIN;
+	clock->caps.n_per_out      = MCHP_RDS_PTP_N_PEROUT;
+	clock->caps.pin_config     = clock->pin_config;
 	clock->caps.adjfine        = mchp_rds_ptp_ltc_adjfine;
 	clock->caps.adjtime        = mchp_rds_ptp_ltc_adjtime;
 	clock->caps.gettime64      = mchp_rds_ptp_ltc_gettime64;
 	clock->caps.settime64      = mchp_rds_ptp_ltc_settime64;
+	clock->caps.enable         = mchp_rds_ptpci_enable;
+	clock->caps.verify         = mchp_rds_ptpci_verify;
+	clock->caps.getcrosststamp = NULL;
 	clock->ptp_clock = ptp_clock_register(&clock->caps,
 					      &phydev->mdio.dev);
 	if (IS_ERR(clock->ptp_clock))
@@ -1021,6 +1313,8 @@ struct mchp_rds_ptp_clock *mchp_rds_ptp_probe(struct phy_device *phydev, u8 mmd,
 
 	phydev->mii_ts = &clock->mii_ts;
 
+	clock->mchp_rds_ptp_event = -1;
+
 	/* Timestamp selected by default to keep legacy API */
 	phydev->default_timestamp = true;
 
-- 
2.17.1


