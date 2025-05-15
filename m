Return-Path: <netdev+bounces-190879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F20AB92BE
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 01:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82F44176BC7
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 23:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA328289350;
	Thu, 15 May 2025 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FkqgcpXC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8D25A2B4
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747351027; cv=none; b=jhyRO4GAKVCnPSXyp0D5zutAPELvTpwCNZxatYjifZ0S/osgxnsBB9c5Tm3K9l7xZaaqI5OTgyjbAZxRXM3jrq/RD2mTgMavkpRe2Vi9HzyCTWtrtnWhktQsq1Mv1GEe1k/g1bR+1QyqfuZDocAkzAQwUpS75dt2U+i+ZPHSJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747351027; c=relaxed/simple;
	bh=Q3mCCfNrVMXkcWUKeGps5pM10bhy4U3Ylxu76V2rTvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCXqaEb6HXK0aHZQlpkNb7bA2M8otZGA0wyK48ge4Zad1Fr6RVqAscBn+EWoMGqwOfJaGQ30jGkPvVn8jm03ti0lfUa1QcYHnOzajZiEU21pmHFJp9+YNQQ15b4TgNDgQxSk8rirmeMRwcwNTM/3CxdGBDiJWTZQ0lkG6twLwyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FkqgcpXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BADC4CEEF;
	Thu, 15 May 2025 23:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747351027;
	bh=Q3mCCfNrVMXkcWUKeGps5pM10bhy4U3Ylxu76V2rTvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FkqgcpXC+Zx5Lqjq5FmymWn2S1OGTpRQJswvvJsdXgGuO99KGdKwRh5nOXOg5I0LN
	 5sjV0Mg7gGoFVGLJe1I94N6Ig/ivuxCOg/r2SHQhSZVq4ftR5EMQ37blLAtNh1eEIn
	 upO69o4xRMWWivSE8t5noxKtdo8UiSW3rSFszvR22Ha0sAB9y1H1O/02JgG1JFGBuv
	 rU9xQBT5e+DxrHl28qpt6VFLVVsyM5La4RzNZz3l4Z+sKYmWBJm1lgUBgnVth6i54U
	 x5+SMGyiPIXkGFC4SRkpG/BbKvRAl7W9/jZuW0SyohH5pvp4YGPPiaGExpNsmDsai3
	 lh/FQ0OKfJtRA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	daniel@iogearbox.net,
	nicolas.dichtel@6wind.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/9] netlink: specs: rt-link: add C naming info for ovpn
Date: Thu, 15 May 2025 16:16:42 -0700
Message-ID: <20250515231650.1325372-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515231650.1325372-1-kuba@kernel.org>
References: <20250515231650.1325372-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

C naming info for OVPN which was added since I adjusted
the existing attrs. Also add missing reference to a header needed
for a bridge struct.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/rt-link.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/netlink/specs/rt-link.yaml b/Documentation/netlink/specs/rt-link.yaml
index 7f91f474ff25..5ec3d35b7a38 100644
--- a/Documentation/netlink/specs/rt-link.yaml
+++ b/Documentation/netlink/specs/rt-link.yaml
@@ -594,6 +594,7 @@ protonum: 0
         name: reasm-overlaps
   - name: br-boolopt-multi
     type: struct
+    header: linux/if_bridge.h
     members:
       -
         name: optval
@@ -826,6 +827,8 @@ protonum: 0
       - name: default
   -
     name: ovpn-mode
+    enum-name: ovpn-mode
+    name-prefix: ovpn-mode
     type: enum
     entries:
       - p2p
@@ -2195,6 +2198,7 @@ protonum: 0
         type: u16
   -
     name: linkinfo-ovpn-attrs
+    name-prefix: ifla-ovpn-
     attributes:
       -
         name: mode
-- 
2.49.0


