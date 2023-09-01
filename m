Return-Path: <netdev+bounces-31791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA92790317
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 23:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E8F281951
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 21:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A27F9E9;
	Fri,  1 Sep 2023 21:17:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0826BF9E1
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 21:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1954EC433C8;
	Fri,  1 Sep 2023 21:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693603047;
	bh=Me0Z5gtD3X+vFlIiVu0e2+D0btlRSRW4qCN3xpDjeHE=;
	h=From:To:Cc:Subject:Date:From;
	b=I9gT0CzyxOb4cWviUs4e+rVXO6nuSjRS9HZ2v3AUrZG5VHlUGB3W8yajwuCS5d9Li
	 8MNXQAMbA6kgNvE/DryPex7m08UrIwcSLjSVVf8xjGbsdKL/tTWf2GQW0nSE0eJRug
	 rfrS7qvYUP1SD4Q2lmbLnMz0MWxOYVi9Rn3NOLfPQ0IbgUbUTkDQwTb0lypnDYSW4k
	 ZBw03AsquhIsW5EGLh2/VFv/75J2MMSzjrCBmmhflf8RNHaf/rxQ0NmbljjC9mur2t
	 28i9uDmmrplgFTNsRrMJblMDg3vNjTkdKZ3RAlgMvc6G3TSO5bmwHSzOmivNlXOqqn
	 OnyoN2DNuX8Pg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	corbet@lwn.net,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: [PATCH net] docs: netdev: update the netdev infra URLs
Date: Fri,  1 Sep 2023 14:17:18 -0700
Message-ID: <20230901211718.739139-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some corporate proxies block our current NIPA URLs because
they use a free / shady DNS domain. As suggested by Jesse
we got a new DNS entry from Konstantin - netdev.bots.linux.dev,
use it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: corbet@lwn.net
CC: workflows@vger.kernel.org
CC: linux-doc@vger.kernel.org

CC: intel-wired-lan@lists.osuosl.org

Please LMK if the old URLs pop up somewhere, I may have missed
some place. The old patchwork checks will continue to use the
old address but new ones should link via netdev.bots...
---
 Documentation/process/maintainer-netdev.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index db1b81cfba9b..09dcf6377c27 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -98,7 +98,7 @@ If you aren't subscribed to netdev and/or are simply unsure if
 repository link above for any new networking-related commits.  You may
 also check the following website for the current status:
 
-  https://patchwork.hopto.org/net-next.html
+  https://netdev.bots.linux.dev/net-next.html
 
 The ``net`` tree continues to collect fixes for the vX.Y content, and is
 fed back to Linus at regular (~weekly) intervals.  Meaning that the
@@ -185,7 +185,7 @@ must match the MAINTAINERS entry) and a handful of senior reviewers.
 
 Bot records its activity here:
 
-  https://patchwork.hopto.org/pw-bot.html
+  https://netdev.bots.linux.dev/pw-bot.html
 
 Review timelines
 ~~~~~~~~~~~~~~~~
-- 
2.41.0


