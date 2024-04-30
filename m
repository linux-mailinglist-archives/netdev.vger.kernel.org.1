Return-Path: <netdev+bounces-92652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EB48B830F
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 410E2B212BD
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534D21BED90;
	Tue, 30 Apr 2024 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+Vck75u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E74C17BB03
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714520493; cv=none; b=M4K942NGrqHoeznrFOlEWncMn/tIWY8Vt1RtGuO5uRi/ymXnuYWd07lsJsKxt2q2dZa5SQFAu3pBDt8htUtk4DQpbjz3EDO21SCNFyoyLb7GTglid9n7824qdJHAfZdv4EHiK08rTC+padBlAkvkW7O1MKair5Hqo1yiYvL7Kjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714520493; c=relaxed/simple;
	bh=BLz4Gfh7U3eQeDrWkvzxRQq4pSL/Uo46YYGf1p2umb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dKz9+bzCVEembAO8na3G8ZNM9BsCS64UsWDaGacI1jS8i+73r/QuHfavmHUoT3AmjUCbqXBp1YywJjUvPETuhW0BgUMv65lgsPqW0wTz4RQrlQzgk5x7VD8BVHMWooOjHaG94JmlRgk00C+nfjM4L+fWU9vMF7bwKalDzsxdqrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+Vck75u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AFAC2BBFC;
	Tue, 30 Apr 2024 23:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714520492;
	bh=BLz4Gfh7U3eQeDrWkvzxRQq4pSL/Uo46YYGf1p2umb0=;
	h=From:To:Cc:Subject:Date:From;
	b=W+Vck75uw5oMbUj4C0LmOMgbIxJSsN+l/wUw0k75l70TGjaXstOaajjfZMOKe+Wap
	 Fa8MLqpHUx4rNGXW+nkeibubTDCm+0ru3MXKnPcthvjOTzzdCI81yi+pQGU0nKc5hO
	 qXW1Y3CrSccFQVJ7s+33cJTMcnrUCROfskP3l/d+PemlAeRgiKXusd+wX1XOzxNVrD
	 Yw/cmYu6Fih9mDlbWzn1AR9xa8LBbQFFAwdRDbhjoogg3Lbs0Zf7K7toHuI/yOl759
	 goETpCm+j2BQRsLxDNMlGWG9p01QT0YcIyZUn04ZxPHCf4iosFI4VrdVtnD2aC2ijq
	 FCZNWj9vI1Tgw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Raju.Rangoju@amd.com,
	Jakub Kicinski <kuba@kernel.org>,
	Varun Prakash <varun@chelsio.com>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>
Subject: [PATCH net] MAINTAINERS: orphan Chelsio drivers maintained by Raju Rangoju
Date: Tue, 30 Apr 2024 16:41:27 -0700
Message-ID: <20240430234127.1358783-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Raju seems to work at AMD now, and the Chelsio email address
bounces.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CCing other Chelsio maintainers:

CC: Varun Prakash <varun@chelsio.com>
CC: Ayush Sawal <ayush.sawal@chelsio.com>
CC: Potnuri Bharat Teja <bharat@chelsio.com>

Please feel free to send your own patch to nominate someone
else, I'll keep this patch in patchwork until the end of
the week, and only apply it if there's no patch from you.
---
 MAINTAINERS | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa7cf5807dc2..d2656f4cc9c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5715,9 +5715,8 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/dvb-frontends/cxd2820r*
 
 CXGB3 ETHERNET DRIVER (CXGB3)
-M:	Raju Rangoju <rajur@chelsio.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Orphan
 W:	http://www.chelsio.com
 F:	drivers/net/ethernet/chelsio/cxgb3/
 
@@ -5736,9 +5735,8 @@ W:	http://www.chelsio.com
 F:	drivers/crypto/chelsio
 
 CXGB4 ETHERNET DRIVER (CXGB4)
-M:	Raju Rangoju <rajur@chelsio.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Orphan
 W:	http://www.chelsio.com
 F:	drivers/net/ethernet/chelsio/cxgb4/
 
@@ -5765,9 +5763,8 @@ F:	drivers/infiniband/hw/cxgb4/
 F:	include/uapi/rdma/cxgb4-abi.h
 
 CXGB4VF ETHERNET DRIVER (CXGB4VF)
-M:	Raju Rangoju <rajur@chelsio.com>
 L:	netdev@vger.kernel.org
-S:	Supported
+S:	Orphan
 W:	http://www.chelsio.com
 F:	drivers/net/ethernet/chelsio/cxgb4vf/
 
-- 
2.44.0


