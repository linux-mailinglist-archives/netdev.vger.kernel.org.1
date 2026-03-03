Return-Path: <netdev+bounces-263316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMGzIx4Op2k0cwAAu9opvQ
	(envelope-from <netdev+bounces-263316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:36:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A2E1F3E6E
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2486A312F08A
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825344EA392;
	Tue,  3 Mar 2026 16:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="au7R0NoP"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D092B4DC543
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555450; cv=none; b=JD40FhEX3bahgMP2ylGBF7vc+PftDr08U722GKy3ofWPZibFf/x+bjCfAgR8K2VxWrpMDpVGY2ZTBS5yaRMj2JQSLKPEpe+NBrWS0jA8DiorZ9K9C6htHkFyd1dpYu8EMYX3F9Tbiqv/mNAc2TP2zWE/I1WoBRJX1tB46XTygoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555450; c=relaxed/simple;
	bh=tk0F06+G3SMB4MndmdYG1hQ+EB6y5972Bmz8iixfNm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QZCRkgQ0oF9S2C8B+U0u3/zzk59h9zTA8oe3sk3gYs+IQ0tPldPhLGcD4OfCdsSvIsrgGQyH/XpnWQPXVDSG/umIUcc+lIFlRWMBOizOgzHXx2LYbelOBqOG541S79yab/8GKMbnyLgRgBY7LkQY5DVHojGf0szYzc/ezYESZkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=au7R0NoP; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 55456d41-171e-11f1-8a98-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 55456d41-171e-11f1-8a98-005056ab378f;
	Tue, 03 Mar 2026 17:30:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=XwJDfxGWlq3ZTniUhfbmjJGj51XeuY1/TTBY4ewaFoA=;
	b=au7R0NoPZRXJNBKdSUoYfUY6oNxoGeQGYyffj2KiibJsbcsVyT8+zOiPZ7VGgIXzz03My9e7a9/TR
	 2JirHkmyTyLoa5dGZmRYIoXurZxLmQZHCuzb+sux/xQjNbnT1aU3m01weJ1wIXhnaBBZBlwOV6sezc
	 4Yed6o+arV0/wFWi6Br+CaUrSPtVqeZHgQrg6hM0pCVKI2H33fBZMKHH4Z17a9yNmLoSV77OWoIBc7
	 qLaXzEffmaVa9sew9ej+4ScfCzCzt3//RRJ+fuuS2mNdOCJhjrJrRN3sUrtpHoeaPTGWLPQk9QcGPM
	 Bs0LwjGRXYsVrkueDQ6sK9K8FUJdT5Q==
X-KPN-MID: 33|mvIixtBds2uMUY3QiNec81tUBW2l62b8xSp5MLadHxr3D6lVYZUuu384c7pb3jo
 mVw4jhYqGYMuBHq7KFNulOyxrJQpRKH8CzRdKycfkvzs=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|UlV0hp9ti6jp85BTlRjndd8tZt3498MHJr/jTrGhPIqJQqa8kTmLc9ht+osZDzJ
 vWAKhPtTH3+4az/7z9y+rbg==
Received: from daedalus.home (unknown [178.230.196.166])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 51c28fbc-171e-11f1-bdab-005056ab1411;
	Tue, 03 Mar 2026 17:30:47 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org (open list:DIBS (DIRECT INTERNAL BUFFER SHARING)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] dibs: change dibs_class to a const struct
Date: Tue,  3 Mar 2026 17:31:04 +0100
Message-ID: <20260303163104.3749311-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 38A2E1F3E6E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[xs4all.nl,linuxfoundation.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263316-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xs4all.nl:dkim,xs4all.nl:email,xs4all.nl:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email]
X-Rspamd-Action: no action

The class_create() call has been deprecated in favor of class_register()
as the driver core now allows for a struct class to be in read-only
memory. Change dibs_class to be a const struct class and drop the
class_create() call.

Link: https://lore.kernel.org/all/2023040244-duffel-pushpin-f738@gregkh/

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/dibs/dibs_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
index f1816361b74d..14c3e2d84902 100644
--- a/drivers/dibs/dibs_main.c
+++ b/drivers/dibs/dibs_main.c
@@ -19,7 +19,9 @@
 MODULE_DESCRIPTION("Direct Internal Buffer Sharing class");
 MODULE_LICENSE("GPL");
 
-static struct class *dibs_class;
+static const struct class dibs_class = {
+	.name		= "dibs",
+};
 
 /* use an array rather a list for fast mapping: */
 static struct dibs_client *clients[MAX_DIBS_CLIENTS];
@@ -137,7 +139,7 @@ struct dibs_dev *dibs_dev_alloc(void)
 	if (!dibs)
 		return dibs;
 	dibs->dev.release = dibs_dev_release;
-	dibs->dev.class = dibs_class;
+	dibs->dev.class = &dibs_class;
 	device_initialize(&dibs->dev);
 
 	return dibs;
@@ -253,9 +255,9 @@ static int __init dibs_init(void)
 {
 	int rc;
 
-	dibs_class = class_create("dibs");
-	if (IS_ERR(dibs_class))
-		return PTR_ERR(dibs_class);
+	rc = class_register(&dibs_class);
+	if (rc)
+		return rc;
 
 	rc = dibs_loopback_init();
 	if (rc)
@@ -267,7 +269,7 @@ static int __init dibs_init(void)
 static void __exit dibs_exit(void)
 {
 	dibs_loopback_exit();
-	class_destroy(dibs_class);
+	class_unregister(&dibs_class);
 }
 
 subsys_initcall(dibs_init);

base-commit: d466c332e106fe666d1e2f5a24d08e308bebbfa1
-- 
2.53.0


