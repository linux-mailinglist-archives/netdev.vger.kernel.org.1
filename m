Return-Path: <netdev+bounces-30064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8754F785C7D
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 17:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27372812F8
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AE7C8EC;
	Wed, 23 Aug 2023 15:49:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4B52905
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 15:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD410C433C9;
	Wed, 23 Aug 2023 15:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692805765;
	bh=NE42OlPzmRHlwFXCXXgi1f+Eb2OiCz1sD7zYgQ/OL2s=;
	h=From:To:Cc:Subject:Date:From;
	b=oVM6RklICxDkz/4elBAXRcH/fsjP8rqzNRWH2m7KbSNa+nVld7NxUXQVIm4Htxk8t
	 qHvEWzLP7w7ptYMVlF8VGmJHACNspzxbUC+Vci07cna1WO7vlqqHMJaECc2lzUE0VY
	 /UuHbHHlnNSeURoMuyDQRhg6LnidQ4EKv1PQ+2pQl3oZgi2NcpcDjkiygQ5/20sdL0
	 4cO4VDhxNYoFSLiYzNEfGop35aQ27D+4NnPSo3nRaTHRQ9Kp6xWN/DRbdYO3ur/fp0
	 Qz2pzlj+edBLD2aPxnyrhwLcjS5hiMTcHvxvcDdWe5jyzK3GWuErkSsMByU6920t8W
	 dE9otp7fGttIA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] docs: netdev: recommend against --in-reply-to
Date: Wed, 23 Aug 2023 08:49:22 -0700
Message-ID: <20230823154922.1162644-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's somewhat unfortunate but with (my?) the current tooling
if people post new versions of a set in reply to an old version
managing the review queue gets difficult. So recommend against it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/process/maintainer-netdev.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 2ab843cde830..c1c732e9748b 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -167,6 +167,8 @@ Asking the maintainer for status updates on your
 patch is a good way to ensure your patch is ignored or pushed to the
 bottom of the priority list.
 
+.. _Changes requested:
+
 Changes requested
 ~~~~~~~~~~~~~~~~~
 
@@ -359,6 +361,10 @@ Make sure you address all the feedback in your new posting. Do not post a new
 version of the code if the discussion about the previous version is still
 ongoing, unless directly instructed by a reviewer.
 
+The new version of patches should be posted as a separate thread,
+not as a reply to the previous posting. Change log should include a link
+to the previous posting (see :ref:`Changes requested`).
+
 Testing
 -------
 
-- 
2.41.0


