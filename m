Return-Path: <netdev+bounces-149989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E839E8674
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 17:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2948162FD3
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 16:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9647516EB7C;
	Sun,  8 Dec 2024 16:31:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from iodev.co.uk (iodev.co.uk [46.30.189.100])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8055516DEB5
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.189.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675519; cv=none; b=AQ6nEnHeMFVnBe9WiE02GegPFM6KjdTME7iHHNdcBJ402fNqAFMdmG/lhLur6J/EymVyHrjDMBcLB50ztF3e9jOS8Cd+AJZCIxXeiGMLuD/UFN+/9QQNf1sxXHqCg2EnNOKZRqu8rDSmrhjVUFYjXj8c3tECGdjGMSfJ0K9xqw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675519; c=relaxed/simple;
	bh=FP+WbkXC1KC2eZqztfsV4VD+7glZ/Dd4cjcI8xun6C8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eTskdwoVuQE/mLyF1MvXUWm0HK6YJT5eLAdjLXTryhEEdKRbVf+xoY4g/fEIe33DfH8Eyd8hpFfgG9OdByqQZsDbat4HdBedut3Wk9aspPLkSYMZiewnQyApFTMYaaBN24CMzp/i5dXe1WJba/LrGnH98avnrP6vJYSK5DRkmRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iodev.co.uk; spf=pass smtp.mailfrom=iodev.co.uk; arc=none smtp.client-ip=46.30.189.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iodev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iodev.co.uk
Received: from localhost (unknown [83.50.135.165])
	by iodev.co.uk (Postfix) with ESMTPSA id 8A56738E0D4;
	Sun, 08 Dec 2024 17:22:45 +0100 (CET)
From: Ismael Luceno <ismael@iodev.co.uk>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Ismael Luceno <ismael@iodev.co.uk>
Subject: [PATCH] ip link: Include limits.h for PATH_MAX
Date: Sun,  8 Dec 2024 17:22:38 +0100
Message-ID: <20241208162238.31832-2-ismael@iodev.co.uk>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
---
 ip/iplink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ip/iplink.c b/ip/iplink.c
index aa2332fccfa3..fbaa8c2b7500 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -22,6 +22,7 @@
 #include <sys/ioctl.h>
 #include <stdbool.h>
 #include <linux/mpls.h>
+#include <limits.h>
 
 #include "rt_names.h"
 #include "utils.h"
-- 
2.46.0


