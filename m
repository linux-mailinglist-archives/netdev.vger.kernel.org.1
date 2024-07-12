Return-Path: <netdev+bounces-111148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB75930103
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 21:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C27AB22886
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 19:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9102B2E62C;
	Fri, 12 Jul 2024 19:39:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cloudsdale.the-delta.net.eu.org (cloudsdale.the-delta.net.eu.org [138.201.117.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA170347B4
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 19:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.117.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720813149; cv=none; b=EKvQrEkmtk5J24Z4QIuMKx1idAwlsQosJqSSqVCrG75IsMTPIumBettAw7EvEpwciLcid36YdWyytAKLV8v3KV1K2ueuf611iOvuTcSXeKdZcT1vXPDK8YoTshnAoPl0mDplhNt/Vz/4chedwDLm6eG/ZZBSHSrBFFRmW5oO2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720813149; c=relaxed/simple;
	bh=/dBCaLURWhpyD7gyix8erY0eaGdIjyIvFT3o+9Edet8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6hwTTp/qpYvchNJdfDfu4pAkB3Kv8lqIgONCfeuDq/AHMFlX8IOD37NxCgOTdouk4SUlbyjG8RcKBzoE2UAnfKG2d7IOqhZR3P+xh0eZmd/BffFnBo5jo7/ZyfFLACo0NxaYawtWPu6UNlNKQ4L5mh0GCnPgf0sxGP16fZ5uHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hacktivis.me; spf=pass smtp.mailfrom=hacktivis.me; arc=none smtp.client-ip=138.201.117.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hacktivis.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hacktivis.me
Received: 
	by cloudsdale.the-delta.net.eu.org (OpenSMTPD) with ESMTP id 0a910d95;
	Fri, 12 Jul 2024 19:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=hacktivis.me; h=from:to
	:cc:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=20240308_115322; bh=/dBCaLURWhpyD7
	gyix8erY0eaGdIjyIvFT3o+9Edet8=; b=WpjjcNSsCW6rVLn/1O5Auc2otoEDFw
	thrcdom6vDRSRvaEuQtpibu94dMopTmWuiSjfZjGFDzfD4KazF4QIU5WYRNNqRbH
	1JZHgyrfVzHFv8e+cSrmNno26oMI69Uhyh/mdhisIqcKvYRaOQje5FkRcc/qN8Ae
	UGVhIeY3BDfa7D+z2ARnFCCk+JRAFepS9gnwtSk1Xwp+XY4hbtpcXJIGqAtGv6oA
	52jnNidv782TkdK17fLq+Ic0+H7PQQFF9MzzHK4tS4rz/p/FYB/OU6c0D/BqLog/
	5rg6rpv4PMdjVDcjFaNACuRxjnfbZ+jr0JpQt5b5uYVWi0ExDp8esr9kvzN+9B16
	i9mLFyAQb3ATK8oay6U93O4fjwTjJNKBWSZBl5SchZjkANdpc5GXPb+kv3Znv+P0
	26ro4gWLG2VH6UGVdwZu9R1L91TEMGV0WoqUpCUhmp5ZFQiR8UQGlI1FWi8Xyg7V
	efMKVUi9kHj+wXxBis37FfDmLfxPvxHXKCwptDAptM165mliepDjzkl32URAwMb5
	vwucoFzfM9U9DzT9qGpuACMlaEIVxOv7cbyJDyLkcNZzYqKPM5lhjn4CM5baFHqz
	91CBPwetuKYTnJcOq7UWlKf6g7DYyULFK4poqX2fcKH17AkmJ/cp+B+vBIpTD1j6
	mYimIxnVSpyoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=hacktivis.me; h=from:to:cc
	:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; q=dns; s=20240308_115322; b=QHBM+7aj
	uoD46yPPPOLHEq7DZw/GeOfv8o+oIcEsweXAGV2PEVbBRSavXGfPkZA4EIXzPAHN
	aH/rQ44Jz+SbZwp3GHAT4SscdeELpkUanNa4jjJtJ5CayeX2zS8r3pKhWEbc8wHj
	1yP+1imx5wmyy023YmI2rVftb/eL6ej/93s1ICjcRpoP67/ps7g5h6CbLZGaRKlk
	nhyTuv53vV+5YVWb7seNuPNT+2Vey+uCPyvwAf44vdMCF3UEfEcoc+5N3UL5jknZ
	mk3QnGPvbq+QCrpancVNIsMRehNlJOb3bF/MiqzrwKvQfAUEEaWmkGGlJIvYsrpZ
	QHnuM1Xa9n5zph3kTtlWl0jFdJ3JAOdXH7JenoQ6AbDlAfmAOE1vdLLShwYDGTWV
	fuUGHSVbvqXSL2DbqWWOTQb1nlcXGEoUj9KjuwntblNpyIGP5x65VesGheLRYoQd
	Xo3G1Du9H0iuZWZSDYzsj684miRw0P8NI9qsQDntSv3TpcEDV3jiFHrl3engpumP
	yPAFDHgqQP0AHPi4pFvQQhWUvegnbAvErnPIyHCvjixuIhFcQ1jkiH2LZdnNhuAr
	N/z7v08ew7bLONvUmdKq9Qs4BefwpBFwPnb8fh/281uQlig67r+YFRJ5bRIlbPTK
	1q4qe6udgv9R2g0u+Rwm0qlCT/J4/SBs4s4=
Received: from localhost (cloudsdale.the-delta.net.eu.org [local])
	by cloudsdale.the-delta.net.eu.org (OpenSMTPD) with ESMTPA id be45d66c;
	Fri, 12 Jul 2024 19:12:12 +0000 (UTC)
From: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
To: netdev@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
Subject: [PATCH 2/2] arpd.c: Use names for struct msghdr initialisation
Date: Fri, 12 Jul 2024 21:12:09 +0200
Message-ID: <20240712191209.31324-2-contact@hacktivis.me>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240712191209.31324-1-contact@hacktivis.me>
References: <20240712191209.31324-1-contact@hacktivis.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following compiler error which is due to padding elements
being present in musl (1.2.5), thankfully the struct element names
are part of POSIX.

arpd.c:442:3: error: incompatible pointer to integer conversion initializing 'int' with an expression of type 'void *' [-Wint-conversion]
  442 |                 NULL,   0,
      |                 ^~~~

Signed-off-by: Haelwenn (lanodan) Monnier <contact@hacktivis.me>
---
 misc/arpd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/misc/arpd.c b/misc/arpd.c
index 3185620..724d387 100644
--- a/misc/arpd.c
+++ b/misc/arpd.c
@@ -437,10 +437,13 @@ static void get_kern_msg(void)
 	struct iovec iov;
 	char   buf[8192];
 	struct msghdr msg = {
-		(void *)&nladdr, sizeof(nladdr),
-		&iov,	1,
-		NULL,	0,
-		0
+		.msg_name = (void *)&nladdr,
+		.msg_namelen = sizeof(nladdr),
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = NULL,
+		.msg_controllen = 0,
+		.msg_flags = 0
 	};
 
 	iov.iov_base = buf;
-- 
2.44.2


