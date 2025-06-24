Return-Path: <netdev+bounces-200645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0097CAE6714
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 15:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F853A75F6
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 13:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BD3299A85;
	Tue, 24 Jun 2025 13:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwtN/2eW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A87D23E336;
	Tue, 24 Jun 2025 13:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773058; cv=none; b=rttg3ztKm4bMfoUbIPanbYC8Kn+l06WLjk94zTcWhl8jUC78s9J3KxdHrVqF0HqXBLh5CfK3BiMuTSN3HNCWJ+tk8VKhZPuoeIZ2T5a/zZ5FDlROhMVlW+3K8BqSeWiVDJ4HevZE2ll96suX6LxPiIjye1KDu6vP1PVgKgwtmkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773058; c=relaxed/simple;
	bh=0u8rfWjQgNMd3JSn2W3AZTA1DNb5PlWDUIQ/f/uQPQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Vvj3NSW8xw0Lmfqpo+pBilf9VTOfp7AdAAs8KmXckEE45PlvPvZ4VvrfqL4fuRYqCOmhrbpvDclYhurFwSHPLqV+3kbwQBRsFeTy7iS6SIGwI95qI+ZJZwUis5NbdQf5gRTDligyjICbxPq+sdsUR+pVlH4zN0A9TpTlWfspavU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwtN/2eW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD9B4C4CEE3;
	Tue, 24 Jun 2025 13:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750773056;
	bh=0u8rfWjQgNMd3JSn2W3AZTA1DNb5PlWDUIQ/f/uQPQU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=KwtN/2eWAgx7EDn19yJiPPcCpd2+xiWhCVq4w8a7Ho4oIsFVbikMF51qaMs9CDdqi
	 4+w8sSP85tPnDxSVCr9RptU7wMy/Nqqrxh9xRXObIerRSiIf/NAMuHmR3TONMZSh8q
	 EwDGs60Tlq0wXn63Syd4IzqQKi+TklyuTp4LxgS0yn50cRy3v0jKlSYqShT0GD03EN
	 i1qEySVm7QEJhZci+1TKWb+2eOHIHxgtz2xD4dJwHudpNhQEoH0pj3fJV06mVKMShR
	 p90YT5tEbbNJehkGVf/BoKrqvxCYEh2YJ+SjTQcB9v00T799eBPzBaGIMkO0iFo+dh
	 jbjRrttE+nInQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AE0C71157;
	Tue, 24 Jun 2025 13:50:56 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 24 Jun 2025 08:50:44 -0500
Subject: [PATCH] lib: packing: Include necessary headers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-packing-includes-v1-1-c23c81fab508@amd.com>
X-B4-Tracking: v=1; b=H4sIADOtWmgC/x3MQQqAIBBA0avIrBNKNKKrRItyxhoKE6UIxLsnL
 d/i/wyJIlOCUWSI9HDiy1d0jQC7L34jyVgNqlWm7ZWWYbEH+02yt+eNlKRBo/XakcOhh5qFSI7
 ffznNpXwe61EOYgAAAA==
X-Change-ID: 20250624-packing-includes-5d544b1efd86
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750773056; l=1124;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=1ATmUuW12KVE9D3wPQ8yQHOTVuSIERg6h39NE9Fw3aU=;
 b=MCdarkHUxzygavkxODWUEUPh919s6qS4cud9Js0mf9mhf3nB8iySPhbIPLiptdn8Dt04gpKzc
 dds3LJ/Fj87BQiwrZReydyBFp7UXuZfCALw1r2AnszssNfMKYt3rtU3
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

packing.h uses ARRAY_SIZE(), BUILD_BUG_ON_MSG(), min(), max(), and
sizeof_field() without including the headers where they are defined,
potentially causing build failures.

Fix this in packing.h and sort the result.

Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 include/linux/packing.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/packing.h b/include/linux/packing.h
index 0589d70bbe0434c418f41b842f92b3300a107762..20ae4d452c7bb4069eb625ba332d617c2a840193 100644
--- a/include/linux/packing.h
+++ b/include/linux/packing.h
@@ -5,8 +5,12 @@
 #ifndef _LINUX_PACKING_H
 #define _LINUX_PACKING_H
 
-#include <linux/types.h>
+#include <linux/array_size.h>
 #include <linux/bitops.h>
+#include <linux/build_bug.h>
+#include <linux/minmax.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
 
 #define GEN_PACKED_FIELD_STRUCT(__type) \
 	struct packed_field_ ## __type { \

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250624-packing-includes-5d544b1efd86

Best regards,
-- 
Nathan Lynch <nathan.lynch@amd.com>



