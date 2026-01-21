Return-Path: <netdev+bounces-252072-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFW3AGFNcWkahAAAu9opvQ
	(envelope-from <netdev+bounces-252072-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:04:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DFB5E730
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 23:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D61D56DE60
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 21:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD5F423A7B;
	Wed, 21 Jan 2026 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fUiJF/Y7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035373D410B
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 21:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032726; cv=none; b=DUJosnb0bbC7ozwV6SMQVhbblob2Nbibb+ILpgtl8pH9deEuu+kFobdTDDvskZ2kURvJIDaHULEmSkL4ZF91NViJTkPuDGpSVTKGDTyOVkooCMMxsyN1HIpLvs83ILoKneFJJmwyby7VglXzL3Hsk1Q9wRJagOGGq8wMRATrcB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032726; c=relaxed/simple;
	bh=NkyajNX39pjG31IpBQoNBHSV76fg0h2DjgLRSJpGEBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0lFhzp/50HyqBD4fAjfn+wVjaOwbZ4QwtM+gzlt7fuom7yowmE6aVoFVfUU9PDhOd1Dn6mPMNkxu6b6WvW6w3LlZfnJyMrwfv0X5xH5+NJ8g6befymBgqXh/v2IZSYngdYT6+rLKLQDNHTtSLTqc0n0Fa0vU5uFxA9LgpKmI7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fUiJF/Y7; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65808bb859cso470264a12.2
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769032723; x=1769637523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRzjqakfn4E2JjYI30aMmbNg9oupkKMXCUErVIHa81A=;
        b=fUiJF/Y7wVGmVNXilQTK3cW4MuwmgvwG4bQarPPEt9hvWKtgBAln/L0CShce1SONbm
         uzHnq7d1NFO5tsnu1wBlFbdRlbG7hIWBtybfVaqhKULCFgGwNzM3MXHugpqERFtVuhKz
         76vxW7puU8zwC/7JsvX0h4yY+0Nq4gL0UAy0n7MQ5Ve4omk/gbOSZxX/kmIT1xmHaWEk
         VQgrMqDNLij493BGNtsM8ZNN6NKwxPc33WCFMNK0DGqV3FGf8nnLDGZ0hncXdAOwEeqZ
         3+66iidgJnkTqQRZ6KsXLeZXcMJ7av4VwWbjYd6WPt8Qj1FhbDw3RmLqhy9OfV0Npjd5
         CLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769032723; x=1769637523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NRzjqakfn4E2JjYI30aMmbNg9oupkKMXCUErVIHa81A=;
        b=c2pKJHiGZU6qLlCYL8RL2UQQhaA64FNBnfAxay1dGQZ2bGFmHQFqsRMSPlrWtto9rw
         sQwMMTe3FgpVwyOuUjnJZPbaQkgSq/JYse+o3ZD3Ri7LbYPchSkYcTGqQxZJR7b3Tfrr
         Rlu38bknYBQwFgdOv3UDLtnWChj/DvZK2WriKod6k4segaJPHroTXarnEw2Ujhmjdz9W
         +3Sxk6A3bmefXSTnd47ijrvZX6+QufoWGiCum7LjiNjs4MsMzLQLl/3Bzcv52nzzdwOA
         LflBOFKzItN6JnW49MTONHP1wow3JfuWRXLUGKtHcWgbTDIfe5Fy7UBGj6Le9Tqxncby
         Es9Q==
X-Gm-Message-State: AOJu0YwJ5yr+kDDDKRlA/Ujf+r1vhXloTP1lz9lL+G7PCbXoC4SkhC5+
	i+qwajzHUPOsAIiq+K597sc6mNWrqWkFRmg17xuSV3uLrwhwUKBHMhCdMsYuJSrer5pu46YEhvS
	Po9cZhY4D6DRaqsxNuasjNo2Ta0g+U8/gwBZhkGvxJiKLnbk/5mLZJXotuvcGPxVw7TxW9Q6Ge4
	yMYu9qpn1l6rzcREJqD9YEfTe4dvjiD6lQcaLq7xmp/PCeZ78=
X-Gm-Gg: AZuq6aKL3HF9p14VfJesVqgZZOqWmK+lP/XoY06Jx/DubCx81Atu3o5lS1ip1lYJ38s
	J0+5tPjDk17RPKArwOnUiMbOHz3op8zF7dwL7dPs/RdB0d/OwkO6UMNzro5ysYW+A4dQxXUrxt/
	7Rh5WAmh/JDbvCRDWKPF1snRz9lIUT8YTVFArcCgAaI9EJYdOY+/m2CYqpG//qeczgpH/FboPvA
	Ovqym/XuUsfYZWDTr0rKLNKUr8IWN0KMqvQyWIPAOJJA/hUvNM9Tpc3xj/z63+ycyTailMU+d9J
	GDzNSWxxvgiq02iBv2XNLVS36TP/+X072I3J00VCCtgB3yrIet9sDI8LRRYBeBi8xEpEJ0JaREn
	Kglr66yKUHehj2qM9eWvDOLJSUdE1hVhxpeEhoeplJlKA3V4u9sXOuE1xSW2xK9yzrrIyFcDs3d
	bGFomg2ZoF9Tq5gm3fQ/u5fAjeinYwSvS7toa1
X-Received: by 2002:a17:907:948d:b0:b87:17eb:561d with SMTP id a640c23a62f3a-b879324b892mr1542419566b.58.1769032722975;
        Wed, 21 Jan 2026 13:58:42 -0800 (PST)
Received: from dev-rjethwani.dev.purestorage.com ([2620:125:9007:640:ffff::71f8])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b87959c9fbbsm1652184266b.38.2026.01.21.13.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 13:58:42 -0800 (PST)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v4 3/3] mlx5: TLS 1.3 hardware offload support
Date: Wed, 21 Jan 2026 14:57:27 -0700
Message-Id: <20260121215727.3994324-4-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260121215727.3994324-1-rjethwani@purestorage.com>
References: <20260121215727.3994324-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	TAGGED_FROM(0.00)[bounces-252072-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[purestorage.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,purestorage.com:email,purestorage.com:dkim,purestorage.com:mid]
X-Rspamd-Queue-Id: 95DFB5E730
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add TLS 1.3 hardware offload support to mlx5 driver, enabling both
TX and RX hardware acceleration for TLS 1.3 connections on Mellanox
ConnectX-6 Dx and newer adapters.

This patch enables:
- TLS 1.3 version detection and validation with proper capability
checking
- TLS 1.3 crypto context configuration using
MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3 (0x3)
- Correct IV handling for TLS 1.3 (12-byte IV vs TLS 1.2's 4-byte salt)
- Hardware offload for both TLS 1.3 AES-GCM-128 and AES-GCM-256 cipher
suites

Key differences from TLS 1.2:
- TLS 1.2: Only 4-byte salt copied to gcm_iv, explicit IV in each record
- TLS 1.3: Full 12-byte IV (salt + iv) copied to gcm_iv + implicit_iv
  * salt (4 bytes) → gcm_iv[0:3]
  * iv (8 bytes)   → gcm_iv[4:7] + implicit_iv[0:3]
  * Note: gcm_iv and implicit_iv are contiguous in memory

The EXTRACT_INFO_FIELDS macro is updated to also extract the 'iv' field
which is needed for TLS 1.3.

Tested on Mellanox ConnectX-6 Dx (Crypto Enabled) with TLS 1.3 AES-GCM-128
and AES-GCM-256 cipher suites.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 .../ethernet/mellanox/mlx5/core/en_accel/ktls.h    |  8 +++++++-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c        | 14 +++++++++++---
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
index 07a04a142a2e..0469ca6a0762 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h
@@ -30,7 +30,9 @@ static inline bool mlx5e_is_ktls_device(struct mlx5_core_dev *mdev)
 		return false;
 
 	return (MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_128) ||
-		MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_256));
+		MLX5_CAP_TLS(mdev, tls_1_2_aes_gcm_256) ||
+		MLX5_CAP_TLS(mdev, tls_1_3_aes_gcm_128) ||
+		MLX5_CAP_TLS(mdev, tls_1_3_aes_gcm_256));
 }
 
 static inline bool mlx5e_ktls_type_check(struct mlx5_core_dev *mdev,
@@ -40,10 +42,14 @@ static inline bool mlx5e_ktls_type_check(struct mlx5_core_dev *mdev,
 	case TLS_CIPHER_AES_GCM_128:
 		if (crypto_info->version == TLS_1_2_VERSION)
 			return MLX5_CAP_TLS(mdev,  tls_1_2_aes_gcm_128);
+		else if (crypto_info->version == TLS_1_3_VERSION)
+			return MLX5_CAP_TLS(mdev,  tls_1_3_aes_gcm_128);
 		break;
 	case TLS_CIPHER_AES_GCM_256:
 		if (crypto_info->version == TLS_1_2_VERSION)
 			return MLX5_CAP_TLS(mdev,  tls_1_2_aes_gcm_256);
+		else if (crypto_info->version == TLS_1_3_VERSION)
+			return MLX5_CAP_TLS(mdev,  tls_1_3_aes_gcm_256);
 		break;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
index 570a912dd6fa..f3f90ad6c6cf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c
@@ -6,6 +6,7 @@
 
 enum {
 	MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2 = 0x2,
+	MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3 = 0x3,
 };
 
 enum {
@@ -15,8 +16,10 @@ enum {
 #define EXTRACT_INFO_FIELDS do { \
 	salt    = info->salt;    \
 	rec_seq = info->rec_seq; \
+	iv      = info->iv;      \
 	salt_sz    = sizeof(info->salt);    \
 	rec_seq_sz = sizeof(info->rec_seq); \
+	iv_sz      = sizeof(info->iv);      \
 } while (0)
 
 static void
@@ -25,8 +28,8 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
 		   u32 key_id, u32 resync_tcp_sn)
 {
 	char *initial_rn, *gcm_iv;
-	u16 salt_sz, rec_seq_sz;
-	char *salt, *rec_seq;
+	u16 salt_sz, rec_seq_sz, iv_sz;
+	char *salt, *rec_seq, *iv;
 	u8 tls_version;
 	u8 *ctx;
 
@@ -59,7 +62,12 @@ fill_static_params(struct mlx5_wqe_tls_static_params_seg *params,
 	memcpy(gcm_iv,      salt,    salt_sz);
 	memcpy(initial_rn,  rec_seq, rec_seq_sz);
 
-	tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2;
+	if (crypto_info->crypto_info.version == TLS_1_3_VERSION) {
+		memcpy(gcm_iv + salt_sz, iv, iv_sz);
+		tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3;
+	} else {
+		tls_version = MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_2;
+	}
 
 	MLX5_SET(tls_static_params, ctx, tls_version, tls_version);
 	MLX5_SET(tls_static_params, ctx, const_1, 1);
-- 
2.25.1


