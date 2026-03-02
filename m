Return-Path: <netdev+bounces-262793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNxTBTrrpWlLHwAAu9opvQ
	(envelope-from <netdev+bounces-262793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 20:55:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6011DF011
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 20:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7CFCE3061CE0
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 19:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A6933F8BA;
	Mon,  2 Mar 2026 19:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HqQZrbKG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6663859E0
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772481282; cv=none; b=aQDACtbW4dYCUb0bLw8DlPG0dwlGID869yJrrgvD+YCX4okMF8d9mrSWQscex1eNiv062ueJMHraaWxBGuE6EBdqPmmPwG8x4ocjWLzBUymWUM0+5jRIcnPUBVDZr8CK+zFhi9ICNtlr330Fx2NMnSINry62tEYi0t6wAzTTx1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772481282; c=relaxed/simple;
	bh=WUwGJD0pWzW4QiYZ0NkHgvIb2Xz4SfrboA1bkSyZDN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcp5M16TetuOEznkeSYvUl29itIvVV6lwTbEkU8AMUTlC76nAGvlIp8/61TvgscVyMtAr/Vb2/EXGANbxZh2zRfCRYCLOXibbbMX3SrSpT7I3x6ZWlUJKUbXHdrCqB3lEjnP20QaQoC8/uIGvreIV1EO0he8V+Nh21gaJmWKrTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HqQZrbKG; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2ae46b9c70dso7403775ad.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 11:54:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772481281; x=1773086081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJGdTjCWcN7+FPK2Rcu4FQwQzwIIdasxcvxeVm4EkoI=;
        b=SmNYihAyT/EbVFP8e3XSnOFeU1/KYI6FqRJccTtLzr8Omg9LE5hluEhSRwF+nPx2MV
         lFBTxaYHahl0bQIYqHW3jBSyUxEykCYzQbYAVtBVW4/EUBuYoXbxbbAk+e7LEF6eF+cv
         qgFYzNNxgQ8VHkmdDYgXE5WaE/piWRUJPaJ3MZzx18hG+JvjH6TBUFgrtIraAq0zx85a
         tqhjJ8fVYjzLEYBPUR8KYWVdu2N1k1T5Ghayj/PBmMceEy+xtOqnr2zERr5xFdOiS/NU
         x8psCmNO6uD8CHLDCTucMXBoLGaf7C1Z3+I9adricwcTMp++WVEBggQFvIhvtmuGxAc1
         0WOg==
X-Gm-Message-State: AOJu0YyoJnibaDMkKrYbOmvPlp9E2cO2I2UxdggqP5FydbsvucFyT1Xa
	iC6Wf43Fb7D8WIgW8ZoWUcAXGZcGhDckovFquAaQF9LPj+DoQT8jANtelQ8vUDBNkjpct1YbKBm
	wEQn658ND6uCPJt+89DvbE8Ptu2zm+g6TkrfOFJfVducR9DTP7C18ZcSJbeAokkzxWmWf1Fjyi7
	B+KIz/+z+VDthhgAOehl7mBxdg4gSiVVt0KnQIIyl/IMlm7Z+Y32x3/2OjU1W17bUF2OtgBREv2
	Pz8lfXwmItfDnVra754
X-Gm-Gg: ATEYQzxyYRIlDSqx3vSNzNPaih37yDesRg3e3Wu7/pvMbgaBqHoHC32q5LyCUzmPjHk
	yB3jutaRrAEEjxFRSdB2aG6STNNuXEda4BZRxz36gTlNHEpH4X9TU6xC5nLckGnYBwHcanKuUwt
	jr0NH9I6cf+G8/MwgArx5QpqwQzJFwX0MiouMq52qc7Umb+2xQqrT9n0dAIDEUMls//wCr260zS
	Vid6Qv2Cr3roELnzzWopQQTCPAzlOZ0Mysc8iqzKFr3QmrFe0RkkFtKWpXBqvd/fKC3kewPx0/c
	SdkAKrqiTIzpU6KKbfEdpT/wmU4AtQ2YV2ZfoK6/0KMtU1b1YUAyT0sAXZG+DTOld6hEjNKKUQC
	7KHkRZviHrWkJUlp8DPDdIv3YPssLoEPTq3y0ieT+g68TTbru50P+asEdd3TAsHgZ+TlEpRjoTk
	f00NkGhc8Y4Puh0l3nVaB5/cdE/+5aa2dbfQdGdkSjEBG/Yhr7iI9Lx2z7t7t5mg/Yng==
X-Received: by 2002:a17:902:f543:b0:2ae:d7c:1ec6 with SMTP id d9443c01a7336-2ae2b55872amr131861465ad.0.1772481281048;
        Mon, 02 Mar 2026 11:54:41 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb5eee32sm17876605ad.42.2026.03.02.11.54.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2026 11:54:41 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-899f474fae1so128379256d6.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 11:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772481280; x=1773086080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TJGdTjCWcN7+FPK2Rcu4FQwQzwIIdasxcvxeVm4EkoI=;
        b=HqQZrbKGQ8c+sO2oVz+xcI9z//EvpgmlkFhJH+CcI3JuQ0VgHaKW1k2PmvtSDfix3F
         BoVa+nctPpAKIrvkSRyxJXQJR9ON6EQc2WOpTN9siUt8sHIrJfikczW0u2hK3bJDQDOS
         ARoACCpvdX0nVLi2nBTurgzJUbFcEZrRT1xCI=
X-Received: by 2002:a05:620a:29c1:b0:8ca:33d7:8be9 with SMTP id af79cd13be357-8cbc8ce73d0mr1861217385a.28.1772481279553;
        Mon, 02 Mar 2026 11:54:39 -0800 (PST)
X-Received: by 2002:a05:620a:29c1:b0:8ca:33d7:8be9 with SMTP id af79cd13be357-8cbc8ce73d0mr1861214485a.28.1772481279058;
        Mon, 02 Mar 2026 11:54:39 -0800 (PST)
Received: from lvnvdb0691.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf736cfasm1208049285a.49.2026.03.02.11.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:54:38 -0800 (PST)
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
Subject: [net-next 2/3] netdevsim: psp: Handle statistics reset
Date: Mon,  2 Mar 2026 11:53:51 -0800
Message-ID: <20260302195352.1015990-3-akhilesh.samineni@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260302195352.1015990-1-akhilesh.samineni@broadcom.com>
References: <20260302195352.1015990-1-akhilesh.samineni@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 8B6011DF011
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-262793-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilesh.samineni@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Implement reset_stats for netdevsim PSP so that the
reset-stats netlink command works.

Signed-off-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Reviewed-by: Kiran Kella <kiran.kella@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/netdevsim/psp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 0b4d717253b0..d4bede67f283 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -192,6 +192,19 @@ static void nsim_get_stats(struct psp_dev *psd, struct psp_dev_stats *stats)
 	} while (u64_stats_fetch_retry(&ns->psp.syncp, start));
 }
 
+static int nsim_reset_stats(struct psp_dev *psd, struct netlink_ext_ack *extack)
+{
+	struct netdevsim *ns = psd->drv_priv;
+
+	u64_stats_update_begin(&ns->psp.syncp);
+	u64_stats_set(&ns->psp.rx_bytes, 0);
+	u64_stats_set(&ns->psp.rx_packets, 0);
+	u64_stats_set(&ns->psp.tx_bytes, 0);
+	u64_stats_set(&ns->psp.tx_packets, 0);
+	u64_stats_update_end(&ns->psp.syncp);
+	return 0;
+}
+
 static struct psp_dev_ops nsim_psp_ops = {
 	.set_config	= nsim_psp_set_config,
 	.rx_spi_alloc	= nsim_rx_spi_alloc,
@@ -199,6 +212,7 @@ static struct psp_dev_ops nsim_psp_ops = {
 	.tx_key_del	= nsim_assoc_del,
 	.key_rotate	= nsim_key_rotate,
 	.get_stats	= nsim_get_stats,
+	.reset_stats	= nsim_reset_stats,
 };
 
 static struct psp_dev_caps nsim_psp_caps = {
-- 
2.45.4


