Return-Path: <netdev+bounces-49379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B267F1DAA
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 21:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 253092828D0
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 20:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FB037154;
	Mon, 20 Nov 2023 20:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5qECeYs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DC419BC2;
	Mon, 20 Nov 2023 20:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2FDC433C8;
	Mon, 20 Nov 2023 20:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700510472;
	bh=xhLK50jLAz04UHazu67omTgum5sysPJRblqRFVwcoQM=;
	h=From:To:Cc:Subject:Date:From;
	b=k5qECeYsVfWze77kgqY/oCQAC1fqRDNultn3l8W2z1cbdec99TBye+DVRcUkhJuJA
	 0vP2dfmOjTqCYKFYdUMfngUr3LKDT7iO0xvPAcNZSZk/FkprASJhzqvOOD2VPT9JQ/
	 /5IVwLlZfHuFpqGBj1SDVJMDJkNUnSq6gHr5fmPMm1sWq/0Cme2ipthhdB7Ke3Iulb
	 x/cvEPsJW91cHAP8KriLIkreYSov0UPTSUvv+xvqzCK2RF6qumRKLo/5GUCk+k7GVv
	 5jZuN5qZmIGo1/8fJsQO//3U270ky986bQJSTHia1yzwxqGuhQha44yRpPthEWGFVc
	 eqp2dRfCXhTZA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>,
	corbet@lwn.net,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net] docs: netdev: try to guide people on dealing with silence
Date: Mon, 20 Nov 2023 12:01:09 -0800
Message-ID: <20231120200109.620392-1-kuba@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There has been more than a few threads which went idle before
the merge window and now people came back to them and started
asking about next steps.

We currently tell people to be patient and not to repost too
often. Our "not too often", however, is still a few orders of
magnitude faster than other subsystems. Or so I feel after
hearing people talk about review rates at LPC.

Clarify in the doc that if the discussion went idle for a week
on netdev, 95% of the time there's no point waiting longer.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - rephrase the first paragraph
v1: https://lore.kernel.org/all/20231118152232.787e9ea2@kernel.org/

CC: corbet@lwn.net
CC: workflows@vger.kernel.org
CC: linux-doc@vger.kernel.org
---
 Documentation/process/maintainer-netdev.rst | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 7feacc20835e..84ee60fceef2 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -193,9 +193,23 @@ Review timelines
 Generally speaking, the patches get triaged quickly (in less than
 48h). But be patient, if your patch is active in patchwork (i.e. it's
 listed on the project's patch list) the chances it was missed are close to zero.
-Asking the maintainer for status updates on your
-patch is a good way to ensure your patch is ignored or pushed to the
-bottom of the priority list.
+
+The high volume of development on netdev makes reviewers move on
+from discussions relatively quickly. New comments and replies
+are very unlikely to arrive after a week of silence. If a patch
+is no longer active in patchwork and the thread went idle for more
+than a week - clarify the next steps and/or post the next version.
+
+For RFC postings specifically, if nobody responded in a week - reviewers
+either missed the posting or have no strong opinions. If the code is ready,
+repost as a PATCH.
+
+Emails saying just "ping" or "bump" are considered rude. If you can't figure
+out the status of the patch from patchwork or where the discussion has
+landed - describe your best guess and ask if it's correct. For example::
+
+  I don't understand what the next steps are. Person X seems to be unhappy
+  with A, should I do B and repost the patches?
 
 .. _Changes requested:
 
-- 
2.42.0


