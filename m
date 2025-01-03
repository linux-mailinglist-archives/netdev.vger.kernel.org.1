Return-Path: <netdev+bounces-154938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C22A0067D
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 10:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C19497A066F
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 09:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0354A1D357A;
	Fri,  3 Jan 2025 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wgxFanO6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6FA1D0E20;
	Fri,  3 Jan 2025 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735895359; cv=none; b=O3kF1n4Kix2l+NL8bLji1d7W4X1NSI2ABIxYcVvJIl3CEpkLoPR/c27aQEuyssg/y3/LGNVcTiL1sAsKTCSUjuU+8Tu0khLLCbL480Bls/sX38ycr4sob+VmQGXIj3eKUnxzTCXMoMFsGSP2ND6HtH/LSG5Js2FAFbrUFIvdFMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735895359; c=relaxed/simple;
	bh=iXS4EE0TcxAe6aPvHVLNhiI6Aca/lwR5NaMpv6XsYMk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RUPeYeciPKOjQDMcM06lnWSJXKjVBImqhB/k9/849ZgACSuC6pK8MSSdNhB7Fr+a4dchh9c2T9/6WjQmMb7agnZK8M3wJEUblhM0kyDuyWQta2spArUodsraiaA7EtP+Pvy0cbNQcEou6cAoXVLvy4adFGS7vmuaHSWPQEiJkHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wgxFanO6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1735895357; x=1767431357;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=iXS4EE0TcxAe6aPvHVLNhiI6Aca/lwR5NaMpv6XsYMk=;
  b=wgxFanO6s/hkrclKDkx7uS6Q6EoVTI1VC7ZpM3InB2HU0t3LvUCcKbrs
   FsoCZ/ROgDonbDAY3LWTtlgr6kaIq/w+oi0c9qHJYvaxY2Fp7yInzF56G
   JsQ4bog/7/J2YBbtqg5LGDSkeaRQA1ZDLWGz8URGr2TmpDOczQl2u55CN
   gIqBtStKsSXA/CQWx4r2dgvDBEKQCqOeqN7JRHC2HHo8Gug+4VQFwYGCy
   aFW1HInVUfZrUy1zldxkLOAAZkGpuEly+/pxkOs3zMjHHb2gkRbbTO0mF
   uYqp1zuDN7E7QrwApzdVq/Jtk3cTGDTTnKq7vUxTmWhN9zEVp1TSjBaWY
   Q==;
X-CSE-ConnectionGUID: 9lugowQIRF2Bdg+6ihLSRg==
X-CSE-MsgGUID: NVneJ3oWSiiBbDvQLoK7mw==
X-IronPort-AV: E=Sophos;i="6.12,286,1728975600"; 
   d="scan'208";a="35788960"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Jan 2025 02:08:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 3 Jan 2025 02:07:45 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 3 Jan 2025 02:07:41 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next 3/3] net: phy: microchip_rds_ptp : Add PEROUT feature library for RDS PTP supported phys
Date: Fri, 3 Jan 2025 14:37:31 +0530
Message-ID: <20250103090731.1355-4-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250103090731.1355-1-divya.koppera@microchip.com>
References: <20250103090731.1355-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adds PEROUT feature for RDS PTP supported phys where
we can generate periodic output signal on supported
GPIO pins

Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
 drivers/net/phy/microchip_rds_ptp.c | 320 ++++++++++++++++++++++++++++
 1 file changed, 320 insertions(+)

diff --git a/drivers/net/phy/microchip_rds_ptp.c b/drivers/net/phy/microchip_rds_ptp.c
index 2936e46531cf..396975be2a31 100644
--- a/drivers/net/phy/microchip_rds_ptp.c
+++ b/drivers/net/phy/microchip_rds_ptp.c
@@ -54,6 +54,288 @@ static int mchp_rds_phy_set_bits_mmd(struct mchp_rds_ptp_clock *clock,
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
+		phydev_warn(phydev, "perout period too small, minimum is 200ns\n");
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
+static int mchp_general_event_config(struct mchp_rds_ptp_clock *clock, s8 event,
+				     int pulse_width)
+{
+	int general_config;
+
+	general_config = mchp_rds_phy_read_mmd(clock, MCHP_RDS_PTP_GEN_CFG,
+					       MCHP_RDS_PTP_CLOCK);
+	if (general_config < 0)
+		return general_config;
+
+	general_config &= ~(MCHP_RDS_PTP_GEN_CFG_LTC_EVT_X_MASK_(event));
+	general_config |= MCHP_RDS_PTP_GEN_CFG_LTC_EVT_X_SET_(event,
+							      pulse_width);
+	general_config &= ~(MCHP_RDS_PTP_GEN_CFG_RELOAD_ADD_X_(event));
+	general_config |= MCHP_RDS_PTP_GEN_CFG_POLARITY_X_(event);
+
+	return mchp_rds_phy_write_mmd(clock, MCHP_RDS_PTP_GEN_CFG,
+				      MCHP_RDS_PTP_CLOCK, general_config);
+}
+
+static int mchp_set_clock_reload(struct mchp_rds_ptp_clock *clock, s8 evt,
+				 s64 period_sec, u32 period_nsec)
+{
+	int rc;
+
+	rc = mchp_rds_phy_write_mmd(clock,
+				    MCHP_RDS_PTP_CLK_TRGT_RELOAD_SEC_LO_X(evt),
+				    MCHP_RDS_PTP_CLOCK,
+				    lower_16_bits(period_sec));
+	if (rc < 0)
+		return rc;
+
+	rc = mchp_rds_phy_write_mmd(clock,
+				    MCHP_RDS_PTP_CLK_TRGT_RELOAD_SEC_HI_X(evt),
+				    MCHP_RDS_PTP_CLOCK,
+				    upper_16_bits(period_sec));
+	if (rc < 0)
+		return rc;
+
+	rc = mchp_rds_phy_write_mmd(clock,
+				    MCHP_RDS_PTP_CLK_TRGT_RELOAD_NS_LO_X(evt),
+				    MCHP_RDS_PTP_CLOCK,
+				    lower_16_bits(period_nsec));
+	if (rc < 0)
+		return rc;
+
+	return mchp_rds_phy_write_mmd(clock,
+				      MCHP_RDS_PTP_CLK_TRGT_RELOAD_NS_HI_X(evt),
+				      MCHP_RDS_PTP_CLOCK,
+				      upper_16_bits(period_nsec) & 0x3fff);
+}
+
+static int mchp_get_event(struct mchp_rds_ptp_clock *clock, int pin)
+{
+	if (clock->mchp_rds_ptp_event_a < 0 && pin == clock->gpio_event_a) {
+		clock->mchp_rds_ptp_event_a = pin;
+		return MCHP_RDS_PTP_EVT_A;
+	}
+
+	if (clock->mchp_rds_ptp_event_b < 0 && pin == clock->gpio_event_b) {
+		clock->mchp_rds_ptp_event_b = pin;
+		return MCHP_RDS_PTP_EVT_B;
+	}
+
+	return -1;
+}
+
+static int mchp_set_clock_target(struct mchp_rds_ptp_clock *clock, s8 evt,
+				 s64 start_sec, u32 start_nsec)
+{
+	int rc;
+
+	if (evt < 0)
+		return -1;
+
+	/* Set the start time */
+	rc = mchp_rds_phy_write_mmd(clock, MCHP_RDS_PTP_CLK_TRGT_SEC_LO_X(evt),
+				    MCHP_RDS_PTP_CLOCK,
+				    lower_16_bits(start_sec));
+	if (rc < 0)
+		return rc;
+
+	rc = mchp_rds_phy_write_mmd(clock, MCHP_RDS_PTP_CLK_TRGT_SEC_HI_X(evt),
+				    MCHP_RDS_PTP_CLOCK,
+				    upper_16_bits(start_sec));
+	if (rc < 0)
+		return rc;
+
+	rc = mchp_rds_phy_write_mmd(clock, MCHP_RDS_PTP_CLK_TRGT_NS_LO_X(evt),
+				    MCHP_RDS_PTP_CLOCK,
+				    lower_16_bits(start_nsec));
+	if (rc < 0)
+		return rc;
+
+	return mchp_rds_phy_write_mmd(clock, MCHP_RDS_PTP_CLK_TRGT_NS_HI_X(evt),
+				      MCHP_RDS_PTP_CLOCK,
+				      upper_16_bits(start_nsec) & 0x3fff);
+}
+
+static int mchp_rds_ptp_perout_off(struct mchp_rds_ptp_clock *clock,
+				   s8 gpio_pin)
+{
+	u16 general_config;
+	int event;
+	int rc;
+
+	if (clock->mchp_rds_ptp_event_a == gpio_pin)
+		event = MCHP_RDS_PTP_EVT_A;
+	else if (clock->mchp_rds_ptp_event_b == gpio_pin)
+		event = MCHP_RDS_PTP_EVT_B;
+
+	/* Set target to too far in the future, effectively disabling it */
+	rc = mchp_set_clock_target(clock, gpio_pin, 0xFFFFFFFF, 0);
+	if (rc < 0)
+		return rc;
+
+	general_config = mchp_rds_phy_read_mmd(clock, MCHP_RDS_PTP_GEN_CFG,
+					       MCHP_RDS_PTP_CLOCK);
+	general_config |= MCHP_RDS_PTP_GEN_CFG_RELOAD_ADD_X_(event);
+	rc = mchp_rds_phy_write_mmd(clock, MCHP_RDS_PTP_GEN_CFG,
+				    MCHP_RDS_PTP_CLOCK, general_config);
+	if (rc < 0)
+		return rc;
+
+	if (event == MCHP_RDS_PTP_EVT_A)
+		clock->mchp_rds_ptp_event_a = -1;
+
+	if (event == MCHP_RDS_PTP_EVT_B)
+		clock->mchp_rds_ptp_event_b = -1;
+
+	return 0;
+}
+
+static int mchp_rds_ptp_perout(struct ptp_clock_info *ptpci,
+			       struct ptp_perout_request *perout, int on)
+{
+	struct mchp_rds_ptp_clock *clock = container_of(ptpci,
+						      struct mchp_rds_ptp_clock,
+						      caps);
+	struct phy_device *phydev = clock->phydev;
+	int ret, event, gpio_pin, pulsewidth;
+
+	/* Reject requests with unsupported flags */
+	if (perout->flags & ~PTP_PEROUT_DUTY_CYCLE)
+		return -EOPNOTSUPP;
+
+	gpio_pin = ptp_find_pin(clock->ptp_clock, PTP_PF_PEROUT, perout->index);
+	if (gpio_pin != clock->gpio_event_a && gpio_pin != clock->gpio_event_b)
+		return -EINVAL;
+
+	if (!on) {
+		ret = mchp_rds_ptp_perout_off(clock, gpio_pin);
+		return ret;
+	}
+
+	ret = mchp_get_pulsewidth(phydev, perout, &pulsewidth);
+	if (ret < 0)
+		return ret;
+
+	event = mchp_get_event(clock, gpio_pin);
+	if (event < 0)
+		return event;
+
+	/* Configure to pulse every period */
+	ret = mchp_general_event_config(clock, event, pulsewidth);
+	if (ret < 0)
+		return ret;
+
+	ret = mchp_set_clock_target(clock, event, perout->start.sec,
+				    perout->start.nsec);
+	if (ret < 0)
+		return ret;
+
+	return mchp_set_clock_reload(clock, event, perout->period.sec,
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
+	if (!(pin == clock->gpio_event_b && chan == 1) &&
+	    !(pin == clock->gpio_event_a && chan == 0))
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
@@ -479,6 +761,20 @@ static int mchp_rds_ptp_ltc_adjtime(struct ptp_clock_info *info, s64 delta)
 					    MCHP_RDS_PTP_CMD_CTL_LTC_STEP_NSEC);
 	}
 
+	mutex_unlock(&clock->ptp_lock);
+	info->gettime64(info, &ts);
+	mutex_lock(&clock->ptp_lock);
+
+	/* Target update is required for pulse generation on events that
+	 * are enabled
+	 */
+	if (clock->mchp_rds_ptp_event_a >= 0)
+		mchp_set_clock_target(clock, MCHP_RDS_PTP_EVT_A,
+				      ts.tv_sec + MCHP_RDS_PTP_BUFFER_TIME, 0);
+
+	if (clock->mchp_rds_ptp_event_b >= 0)
+		mchp_set_clock_target(clock, MCHP_RDS_PTP_EVT_B,
+				      ts.tv_sec + MCHP_RDS_PTP_BUFFER_TIME, 0);
 out_unlock:
 	mutex_unlock(&clock->ptp_lock);
 
@@ -989,16 +1285,37 @@ struct mchp_rds_ptp_clock *mchp_rds_ptp_probe(struct phy_device *phydev, u8 mmd,
 	clock->mmd		= mmd;
 
 	mutex_init(&clock->ptp_lock);
+	clock->pin_config = devm_kmalloc_array(&phydev->mdio.dev,
+					       MCHP_RDS_PTP_N_GPIO,
+					       sizeof(*clock->pin_config),
+					       GFP_KERNEL);
+	if (!clock->pin_config)
+		return ERR_PTR(-ENOMEM);
+
+	for (int i = 0; i < MCHP_RDS_PTP_N_GPIO; ++i) {
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
+	clock->caps.n_pins         = MCHP_RDS_PTP_N_GPIO;
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
@@ -1021,6 +1338,9 @@ struct mchp_rds_ptp_clock *mchp_rds_ptp_probe(struct phy_device *phydev, u8 mmd,
 
 	phydev->mii_ts = &clock->mii_ts;
 
+	clock->mchp_rds_ptp_event_a = -1;
+	clock->mchp_rds_ptp_event_b = -1;
+
 	/* Timestamp selected by default to keep legacy API */
 	phydev->default_timestamp = true;
 
-- 
2.17.1


