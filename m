Return-Path: <netdev+bounces-262737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEK8JnXApWknFgAAu9opvQ
	(envelope-from <netdev+bounces-262737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:53:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF921DD475
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4E5E330B7AA0
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 16:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E723E9F7B;
	Mon,  2 Mar 2026 16:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="tqiC1kBA"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3E330B53E
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 16:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469108; cv=none; b=qxFtmDwu+ZxD3i9G5qaSxcupBnRFR9VN1fgQVepNx4hNh6v0tBYyPH+abW4egkgyPRAoDY7MfSY7WuLYd5ASqS5uIFf8WoExh4qCjvuVxmcH3MtQxfIvRA+Xju9l6xPZPRJ7F4eI/IxQ7uUjJ8dvvPo0wFZOzb5Anpi8vD7Qbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469108; c=relaxed/simple;
	bh=P4rOubtCaGZlgRSb8+3lpXYms/AYdxc//yZt17X5Zew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YAhsXIXLMbTcNeSzWf9YPg4M9CazTun6PmRWYr5cmZVOaX8aivrn6oV5nLbQrZm0Airtr0Khp5gW7EzWJ+csyYK3UWx1OSowyelni1xqX0XmZx1+1RqlLPfmo+NIrPv+XQJ0woZXHtGxM05fIubCuNXUhvtb4AOoK8W4R+BQ7qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=tqiC1kBA; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 4c42a8a9-1655-11f1-89dd-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4c42a8a9-1655-11f1-89dd-00505699b430;
	Mon, 02 Mar 2026 17:31:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=uv4xJca8PPZf+nyfQ5HaQjGv+TxEb27Mz7Q/HmxfOFI=;
	b=tqiC1kBAfG8krb4AKKmcUt+1/nCp4mj6xs3ZzzOfjPmiGLqTjXN+oAgSk1lMtt98nUAdnB88BZmjV
	 2T7oq73tVK5RWqy3atpg/DqRgr/BtVU32iOlzvAg7AguHxFjHgoV5iQ8LBN0WuNfle5hyPGVZZjWbI
	 TsBjcMSDa+S7gMKFrdsze1XirGRRnm3I+I72r6bpkHP1eTm4RrmC0w8TWqhiwI03QmMs9XJ4qXsFav
	 nMlOtK/kycQF4xZN2jBfdS/TqebjRsVknHkbhdKahx5k1F6RZ4GEW5pRTE4JInGuXBbYZ8rIlm8QdE
	 38dYBzyYOWemmf1albfIHTr0W0kqjOw==
X-KPN-MID: 33|pKzzVQRx4+6a5NpdfrCkcE7M1dUWULlBXHVHFmQuAGr5EnBj25ZLemq5XL4iKhm
 oOu5sq29NHyvG1xoyzJQcTh74kn6/8B69o1VIYJvONj0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Sn94fXtjpjv2SU2SXg5YQYK4FCDDsgd+G5iqO9W0UZCpGOLgtqupMFnzdedrZh5
 naVxryKMaeEcQy1muhY6BCw==
Received: from daedalus.home (unknown [178.225.116.246])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 488ee769-1655-11f1-8d40-00505699b758;
	Mon, 02 Mar 2026 17:31:43 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org (open list:DIBS (DIRECT INTERNAL BUFFER SHARING)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dibs: change dibs_class to a const struct
Date: Mon,  2 Mar 2026 17:31:03 +0100
Message-ID: <20260302163103.3324304-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9DF921DD475
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[xs4all.nl,linuxfoundation.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262737-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,xs4all.nl:dkim,xs4all.nl:email,xs4all.nl:mid,linuxfoundation.org:email]
X-Rspamd-Action: no action

The class_create() call has been deprecated in favor of class_register()
as the driver core now allows for a struct class to be in read-only
memory. Change dibs_class to be a const struct class and drop the
class_create() call.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
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


