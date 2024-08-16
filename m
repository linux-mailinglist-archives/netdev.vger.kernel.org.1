Return-Path: <netdev+bounces-119195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889599548E2
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 14:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEE82856C7
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 12:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD801B3F05;
	Fri, 16 Aug 2024 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLRFXHD1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD1C16F839
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 12:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811916; cv=none; b=ZjUPrEmRw+x2oLsS/tfKBG9erSQnKKKZpGH43wie5hnS0iFtQZL1jDXZY10cC7rPLauzbh6qkzS3B4tGRKHRoCGVgxy24wab+kAngUbeveJPETbk+Kfiblraa7s7rCyQZPnHblVCU5TF2IiZCyiC19GgUg5ZBIqvApkrkxyxZxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811916; c=relaxed/simple;
	bh=hjA501AZIrV6y3CRES1l4UXPWHHDNKUaFYjTyB2qU0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HCvuykrJXL8zyxx1IydG56vQ9dZnqInn9yGH4DVMDdVQ0ITK/9owH+UHBl+YzpF3iGhtJrJ26Gbc1AojNCE6xElGtKe9iZKYdEhuBIdNo6PYMmZKX1WXYJXIs0Xahzu2wtJOMSMVpZj8cDVV5zXV18BmM2W2IwdYTInV/tlvhIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLRFXHD1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DCFC32782;
	Fri, 16 Aug 2024 12:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723811916;
	bh=hjA501AZIrV6y3CRES1l4UXPWHHDNKUaFYjTyB2qU0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JLRFXHD1TqEGUvxDqvHZ5tVcEJFcKU2xqdkfCvrRT3kjBViXudg6pkuuTJ7/vNTDE
	 8KTU50IVUUzsUvmwSEe2mjSZzxShsXkgztPtzog9JfIYRAQHDu6hmobrQd9veDKuY2
	 hvF1b4ooyXhH2mjIhpSuE9Z3eMCZH/kuHBDEGkuzQwPMCQNTtfJbyWsbTF0OrCdL7a
	 SI4LzBBVMowvUazpgGqQkyxJsbaZrp9el1SRNaT596q9HpyC0K4+Qwr41tZLPVUUI1
	 F4x6rKXxjoLXQ7lPmlrfeZ0CVuUBXeb2lfVd8f15O1h2GYqHy5DDOqApMSy5PN4riE
	 9PUXcvScc70rw==
From: Simon Horman <horms@kernel.org>
Date: Fri, 16 Aug 2024 13:38:03 +0100
Subject: [PATCH net 4/4] MAINTAINERS: Mark JME Network Driver as Odd Fixes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-net-mnt-v1-4-ef946b47ced4@kernel.org>
References: <20240816-net-mnt-v1-0-ef946b47ced4@kernel.org>
In-Reply-To: <20240816-net-mnt-v1-0-ef946b47ced4@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>, 
 Guo-Fu Tseng <cooldavid@cooldavid.org>, Moon Yeounsu <yyyynoom@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

This driver only appears to have received sporadic clean-ups, typically
part of some tree-wide activity, and fixes for quite some time.  And
according to the maintainer, Guo-Fu Tseng, the device has been EOLed for
a long time [1].

[1] https://lore.kernel.org/netdev/20240805003139.M94125@cooldavid.org/

Accordingly, it seems appropriate to mark this driver as odd fixes.

Cc: Moon Yeounsu <yyyynoom@gmail.com>
Cc: Guo-Fu Tseng <cooldavid@cooldavid.org>
Signed-off-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38f3731d0e3b..6ed906576942 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11995,7 +11995,7 @@ F:	fs/jfs/
 JME NETWORK DRIVER
 M:	Guo-Fu Tseng <cooldavid@cooldavid.org>
 L:	netdev@vger.kernel.org
-S:	Maintained
+S:	Odd Fixes
 F:	drivers/net/ethernet/jme.*
 
 JOURNALLING FLASH FILE SYSTEM V2 (JFFS2)

-- 
2.43.0


