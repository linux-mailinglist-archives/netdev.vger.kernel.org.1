Return-Path: <netdev+bounces-147932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BE09DF355
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 22:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 519C8B213D6
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 21:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8171AAE00;
	Sat, 30 Nov 2024 21:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/fjAFlz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAE81AA1E2
	for <netdev@vger.kernel.org>; Sat, 30 Nov 2024 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733002864; cv=none; b=hlrUGn2sdGRMdEuwZXmX6xxzVwjHYKZszfolnyL3dH/2w/mL3eE1HspbLO/XVl0QD0tznvVXD6uZfQzVMpPiQ7ZjonT95iNYdcRbFo9+C34AEXB36/cZkyZxAqGCk066fBMPLvXAMMay/AUHku2y6v79vV+qWI5u+wOun/QAJkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733002864; c=relaxed/simple;
	bh=WeBXm0eOmnpYaGhMMdTOj54iwBq5vq2RfpqMf0fMS40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PDuPQB+wM+dH92Lhg3C+xyLI+0lXvm/FW6rXUFPxdAtS6Ma5pnzirGcilhi21BqCkNRvsE6I3D+ygPCcG/KDlfG0dwnMeRCmlQlQidXYEqO9vGO12owJFHBEUANhL0XqdyyDgizz852iDX+RBZcVoyiw+FPiTOIQB9N8x8NngO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/fjAFlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B39DC4CECC;
	Sat, 30 Nov 2024 21:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733002863;
	bh=WeBXm0eOmnpYaGhMMdTOj54iwBq5vq2RfpqMf0fMS40=;
	h=From:To:Cc:Subject:Date:From;
	b=h/fjAFlz6zzaQaaBP/RvEChbIhEJ/C7x9eU66DZ7l92x72W/sA2S/U4VJ1Vn6vdCT
	 07H98vnIagLCMlAuCJqgc1Zcu13IvCSQnQHS+AEvxug/mk0eaPSXWqJ3/9ROCud7OI
	 If7LPukAL1EFREbF5HMmW0seeUD9MGzfz01Ndbs0iOC31Ydxheo1CR4pcl4Qm6NSsO
	 b1rXcT855Q97/uRBLPQcs+OzeiPm6n9OPehbGqQW+kBEW/xT/ZYdSKrxYRpZmTWM51
	 O3LExPwYyCDRbDG/s2yR624FxZr/r91qtPXuHue7AnADwfTi+lmC590k6w9fdlSKEp
	 O54tpUUgpw+Zw==
From: Jakub Kicinski <kuba@kernel.org>
To: richardcochran@gmail.com
Cc: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] MAINTAINERS: list PTP drivers under networking
Date: Sat, 30 Nov 2024 13:41:00 -0800
Message-ID: <20241130214100.125325-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PTP patches go via the netdev trees, add drivers/ptp/ to the networking
entry so that get_maintainer.pl --scm lists those trees above Linus's
tree.

Thanks to the real entry using drivers/ptp/* the original entry will
still be considered more specific / higher prio.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Richard Cochran <richardcochran@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b878ddc99f94..bac337a2f962 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16051,6 +16051,7 @@ F:	Documentation/devicetree/bindings/net/
 F:	Documentation/networking/net_cachelines/net_device.rst
 F:	drivers/connector/
 F:	drivers/net/
+F:	drivers/ptp/
 F:	include/dt-bindings/net/
 F:	include/linux/cn_proc.h
 F:	include/linux/etherdevice.h
-- 
2.47.0


