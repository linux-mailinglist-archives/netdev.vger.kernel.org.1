Return-Path: <netdev+bounces-111147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE9A930102
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 21:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26E152842D0
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 19:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91279208CA;
	Fri, 12 Jul 2024 19:39:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cloudsdale.the-delta.net.eu.org (cloudsdale.the-delta.net.eu.org [138.201.117.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4531B95B
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.201.117.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720813144; cv=none; b=JaRudqt8qBWcZ6GHBgmhNGcHvVt3SUn/9J+j3HKmeKjri3z884rnNddisYx9GPutApeqnNC3tr7h2hAkGmz19SEHCw8DaXlBQpuNCOL6bjzEuHiohUj9lyA95WfAoQ41Avm6Qgn/BvfhRGbT1ifL2PjjCYsza9LlVDcQ097CqUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720813144; c=relaxed/simple;
	bh=r4hqy74kp2e4+7UFw68jP6uRypswdxwFInMIMpWxXWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rEyzgQFr3EK5w0QDHISO+QYq1Kwmd8+oYD1vGWwpCBYrB4OcpI5qPEGvEfSUUrVViJUBueyus6NeNN5kcUCFPcHqeGrf3SPPvtccO3kYHI81982rgUtnAXSUj3JBCDbm/hmXGhlbG/QxGEmUd3tkk40F+fAR/hs3kJo4nXzvglA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hacktivis.me; spf=pass smtp.mailfrom=hacktivis.me; arc=none smtp.client-ip=138.201.117.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hacktivis.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hacktivis.me
Received: 
	by cloudsdale.the-delta.net.eu.org (OpenSMTPD) with ESMTP id 2f67be6e;
	Fri, 12 Jul 2024 19:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=hacktivis.me; h=from:to
	:cc:date:message-id:mime-version:content-transfer-encoding; s=
	20240308_115322; bh=r4hqy74kp2e4+7UFw68jP6uRypswdxwFInMIMpWxXWQ=; b=
	Y6LTlV81JXnRG23xnYKKjgCsrykv7VcGO9uaoxTI5XsGTHde7UdLo0X4uivb28HN
	dO4dJysmCqehSCT76rj97WI3Qnf6wOSatPeXVvxKc/KMU2UGMqwyTTsHTbilyqDB
	J5VsigwO6XUfUNOQ2qKkp5mH+Uv6Zg18lplle2mo1MhGCeqOWmnvXd38lPCyjSqL
	Ryf4/DeFeQ9n1RKsuApw2XkFgxcKtSyX0ZNUqn1lwwBCqV7Eh5yV52NxMeuTv4yc
	bYM9ljo/ltzmHuBDayUyc/uZ5IOFTumdPGPUGjXS6nYgpBuYjpiuAaOgiLy6ciSw
	9UfuctH0c+Jz3bUHyUG3WfjTl0JRO+LW+b5Irqe5+8cIFuAZVBC4CFblgD9ft5sw
	m35hI+oG45kfayQToVYfCFQ0xu/0BGnU5MYj0Gr1frZb0kqvuTIuS18o7KJFO8zZ
	gSGPmdWuNRqe0iVhfB5CVe3u7nyRrqsADEx98sf0FtFg6iBW/65xktRw6fsxHwnL
	+dhUTRpHyxjYleTWwdf4rhfIiVuYnzAK4YoQiakW00HmmivNZX9+csqjtfJTn696
	c0+ys1Haar1OR4k1OOeR8ueQJBP/2j0NlLJJoPH6AlgX/weMIfNpBQ1kaQDV5FWo
	EpvgvzO78K4WP89hZgySQmAApzioOILwC/aToBRjKik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=hacktivis.me; h=from:to:cc
	:date:message-id:mime-version:content-transfer-encoding; q=dns;
	 s=20240308_115322; b=q2bWo+W+fc/ER2PodBo7yk5oz9+orsmmGCqWgpUeJg
	XxiND/vikIPgrsT4D4RHWceUxzq/jxVmmv4abV0ZUMNr+ONiqW3NhI0O1CGhTKZw
	rdDFeQ7SZbPCbbTfSlCVAsFy+ltuWaFqIP4AOIRfUtkwySx5gx0bChaAtWIB7seB
	i+Qiq0vvM3LKJ41u0kukYCy0WP/lzPW8T2VPtj1ZAP/XdGFMV0Cio3Pmjs19ySYK
	u78PhrGWcsyPS0U6b5b3MVwOC9ITBQNuj8zzTvAeGjAt3sK4Bu4JME3UY2Yllcmq
	QrVHxZdpzKuz81dMm/TxOChK4v1QORHQ0tQ+oZUWNL3Njtsjos/0mh2dQQDfmtHi
	+uDgpNe5t+HqX+b2cg1XvfPTY5md8bNSIzJZvC4eCoMMU2ADDSYoXag1OZXgGJiZ
	fWFqsi4NFNGEZFueaHVQFxSFObYmqsXj+DRTEF49jTGQY6MS1Y9fvwTU2h8zrXy1
	fE225M65awL+gowtMNJUIDs32NPSd1tRKLW6l5wrxrG2Fg2Avn7+QFjV8vkcAyb/
	StHsd6QHXj7LoJZuvwr78lhV/oSA2QjaOsJDsl+8OSoAvDrHC4j9/tZfTE9DanwO
	xW/VW8pVS/3/pZ6UfRGKs/NTopn1u99j+wujbd/AZhj0LLD8p7MmUmprTD72So33
	o=
Received: from localhost (cloudsdale.the-delta.net.eu.org [local])
	by cloudsdale.the-delta.net.eu.org (OpenSMTPD) with ESMTPA id b2b745b0;
	Fri, 12 Jul 2024 19:12:11 +0000 (UTC)
From: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
To: netdev@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>
Subject: [PATCH 1/2] libnetlink.h: Add <endian.h> for htobe64
Date: Fri, 12 Jul 2024 21:12:08 +0200
Message-ID: <20240712191209.31324-1-contact@hacktivis.me>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Required to build on musl (1.2.5)

Signed-off-by: Haelwenn (lanodan) Monnier <contact@hacktivis.me>
---
 include/libnetlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/libnetlink.h b/include/libnetlink.h
index 30f0c2d..2b207e8 100644
--- a/include/libnetlink.h
+++ b/include/libnetlink.h
@@ -3,6 +3,7 @@
 #define __LIBNETLINK_H__ 1
 
 #include <stdio.h>
+#include <endian.h>
 #include <string.h>
 #include <asm/types.h>
 #include <linux/netlink.h>
-- 
2.44.2


