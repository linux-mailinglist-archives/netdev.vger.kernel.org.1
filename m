Return-Path: <netdev+bounces-275758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O7UJnoy1GmtsAcAu9opvQ
	(envelope-from <netdev+bounces-275758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:23:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F7C3A7D2E
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABBCB3014295
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 22:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8502F39AB;
	Mon,  6 Apr 2026 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dWnRk+t6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f228.google.com (mail-yw1-f228.google.com [209.85.128.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099DA39DBD2
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 22:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514213; cv=none; b=WaHvgWTWzVnGEG+Ypw0E1gGEWwfUJ2dTK7yOiDjKTcKP8wqRgNDoPYgD62S0cRnxhikZAxouLEyZgefbAy1IhbxctlVTIk5goWUmTnEQ1klVQ4M+vZ1hsQ2EqWfrOvSXd3Xr3kzU6MLN6rrXHuFBqH6ufH/DoofmNtH0dXslcPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514213; c=relaxed/simple;
	bh=VLQ5IkcBtCjBDGaR0WwwpGww4PBjusxCzJ79AXUkr1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gANPDnCLTteo+RrnF5rFWzPhABUlCVuf5Lzu8U+iey6wa8qGdmokBlnpVknlVGAaQB/vKnL8NJ4ZcLreZUXMP1jy9wWM7CzL7jqYOkKHjEAPuH8uE+YI50FSKxuV/49rZVQ8rvtPBBETN5ISH9g0+K5Tx/z9MltzrLOsOfs37FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dWnRk+t6; arc=none smtp.client-ip=209.85.128.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f228.google.com with SMTP id 00721157ae682-79c20063a32so45460857b3.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 15:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775514211; x=1776119011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pww6noY0UbFv/2uFTq7wBzMSydfDf9FT6J6UA49RRWE=;
        b=TImaeM1hWC2PT80J3076+pl9hRVhBgf1m6i+4WRJGeovucE3m7d2wDw1nkigrV3V0S
         ZrmtrjmCY/3H51POA0bUhWR8EgfkMG3g1BM4IePHgVfMV76oIkqZHyXWFNF7p8n5twtC
         7IKLnmq6HUAZ+EZ4m7ZprPqhxZ0yVqFmjaa5sJGC+hBfFAFwKFBQRUJPobOCdGaXHrM8
         ZMA0+RIjLTV2IDug5L760o5ahBHl6ZCuEIZduqTP68WTExefj9HMkmJaDIwHoneNOQ4V
         PwjJgRfcP82FjZX9TdD47igeNtnMSfhgtPPPcfcVZXyBJnLoZAur6KHNxeTqnArBDQFq
         f0OQ==
X-Gm-Message-State: AOJu0YxVSfTZvazBlki+4J7lgisrWAWDGT8bxa5eR/9Bp5mZXVNvzjGt
	ClIzwYa1D2zub6+SFQPqiJVdrxgqY7H2mEnNaaabwhkbOKo8laWgWIcrh8dpk3Ilmh32Oq7lXFm
	DApLjmbWXgCXrJJzrJb5lXFyta5pG0UINWUH1EzdY1pfG67DJ+gQpN3Ww7DMJT14Om3az+TBkXe
	tvIrpZNlrvNNKe0MIVzTat7BZxm5vm/jC8Uc4lViN6eUO2WKLy5D8ZLnDb2dbqXly3Nw9Avnsra
	9e1midfB7bKZwuqoVZM
X-Gm-Gg: AeBDies0gv5iY9pM+5np4dMuFosGYJU8dfNhInBWEnypmUSfmVA4gAwmyD8IcZcJ9la
	bXITy8R6shSuBmmx0R7jIlwzcc6aDT96ak7w7nJAkcFFoLn1JFnG8Jgk60AVqGIczNAW2RUdHJ1
	nPqumiM+FClpvBEdPAEHvmkjupvw07fiw0Hg6/jEPk6B73uXs+Oy3J3qd2/YlpyTuEbWfttS0gF
	1mcIulkkC/g8cRHwb9bvzrBioYLs1y81SWBm6NGA3/QvUEwq6VsAv2mFV1FJs2v/RVA35fOglqI
	nbvYjIYIL+L+GrpzyVe0G0A3dcxbQ0cnvqtjIQ3L8aCYBefRihzURvIEmXACfNj9pAjyMKlPt0t
	SmimbGBIxSMkNc9Clpz0jRshye2FTUsKm4ptdMrBJcXIhlXOQanPWUUxySD9PUGdYiWMd408o0F
	SRWjojYwOZL2SlttPgvsJ/sU8qeYR2ygf4zRCeuY8Bs3eJDzbtpuVp3qis77y4Tfc=
X-Received: by 2002:a05:690c:3684:b0:79e:c253:f723 with SMTP id 00721157ae682-7a3bee2ddecmr134084017b3.34.1775514210985;
        Mon, 06 Apr 2026 15:23:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7a36e82d4f3sm10252137b3.11.2026.04.06.15.23.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 15:23:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2bdd327d970so3317788eec.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 15:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775514210; x=1776119010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pww6noY0UbFv/2uFTq7wBzMSydfDf9FT6J6UA49RRWE=;
        b=dWnRk+t6at+6J+cLuVCgAVa6nLsYf7UPODojf3AVY4yOh/R1xSowP8CrYjpQwzvJI2
         G9nPliGhsEWmVRXxqEN/2txZHZcnvtvtneIB5c0oEDjcOHQoSfWBoMTD0DfoSbgbrD+g
         LUY9BTYPQEiZiZnI3Fsgy0PHLRFv60FO0NBYY=
X-Received: by 2002:a05:7301:1288:b0:2c1:5889:779c with SMTP id 5a478bee46e88-2cad853b80cmr6878993eec.16.1775514209619;
        Mon, 06 Apr 2026 15:23:29 -0700 (PDT)
X-Received: by 2002:a05:7301:1288:b0:2c1:5889:779c with SMTP id 5a478bee46e88-2cad853b80cmr6878978eec.16.1775514209017;
        Mon, 06 Apr 2026 15:23:29 -0700 (PDT)
Received: from lvnvdb0691.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cb92ea0ef1sm11771909eec.21.2026.04.06.15.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:23:28 -0700 (PDT)
From: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemb@google.com,
	daniel.zahka@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayakrishnan.udayavarma@broadcom.com,
	ajit.khaparde@broadcom.com,
	kiran.kella@broadcom.com,
	akhilesh.samineni@broadcom.com,
	sachin.suman@broadcom.com
Subject: [PATCH net-next 1/3] psp: add crypt-offset and spi-threshold get/set attributes
Date: Mon,  6 Apr 2026 15:23:03 -0700
Message-ID: <20260406222305.4111170-2-akhilesh.samineni@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
References: <20260406222305.4111170-1-akhilesh.samineni@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-275758-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilesh.samineni@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C0F7C3A7D2E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

crypt-offset (Crypt Offset)
----------------------------------
The crypt-offset attribute specifies the byte offset within a packet
from which encryption begins. This is a per-device attribute that
allows a portion of the packet header to remain in plaintext while
the rest of the payload is encrypted. This is useful in scenarios
where intermediate nodes need to inspect or process a fixed-size
header before the encrypted payload.

The default value is 0, meaning encryption starts from the beginning
of the payload following the PSP header.

spi-threshold (SPI Threshold)
------------------------------
The SPI (Security Parameter Index) is a 32-bit per-device identifier
used to distinguish security associations. As SPI values are allocated
monotonically, a threshold is needed to trigger timely SPI rotation
before the space is exhausted.

The spi-threshold attribute allows userspace to configure the value at
which an SPI rotation should be initiated. The default is set to
PSP_SPI_THRESHOLD_DEFAULT (~90% of 0x7FFFFFFF), providing a comfortable
margin to perform rotation without racing to exhaustion.

NOTE: A follow-up series will add notification support to alert
subscribed users when the configured spi-threshold is reached, enabling
timely SPI rotation.

Signed-off-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Reviewed-by: Kiran Kella <kiran.kella@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 Documentation/netlink/specs/psp.yaml | 13 +++++++++++++
 include/net/psp/types.h              |  7 +++++++
 include/uapi/linux/psp.h             |  2 ++
 net/psp/psp-nl-gen.c                 |  6 ++++--
 net/psp/psp_main.c                   |  3 +++
 net/psp/psp_nl.c                     | 27 +++++++++++++++++++++++----
 6 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index f3a57782d2cf..b22869be91cf 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -38,6 +38,15 @@ attribute-sets:
         type: u32
         enum: version
         enum-as-flags: true
+      -
+        name: crypt-offset
+        doc: The offset from the end of the PSP header to the start of the encrypted payload.
+        type: u8
+      -
+        name: spi-threshold
+        doc: Threshold for the SPI to trigger notification to the user for appropriate rotate action.
+        type: u32
+
   -
     name: assoc
     attributes:
@@ -170,6 +179,8 @@ operations:
             - ifindex
             - psp-versions-cap
             - psp-versions-ena
+            - crypt-offset
+            - spi-threshold
         pre: psp-device-get-locked
         post: psp-device-unlock
       dump:
@@ -193,6 +204,8 @@ operations:
           attributes:
             - id
             - psp-versions-ena
+            - crypt-offset
+            - spi-threshold
         reply:
           attributes: []
         pre: psp-device-get-locked
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index 25a9096d4e7d..875f7822557f 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -25,6 +25,9 @@ struct psphdr {
 #define PSP_SPI_KEY_ID		GENMASK(30, 0)
 #define PSP_SPI_KEY_PHASE	BIT(31)
 
+/* Default SPI threshold: ~90% of max SPI (0x7FFFFFFF) to allow rotation before exhaustion */
+#define PSP_SPI_THRESHOLD_DEFAULT	0x73333333
+
 #define PSPHDR_CRYPT_OFFSET	GENMASK(5, 0)
 
 #define PSPHDR_VERFL_SAMPLE	BIT(7)
@@ -38,9 +41,13 @@ struct psphdr {
 /**
  * struct psp_dev_config - PSP device configuration
  * @versions: PSP versions enabled on the device
+ * @crypt_offset: crypto offset configured on the device
+ * @spi_threshold: SPI threshold value on the device
  */
 struct psp_dev_config {
 	u32 versions;
+	u8 crypt_offset;
+	u32 spi_threshold;
 };
 
 /**
diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
index a3a336488dc3..bb390159dc72 100644
--- a/include/uapi/linux/psp.h
+++ b/include/uapi/linux/psp.h
@@ -22,6 +22,8 @@ enum {
 	PSP_A_DEV_IFINDEX,
 	PSP_A_DEV_PSP_VERSIONS_CAP,
 	PSP_A_DEV_PSP_VERSIONS_ENA,
+	PSP_A_DEV_CRYPT_OFFSET,
+	PSP_A_DEV_SPI_THRESHOLD,
 
 	__PSP_A_DEV_MAX,
 	PSP_A_DEV_MAX = (__PSP_A_DEV_MAX - 1)
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index 22a48d0fa378..e50b8b80955c 100644
--- a/net/psp/psp-nl-gen.c
+++ b/net/psp/psp-nl-gen.c
@@ -23,9 +23,11 @@ static const struct nla_policy psp_dev_get_nl_policy[PSP_A_DEV_ID + 1] = {
 };
 
 /* PSP_CMD_DEV_SET - do */
-static const struct nla_policy psp_dev_set_nl_policy[PSP_A_DEV_PSP_VERSIONS_ENA + 1] = {
+static const struct nla_policy psp_dev_set_nl_policy[PSP_A_DEV_SPI_THRESHOLD + 1] = {
 	[PSP_A_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
 	[PSP_A_DEV_PSP_VERSIONS_ENA] = NLA_POLICY_MASK(NLA_U32, 0xf),
+	[PSP_A_DEV_CRYPT_OFFSET] = { .type = NLA_U8, },
+	[PSP_A_DEV_SPI_THRESHOLD] = { .type = NLA_U32, },
 };
 
 /* PSP_CMD_KEY_ROTATE - do */
@@ -75,7 +77,7 @@ static const struct genl_split_ops psp_nl_ops[] = {
 		.doit		= psp_nl_dev_set_doit,
 		.post_doit	= psp_device_unlock,
 		.policy		= psp_dev_set_nl_policy,
-		.maxattr	= PSP_A_DEV_PSP_VERSIONS_ENA,
+		.maxattr	= PSP_A_DEV_SPI_THRESHOLD,
 		.flags		= GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 9508b6c38003..536ee44db09d 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -79,6 +79,9 @@ psp_dev_create(struct net_device *netdev,
 	INIT_LIST_HEAD(&psd->stale_assocs);
 	refcount_set(&psd->refcnt, 1);
 
+	/* ~90% of 0x7FFFFFFF; allows SPI rotation well before space is exhausted */
+	psd->config.spi_threshold = PSP_SPI_THRESHOLD_DEFAULT;
+
 	mutex_lock(&psp_devs_lock);
 	err = xa_alloc_cyclic(&psp_devs, &psd->id, psd, xa_limit_16b,
 			      &last_id, GFP_KERNEL);
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 6afd7707ec12..fbb77460a24b 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -101,7 +101,9 @@ psp_nl_dev_fill(struct psp_dev *psd, struct sk_buff *rsp,
 	if (nla_put_u32(rsp, PSP_A_DEV_ID, psd->id) ||
 	    nla_put_u32(rsp, PSP_A_DEV_IFINDEX, psd->main_netdev->ifindex) ||
 	    nla_put_u32(rsp, PSP_A_DEV_PSP_VERSIONS_CAP, psd->caps->versions) ||
-	    nla_put_u32(rsp, PSP_A_DEV_PSP_VERSIONS_ENA, psd->config.versions))
+	    nla_put_u32(rsp, PSP_A_DEV_PSP_VERSIONS_ENA, psd->config.versions) ||
+	    nla_put_u8(rsp, PSP_A_DEV_CRYPT_OFFSET, psd->config.crypt_offset) ||
+	    nla_put_u32(rsp, PSP_A_DEV_SPI_THRESHOLD, psd->config.spi_threshold))
 		goto err_cancel_msg;
 
 	genlmsg_end(rsp, hdr);
@@ -193,6 +195,13 @@ int psp_nl_dev_set_doit(struct sk_buff *skb, struct genl_info *info)
 
 	memcpy(&new_config, &psd->config, sizeof(new_config));
 
+	if (!info->attrs[PSP_A_DEV_PSP_VERSIONS_ENA] &&
+	    !info->attrs[PSP_A_DEV_CRYPT_OFFSET] &&
+	    !info->attrs[PSP_A_DEV_SPI_THRESHOLD]) {
+		NL_SET_ERR_MSG(info->extack, "No settings present");
+		return -EINVAL;
+	}
+
 	if (info->attrs[PSP_A_DEV_PSP_VERSIONS_ENA]) {
 		new_config.versions =
 			nla_get_u32(info->attrs[PSP_A_DEV_PSP_VERSIONS_ENA]);
@@ -200,9 +209,19 @@ int psp_nl_dev_set_doit(struct sk_buff *skb, struct genl_info *info)
 			NL_SET_ERR_MSG(info->extack, "Requested PSP versions not supported by the device");
 			return -EINVAL;
 		}
-	} else {
-		NL_SET_ERR_MSG(info->extack, "No settings present");
-		return -EINVAL;
+	}
+
+	if (info->attrs[PSP_A_DEV_CRYPT_OFFSET])
+		new_config.crypt_offset =
+			nla_get_u8(info->attrs[PSP_A_DEV_CRYPT_OFFSET]);
+
+	if (info->attrs[PSP_A_DEV_SPI_THRESHOLD]) {
+		new_config.spi_threshold =
+			nla_get_u32(info->attrs[PSP_A_DEV_SPI_THRESHOLD]);
+		if (new_config.spi_threshold & PSP_SPI_KEY_PHASE) {
+			NL_SET_ERR_MSG(info->extack, "SPI threshold must not have bit 31 set");
+			return -EINVAL;
+		}
 	}
 
 	rsp = psp_nl_reply_new(info);
-- 
2.45.4


