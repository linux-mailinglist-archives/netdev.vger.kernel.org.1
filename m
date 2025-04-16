Return-Path: <netdev+bounces-183517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1C2A90E73
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 00:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D6B3A878F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B551323E337;
	Wed, 16 Apr 2025 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyrZe/5y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CF014B950;
	Wed, 16 Apr 2025 22:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744841433; cv=none; b=XPclIf44Z9uR+7ZJAj9xjmJhIcLH2SGeYn4XXb2n6OW8lN+zSdON4sjLH+4mGCfYL9stPQnoKyPtEArGTpuKSXgEXJb3mWhsnN1wsOJXoBisRe370v/GZjmQKXftYJbTClnj8uGXEG6StvUIccJmWoeQboIqYysbq+v6EHBfb98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744841433; c=relaxed/simple;
	bh=Y5AU4mf8TUi/WGax8QOVgpoVXa9qANocM2ytobVxq90=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jHXqmVlDToY8iqwW4mRpc6NJD8KqT892nP+k5BKBBqMM0nswXurUmWczsShP4RB5wlirJ2/mEYyZki15ZJ9Siwe0disyO5iYuk80B3BirhrP7VZHx3LjU3YL7OZ7scrFFYVckigbHMTleCnLyix+EL4BaJTklheS0werNMHwXMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyrZe/5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50179C4CEE2;
	Wed, 16 Apr 2025 22:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744841433;
	bh=Y5AU4mf8TUi/WGax8QOVgpoVXa9qANocM2ytobVxq90=;
	h=From:To:Cc:Subject:Date:From;
	b=SyrZe/5yZ9BYxUqVV0dSXe8nmVrIxdksnf4SVPWdNkcNrk35XnLSv4KQqHp+yyBwq
	 CD7wLEFBuTPUo9wq294Dzl6wF/jQ2nFyawCY1TZo2KWpR+evktMnh8BO5/497Or0eB
	 uMO7izgT+pNbjVqVQAKKdgdAebCnD6o1DzCjb5KCfiJASuMpYkUzco+G1DVXMbPl9M
	 fMU5VUkgcYqkyu8TBNl8GHHrDdQEt79KXu7UpfD1E5ZAPzjZIpTQ3wd6rmtu2EWtbx
	 OiSGTSPx/1MPZgaiGbCwqdydAwz5NPzsEdUl2tDDLPN7z0VFMenSWXEYEWiJoNNAsj
	 JgNUXMT6sOpBw==
From: Kees Cook <kees@kernel.org>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>
Cc: Kees Cook <kees@kernel.org>,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] emulex/benet: Annotate flash_cookie as nonstring
Date: Wed, 16 Apr 2025 15:10:29 -0700
Message-Id: <20250416221028.work.967-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2658; i=kees@kernel.org; h=from:subject:message-id; bh=Y5AU4mf8TUi/WGax8QOVgpoVXa9qANocM2ytobVxq90=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkMWlc37BIsktx2QbF9tv++hYmVIf9ea5rb9LydEHpt7 qPXJxtOdJSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAExEVIaR4UJWQpnYoX6jzvS7 154dn9LGKjFzzZonnabW/m2bNXfyPGT4p7v8dV3RwXXf9rVM4txU5HjmAX+QYJOQaMp1rp0pnCp +HAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

GCC 15's new -Wunterminated-string-initialization notices that the 32
character "flash_cookie" (which is not used as a C-String)
needs to be marked as "nonstring":

drivers/net/ethernet/emulex/benet/be_cmds.c:2618:51: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (17 chars into 16 available) [-Wunterminated-string-initialization]
 2618 | static char flash_cookie[2][16] = {"*** SE FLAS", "H DIRECTORY *** "};
      |                                                   ^~~~~~~~~~~~~~~~~~

Add this annotation, avoid using a multidimensional array, but keep the
string split (with a comment about why). Additionally mark it const
and annotate the "cookie" member that is being memcmp()ed against as
nonstring too.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>
Cc: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: Somnath Kotur <somnath.kotur@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
---
 drivers/net/ethernet/emulex/benet/be_cmds.c | 6 +++++-
 drivers/net/ethernet/emulex/benet/be_cmds.h | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.c b/drivers/net/ethernet/emulex/benet/be_cmds.c
index 51b8377edd1d..adb441b36581 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.c
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.c
@@ -2615,7 +2615,11 @@ static int be_cmd_get_flash_crc(struct be_adapter *adapter, u8 *flashed_crc,
 	return status;
 }
 
-static char flash_cookie[2][16] = {"*** SE FLAS", "H DIRECTORY *** "};
+/*
+ * Since the cookie is text, add a parsing-skipped space to keep it from
+ * ever being matched on storage holding this source file.
+ */
+static const char flash_cookie[32] __nonstring = "*** SE FLAS" "H DIRECTORY *** ";
 
 static bool phy_flashing_required(struct be_adapter *adapter)
 {
diff --git a/drivers/net/ethernet/emulex/benet/be_cmds.h b/drivers/net/ethernet/emulex/benet/be_cmds.h
index d70818f06be7..5e2d3ddb5d43 100644
--- a/drivers/net/ethernet/emulex/benet/be_cmds.h
+++ b/drivers/net/ethernet/emulex/benet/be_cmds.h
@@ -1415,7 +1415,7 @@ struct flash_section_entry {
 } __packed;
 
 struct flash_section_info {
-	u8 cookie[32];
+	u8 cookie[32] __nonstring;
 	struct flash_section_hdr fsec_hdr;
 	struct flash_section_entry fsec_entry[32];
 } __packed;
-- 
2.34.1


