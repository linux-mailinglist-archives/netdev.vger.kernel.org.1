Return-Path: <netdev+bounces-62705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BB8828A3D
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 17:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF4128803B
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 16:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F91F3A8D5;
	Tue,  9 Jan 2024 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EC50edTb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063BD3A8CA
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 16:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F84C433B1;
	Tue,  9 Jan 2024 16:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704818724;
	bh=UALY/8U9M4ZX7fqMkazOyIQRULQ4mEfTqyNahWnOBzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EC50edTbP3mPlT32/N4ngFSsyMIKqzPdlfaZ22vF78PtacPty2mtBn8WOSzVKXGLs
	 H+m1yipauZB+y5YS1QbRXsJPQ189qyGe9PE3IrHOnn55iBoJhG5cosApnx2qX1zdd2
	 bxnQeZQb2GvV3lf5JnV7OQXs+F/VsS/O5zk969HF21PUTtCaFKzcIgj+XAqZx/By67
	 S+q9Wdw8dPdqJoR31yqK1qIpkIRMHv/N4k8nVaPY/3ArIWOHIXeDGSq02T0T5Qd/Ey
	 6gacAXfOd8EaTpTcXKrQ5EjaGhJBdNXA6ufU0ZvYf13AW/+qey9ySVbPfPsdzrYC02
	 Ogvjdm2KXKayQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH net 2/7] MAINTAINERS: eth: mt7530: move Landen Chao to CREDITS
Date: Tue,  9 Jan 2024 08:45:12 -0800
Message-ID: <20240109164517.3063131-3-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109164517.3063131-1-kuba@kernel.org>
References: <20240109164517.3063131-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

mt7530 is a pretty active driver and last we have heard
from Landen Chao on the list was March. There were total
of 4 message from them in the last 2.5 years.
I think it's time to move to CREDITS.

Subsystem MEDIATEK SWITCH DRIVER
  Changes 94 / 169 (55%)
  Last activity: 2023-10-11
  Arınç ÜNAL <arinc.unal@arinc9.com>:
    Author e94b590abfff 2023-08-19 00:00:00 12
    Tags e94b590abfff 2023-08-19 00:00:00 16
  Daniel Golle <daniel@makrotopia.org>:
    Author 91daa4f62ce8 2023-04-19 00:00:00 17
    Tags ac49b992578d 2023-10-11 00:00:00 20
  Landen Chao <Landen.Chao@mediatek.com>:
  DENG Qingfang <dqfext@gmail.com>:
    Author 342afce10d6f 2021-10-18 00:00:00 24
    Tags 342afce10d6f 2021-10-18 00:00:00 25
  Sean Wang <sean.wang@mediatek.com>:
    Tags c288575f7810 2020-09-14 00:00:00 5
  Top reviewers:
    [46]: f.fainelli@gmail.com
    [29]: andrew@lunn.ch
    [19]: olteanv@gmail.com
  INACTIVE MAINTAINER Landen Chao <Landen.Chao@mediatek.com>

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Arınç ÜNAL <arinc.unal@arinc9.com>
CC: Daniel Golle <daniel@makrotopia.org>
CC: Landen Chao <Landen.Chao@mediatek.com>
CC: DENG Qingfang <dqfext@gmail.com>
CC: Sean Wang <sean.wang@mediatek.com>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index a80bd154ae38..1c86d25dd131 100644
--- a/CREDITS
+++ b/CREDITS
@@ -678,6 +678,10 @@ D: Media subsystem (V4L/DVB) drivers and core
 D: EDAC drivers and EDAC 3.0 core rework
 S: Brazil
 
+N: Landen Chao
+E: Landen.Chao@mediatek.com
+D: MT7531 Ethernet switch support
+
 N: Raymond Chen
 E: raymondc@microsoft.com
 D: Author of Configure script
diff --git a/MAINTAINERS b/MAINTAINERS
index 737504c0c432..ee3fbf1723a6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13619,7 +13619,6 @@ F:	include/soc/mediatek/smi.h
 MEDIATEK SWITCH DRIVER
 M:	Arınç ÜNAL <arinc.unal@arinc9.com>
 M:	Daniel Golle <daniel@makrotopia.org>
-M:	Landen Chao <Landen.Chao@mediatek.com>
 M:	DENG Qingfang <dqfext@gmail.com>
 M:	Sean Wang <sean.wang@mediatek.com>
 L:	netdev@vger.kernel.org
-- 
2.43.0


