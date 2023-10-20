Return-Path: <netdev+bounces-43130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFF07D180D
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 23:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A19D6B2164A
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 21:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF7B2B75F;
	Fri, 20 Oct 2023 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hdQ61m8K"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A02B74E
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 21:28:19 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2EFD75
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:28:13 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-27d425a2dd0so1092416a91.2
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 14:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1697837293; x=1698442093; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSpgaC8ADZDGygsAiQ87GU/cdospOEvaz60x2pFG6ag=;
        b=hdQ61m8KYsvMAKDfLbK3815govkPaPFm3kjiv84V+50O6Jui7Q8sBCtmrDX7uSLjS7
         o66YaxIy4dwxkk0eZFaSfPISQEyhPCB2aDLoS6fgUOxfn2RNXmW7/Un/MPOLCBol6kNQ
         pp4EhtKiYIaFsllJ72g/e0sjRZ+9NLroqGu/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697837293; x=1698442093;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSpgaC8ADZDGygsAiQ87GU/cdospOEvaz60x2pFG6ag=;
        b=FxTQgYqRUnhvLBG3KN9Pr8uITSiqJPuO16kZ51TM7Yw4TLpfYtQ5AqOm1B1VUECBv0
         pOAgsnmjsbeV+rd10MMg/6jh81UfYi9HaAi4dWmxc9GlxF61nZMPO8Uo4olt7mhegKDi
         oOoKxckyGr9dNRR71x4W67U2tAicMWkp3Z2h9jFvdKOxDLPiDeVHtZXWeCXIoTWnaTRj
         hpwRzuCr22rEyvq1ZKx1Vao/sM0c8QTRWewOZ8qzx/nEVxEBFHKxAd57Z2mJb/fVqdyt
         taDB2dWbOWcZW/VtSke9HBjQaOT+aShqcPPqJNTQ0d2DRKlK1zK4oaCDuujbfSNOS4oB
         SCXg==
X-Gm-Message-State: AOJu0YwGTnOPDcQuLkGht8pjGQmydc2Bcj6u1kXAw+toukX1eQ6RtUzS
	WTTY10A3nX5VnQHS7Og3K0uPQdtjF15fihailkc=
X-Google-Smtp-Source: AGHT+IGPe2gvn28pkTBmwCtaHo4FCFa17lw/qcO1kB3yMGXCC+2lcAeU30wsAbHAQ0sc86pNdzJjHQ==
X-Received: by 2002:a17:90a:1d9:b0:27c:fb63:9c89 with SMTP id 25-20020a17090a01d900b0027cfb639c89mr3391901pjd.0.1697837292931;
        Fri, 20 Oct 2023 14:28:12 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id j13-20020a17090a7e8d00b0026d4100e0e8sm1843348pjl.10.2023.10.20.14.28.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Oct 2023 14:28:12 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: [PATCH net-next 3/8] bnxt_en: add infrastructure to lookup ethtool link mode
Date: Fri, 20 Oct 2023 14:27:52 -0700
Message-Id: <20231020212757.173551-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231020212757.173551-1-michael.chan@broadcom.com>
References: <20231020212757.173551-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000c741e006082c8c27"

--000000000000c741e006082c8c27
Content-Transfer-Encoding: 8bit

From: Edwin Peer <edwin.peer@broadcom.com>

Add infrastructure to look up the enum ethtool_link_mode_bit_indices
from link information provided by the firmware.  The link speed,
signal mode, and media type returned by firmware will be used to
look up the ethtool link mode.

The immediate benefit is that once the link mode is determined, we can
now use ethtool_params_from_link_mode() to fill the basic ethtool
parameters including the number of lanes.  Lanes will be fully
supported in the next patch.

Signed-off-by: Edwin Peer <edwin.peer@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   1 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 277 ++++++++++++++++--
 2 files changed, 258 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 80846c3ca9fc..e702dbc3e6b1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1295,6 +1295,7 @@ struct bnxt_link_info {
 	u8			req_signal_mode;
 #define BNXT_SIG_MODE_NRZ	PORT_PHY_QCFG_RESP_SIGNAL_MODE_NRZ
 #define BNXT_SIG_MODE_PAM4	PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4
+#define BNXT_SIG_MODE_MAX	(PORT_PHY_QCFG_RESP_SIGNAL_MODE_LAST + 1)
 	u8			req_duplex;
 	u8			req_flow_ctrl;
 	u16			req_link_speed;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 547247d98eba..c925e21eadec 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -1506,6 +1506,230 @@ u32 _bnxt_fw_to_ethtool_adv_spds(u16 fw_speeds, u8 fw_pause)
 	return speed_mask;
 }
 
+enum bnxt_media_type {
+	BNXT_MEDIA_UNKNOWN = 0,
+	BNXT_MEDIA_TP,
+	BNXT_MEDIA_CR,
+	BNXT_MEDIA_SR,
+	BNXT_MEDIA_LR_ER_FR,
+	BNXT_MEDIA_KR,
+	BNXT_MEDIA_KX,
+	BNXT_MEDIA_X,
+	__BNXT_MEDIA_END,
+};
+
+static const enum bnxt_media_type bnxt_phy_types[] = {
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_BASECR] = BNXT_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_BASEKR4] =  BNXT_MEDIA_KR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_BASELR] = BNXT_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_BASESR] = BNXT_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_BASEKR2] = BNXT_MEDIA_KR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_BASEKX] = BNXT_MEDIA_KX,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_BASEKR] = BNXT_MEDIA_KR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_BASET] = BNXT_MEDIA_TP,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_BASETE] = BNXT_MEDIA_TP,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_25G_BASECR_CA_L] = BNXT_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_25G_BASECR_CA_S] = BNXT_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_25G_BASECR_CA_N] = BNXT_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_25G_BASESR] = BNXT_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASECR4] = BNXT_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR4] = BNXT_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASELR4] = BNXT_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASEER4] = BNXT_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR10] = BNXT_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_40G_BASECR4] = BNXT_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_40G_BASESR4] = BNXT_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_40G_BASELR4] = BNXT_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_40G_BASEER4] = BNXT_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_40G_ACTIVE_CABLE] = BNXT_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_1G_BASET] = BNXT_MEDIA_TP,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_1G_BASESX] = BNXT_MEDIA_X,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_1G_BASECX] = BNXT_MEDIA_X,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASECR4] = BNXT_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASESR4] = BNXT_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASELR4] = BNXT_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_200G_BASEER4] = BNXT_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_50G_BASECR] = BNXT_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_50G_BASESR] = BNXT_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_50G_BASELR] = BNXT_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_50G_BASEER] = BNXT_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASECR2] = BNXT_MEDIA_CR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASESR2] = BNXT_MEDIA_SR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASELR2] = BNXT_MEDIA_LR_ER_FR,
+	[PORT_PHY_QCFG_RESP_PHY_TYPE_100G_BASEER2] = BNXT_MEDIA_LR_ER_FR,
+};
+
+static enum bnxt_media_type
+bnxt_get_media(struct bnxt_link_info *link_info)
+{
+	switch (link_info->media_type) {
+	case PORT_PHY_QCFG_RESP_MEDIA_TYPE_TP:
+		return BNXT_MEDIA_TP;
+	case PORT_PHY_QCFG_RESP_MEDIA_TYPE_DAC:
+		return BNXT_MEDIA_CR;
+	default:
+		if (link_info->phy_type < ARRAY_SIZE(bnxt_phy_types))
+			return bnxt_phy_types[link_info->phy_type];
+		return BNXT_MEDIA_UNKNOWN;
+	}
+}
+
+enum bnxt_link_speed_indices {
+	BNXT_LINK_SPEED_UNKNOWN = 0,
+	BNXT_LINK_SPEED_100MB_IDX,
+	BNXT_LINK_SPEED_1GB_IDX,
+	BNXT_LINK_SPEED_10GB_IDX,
+	BNXT_LINK_SPEED_25GB_IDX,
+	BNXT_LINK_SPEED_40GB_IDX,
+	BNXT_LINK_SPEED_50GB_IDX,
+	BNXT_LINK_SPEED_100GB_IDX,
+	BNXT_LINK_SPEED_200GB_IDX,
+	__BNXT_LINK_SPEED_END
+};
+
+static enum bnxt_link_speed_indices bnxt_fw_speed_idx(u16 speed)
+{
+	switch (speed) {
+	case BNXT_LINK_SPEED_100MB: return BNXT_LINK_SPEED_100MB_IDX;
+	case BNXT_LINK_SPEED_1GB: return BNXT_LINK_SPEED_1GB_IDX;
+	case BNXT_LINK_SPEED_10GB: return BNXT_LINK_SPEED_10GB_IDX;
+	case BNXT_LINK_SPEED_25GB: return BNXT_LINK_SPEED_25GB_IDX;
+	case BNXT_LINK_SPEED_40GB: return BNXT_LINK_SPEED_40GB_IDX;
+	case BNXT_LINK_SPEED_50GB: return BNXT_LINK_SPEED_50GB_IDX;
+	case BNXT_LINK_SPEED_100GB: return BNXT_LINK_SPEED_100GB_IDX;
+	case BNXT_LINK_SPEED_200GB: return BNXT_LINK_SPEED_200GB_IDX;
+	default: return BNXT_LINK_SPEED_UNKNOWN;
+	}
+}
+
+static const enum ethtool_link_mode_bit_indices
+bnxt_link_modes[__BNXT_LINK_SPEED_END][BNXT_SIG_MODE_MAX][__BNXT_MEDIA_END] = {
+	[BNXT_LINK_SPEED_100MB_IDX] = {
+		{
+			[BNXT_MEDIA_TP] = ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+		},
+	},
+	[BNXT_LINK_SPEED_1GB_IDX] = {
+		{
+			[BNXT_MEDIA_TP] = ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+			/* historically baseT, but DAC is more correctly baseX */
+			[BNXT_MEDIA_CR] = ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+			[BNXT_MEDIA_KX] = ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
+			[BNXT_MEDIA_X] = ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+			[BNXT_MEDIA_KR] = ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
+		},
+	},
+	[BNXT_LINK_SPEED_10GB_IDX] = {
+		{
+			[BNXT_MEDIA_TP] = ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
+			[BNXT_MEDIA_CR] = ETHTOOL_LINK_MODE_10000baseCR_Full_BIT,
+			[BNXT_MEDIA_SR] = ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
+			[BNXT_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_10000baseLR_Full_BIT,
+			[BNXT_MEDIA_KR] = ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
+			[BNXT_MEDIA_KX] = ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT,
+		},
+	},
+	[BNXT_LINK_SPEED_25GB_IDX] = {
+		{
+			[BNXT_MEDIA_CR] = ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
+			[BNXT_MEDIA_SR] = ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
+			[BNXT_MEDIA_KR] = ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
+		},
+	},
+	[BNXT_LINK_SPEED_40GB_IDX] = {
+		{
+			[BNXT_MEDIA_CR] = ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
+			[BNXT_MEDIA_SR] = ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT,
+			[BNXT_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT,
+			[BNXT_MEDIA_KR] = ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
+		},
+	},
+	[BNXT_LINK_SPEED_50GB_IDX] = {
+		[BNXT_SIG_MODE_NRZ] = {
+			[BNXT_MEDIA_CR] = ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
+			[BNXT_MEDIA_SR] = ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
+			[BNXT_MEDIA_KR] = ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
+		},
+		[BNXT_SIG_MODE_PAM4] = {
+			[BNXT_MEDIA_CR] = ETHTOOL_LINK_MODE_50000baseCR_Full_BIT,
+			[BNXT_MEDIA_SR] = ETHTOOL_LINK_MODE_50000baseSR_Full_BIT,
+			[BNXT_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT,
+			[BNXT_MEDIA_KR] = ETHTOOL_LINK_MODE_50000baseKR_Full_BIT,
+		},
+	},
+	[BNXT_LINK_SPEED_100GB_IDX] = {
+		[BNXT_SIG_MODE_NRZ] = {
+			[BNXT_MEDIA_CR] = ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
+			[BNXT_MEDIA_SR] = ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT,
+			[BNXT_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
+			[BNXT_MEDIA_KR] = ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
+		},
+		[BNXT_SIG_MODE_PAM4] = {
+			[BNXT_MEDIA_CR] = ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT,
+			[BNXT_MEDIA_SR] = ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT,
+			[BNXT_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_100000baseLR2_ER2_FR2_Full_BIT,
+			[BNXT_MEDIA_KR] = ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT,
+		},
+	},
+	[BNXT_LINK_SPEED_200GB_IDX] = {
+		[BNXT_SIG_MODE_PAM4] = {
+			[BNXT_MEDIA_CR] = ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT,
+			[BNXT_MEDIA_SR] = ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT,
+			[BNXT_MEDIA_LR_ER_FR] = ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT,
+			[BNXT_MEDIA_KR] = ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT,
+		},
+	},
+};
+
+#define BNXT_LINK_MODE_UNKNOWN -1
+
+static enum ethtool_link_mode_bit_indices
+bnxt_get_link_mode(struct bnxt_link_info *link_info)
+{
+	enum ethtool_link_mode_bit_indices link_mode;
+	enum bnxt_link_speed_indices speed;
+	enum bnxt_media_type media;
+	u8 sig_mode;
+
+	if (link_info->phy_link_status != BNXT_LINK_LINK)
+		return BNXT_LINK_MODE_UNKNOWN;
+
+	media = bnxt_get_media(link_info);
+	if (BNXT_AUTO_MODE(link_info->auto_mode)) {
+		speed = bnxt_fw_speed_idx(link_info->link_speed);
+		sig_mode = link_info->active_fec_sig_mode &
+			PORT_PHY_QCFG_RESP_SIGNAL_MODE_MASK;
+	} else {
+		speed = bnxt_fw_speed_idx(link_info->req_link_speed);
+		sig_mode = link_info->req_signal_mode;
+	}
+	if (sig_mode >= BNXT_SIG_MODE_MAX)
+		return BNXT_LINK_MODE_UNKNOWN;
+
+	/* Note ETHTOOL_LINK_MODE_10baseT_Half_BIT == 0 is a legal Linux
+	 * link mode, but since no such devices exist, the zeroes in the
+	 * map can be conveniently used to represent unknown link modes.
+	 */
+	link_mode = bnxt_link_modes[speed][sig_mode][media];
+	if (!link_mode)
+		return BNXT_LINK_MODE_UNKNOWN;
+
+	switch (link_mode) {
+	case ETHTOOL_LINK_MODE_100baseT_Full_BIT:
+		if (~link_info->duplex & BNXT_LINK_DUPLEX_FULL)
+			link_mode = ETHTOOL_LINK_MODE_100baseT_Half_BIT;
+		break;
+	case ETHTOOL_LINK_MODE_1000baseT_Full_BIT:
+		if (~link_info->duplex & BNXT_LINK_DUPLEX_FULL)
+			link_mode = ETHTOOL_LINK_MODE_1000baseT_Half_BIT;
+		break;
+	default:
+		break;
+	}
+
+	return link_mode;
+}
+
 #define BNXT_FW_TO_ETHTOOL_SPDS(fw_speeds, fw_pause, lk_ksettings, name)\
 {									\
 	if ((fw_speeds) & BNXT_LINK_SPEED_MSK_100MB)			\
@@ -1720,42 +1944,56 @@ u32 bnxt_fw_to_ethtool_speed(u16 fw_link_speed)
 	}
 }
 
+static void bnxt_get_default_speeds(struct ethtool_link_ksettings *lk_ksettings,
+				    struct bnxt_link_info *link_info)
+{
+	struct ethtool_link_settings *base = &lk_ksettings->base;
+
+	if (link_info->link_state == BNXT_LINK_STATE_UP) {
+		base->speed = bnxt_fw_to_ethtool_speed(link_info->link_speed);
+		base->duplex = DUPLEX_HALF;
+		if (link_info->duplex & BNXT_LINK_DUPLEX_FULL)
+			base->duplex = DUPLEX_FULL;
+	} else if (!link_info->autoneg) {
+		base->speed = bnxt_fw_to_ethtool_speed(link_info->req_link_speed);
+		base->duplex = DUPLEX_HALF;
+		if (link_info->req_duplex == BNXT_LINK_DUPLEX_FULL)
+			base->duplex = DUPLEX_FULL;
+	}
+}
+
 static int bnxt_get_link_ksettings(struct net_device *dev,
 				   struct ethtool_link_ksettings *lk_ksettings)
 {
-	struct bnxt *bp = netdev_priv(dev);
-	struct bnxt_link_info *link_info = &bp->link_info;
 	struct ethtool_link_settings *base = &lk_ksettings->base;
-	u32 ethtool_speed;
+	enum ethtool_link_mode_bit_indices link_mode;
+	struct bnxt *bp = netdev_priv(dev);
+	struct bnxt_link_info *link_info;
 
+	ethtool_link_ksettings_zero_link_mode(lk_ksettings, advertising);
 	ethtool_link_ksettings_zero_link_mode(lk_ksettings, supported);
+	base->duplex = DUPLEX_UNKNOWN;
+	base->speed = SPEED_UNKNOWN;
+	link_info = &bp->link_info;
+
 	mutex_lock(&bp->link_lock);
 	bnxt_fw_to_ethtool_support_spds(link_info, lk_ksettings);
+	link_mode = bnxt_get_link_mode(link_info);
+	if (link_mode != BNXT_LINK_MODE_UNKNOWN)
+		ethtool_params_from_link_mode(lk_ksettings, link_mode);
+	else
+		bnxt_get_default_speeds(lk_ksettings, link_info);
 
-	ethtool_link_ksettings_zero_link_mode(lk_ksettings, advertising);
 	if (link_info->autoneg) {
 		bnxt_fw_to_ethtool_advertised_spds(link_info, lk_ksettings);
 		ethtool_link_ksettings_add_link_mode(lk_ksettings,
 						     advertising, Autoneg);
 		base->autoneg = AUTONEG_ENABLE;
-		base->duplex = DUPLEX_UNKNOWN;
-		if (link_info->phy_link_status == BNXT_LINK_LINK) {
+		if (link_info->phy_link_status == BNXT_LINK_LINK)
 			bnxt_fw_to_ethtool_lp_adv(link_info, lk_ksettings);
-			if (link_info->duplex & BNXT_LINK_DUPLEX_FULL)
-				base->duplex = DUPLEX_FULL;
-			else
-				base->duplex = DUPLEX_HALF;
-		}
-		ethtool_speed = bnxt_fw_to_ethtool_speed(link_info->link_speed);
 	} else {
 		base->autoneg = AUTONEG_DISABLE;
-		ethtool_speed =
-			bnxt_fw_to_ethtool_speed(link_info->req_link_speed);
-		base->duplex = DUPLEX_HALF;
-		if (link_info->req_duplex == BNXT_LINK_DUPLEX_FULL)
-			base->duplex = DUPLEX_FULL;
 	}
-	base->speed = ethtool_speed;
 
 	base->port = PORT_NONE;
 	if (link_info->media_type == PORT_PHY_QCFG_RESP_MEDIA_TYPE_TP) {
@@ -1772,8 +2010,7 @@ static int bnxt_get_link_ksettings(struct net_device *dev,
 
 		if (link_info->media_type == PORT_PHY_QCFG_RESP_MEDIA_TYPE_DAC)
 			base->port = PORT_DA;
-		else if (link_info->media_type ==
-			 PORT_PHY_QCFG_RESP_MEDIA_TYPE_FIBRE)
+		else
 			base->port = PORT_FIBRE;
 	}
 	base->phy_address = link_info->phy_addr;
-- 
2.30.1


--000000000000c741e006082c8c27
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIGiOF2us5etmYVIig6VTncOT7ySUx52Q
XLUS23uqkajPMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTAy
MDIxMjgxM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQA9ul+oryv3gccIAsaHlCaGrQ925VnTHF3vopALfTlUNGgyTEuA
WXkUq6ZuAUOvE5UXG82yKOlAoSaykyEZaxO/K1L5dEVlZhVvbkVfvnNDOEyzbObHlWh/ezch+Gq3
ZapItTVapyJDVTExCTmsyP9OreVerAYbRVxE9HPidUusInOiGV63wIBnYPParNt8acez8ghsaAJ2
e4rDfUKCg7XknE2C+pmqYTbrnrtUQJ8pglqBk55/HTfLJnjHjzN1yhcs2qqD7+u4Yg/Usuphh24t
DIM5wgB37gHLrzgTsg83Vmb2HWy0MLHJItL7R++v04DpEUKApBZFXEGEpV0HGFsr
--000000000000c741e006082c8c27--

