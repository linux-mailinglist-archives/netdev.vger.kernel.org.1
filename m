Return-Path: <netdev+bounces-283914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDiLOHm6+Gnh0AIAu9opvQ
	(envelope-from <netdev+bounces-283914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:25:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 049CA4C0A64
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 17:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0FBE3013ABA
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 15:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AA73D6CA4;
	Mon,  4 May 2026 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="Rsj/NsQW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3A53D8114
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907533; cv=none; b=C5Wc2sChy4wnprw5YVt97EUL43qRriyeTsPbEoCFJ611UzoWnpWDPyGZzzdoZucNdHB+wBh0mXsUyCJD/46Gkp4M03OczotH+TCpjULT8b+qd84ZFEOgv1erKzjhpkK55dGKk9qFjQGXS6fc6h1PdCzjdNysuZ19vsnD8yWR2j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907533; c=relaxed/simple;
	bh=GQicZ6yZ62pnjzm570OJWX3OWvGBTqzTvY8wkRH2lU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fQEMtpxuOsqf9Yk7kiAzrFLQyLH4YOJttojX8vlDLx0fV5O4vL+ILqom/THChMw4KNissypx35stfVTkeF98Dd6trjSIMX7d/9xvxbJF6sVvSp43Ll1xjishAiDTzqcxP8AzSIqcmHaFamebQeduHQLRqfNOpwrk5zDv6BOZOfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=Rsj/NsQW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48909558b3aso45322465e9.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777907530; x=1778512330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uzs0BkQvCPRt6F84mKmO5B0KxLBnGhAmM0EUe+fHF5E=;
        b=Rsj/NsQWNh7EUHLGQBgKqQLrtQlLQKTPpi9D4Ht0Zmt8775+vF8g+f4eSHBwW08P14
         cHemegHuVzExY634yu8nLnoOPdCqDZOEcnSmWzX7fRIGx2tiNXmrIry9dDsFZuSPXNd7
         rYtZj0im/zyB4rER9yWa3leENcTqNGmRNimPDJpCgFpxLlyEbWqp3YIua7SlfWZ7b2dQ
         bZhXXQZ+3vHcXxqdBeQaN4o8pSENVFB8/fOkjs/ZD/eT2itNX1TJT5iSJpH2OCP9nxal
         R0IehhQZyv5NgO7XVjs6CcSRoAd3idAWA2lQa0t3S9qcoA0yavD4Hi5TN+LBA88HcdJ/
         zxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777907530; x=1778512330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uzs0BkQvCPRt6F84mKmO5B0KxLBnGhAmM0EUe+fHF5E=;
        b=W9BLe4kolE/j9xSLA0SPFWAkMBMVJHmln9yvleGup+/9KDNwVotX8ib/JSp9sJGLCW
         N6oOpq1fYR+Jr1iz70Bhj2Gm1uW/Lb/YoYpkK+Cjw6JhR+Yqk8DJXuzzzqgbRF1Kamtj
         K8Y4XtCp3M7etNKd8Z+0Setv9TRtKZcgYN1LNqBp4DEb/h7TzG11m6FWcQrqNMvvXTwt
         PfgFshm+DBbCMmYQpbQDx8JvUpr7VvHU4mjYolIfhtqOMucr4NreOySQ5JByirGv3Hgx
         XplZXEcPjRjL8baypnIlmfz1z5prPMyFSu5svRI68JMezQ8NWZ3Mto/8zRal1Ebjr0xL
         1Y2A==
X-Forwarded-Encrypted: i=1; AFNElJ8M623vCWA3vyNj/5mkPYI6NSk7+OHSO2ofUeAla+QONUdz+9xlLy3n6qqs9nEh+m0k+E5VMkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc9AZS/KgpdR4YVRhmHUcIZYt3pz7x5Va8o4pyiUuSUZiRTOcv
	fF5/+3wsXgh8A/XZqVoT9B6Th0DX4zUB/39JAQdY0mKi1QyVYqKMQ0fkBU9sH1c0BOw=
X-Gm-Gg: AeBDieslznkbQMTKxtM/6/JFqKg8DYIlsc1NsrA0T40Y8u8YQ9aBsyJyMjuVNr2g4sG
	2zV4Iue7m5rZICw34GythtyZ+oF1GiZwDMyppVxTkLeqX+BjonHFTh5HNWimUq5R3iRuJ7ioj0Z
	XY+ORgqhD5CA4tGqE+gwetcnbRMIhW1ExpKQNw2pxSAQ2SExZEulLcalKTCav95SYwtaSw9rV+j
	0JPfOD6GWjADk4UzCGxECQ84sIXe7JYnOop35gOdYSFelQOjPqOdoDezNxDjzcRsULABJUul6sz
	ssOd6Qre32T72yT5bzfEwM02p8Z4oWbSyQFweY86Xp8YLWg1uOuWCAhR1zv8CYR6l+QjpiX4UTU
	a2HH3ojvF9WspCU0ifOtAtQtXd1Fee5yhcTJtFLMcSWkcsaJ7raevWXVnOQD3d9V+CIHNVTl8rt
	tNGhFPu3Mxt32bOYfA0Kjn0+ArU18eCa0aZZmkSeJ/2TJYXPE1c2U5frG5R7kMMcGWCyB4I1fuN
	hSQmBIggL1Qq/8VExJ69yg5DRrYJ2zCZSsu
X-Received: by 2002:a05:600c:6091:b0:489:19e9:b139 with SMTP id 5b1f17b1804b1-48a9852e435mr181848855e9.1.1777907530015;
        Mon, 04 May 2026 08:12:10 -0700 (PDT)
Received: from localhost (p200300f65f114e08197264a4bf9e813f.dip0.t-ipconnect.de. [2003:f6:5f11:4e08:1972:64a4:bf9e:813f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a8fea68b4sm82719845e9.9.2026.05.04.08.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 08:12:09 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Chas Williams <3chas3@gmail.com>
Cc: linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH net-next] atm: solos-pci: Simplify initialisation of pci_device_id array
Date: Mon,  4 May 2026 17:12:01 +0200
Message-ID: <20260504151202.2139919-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=GQicZ6yZ62pnjzm570OJWX3OWvGBTqzTvY8wkRH2lU4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBp+LdC3j2lx1QGDBvEo78HvoMI7VnkL0aG6eqtI 9jmw243xYiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCafi3QgAKCRCPgPtYfRL+ Tn/AB/9FCiYRSl7IgTxm9OSuFymEf9XBT0iAz42pGxBxUkQJRucXSXEadwf8gkQc+hxsHdHe6vG gAjirh9WW1boJVxULyzIbWvPT3cy/bDQfJoAUZ6nPpnI/WJ00zoHIkGmHtKspqObZREIEGHxRjk gUMhW0mZs9MMgcuAq4r5DSbmepqE99T5tOrOLlwumRTel+Hn5amLKzaX7niMdmjw4b7whp7qtvC PEYeoKXhjCGWePDUB9cvtFcUVS2jJfPCEuNsgHaaU/TrshN6LXH6Hr6oZNxEU98D2odIXvp/Wpp 4ZZj6S9iHOqpLux6CJE2ZoeLbfz6DXfqp5ibCTBRMKIkAyfK
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 049CA4C0A64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283914-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:mid,baylibre.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,baylibre-com.20251104.gappssmtp.com:dkim]

Use the convenience macro PCI_DEVICE to initialize .vendor, .device,
.subvendor and .subdevice. Drop explicit zeros that the compiler also
fills in.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

The secret plan is to make struct pci_device_id::driver_data an
anonymous union (similar to
https://lore.kernel.org/all/cover.1776579304.git.u.kleine-koenig@baylibre.com/)
and that requires named initializers. But IMHO it's also a nice cleanup
on its own.

The anonymous union will allow changes like the following:

-       { PCI_DEVICE(0x8086, 0x8108), .driver_data = (long) &psb_chip_ops },
+       { PCI_DEVICE(0x8086, 0x8108), .driver_data_ptr = &psb_chip_ops },

(together with the respective change in the code when the value is
used). This gets rid of a bunch of casts and thus slightly improves
type safety. But that doesn't affect drivers/atm as here no pointers
are used as driver data. Still this driver needs adaption to work with
the changed definition of pci_device_id.

Best regards
Uwe

 drivers/atm/solos-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index 24c764664c24..bcb1353877e4 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -1464,8 +1464,8 @@ static void fpga_remove(struct pci_dev *dev)
 }
 
 static const struct pci_device_id fpga_pci_tbl[] = {
-	{ 0x10ee, 0x0300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ 0, }
+	{ PCI_DEVICE(0x10ee, 0x0300) },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pci,fpga_pci_tbl);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3


