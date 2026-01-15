Return-Path: <netdev+bounces-250191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB00D24D4B
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9828F30055B7
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754863A0B24;
	Thu, 15 Jan 2026 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="so+Z/t4Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512A132B9B4;
	Thu, 15 Jan 2026 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768485255; cv=none; b=DM6OTdvG3wiblXmSSO17h/v+J3Bg55iyfK3sYS+Vhw8hz/ootvpXyV9Kt5BL/h2FIkEkmI2rGEf51kHbdX/jvMd3X7OAstaUrvC1zGPvvl/Txuet9+eU+GjgvQYsjIk41DyrBpfG2Uf6/ODzWiyEtF3I3UBBHF/OxzVYBJJzkLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768485255; c=relaxed/simple;
	bh=WSXLOcHxIxtOZjLHJ9uAAQOGI0Bc9Qh95Zk3kWa0HzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AAwqwBO7vAN7GKyI4KHfiJwGE01lWUEF5GBBGDsnswb65pEKPuv3DNaH/0fbvyv3n3obEMNOCRBMaxH9DEqX4kFnmvjCp3mt/RqmkdtuD2StE6cwXkF5ejffyMHuUUgzphEfHXnZHKGiTNz6xhkXVz0I0+x7G578G0JGUYZgf4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=so+Z/t4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B7BC116D0;
	Thu, 15 Jan 2026 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768485255;
	bh=WSXLOcHxIxtOZjLHJ9uAAQOGI0Bc9Qh95Zk3kWa0HzY=;
	h=From:Date:Subject:To:Cc:From;
	b=so+Z/t4YX3N5EtouxVjh1Wgqzjd1WQexNx3d1thQ2/4DzlyMZ5CGtcl0Jp3FUChOS
	 RsX5e7gB7CvjPTeixAvVDE/fpl3yrCJsBp3LcICskQR0ZLfSx/STBo1SL0/IOfgrhh
	 77PkDnw2Y1RP4f/hJhGhgpVkjpI7oTbBoSG2Qw6IbN3c8tIjF/F1QFKDLdrSb2OIN7
	 Hc+7aqaFwM43julB+1Xv/5qbBFj8rkasgW2NuSKX0ZIZCb6LU6vPILNnVVyxhnjllJ
	 2785c6vJxkC2C9tR2fKYsRd4YFkC7HJuzmpPSOVMx/YAdUXD4UiGfZy3mK7Rms6Pxi
	 TTCThhe9QH+AA==
From: Simon Horman <horms@kernel.org>
Date: Thu, 15 Jan 2026 13:54:00 +0000
Subject: [PATCH v2] docs: netdev: refine 15-patch limit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-15-minutes-of-fame-v2-1-70cbf0883aff@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHfxaGkC/32NQQ6CMBBFr0Jm7ZhOoYS48h6GBcIUJkpLWmw0h
 LtbOYDL95L//gaRg3CES7FB4CRRvMugTwX0U+dGRhkyg1a6VkQlksFZ3GvliN6i7WZGq6tSNYM
 xignycAls5X1Eb23mSeLqw+f4SPSzf3OJkFA1qr5X1PS1Ha4PDo6fZx9GaPd9/wJQQEsTtQAAA
 A==
X-Change-ID: 20260113-15-minutes-of-fame-f24308d550e1
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.14.2

The 15 patch limit is intended by the maintainers to cover
all outstanding patches on the mailing list on a per-tree basis.
Not just those in a single patchset. Document this practice accordingly.

Signed-off-by: Simon Horman <horms@kernel.org>
---
Changes in v2:
- Clarify that the limit is per-tree. (Jakub)
- Link to v1: https://lore.kernel.org/r/20260113-15-minutes-of-fame-v1-1-0806b418c6fd@kernel.org
---
 Documentation/process/maintainer-netdev.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 989192421cc9db6c93c816f2dfb7afbe48dd25fc..6bce4507d5d3136270bbf552880451e08b137b61 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -363,6 +363,18 @@ just do it. As a result, a sequence of smaller series gets merged quicker and
 with better review coverage. Re-posting large series also increases the mailing
 list traffic.
 
+Limit patches outstanding on mailing list
+-----------------------------------------
+
+Avoid having more than 15 patches, across all series, outstanding for
+review on the mailing list for a single tree. In other words, a maximum of
+15 patches under review on net, and a maximum of 15 patches under review on
+net-next.
+
+This limit is intended to focus developer effort on testing patches before
+upstream review. Aiding the quality of upstream submissions, and easing the
+load on reviewers.
+
 .. _rcs:
 
 Local variable ordering ("reverse xmas tree", "RCS")




