Return-Path: <netdev+bounces-260142-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oF4YIGSUnGnRJQQAu9opvQ
	(envelope-from <netdev+bounces-260142-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:54:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5CA17B260
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E5EF319E6EA
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97C93385B9;
	Mon, 23 Feb 2026 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/+K3dpC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF09338932
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868973; cv=none; b=q62sWqYmFKh92QuRe4TdmvbxFBGFluFKrQIR4lu2P/BF2YB1xe9ZdwQjB3zphZbVAmg9C8QEb0IO5HFt+qzmoWSgql75v7oY//IsIfVx+E8XBVyCY/FCqSQKMZvMLaaHJ7RQZp+IdYGFCwlzAgVK+tcf228PqMVhk7/GnolL7AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868973; c=relaxed/simple;
	bh=8UqSXpA3T3nleoI87MLNyB9ay9p+JUDHnxsQPPKirJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFyHWMYviH594sWcJDMTM4OwXSaIojCdru0a5dCjwtXS7mPApE1NMg3WXHQnZHdndjKUEECK4/5o4TYZMt6b1k31q/5/35MxsoBE/pkKezDQrxcimdRBVPPX/S3EpbivHcSA7WN641iwwLVD4CPBQFak8RlVQYS3uwJeour8Sgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/+K3dpC; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-480706554beso56013705e9.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771868970; x=1772473770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAiTJIXNOm9JIH5k3exVo0fYB7TWPjlSfADup0T5UCo=;
        b=k/+K3dpCFJHuRLPn8LVCqwC23GC5a3r5jVA9rs0LUuWMQiQ2y4YSvZ4xjumFprem2d
         C80BmrUH7K3CBHt7mSzCBgOFUtHZcrI0V3mb/12DYMTlkwZ1oEZ1p9wD+v3sh5v58CT+
         EGcnsWLPmX4zdGsKjhTPkjMe09on2I0gzxYd4kBirP4zN8g1HVOIezWtdBwq7n2NFFK1
         2lT2UJ7fNSgr+I3vYbC8ZU/qephyMqMXxemWuVEKXOtUbozY1qZf0QcFUreTu6R0qPkR
         B3G1uciTbV1rCRUt4y1jmjnoPAAm2e3xtY12kDF3VJ40fBTk64xHPzT0u82QoZ234nf1
         N2gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868970; x=1772473770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WAiTJIXNOm9JIH5k3exVo0fYB7TWPjlSfADup0T5UCo=;
        b=VMFPYnVhwz2OmGqBtB3gwLTRgs8Q67OmLCOTDRn56lXwSE+fBLxH2++iAB5NxlAxom
         qPlc5gyfC2+tv6SHD5esFDv2keFzWQ99Pr3wIVCx3B5TEdAQaNxGJCdmnGZEN1asXrbb
         6Pmb3SPLak79mGuEhC/4ydAJ9NF7myEWZPMzGRc0L4KtQTOPz5rG8hshk/u5BXcNjiPw
         1O0dbRSfWaSWjcZHcspswmrPtGcVYc7MjqGIUnRV7nCFI/n6rq4fTtLacGWNVVUyN6Z/
         K1ff9ivWpo7k+E71AvgmwidhOWiLLgt0GUUUs7aOVPILES8Kn/29mhbERR1pDaJgkHK4
         /RtQ==
X-Gm-Message-State: AOJu0YzS0Riifc6UQL/fJ0B4stOWVJeoaxTkVF4xhOWd8RyEztXHEKoj
	KD/eSN8C9QCgCROsFt14fX/NL7fk9bNS18bS2mkxktQuMY7Vx3nGAaeT9itPXpZk
X-Gm-Gg: AZuq6aK8IIKCCF/VkBc2oZs94gJuMdnPE8xg10AVldNES/FF9lup68jHSlZDfPh79rs
	BIbTHsHTrHJKcVmz0PbgQStptIqYYLCEcchV52k+DK7/kMAhebOS/z9aLyHHsa8DmZEaWeTk5MC
	eTaex0MPy78c6a+qoQ6wfVNaO2KXyxg2iAHB5anmtBLrGFY+AriJ8egT4iTXxJWIEN4Vz/qstyy
	wUDqUouiEtkr9En+qUZjZDRbXQmwyVT/LMGV/OYqgnXyb8nEav6loiBjRPTJL13ul+9jrj5fJ7k
	+oyERYk6sNrdNicaDriBcl9JWuhjQEJR47I6rGcpH0dHeqUzsROKip5g1QmJx0jtVO0yFLTdVhx
	jRglXfuA7Gmeq0++YNw/vb3ZtAS17Fj07OKdinRaBpqLhtLG117QcNg9EXDBGBxYWOSKc+bNUGA
	YIj12VMYpG6cVALxqxh2Km
X-Received: by 2002:a05:600c:5020:b0:477:5cc6:7e44 with SMTP id 5b1f17b1804b1-483a95fb698mr175345955e9.11.1771868970173;
        Mon, 23 Feb 2026 09:49:30 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:37::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a430a33esm112612585e9.32.2026.02.23.09.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:49:29 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	alok.a.tiwari@oracle.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	davem@davemloft.net,
	dg573847474@gmail.com,
	donald.hunter@gmail.com,
	edumazet@google.com,
	gal@nvidia.com,
	horms@kernel.org,
	idosch@nvidia.com,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	lee@trager.us,
	leon@kernel.org,
	mbloch@nvidia.com,
	mike.marciniszyn@gmail.com,
	mohsin.bashr@gmail.com,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	vadim.fedorenko@linux.dev
Subject: [RFC net-next V3 5/5] eth: mlx5: Move pause storm errors to pause stats
Date: Mon, 23 Feb 2026 09:49:14 -0800
Message-ID: <20260223174914.74461-6-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223174914.74461-1-mohsin.bashr@gmail.com>
References: <20260223174914.74461-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260142-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,oracle.com,lunn.ch,davemloft.net,gmail.com,google.com,nvidia.com,kernel.org,intel.com,meta.com,bootlin.com,trager.us,pengutronix.de,redhat.com,linux.dev];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB5CA17B260
X-Rspamd-Action: no action

Report device_stall_critical_watermark_cnt as tx_pause_storm_events in
the ethtool_pause_stats struct. This counter tracks pause storm error
events which indicate the NIC has been sending pause frames for an
extended period due to a stall.

The ethtool_pause_stats struct reports these stalls as a single value,
whereas the device supports tracking them per priority. Aggregate the
counter across all priority classes to capture stalls on all priorities.
Note that the stats are fetched from the device for each priority via
mlx5_core_access_reg().

RFC: See cover letter for details on open questions regarding this patch

Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index a8af84fc9763..1a3ecf073913 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -916,11 +916,30 @@ static int mlx5e_stats_get_ieee(struct mlx5_core_dev *mdev,
 				    sz, MLX5_REG_PPCNT, 0, 0);
 }
 
+static int mlx5e_stats_get_per_prio(struct mlx5_core_dev *mdev,
+				    u32 *ppcnt_per_prio, int prio)
+{
+	u32 in[MLX5_ST_SZ_DW(ppcnt_reg)] = {};
+	int sz = MLX5_ST_SZ_BYTES(ppcnt_reg);
+
+	if (!(MLX5_CAP_PCAM_FEATURE(mdev, pfcc_mask) &&
+	      MLX5_CAP_DEBUG(mdev, stall_detect)))
+		return -EOPNOTSUPP;
+
+	MLX5_SET(ppcnt_reg, in, local_port, 1);
+	MLX5_SET(ppcnt_reg, in, grp, MLX5_PER_PRIORITY_COUNTERS_GROUP);
+	MLX5_SET(ppcnt_reg, in, prio_tc, prio);
+	return mlx5_core_access_reg(mdev, in, sz, ppcnt_per_prio, sz,
+				    MLX5_REG_PPCNT, 0, 0);
+}
+
 void mlx5e_stats_pause_get(struct mlx5e_priv *priv,
 			   struct ethtool_pause_stats *pause_stats)
 {
 	u32 ppcnt_ieee_802_3[MLX5_ST_SZ_DW(ppcnt_reg)];
 	struct mlx5_core_dev *mdev = priv->mdev;
+	u64 ps_stats = 0;
+	int prio;
 
 	if (mlx5e_stats_get_ieee(mdev, ppcnt_ieee_802_3))
 		return;
@@ -933,6 +952,17 @@ void mlx5e_stats_pause_get(struct mlx5e_priv *priv,
 		MLX5E_READ_CTR64_BE_F(ppcnt_ieee_802_3,
 				      eth_802_3_cntrs_grp_data_layout,
 				      a_pause_mac_ctrl_frames_received);
+
+	for (prio = 0; prio < NUM_PPORT_PRIO; prio++) {
+		if (mlx5e_stats_get_per_prio(mdev, ppcnt_ieee_802_3, prio))
+			return;
+
+		ps_stats += MLX5E_READ_CTR64_BE_F(ppcnt_ieee_802_3,
+						  eth_per_prio_grp_data_layout,
+						  device_stall_critical_watermark_cnt);
+	}
+
+	pause_stats->tx_pause_storm_events = ps_stats;
 }
 
 void mlx5e_stats_eth_phy_get(struct mlx5e_priv *priv,
-- 
2.47.3


