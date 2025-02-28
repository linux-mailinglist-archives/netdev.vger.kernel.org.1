Return-Path: <netdev+bounces-170520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0154CA48E73
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 635AC7A8274
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9CF14375D;
	Fri, 28 Feb 2025 02:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AY3ZITTs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1613D62B
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709138; cv=none; b=N6kaeWZZ7ks+BSem1w74txIuROE+EtXhfvtP8pPHwcJWHqP/udPmzRagqLu+nryjsfUiWoWxGM2LFbQLYDvJkTECY8aFheOJAJWBesF+1Jv5Q5P3WMRdzb5YHsDlgqYcRU6mHNU3jCoDzBAAP5NQwgtZZWoG4EshLcw+cDQ5FEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709138; c=relaxed/simple;
	bh=2+Bz6ZoDs77Q8IRkiQ9Y+Hvsv5PXtVP/+4Mz/RRoaDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNuUgtwEMt2eoi94UI65Upc1yrL1g3TSdc5DwBJQ77igW/sPK0hSTM1BEZDmhIq+Z2g66cen1QWwk5fjUCrlrCrHqLoHQ/Iwk4u60cNppWD1bT02D1Bif+CEpFheYzwmrouRG8zy5Ij9VBVTj54Rkf32/nG1g/BEl+v/Va3cqbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AY3ZITTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3E1C4CEDD;
	Fri, 28 Feb 2025 02:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740709137;
	bh=2+Bz6ZoDs77Q8IRkiQ9Y+Hvsv5PXtVP/+4Mz/RRoaDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AY3ZITTsrQfTE5As1XIJUYeu3cb9yWpYJsJyDIPZLlSHbEV1QxQ/GTO+gUg6F70C8
	 EZdcmnb1D1G97ERYmxkLo2PSe9p/AZhqEIaFgTEOh5qGq1tw6I7ADXohED9vcm2ZMn
	 GCmzRPDVIneyq6XlimFTFH0qjj+PFGmca8bm3wssTT+Mx8Jr3CmJGRfn2A/f8OQN4z
	 okDR+SEpWF75RvOBY6AXV3yjL/y7N8TOLVZ9IhrlON9QAICBB2YEcjNeN7uy/kDLW/
	 s0E7f5ErYim/GnkwSCbJTFcb5VXYcfbsKMVKm8+eUHRoM6CgaVuFD163XJCgc/3ZGm
	 bo4ybxXlnAS/A==
From: Saeed Mahameed <saeed@kernel.org>
To: stephen@networkplumber.org,
	dsahern@gmail.com,
	Jiri Pirko <jiri@nvidia.com>,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>
Subject: [PATCH iproute2 01/10] update kernel headers
Date: Thu, 27 Feb 2025 18:18:28 -0800
Message-ID: <20250228021837.880041-2-saeed@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228021837.880041-1-saeed@kernel.org>
References: <20250228021837.880041-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Bring enum devlink_dyn_attr_type from kernel headers

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
---
 include/uapi/linux/devlink.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 80051b8c..b822baf9 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -385,6 +385,23 @@ enum devlink_linecard_state {
 	DEVLINK_LINECARD_STATE_MAX = __DEVLINK_LINECARD_STATE_MAX - 1
 };
 
+/**
+ * enum devlink_dyn_attr_type - Dynamic attribute type type.
+ */
+enum devlink_dyn_attr_type {
+	/* Following values relate to the internal NLA_* values */
+	DEVLINK_DYN_ATTR_TYPE_U8 = 1,
+	DEVLINK_DYN_ATTR_TYPE_U16,
+	DEVLINK_DYN_ATTR_TYPE_U32,
+	DEVLINK_DYN_ATTR_TYPE_U64,
+	DEVLINK_DYN_ATTR_TYPE_STRING,
+	DEVLINK_DYN_ATTR_TYPE_FLAG,
+	DEVLINK_DYN_ATTR_TYPE_NUL_STRING = 10,
+	DEVLINK_DYN_ATTR_TYPE_BINARY,
+	__DEVLINK_DYN_ATTR_TYPE_CUSTOM_BASE = 0x80,
+	/* Any possible custom types, unrelated to NLA_* values go below */
+};
+
 enum devlink_attr {
 	/* don't change the order or add anything between, this is ABI! */
 	DEVLINK_ATTR_UNSPEC,
-- 
2.48.1


