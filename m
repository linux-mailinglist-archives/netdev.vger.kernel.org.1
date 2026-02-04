Return-Path: <netdev+bounces-256740-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN/ZLMVng2kbmgMAu9opvQ
	(envelope-from <netdev+bounces-256740-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:37:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B0DE8FF1
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52786307CBAB
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB0A42669C;
	Wed,  4 Feb 2026 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggQ7GbAO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5965F42669B
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770218418; cv=none; b=W52LCAG1AHl8IYXKqXpuQtUzqnbbo3Y8C71uDljcoS49wwoIA7ExXN+fzVXbrCVdIeD5aSaMc7c+af8rIbefjvUOQreayBbZNOByJJOju3eq6mkvk9lUD1o0Q56cl9r4ar4/CmdwexOWbOHdk5+v1kvt2p5gwCYz2LCRFfJz4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770218418; c=relaxed/simple;
	bh=zQR7YikApmhdQmv/Akonfc2j5j4bYx9WbU5MxAEwt/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ilwLc3UACZRRLpk3FK6BSzrmk/5CqzI84DfWVTaVeXvOEnZPn07dKIj9MRJxpXyTLeLdlYkcQvm5o1rOp/3U2gEcUk4NztRBVwhwPkisyQm8gckoIyjm33PVYlyLTTF9K8NA8c0pgNUu4C3utbo/NB54gWZ8BmPDAqXxL9lL6pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggQ7GbAO; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-649ae700ba0so5029451d50.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 07:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770218417; x=1770823217; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6O2MApH+Z2XpLOqXr6VFFQHet7k4aNKtWz6QvpY9Kkc=;
        b=ggQ7GbAOsgT/bOovXngkDCS2rvDW3FRTxQip1i6vN4khY8JVZLg9Zpwvr/U3PX73eW
         ksUTUa9vhmnYGAv8Wx+Ywjz7HpPDpGb6nlhmgJWmj+wYqgtzuykOysfowPx4AMcGJ2Q9
         XtSWBeFRoAqDCDL0rkgt050iJVYSOWlQ2wXZD3ctfZ0sxlrBuVv9uq6nNRUwmp2stkie
         a850Zmf9uuAm+FFKvtYmdECrV8F3Cb1mZ3HF2gu9xaRx60KgnLFm2GXi+GKy8/g8zX9U
         IkC1+RApnyLIFN7AvBlDBMT++feJID4q/CBu8J/iE+vWGgcN28nciRnqPjTyaf9bvL1e
         aXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770218417; x=1770823217;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6O2MApH+Z2XpLOqXr6VFFQHet7k4aNKtWz6QvpY9Kkc=;
        b=WI67CcanYDNDfADFQI3rdGV+R08xKN1m66HZZOmSi1UQajXcCUmmY4lHSbLdnM8f5d
         nRas71QTlIWsbcAtbaBWb60UPaDqWRrFJs9HKp35vc/zZ2vh9RWYhzuR3tlwa8aabzwg
         DrJmfBG+oR/qZk1URV9/J8J97hSUuSUJhOkQ1KqRzNnJTiEgvGqosjiFVCkMlEvlkzo6
         N/9aSYLgzNSKZrKZJh4ZsubSG1fwh3kcgSAJ6j2kem3E0zxYy/bdpmyLbeujTqb23s4B
         7LDUiUpWivjs2mwO90jjrpXRb/kTjf/Bhqbe2blJICEbDCcqoDce01V7p0dk3ikfnlOX
         4Frw==
X-Gm-Message-State: AOJu0YzI1FCu54HS+P9tEm/Lpr178fMUJf3p8yGuOHnoneZzVrJ2nMh2
	7M+fitdVMQTAR9ejs2x4yZOKmhUkUN3HJ4gvlE39pcP1325EEUEbDJwJ
X-Gm-Gg: AZuq6aLr0E2S5FNKLH6ZZ5bjUvGz5bhtAidIH5ybXC4Kg48grllRoau7j0fbLjjc1jx
	Ysbt7G9U71oi8mNsx9kz79Wk+8tOJiLzMDf/1/EUGkQ/tm6hwiptcSumQUkcmioh0hy3sIo/+bA
	CVl4RcFsbmdRWV3hTxERQWY92yAAVPV4DXmi1N5RJzdmw3F7ynaN1GWUotoYm53q9z+ddyYNFxF
	vd1kco+gYXiCsfM7s2of+MSD3sNwcDXnvjWhXhTCcwaOBaOF02J3iCvq9BfnEg66bpv/r/E28I/
	YVgOmvyoNGRKMCm01VBBsGvPApGqgsNlTT1YwFxbtkXAQKUvMq8Lmk6QDZ+BGxNGJWhTiRapDE8
	aKJiC22I1+8BqGd4OKy9LJW/kEF3fytHs26hztllx7pnyYtbaj1+isqv2YuCkAZKpyW5Bh0G3vY
	Ltk2p7/M9m
X-Received: by 2002:a05:690c:e3cb:b0:793:ac88:2a49 with SMTP id 00721157ae682-794fe797368mr67590857b3.49.1770218417261;
        Wed, 04 Feb 2026 07:20:17 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794fefef59asm23210007b3.50.2026.02.04.07.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 07:20:16 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
Date: Wed, 04 Feb 2026 07:20:11 -0800
Subject: [PATCH net-next 7/9] mlx5: psp: implement deferred tx key deletion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-psp-v1-7-5f034e2dfa36@gmail.com>
References: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
In-Reply-To: <20260204-psp-v1-0-5f034e2dfa36@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, Boris Pismenny <borisp@nvidia.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Daniel Zahka <daniel.zahka@gmail.com>
X-Mailer: b4 0.13.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256740-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,nvidia.com,lunn.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95B0DE8FF1
X-Rspamd-Action: no action

Implement the deferred tx key deletion api. In the case of mlx5,
mlx5e_psp_tx_grace_begin() records the number of wqes retired on each
tx queue, and then mlx5e_psp_tx_grace_end() returns 0 only if
all tx queues have advanced a full ring cycle past the point where
they were snapshotted.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp.c | 101 +++++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en_accel/psp.h |   7 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |   1 +
 4 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
index 9a74438ce10a..30f1dbc3fa9d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.c
@@ -1059,13 +1059,102 @@ mlx5e_psp_get_stats(struct psp_dev *psd, struct psp_dev_stats *stats)
 	stats->tx_error = atomic_read(&priv->psp->tx_drop);
 }
 
+static int mlx5e_psp_tx_grace_begin(struct psp_dev *psd)
+{
+	struct mlx5e_priv *priv = netdev_priv(psd->main_netdev);
+	struct mlx5e_psp_tx_snapshot *snap;
+	int num_channels, num_tc, num_sqs;
+	int idx = 0, rc = 0;
+	int i, tc;
+
+	mutex_lock(&priv->state_lock);
+
+	num_channels = priv->channels.num;
+	num_tc = mlx5e_get_dcb_num_tc(&priv->channels.params);
+	num_sqs = num_channels * num_tc;
+
+	snap = kzalloc(struct_size(snap, wqes, num_sqs), GFP_KERNEL);
+	if (!snap) {
+		rc = -ENOMEM;
+		goto out_unlock;
+	}
+
+	snap->num_channels = num_channels;
+	snap->num_tc = num_tc;
+
+	for (i = 0; i < priv->channels.num; i++) {
+		struct mlx5e_channel *c = priv->channels.c[i];
+
+		for (tc = 0; tc < c->num_tc; tc++)
+			snap->wqes[idx++] = READ_ONCE(c->sq[tc].stats->wqes);
+	}
+
+	priv->psp->tx_snapshot = snap;
+
+out_unlock:
+	mutex_unlock(&priv->state_lock);
+	return rc;
+}
+
+static int mlx5e_psp_tx_grace_end(struct psp_dev *psd)
+{
+	struct mlx5e_priv *priv = netdev_priv(psd->main_netdev);
+	struct mlx5e_psp_tx_snapshot *snap;
+	int num_channels, num_tc;
+	int idx = 0, rc = 0;
+	int i, tc;
+
+	mutex_lock(&priv->state_lock);
+
+	snap = priv->psp->tx_snapshot;
+	num_channels = priv->channels.num;
+	num_tc = mlx5e_get_dcb_num_tc(&priv->channels.params);
+
+	/* If channels were reconfigured, tell core to restart grace period */
+	if (snap->num_channels != num_channels || snap->num_tc != num_tc) {
+		kfree(snap);
+		priv->psp->tx_snapshot = NULL;
+		rc = -ESTALE;
+		goto out_unlock;
+	}
+
+	for (i = 0; i < priv->channels.num; i++) {
+		struct mlx5e_channel *c = priv->channels.c[i];
+
+		for (tc = 0; tc < c->num_tc; tc++) {
+			struct mlx5e_txqsq *sq = &c->sq[tc];
+			u32 ring_size = mlx5_wq_cyc_get_size(&sq->wq);
+			u64 current_wqes = READ_ONCE(sq->stats->wqes);
+			u64 snapshot_wqes = snap->wqes[idx++];
+
+			/* If the ring has cycled, any key_id handles in tx
+			 * descriptors must have been consumed by hw and
+			 * cleaned by sw.
+			 */
+			if ((s64)(current_wqes - snapshot_wqes) < ring_size) {
+				rc = -EAGAIN;
+				goto out_unlock;
+			}
+		}
+	}
+
+	kfree(snap);
+	priv->psp->tx_snapshot = NULL;
+
+out_unlock:
+	mutex_unlock(&priv->state_lock);
+	return rc;
+}
+
 static struct psp_dev_ops mlx5_psp_ops = {
-	.set_config   = mlx5e_psp_set_config,
-	.rx_spi_alloc = mlx5e_psp_rx_spi_alloc,
-	.tx_key_add   = mlx5e_psp_assoc_add,
-	.tx_key_del   = mlx5e_psp_assoc_del,
-	.key_rotate   = mlx5e_psp_key_rotate,
-	.get_stats    = mlx5e_psp_get_stats,
+	.set_config     = mlx5e_psp_set_config,
+	.rx_spi_alloc   = mlx5e_psp_rx_spi_alloc,
+	.tx_key_add     = mlx5e_psp_assoc_add,
+	.tx_key_del     = mlx5e_psp_assoc_del,
+	.key_rotate     = mlx5e_psp_key_rotate,
+	.tx_grace_begin = mlx5e_psp_tx_grace_begin,
+	.tx_grace_end   = mlx5e_psp_tx_grace_end,
+	.get_stats      = mlx5e_psp_get_stats,
 };
 
 void mlx5e_psp_unregister(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
index 6b62fef0d9a7..29800050a331 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/psp.h
@@ -22,10 +22,17 @@ struct mlx5e_psp_stats {
 	u64 psp_tx_bytes_drop;
 };
 
+struct mlx5e_psp_tx_snapshot {
+	int num_channels;
+	int num_tc;
+	u64 wqes[];
+};
+
 struct mlx5e_psp {
 	struct psp_dev *psp;
 	struct psp_dev_caps caps;
 	struct mlx5e_psp_fs *fs;
+	struct mlx5e_psp_tx_snapshot *tx_snapshot;
 	atomic_t tx_key_cnt;
 	atomic_t tx_drop;
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 09f155acb461..5173a0d3f01a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -445,6 +445,7 @@ struct mlx5e_sq_stats {
 	u64 cqes ____cacheline_aligned_in_smp;
 	u64 wake;
 	u64 cqe_err;
+	u64 wqes;
 };
 
 struct mlx5e_xdpsq_stats {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index a01ee656a1e7..412ebc160056 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -883,6 +883,7 @@ bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget)
 	wmb();
 
 	sq->dma_fifo_cc = dma_fifo_cc;
+	stats->wqes += (u16)(sqcc - sq->cc);
 	sq->cc = sqcc;
 
 	netdev_tx_completed_queue(sq->txq, npkts, nbytes);

-- 
2.47.3


