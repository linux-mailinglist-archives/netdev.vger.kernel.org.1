Return-Path: <netdev+bounces-252943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOKnAibOc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:38:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A97C7A381
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A04430135E0
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EBC2C11CD;
	Fri, 23 Jan 2026 19:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dfwI2u9C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f100.google.com (mail-vs1-f100.google.com [209.85.217.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E1B2D6E63
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196952; cv=none; b=b5cAJzPLZH3a8vc9Cgf9LdUuV78O0P1gu+Cu4rDkUqNrOo+gml4gCX3Es/zOb9s4S4SKfNm9/369LLzBl+SXK9LfKeJib1Td2OG6+mLxDVDIeCo6Sivu5YNztIOB2fEFinkGbTu+6Ej+UEp+Xz99F3eLbs8kybcxb3IOA0zJheY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196952; c=relaxed/simple;
	bh=IDtYlfyHd9puO8uzddW7kcDwMbhw00sKaMmn1ogyjtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBVxmgy6Vik3gWZ+0pNHYIQ8ogHL91Ip0qW9CgdqjL6wb38Gjgk085zEUTkrhK4zn5+4JEp5kB6upvx+yvitQkBnetEmjXRYQ2RZv+3C06V2ZVwbJP4GoPk+jnNFm6ltFyPGnRNWA5Kar9CODemUyEh0f20aXAkGjo3l7za94GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dfwI2u9C; arc=none smtp.client-ip=209.85.217.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f100.google.com with SMTP id ada2fe7eead31-5f52b0728ccso1022350137.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:35:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769196949; x=1769801749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5OU/RLBNz5QlYQHo4MnTuUpoycaD8XZR+hOfHOhW5Q=;
        b=KScoSJVF4vSJ7hfSwENuGyHDC0FOVJIu3e4iupVZFiGaEnwCox/IpjR65/1FwngtbA
         6gD2mmXzDxmB87cOcosqJQY/GRR3BVZ7AvzLB8K4L+NiZfybWIPGRSrVxk3U64mBnsnS
         1dKn1ctsN1iqKs19oMPf9qNLS0kLa7oibq2felinN9j2teR2/xlk2XWimcEd+QFhec5u
         ZWlDKGMK03Qv4tW1Q4pdgIFjunI83Db+SXY6CNsORQQBZTT0S3q/QbRG2/FpOr7Poy1m
         k/x6yHuM+78rc43+MFRUIjkJ6CHwh+zEuDVy1WVPBW/tr4n8bJoC4VqieP72rFf3ZxC3
         tsfg==
X-Gm-Message-State: AOJu0Yw9jdW5e9hbFzJX4uk954DoYVKIhApXo62VnBPV9HYgu8WEJyMZ
	aZDWe9qvFS2zDUBJ+4ldiyg0PIol1W3zJAXh8eMiLA+yxnlPgefsj8w45ey3RFv6Q3YzXKj4J2X
	LxnJ+G3uZpYPhBG8FWSYms+HHRdQUvSXzkMnFyatRpsCGQdUdkWvM7yC1uH5MZEBiiPFha4DuUn
	2FC/zXsZddBMVZDSkXeNsDQNsthDtytjqbqPGNL9cItPstPdV0hDVoYGBWdvu3fVb2X056AGmGf
	e5JlCPguPSCEoBsVQ==
X-Gm-Gg: AZuq6aIqJnhGEQeXg09F+8l/lPF9M7amt05fkoVJ4Od0j5Bi0b+LUDByGsSS4aUVzWn
	+UyeO0LtvIDiWUmkyfoEUDXeCc9xnBfMRaoBbV6sWX6kPaV9GawjsaoZ+HaMcbi3uZDvSULWM6e
	ZNcPfG073pJDvjgPpURjWgwpgkAbvTkYQfZojW8KKT6oOeox6aXPniXaRsXSGw0DUXEEUjPBsVr
	PPfm4CTuRXaHhoCWWPSsV92wyagAFLG0j2o1YP+6O9CpHVj86B7jImEwfVmv7b4XC6J6XC6BirW
	ZC11/GyvwWsrOp//DlESHMU6w3Le8Dby97+EnN+mOk2YZjx7pbduHOk568TRbK1FaNJsb0ZdCva
	3hjO+c+BXJ5OHNapDcjAXgJLEaKsaAB7OiN/E9bT/WWtm8HeGS2k81Of6aTsaT3uo3lCDnu6/Xc
	37h8GOexVViVPKmEo7nhmwQNzmujpDtPE2U9ytRTVKrXz5LsGZeBE=
X-Received: by 2002:a05:6102:a49:b0:5de:93bb:c53f with SMTP id ada2fe7eead31-5f54bc5d794mr1094922137.25.1769196948487;
        Fri, 23 Jan 2026 11:35:48 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5f54d650df5sm389891137.5.2026.01.23.11.35.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jan 2026 11:35:48 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b630753cc38so4270206a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769196947; x=1769801747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5OU/RLBNz5QlYQHo4MnTuUpoycaD8XZR+hOfHOhW5Q=;
        b=dfwI2u9CKUNh138627fU31lBII/o4kdUSlsLxgDtim7SIYiVXrdBLwOVHHowId8yDw
         MHsQEPttzPoKBOnZg2k5l+CvesXvfmtjdeQ5UeFtAH9B5u0n6NA6JIk9zZ5J2RbpevvP
         F3M7zuOcrGcrZiIyfqE5aXhs2gfpxoUPT5SUo=
X-Received: by 2002:a05:6a00:4ac9:b0:81d:e9b1:b6e3 with SMTP id d2e1a72fcca58-82317d95c45mr3591367b3a.14.1769196947120;
        Fri, 23 Jan 2026 11:35:47 -0800 (PST)
X-Received: by 2002:a05:6a00:4ac9:b0:81d:e9b1:b6e3 with SMTP id d2e1a72fcca58-82317d95c45mr3591343b3a.14.1769196946503;
        Fri, 23 Jan 2026 11:35:46 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231873e519sm2843206b3a.49.2026.01.23.11.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 11:35:46 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v6, net-next 7/8] bng_en: Add TPA related functions
Date: Sat, 24 Jan 2026 01:05:03 +0530
Message-ID: <20260123193504.285573-8-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123193504.285573-1-bhargava.marreddy@broadcom.com>
References: <20260123193504.285573-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252943-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0A97C7A381
X-Rspamd-Action: no action

Add the functions to handle TPA events in RX path.
This helps the next patch enable TPA functionality.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_hw_def.h  | 239 +++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 124 +++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  46 ++++
 3 files changed, 408 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
index d2c2acf44e82..49828dc05514 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hw_def.h
@@ -143,7 +143,7 @@ struct rx_cmp_ext {
 #define RX_AGG_CMP_LEN			GENMASK(31, 16)
 #define RX_AGG_CMP_LEN_SHIFT		16
 #define RX_AGG_CMP_V			BIT(0)
-#define RX_AGG_CMP_AGG_ID		GENMASK(31, 16)
+#define RX_AGG_CMP_AGG_ID		GENMASK(25, 16)
 #define RX_AGG_CMP_AGG_ID_SHIFT		16
 
 struct rx_agg_cmp {
@@ -206,4 +206,241 @@ struct rx_agg_cmp {
 
 #define RX_CMP_HASH_VALID(rxcmp)				\
 	((rxcmp)->rx_cmp_len_flags_type & cpu_to_le32(RX_CMP_FLAGS_RSS_VALID))
+
+#define TPA_AGG_AGG_ID(rx_agg)				\
+	((le32_to_cpu((rx_agg)->rx_agg_cmp_v) &		\
+	 RX_AGG_CMP_AGG_ID) >> RX_AGG_CMP_AGG_ID_SHIFT)
+
+#define RX_TPA_START_CMP_TYPE				GENMASK(5, 0)
+#define RX_TPA_START_CMP_FLAGS				GENMASK(15, 6)
+#define RX_TPA_START_CMP_FLAGS_SHIFT			6
+#define RX_TPA_START_CMP_FLAGS_ERROR			BIT(6)
+#define RX_TPA_START_CMP_FLAGS_PLACEMENT		GENMASK(9, 7)
+#define RX_TPA_START_CMP_FLAGS_PLACEMENT_SHIFT		7
+#define RX_TPA_START_CMP_FLAGS_PLACEMENT_JUMBO		BIT(7)
+#define RX_TPA_START_CMP_FLAGS_PLACEMENT_HDS		(0x2 << 7)
+#define RX_TPA_START_CMP_FLAGS_PLACEMENT_GRO_JUMBO	(0x5 << 7)
+#define RX_TPA_START_CMP_FLAGS_PLACEMENT_GRO_HDS	(0x6 << 7)
+#define RX_TPA_START_CMP_FLAGS_RSS_VALID		BIT(10)
+#define RX_TPA_START_CMP_FLAGS_TIMESTAMP		BIT(11)
+#define RX_TPA_START_CMP_FLAGS_ITYPES			GENMASK(15, 12)
+#define RX_TPA_START_CMP_FLAGS_ITYPES_SHIFT		12
+#define RX_TPA_START_CMP_FLAGS_ITYPE_TCP		(0x2 << 12)
+#define RX_TPA_START_CMP_LEN				GENMASK(31, 16)
+#define RX_TPA_START_CMP_LEN_SHIFT			16
+#define RX_TPA_START_CMP_V1				BIT(0)
+#define RX_TPA_START_CMP_RSS_HASH_TYPE			GENMASK(15, 9)
+#define RX_TPA_START_CMP_RSS_HASH_TYPE_SHIFT		9
+#define RX_TPA_START_CMP_V3_RSS_HASH_TYPE		GENMASK(15, 7)
+#define RX_TPA_START_CMP_V3_RSS_HASH_TYPE_SHIFT		7
+#define RX_TPA_START_CMP_AGG_ID				GENMASK(25, 16)
+#define RX_TPA_START_CMP_AGG_ID_SHIFT			16
+#define RX_TPA_START_CMP_METADATA1			GENMASK(31, 28)
+#define RX_TPA_START_CMP_METADATA1_SHIFT		28
+#define RX_TPA_START_METADATA1_TPID_SEL			GENMASK(30, 28)
+#define RX_TPA_START_METADATA1_TPID_8021Q		BIT(28)
+#define RX_TPA_START_METADATA1_TPID_8021AD		(0x0 << 28)
+#define RX_TPA_START_METADATA1_VALID			BIT(31)
+
+struct rx_tpa_start_cmp {
+	__le32 rx_tpa_start_cmp_len_flags_type;
+	u32 rx_tpa_start_cmp_opaque;
+	__le32 rx_tpa_start_cmp_misc_v1;
+	__le32 rx_tpa_start_cmp_rss_hash;
+};
+
+#define TPA_START_HASH_VALID(rx_tpa_start)				\
+	((rx_tpa_start)->rx_tpa_start_cmp_len_flags_type &		\
+	 cpu_to_le32(RX_TPA_START_CMP_FLAGS_RSS_VALID))
+
+#define TPA_START_HASH_TYPE(rx_tpa_start)				\
+	(((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
+	   RX_TPA_START_CMP_RSS_HASH_TYPE) >>				\
+	  RX_TPA_START_CMP_RSS_HASH_TYPE_SHIFT) & RSS_PROFILE_ID_MASK)
+
+#define TPA_START_V3_HASH_TYPE(rx_tpa_start)				\
+	(((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
+	   RX_TPA_START_CMP_V3_RSS_HASH_TYPE) >>			\
+	  RX_TPA_START_CMP_V3_RSS_HASH_TYPE_SHIFT) & RSS_PROFILE_ID_MASK)
+
+#define TPA_START_AGG_ID(rx_tpa_start)				\
+	((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
+	 RX_TPA_START_CMP_AGG_ID) >> RX_TPA_START_CMP_AGG_ID_SHIFT)
+
+#define TPA_START_ERROR(rx_tpa_start)					\
+	((rx_tpa_start)->rx_tpa_start_cmp_len_flags_type &		\
+	 cpu_to_le32(RX_TPA_START_CMP_FLAGS_ERROR))
+
+#define TPA_START_VLAN_VALID(rx_tpa_start)				\
+	((rx_tpa_start)->rx_tpa_start_cmp_misc_v1 &			\
+	 cpu_to_le32(RX_TPA_START_METADATA1_VALID))
+
+#define TPA_START_VLAN_TPID_SEL(rx_tpa_start)				\
+	(le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_misc_v1) &	\
+	 RX_TPA_START_METADATA1_TPID_SEL)
+
+#define RX_TPA_START_CMP_FLAGS2_IP_CS_CALC		BIT(0)
+#define RX_TPA_START_CMP_FLAGS2_L4_CS_CALC		BIT(1)
+#define RX_TPA_START_CMP_FLAGS2_T_IP_CS_CALC		BIT(2)
+#define RX_TPA_START_CMP_FLAGS2_T_L4_CS_CALC		BIT(3)
+#define RX_TPA_START_CMP_FLAGS2_IP_TYPE			BIT(8)
+#define RX_TPA_START_CMP_FLAGS2_CSUM_CMPL_VALID		BIT(9)
+#define RX_TPA_START_CMP_FLAGS2_EXT_META_FORMAT		GENMASK(11, 10)
+#define RX_TPA_START_CMP_FLAGS2_EXT_META_FORMAT_SHIFT	10
+#define RX_TPA_START_CMP_V3_FLAGS2_T_IP_TYPE		BIT(10)
+#define RX_TPA_START_CMP_V3_FLAGS2_AGG_GRO		BIT(11)
+#define RX_TPA_START_CMP_FLAGS2_CSUM_CMPL		GENMASK(31, 16)
+#define RX_TPA_START_CMP_FLAGS2_CSUM_CMPL_SHIFT		16
+#define RX_TPA_START_CMP_V2				BIT(0)
+#define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_MASK	GENMASK(3, 1)
+#define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_SHIFT	1
+#define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_NO_BUFFER	(0x0 << 1)
+#define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_BAD_FORMAT	(0x3 << 1)
+#define RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_FLUSH	(0x5 << 1)
+#define RX_TPA_START_CMP_CFA_CODE			GENMASK(31, 16)
+#define RX_TPA_START_CMPL_CFA_CODE_SHIFT		16
+#define RX_TPA_START_CMP_METADATA0_TCI_MASK		GENMASK(31, 16)
+#define RX_TPA_START_CMP_METADATA0_VID_MASK		GENMASK(27, 16)
+#define RX_TPA_START_CMP_METADATA0_SFT			16
+
+struct rx_tpa_start_cmp_ext {
+	__le32 rx_tpa_start_cmp_flags2;
+	__le32 rx_tpa_start_cmp_metadata;
+	__le32 rx_tpa_start_cmp_cfa_code_v2;
+	__le32 rx_tpa_start_cmp_hdr_info;
+};
+
+#define TPA_START_CFA_CODE(rx_tpa_start)				\
+	((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_cfa_code_v2) &	\
+	 RX_TPA_START_CMP_CFA_CODE) >> RX_TPA_START_CMPL_CFA_CODE_SHIFT)
+
+#define TPA_START_IS_IPV6(rx_tpa_start)				\
+	(!!((rx_tpa_start)->rx_tpa_start_cmp_flags2 &		\
+	    cpu_to_le32(RX_TPA_START_CMP_FLAGS2_IP_TYPE)))
+
+#define TPA_START_ERROR_CODE(rx_tpa_start)				\
+	((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_cfa_code_v2) &	\
+	  RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_MASK) >>			\
+	 RX_TPA_START_CMP_ERRORS_BUFFER_ERROR_SHIFT)
+
+#define TPA_START_METADATA0_TCI(rx_tpa_start)				\
+	((le32_to_cpu((rx_tpa_start)->rx_tpa_start_cmp_cfa_code_v2) &	\
+	  RX_TPA_START_CMP_METADATA0_TCI_MASK) >>			\
+	 RX_TPA_START_CMP_METADATA0_SFT)
+
+#define RX_TPA_END_CMP_TYPE				GENMASK(5, 0)
+#define RX_TPA_END_CMP_FLAGS				GENMASK(15, 6)
+#define RX_TPA_END_CMP_FLAGS_SHIFT			6
+#define RX_TPA_END_CMP_FLAGS_PLACEMENT			GENMASK(9, 7)
+#define RX_TPA_END_CMP_FLAGS_PLACEMENT_SHIFT		7
+#define RX_TPA_END_CMP_FLAGS_PLACEMENT_JUMBO		BIT(7)
+#define RX_TPA_END_CMP_FLAGS_PLACEMENT_HDS		(0x2 << 7)
+#define RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_JUMBO	(0x5 << 7)
+#define RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_HDS		(0x6 << 7)
+#define RX_TPA_END_CMP_FLAGS_RSS_VALID			BIT(10)
+#define RX_TPA_END_CMP_FLAGS_ITYPES			GENMASK(15, 12)
+#define RX_TPA_END_CMP_FLAGS_ITYPES_SHIFT		12
+#define RX_TPA_END_CMP_FLAGS_ITYPE_TCP			(0x2 << 12)
+#define RX_TPA_END_CMP_LEN				GENMASK(31, 16)
+#define RX_TPA_END_CMP_LEN_SHIFT			16
+#define RX_TPA_END_CMP_V1				BIT(0)
+#define RX_TPA_END_CMP_TPA_SEGS				GENMASK(15, 8)
+#define RX_TPA_END_CMP_TPA_SEGS_SHIFT			8
+#define RX_TPA_END_CMP_AGG_ID				GENMASK(25, 16)
+#define RX_TPA_END_CMP_AGG_ID_SHIFT			16
+#define RX_TPA_END_GRO_TS				BIT(31)
+
+struct rx_tpa_end_cmp {
+	__le32 rx_tpa_end_cmp_len_flags_type;
+	u32 rx_tpa_end_cmp_opaque;
+	__le32 rx_tpa_end_cmp_misc_v1;
+	__le32 rx_tpa_end_cmp_tsdelta;
+};
+
+#define TPA_END_AGG_ID(rx_tpa_end)					\
+	((le32_to_cpu((rx_tpa_end)->rx_tpa_end_cmp_misc_v1) &		\
+	 RX_TPA_END_CMP_AGG_ID) >> RX_TPA_END_CMP_AGG_ID_SHIFT)
+
+#define TPA_END_TPA_SEGS(rx_tpa_end)					\
+	((le32_to_cpu((rx_tpa_end)->rx_tpa_end_cmp_misc_v1) &		\
+	 RX_TPA_END_CMP_TPA_SEGS) >> RX_TPA_END_CMP_TPA_SEGS_SHIFT)
+
+#define RX_TPA_END_CMP_FLAGS_PLACEMENT_ANY_GRO				\
+	cpu_to_le32(RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_JUMBO &		\
+		    RX_TPA_END_CMP_FLAGS_PLACEMENT_GRO_HDS)
+
+#define TPA_END_GRO(rx_tpa_end)						\
+	((rx_tpa_end)->rx_tpa_end_cmp_len_flags_type &			\
+	 RX_TPA_END_CMP_FLAGS_PLACEMENT_ANY_GRO)
+
+#define TPA_END_GRO_TS(rx_tpa_end)					\
+	(!!((rx_tpa_end)->rx_tpa_end_cmp_tsdelta &			\
+	    cpu_to_le32(RX_TPA_END_GRO_TS)))
+
+#define RX_TPA_END_CMP_TPA_DUP_ACKS			GENMASK(3, 0)
+#define RX_TPA_END_CMP_PAYLOAD_OFFSET			GENMASK(23, 16)
+#define RX_TPA_END_CMP_PAYLOAD_OFFSET_SHIFT		16
+#define RX_TPA_END_CMP_AGG_BUFS				GENMASK(31, 24)
+#define RX_TPA_END_CMP_AGG_BUFS_SHIFT			24
+#define RX_TPA_END_CMP_TPA_SEG_LEN			GENMASK(15, 0)
+#define RX_TPA_END_CMP_V2				BIT(0)
+#define RX_TPA_END_CMP_ERRORS				GENMASK(2, 1)
+#define RX_TPA_END_CMPL_ERRORS_SHIFT			1
+#define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_NO_BUFFER	(0x0 << 1)
+#define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_NOT_ON_CHIP	(0x2 << 1)
+#define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_BAD_FORMAT	(0x3 << 1)
+#define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_RSV_ERROR	(0x4 << 1)
+#define RX_TPA_END_CMP_ERRORS_BUFFER_ERROR_FLUSH	(0x5 << 1)
+
+struct rx_tpa_end_cmp_ext {
+	__le32 rx_tpa_end_cmp_dup_acks;
+	__le32 rx_tpa_end_cmp_seg_len;
+	__le32 rx_tpa_end_cmp_errors_v2;
+	u32 rx_tpa_end_cmp_start_opaque;
+};
+
+#define TPA_END_ERRORS(rx_tpa_end_ext)					\
+	((rx_tpa_end_ext)->rx_tpa_end_cmp_errors_v2 &			\
+	 cpu_to_le32(RX_TPA_END_CMP_ERRORS))
+
+#define TPA_END_PAYLOAD_OFF(rx_tpa_end_ext)				\
+	((le32_to_cpu((rx_tpa_end_ext)->rx_tpa_end_cmp_dup_acks) &	\
+	 RX_TPA_END_CMP_PAYLOAD_OFFSET) >>				\
+	RX_TPA_END_CMP_PAYLOAD_OFFSET_SHIFT)
+
+#define TPA_END_AGG_BUFS(rx_tpa_end_ext)				\
+	((le32_to_cpu((rx_tpa_end_ext)->rx_tpa_end_cmp_dup_acks) &	\
+	 RX_TPA_END_CMP_AGG_BUFS) >> RX_TPA_END_CMP_AGG_BUFS_SHIFT)
+
+#define EVENT_DATA1_RESET_NOTIFY_FATAL(data1)				\
+	(((data1) &							\
+	  ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_MASK) ==\
+	 ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_FW_EXCEPTION_FATAL)
+
+#define EVENT_DATA1_RESET_NOTIFY_FW_ACTIVATION(data1)			\
+	(((data1) &							\
+	  ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_MASK) ==\
+	ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA1_REASON_CODE_FW_ACTIVATION)
+
+#define EVENT_DATA2_RESET_NOTIFY_FW_STATUS_CODE(data2)			\
+	((data2) &							\
+	ASYNC_EVENT_CMPL_RESET_NOTIFY_EVENT_DATA2_FW_STATUS_CODE_MASK)
+
+#define EVENT_DATA1_RECOVERY_MASTER_FUNC(data1)				\
+	(!!((data1) &							\
+	   ASYNC_EVENT_CMPL_ERROR_RECOVERY_EVENT_DATA1_FLAGS_MASTER_FUNC))
+
+#define EVENT_DATA1_RECOVERY_ENABLED(data1)				\
+	(!!((data1) &							\
+	   ASYNC_EVENT_CMPL_ERROR_RECOVERY_EVENT_DATA1_FLAGS_RECOVERY_ENABLED))
+
+#define BNGE_EVENT_ERROR_REPORT_TYPE(data1)				\
+	(((data1) &							\
+	  ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_MASK) >>\
+	 ASYNC_EVENT_CMPL_ERROR_REPORT_BASE_EVENT_DATA1_ERROR_TYPE_SFT)
+
+#define BNGE_EVENT_INVALID_SIGNAL_DATA(data2)				\
+	(((data2) &							\
+	  ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_EVENT_DATA2_PIN_ID_MASK) >>\
+	 ASYNC_EVENT_CMPL_ERROR_REPORT_INVALID_SIGNAL_EVENT_DATA2_PIN_ID_SFT)
 #endif /* _BNGE_HW_DEF_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 5b0e326c5056..6e240f48d89b 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -377,11 +377,37 @@ static void bnge_free_one_agg_ring_bufs(struct bnge_net *bn,
 	}
 }
 
+static void bnge_free_one_tpa_info_data(struct bnge_net *bn,
+					struct bnge_rx_ring_info *rxr)
+{
+	int i;
+
+	for (i = 0; i < bn->max_tpa; i++) {
+		struct bnge_tpa_info *tpa_info = &rxr->rx_tpa[i];
+		u8 *data = tpa_info->data;
+
+		if (!data)
+			continue;
+
+		tpa_info->data = NULL;
+		page_pool_free_va(rxr->head_pool, data, false);
+	}
+}
+
 static void bnge_free_one_rx_ring_pair_bufs(struct bnge_net *bn,
 					    struct bnge_rx_ring_info *rxr)
 {
+	struct bnge_tpa_idx_map *map;
+
+	if (rxr->rx_tpa)
+		bnge_free_one_tpa_info_data(bn, rxr);
+
 	bnge_free_one_rx_ring_bufs(bn, rxr);
 	bnge_free_one_agg_ring_bufs(bn, rxr);
+
+	map = rxr->rx_tpa_idx_map;
+	if (map)
+		memset(map->agg_idx_bmap, 0, sizeof(map->agg_idx_bmap));
 }
 
 static void bnge_free_rx_ring_pair_bufs(struct bnge_net *bn)
@@ -452,11 +478,70 @@ static void bnge_free_all_rings_bufs(struct bnge_net *bn)
 	bnge_free_tx_skbs(bn);
 }
 
+static void bnge_free_tpa_info(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, j;
+
+	for (i = 0; i < bd->rx_nr_rings; i++) {
+		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
+
+		kfree(rxr->rx_tpa_idx_map);
+		rxr->rx_tpa_idx_map = NULL;
+		if (rxr->rx_tpa) {
+			for (j = 0; j < bn->max_tpa; j++) {
+				kfree(rxr->rx_tpa[j].agg_arr);
+				rxr->rx_tpa[j].agg_arr = NULL;
+			}
+		}
+		kfree(rxr->rx_tpa);
+		rxr->rx_tpa = NULL;
+	}
+}
+
+static int bnge_alloc_tpa_info(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	int i, j;
+
+	if (!bd->max_tpa_v2)
+		return 0;
+
+	bn->max_tpa = max_t(u16, bd->max_tpa_v2, MAX_TPA);
+	for (i = 0; i < bd->rx_nr_rings; i++) {
+		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
+
+		rxr->rx_tpa = kcalloc(bn->max_tpa, sizeof(struct bnge_tpa_info),
+				      GFP_KERNEL);
+		if (!rxr->rx_tpa)
+			goto err_free_tpa_info;
+
+		for (j = 0; j < bn->max_tpa; j++) {
+			struct rx_agg_cmp *agg;
+
+			agg = kcalloc(MAX_SKB_FRAGS, sizeof(*agg), GFP_KERNEL);
+			if (!agg)
+				goto err_free_tpa_info;
+			rxr->rx_tpa[j].agg_arr = agg;
+		}
+		rxr->rx_tpa_idx_map = kzalloc(sizeof(*rxr->rx_tpa_idx_map),
+					      GFP_KERNEL);
+		if (!rxr->rx_tpa_idx_map)
+			goto err_free_tpa_info;
+	}
+	return 0;
+
+err_free_tpa_info:
+	bnge_free_tpa_info(bn);
+	return -ENOMEM;
+}
+
 static void bnge_free_rx_rings(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
 	int i;
 
+	bnge_free_tpa_info(bn);
 	for (i = 0; i < bd->rx_nr_rings; i++) {
 		struct bnge_rx_ring_info *rxr = &bn->rx_ring[i];
 		struct bnge_ring_struct *ring;
@@ -581,6 +666,12 @@ static int bnge_alloc_rx_rings(struct bnge_net *bn)
 				goto err_free_rx_rings;
 		}
 	}
+
+	if (bn->priv_flags & BNGE_NET_EN_TPA) {
+		rc = bnge_alloc_tpa_info(bn);
+		if (rc)
+			goto err_free_rx_rings;
+	}
 	return rc;
 
 err_free_rx_rings:
@@ -1126,6 +1217,30 @@ static int bnge_alloc_one_agg_ring_bufs(struct bnge_net *bn,
 	return -ENOMEM;
 }
 
+static int bnge_alloc_one_tpa_info_data(struct bnge_net *bn,
+					struct bnge_rx_ring_info *rxr)
+{
+	dma_addr_t mapping;
+	u8 *data;
+	int i;
+
+	for (i = 0; i < bn->max_tpa; i++) {
+		data = __bnge_alloc_rx_frag(bn, &mapping, rxr,
+					    GFP_KERNEL);
+		if (!data)
+			goto err_free_tpa_info_data;
+
+		rxr->rx_tpa[i].data = data;
+		rxr->rx_tpa[i].data_ptr = data + bn->rx_offset;
+		rxr->rx_tpa[i].mapping = mapping;
+	}
+	return 0;
+
+err_free_tpa_info_data:
+	bnge_free_one_tpa_info_data(bn, rxr);
+	return -ENOMEM;
+}
+
 static int bnge_alloc_one_rx_ring_pair_bufs(struct bnge_net *bn, int ring_nr)
 {
 	struct bnge_rx_ring_info *rxr = &bn->rx_ring[ring_nr];
@@ -1140,8 +1255,17 @@ static int bnge_alloc_one_rx_ring_pair_bufs(struct bnge_net *bn, int ring_nr)
 		if (rc)
 			goto err_free_one_rx_ring_bufs;
 	}
+
+	if (rxr->rx_tpa) {
+		rc = bnge_alloc_one_tpa_info_data(bn, rxr);
+		if (rc)
+			goto err_free_one_agg_ring_bufs;
+	}
+
 	return 0;
 
+err_free_one_agg_ring_bufs:
+	bnge_free_one_agg_ring_bufs(bn, rxr);
 err_free_one_rx_ring_bufs:
 	bnge_free_one_rx_ring_bufs(bn, rxr);
 	return rc;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index ee036ce63655..89c9775f610e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -153,6 +153,45 @@ enum {
 
 #define BNGE_NET_EN_TPA		(BNGE_NET_EN_GRO | BNGE_NET_EN_LRO)
 
+#define BNGE_NO_FW_ACCESS(bd)	(pci_channel_offline((bd)->pdev))
+
+#define MAX_TPA		256
+#define MAX_TPA_MASK	(MAX_TPA - 1)
+#define MAX_TPA_SEGS	0x3f
+
+#define BNGE_TPA_INNER_L3_OFF(hdr_info)	\
+	(((hdr_info) >> 18) & 0x1ff)
+
+#define BNGE_TPA_INNER_L2_OFF(hdr_info)	\
+	(((hdr_info) >> 9) & 0x1ff)
+
+#define BNGE_TPA_OUTER_L3_OFF(hdr_info)	\
+	((hdr_info) & 0x1ff)
+
+struct bnge_tpa_idx_map {
+	u16		agg_id_tbl[1024];
+	DECLARE_BITMAP(agg_idx_bmap, MAX_TPA);
+};
+
+struct bnge_tpa_info {
+	void			*data;
+	u8			*data_ptr;
+	dma_addr_t		mapping;
+	u16			len;
+	unsigned short		gso_type;
+	u32			flags2;
+	u32			metadata;
+	enum pkt_hash_types	hash_type;
+	u32			rss_hash;
+	u32			hdr_info;
+
+	u16			cfa_code; /* cfa_code in TPA start compl */
+	u8			agg_count;
+	u8			vlan_valid:1;
+	u8			cfa_code_valid:1;
+	struct rx_agg_cmp	*agg_arr;
+};
+
 /* Minimum TX BDs for a TX packet with MAX_SKB_FRAGS + 1. We need one extra
  * BD because the first TX BD is always a long BD.
  */
@@ -245,6 +284,10 @@ struct bnge_net {
 #define BNGE_STATE_NAPI_DISABLED	0
 
 	u32			msg_enable;
+	u16			max_tpa;
+	__be16			vxlan_port;
+	__be16			nge_port;
+	__be16			vxlan_gpe_port;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
@@ -390,6 +433,9 @@ struct bnge_rx_ring_info {
 	dma_addr_t		rx_desc_mapping[MAX_RX_PAGES];
 	dma_addr_t		rx_agg_desc_mapping[MAX_RX_AGG_PAGES];
 
+	struct bnge_tpa_info	*rx_tpa;
+	struct bnge_tpa_idx_map *rx_tpa_idx_map;
+
 	struct bnge_ring_struct	rx_ring_struct;
 	struct bnge_ring_struct	rx_agg_ring_struct;
 	struct page_pool	*page_pool;
-- 
2.47.3


