Return-Path: <netdev+bounces-275759-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKSoF3sy1GmtsAcAu9opvQ
	(envelope-from <netdev+bounces-275759-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:23:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE773A7D35
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 00:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C724301B073
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 22:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FF739E17B;
	Mon,  6 Apr 2026 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LZm9wlld"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C8439EF0A
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514220; cv=none; b=pkNqpACsK1R4OzT+D7rg88KX8uTFdAQTUxSKrgl+mx+z/tgAG6iSg6EMAR8AImMt1kFAC4u1C4qqeA4dD+cIwz/wIl2cMszIpoFZLaW1NZTADcK79a9xyu5WvqBlEl1Xzrxc+LHnYhF4f64UgrRPYM9kWXCetzkTWBtozZlagu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514220; c=relaxed/simple;
	bh=MLwDmmpHfE65H7If15lYaG1L4QPVow9RkP5TOYgp/c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYxZqN5qyw4BkPsa5a9WayE9WQlfBy/VdoosbP2/rNO3B4t9n+le28vH0MfcFAjSbaPSovmkHhwYzPUan3tGChdnLLM2WYws2alMuwVfhf5tA7MEfImcGpeBDuoRFHXe/HlkOFEoOzjbeD1cbtgQCmKlSVNmOWqbDpjLI53E1ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LZm9wlld; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2b25cf1b5f0so27974095ad.3
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 15:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775514217; x=1776119017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/sPUbkng1QjzLAqAETuv6rluATxKmrRBMyISC2NL86A=;
        b=EUUw7KNyPx05AjkNSmUcanWdSdpe6FRUVE8/yKFTgCJ8WBnXM0IyAv5VhCp2v7L9MV
         pkYOv7Fic2BojBvquHWLug1XhZezHJEruJu0RYCoitzZkxO1sYhfen0unUZZH1pSWZiU
         LXeHHGiTGm0G88urCXMXJfnK3G/BdnHd6NcoCTeYVJl/P8FKRmjo9PB3Iwtrmxwvyfzt
         xiqt1JyAIDM2+Q1DpUnMmtY885oCNkdcbiyGU0XC+Z0qaYcGvdA28GyoeE5CfuArdA8B
         4sT3JaJ7NInloygOFYFDs4sNDqQX0XZzSqndW+EdZ1rpJx1otQ/uNp2tfQPNdvaWAdKP
         QosQ==
X-Gm-Message-State: AOJu0YzdWHC3wSpSkcsZFJpEvTjFNGfP9Ax44ppaROL4Ay/J/NtNeQUZ
	5rioMAXRex6F0WIKj0006vXGy5aWZlwbUejPjYq2zI26KZmbNV9DAUmFu9xYRRrOemyKjPkKxX3
	aUAI042C67iTTjDVTZM+zIA5XEPu4lZAbIj5Kxm8w3xYIhul6qiqovS16ZBLl1yJnonhaveHUwO
	9/oO650gdDqx7+NRrSRTQiL/Ja2YkUKU4WAX8RKUe1Ak+TUQLJtpiz+++d+0wBARGNMwqYJo/3a
	Ra0wZH8yQR1BdmzPrCJ
X-Gm-Gg: AeBDieudB9U0GV3WOryzRbX/byjJKO6BzlkJprFbbVDqErgOvGs/kHRt5AGVlKjGe2r
	0L37zrWucAkf2xt075byJNA8i8kN1yobplqQyqw7YOyG+3WBaYngM/Io3lVY7ZBLmZDHhr1m/0H
	JCIa6Y8kn3x4Wg8M//kOrxcnXV+rNFereT+MpOaugmCwtStW3ZNrnRuhigIJW7RekmD29591ac+
	p31Sj6Mm7IDFhXQXHbt4tdJPpgL83cm0cz+xQfgbycH+pDJX0cMlFkZ9Ejl/UzULaQ8R7QcnPC5
	F5u0YX0G2ssBlN1auWCFnvPuA0RRXu0a8SppYHRup6Cy3LSOOeWpZW/KCg6y8+6rKpDUNMMdth5
	cETUH3Kxb3WhPM/UmNYynDfxlhj3tiHUJR3mGZ1LogTlzSkAIkgH1MFdfTq39jx8ZxwN4YajMGz
	x5PEHoTIPuK41ST/Jr4PLKHw5t2y2ClEZ8G4TN4pHZ7L29k/ctKL+q2f1ZrS9qyds=
X-Received: by 2002:a17:902:e74b:b0:2b2:4611:5dca with SMTP id d9443c01a7336-2b28178a4c9mr153406155ad.24.1775514216560;
        Mon, 06 Apr 2026 15:23:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b274932f80sm9941065ad.52.2026.04.06.15.23.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2026 15:23:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so6276081eec.1
        for <netdev@vger.kernel.org>; Mon, 06 Apr 2026 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775514215; x=1776119015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sPUbkng1QjzLAqAETuv6rluATxKmrRBMyISC2NL86A=;
        b=LZm9wlldkn1mH4fQ+X5+5jJij7+sO7zvaIifDbnOAroFiYuTtwLVi1d8O1xlNzybV9
         hrS3PlivWQJBtPJH7VT2Xs+iRG7Q4GeiEqSryFyIcw640JlOPe0QTqz5jlho/98yCc2g
         vD8cYkAE7gs3rG1zq3VDxjV3VFAp6OXigue7E=
X-Received: by 2002:a05:7301:7306:b0:2cc:3684:d1 with SMTP id 5a478bee46e88-2cc368401b3mr4303741eec.28.1775514214932;
        Mon, 06 Apr 2026 15:23:34 -0700 (PDT)
X-Received: by 2002:a05:7301:7306:b0:2cc:3684:d1 with SMTP id 5a478bee46e88-2cc368401b3mr4303725eec.28.1775514214419;
        Mon, 06 Apr 2026 15:23:34 -0700 (PDT)
Received: from lvnvdb0691.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cb92ea0ef1sm11771909eec.21.2026.04.06.15.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:23:33 -0700 (PDT)
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
Subject: [PATCH net-next 2/3] netdevsim: psp: handle the new crypt-offset and spi-threshold get/set operations
Date: Mon,  6 Apr 2026 15:23:04 -0700
Message-ID: <20260406222305.4111170-3-akhilesh.samineni@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com];
	TAGGED_FROM(0.00)[bounces-275759-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 0CE773A7D35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the crypt-offset and spi-threshold get/set in netdevsim PSP.

Signed-off-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Reviewed-by: Kiran Kella <kiran.kella@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 drivers/net/netdevsim/netdevsim.h | 2 ++
 drivers/net/netdevsim/psp.c       | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index c904e14f6b3f..3ad7d42391c0 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -117,6 +117,8 @@ struct netdevsim {
 		struct psp_dev *dev;
 		u32 spi;
 		u32 assoc_cnt;
+		u8  crypt_offset;
+		u32 spi_threshold;
 	} psp;
 
 	struct nsim_bus_dev *nsim_bus_dev;
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 0b4d717253b0..9098edf00c5c 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -122,6 +122,11 @@ static int
 nsim_psp_set_config(struct psp_dev *psd, struct psp_dev_config *conf,
 		    struct netlink_ext_ack *extack)
 {
+	struct netdevsim *ns = psd->drv_priv;
+
+	ns->psp.crypt_offset = conf->crypt_offset;
+	ns->psp.spi_threshold = conf->spi_threshold;
+
 	return 0;
 }
 
@@ -249,6 +254,7 @@ int nsim_psp_init(struct netdevsim *ns)
 	if (err)
 		return err;
 
+	ns->psp.spi_threshold = PSP_SPI_THRESHOLD_DEFAULT;
 	debugfs_create_file("psp_rereg", 0200, ddir, ns, &nsim_psp_rereg_fops);
 	return 0;
 }
-- 
2.45.4


