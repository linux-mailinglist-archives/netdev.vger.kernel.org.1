Return-Path: <netdev+bounces-92649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F118B8306
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46785B23293
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2B01C0DC7;
	Tue, 30 Apr 2024 23:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/Dzie+5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8576917BB15
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714519990; cv=none; b=Pw+7Mu8Euoe63pK/eXoQd5UYPAZnzs4V3ujhBR9X4JC1NJXn4OjTROt3Vr9aESzjjdS3kdAE1AZgP5hJ99G2QmXgOuqxxMrzWkNK1eG6lDk8ESd6zFubxb0GhLi45hbBLrsP2B/bhMkQdCQnHLKhf73QthyHRrJkiN8LUbSUO0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714519990; c=relaxed/simple;
	bh=ZJw+SleRsqm02ztET2xIaJqcJ7Pgvg2rob3SXDtn/+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CGu/8A0EUOE05b5VgyaUJ8W6vdXWkCVZUPOTWpDOa+dJolVxlY7zDjOXaljF31Dcfv8Mn8Hvh/ylQtJCS8bOVtd8/PxbLEZn0LYt3GCzBkLd5K08B74NUnNWDt0NcEPQoVAh2uN9QG9Uq3GPkkFGHuKxuoIWVmVmxZx/XwB/Tf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/Dzie+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B54C2BBFC;
	Tue, 30 Apr 2024 23:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714519990;
	bh=ZJw+SleRsqm02ztET2xIaJqcJ7Pgvg2rob3SXDtn/+o=;
	h=From:To:Cc:Subject:Date:From;
	b=m/Dzie+537QxehKboYF0CwO1RIvUDvDOYCiC7QT/8N++vbnJeIkcAuprJWVLW2kCF
	 N8rc6q7TJACmt9mIqykstjkZqoEkMnpIjqwK4uBmxqC2RVRug78yOusgyzwn3DdkKQ
	 JkdbMSyE0E7GH3OZfdw7l1tu2/PR8JUY03vTJS6w7h5kGOcowAJ8yhPFT1RJDhr/1G
	 e0D3rRUHpOmJNYq0YCr3YOEISjOfXF2o2DFCQPRnwkPWxhyRqZRDaUJUpUXE6oj6Cm
	 nOy7LMbjF52VDoi3YYKgT9NQF1gsLufCnFHJ30+w9phcpvv/H3qc8h5cygRitG03yC
	 OZ++EKjidPtoA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	mkalderon@marvell.com,
	manishc@marvell.com,
	skalluru@marvell.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] MAINTAINERS: remove Ariel Elior
Date: Tue, 30 Apr 2024 16:33:05 -0700
Message-ID: <20240430233305.1356105-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aelior@marvell.com bounces, we haven't seen Ariel on lore
since March 2022.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 943921d642ad..c5e216e22766 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4199,7 +4199,6 @@ S:	Supported
 F:	drivers/scsi/bnx2i/
 
 BROADCOM BNX2X 10 GIGABIT ETHERNET DRIVER
-M:	Ariel Elior <aelior@marvell.com>
 M:	Sudarsana Kalluru <skalluru@marvell.com>
 M:	Manish Chopra <manishc@marvell.com>
 L:	netdev@vger.kernel.org
@@ -18035,7 +18034,6 @@ S:	Supported
 F:	drivers/scsi/qedi/
 
 QLOGIC QL4xxx ETHERNET DRIVER
-M:	Ariel Elior <aelior@marvell.com>
 M:	Manish Chopra <manishc@marvell.com>
 L:	netdev@vger.kernel.org
 S:	Supported
@@ -18045,7 +18043,6 @@ F:	include/linux/qed/
 
 QLOGIC QL4xxx RDMA DRIVER
 M:	Michal Kalderon <mkalderon@marvell.com>
-M:	Ariel Elior <aelior@marvell.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/hw/qedr/
-- 
2.44.0


