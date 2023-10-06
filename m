Return-Path: <netdev+bounces-38636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE8D7BBCB9
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 18:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F087281A3B
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74733D76;
	Fri,  6 Oct 2023 16:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWZD4DIQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D3728E0F
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 16:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD69BC433C7;
	Fri,  6 Oct 2023 16:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696609810;
	bh=3JkyYeG33bgahfQv5iDtkIsC8aN1qb2VpMLW0TB6Bs4=;
	h=From:To:Cc:Subject:Date:From;
	b=EWZD4DIQribjkDA4qOQ6firAXYHLeB8Bs9/tRGKshmpg7sCgILn2Nh8iwBRVDBo13
	 g8pu6QIUK5NpZc/ZdjG+Jy2AWVrXjgVQAMHFlYJnyS0mh1TbEfYq0gCjFK0eRZe9SK
	 INSoEzkJs1jRYLlCc+qlNa2xhwM63GLtO1n4TyjZRSc9cblKGan3yVzwNwqSWr1RP8
	 tjrsiIfk6UWyj2AhCHLTswtwFP7UpMokQekLM+UWEzOVaYs5LAQM2WtjHROjqIjhPM
	 zu175u9MHJXod2TA2z8N7PtCpku4zMH4Lrv2X/qcwHGjaZgfdU8FE8o5rnpu478yRw
	 CmUrqH7NaWxuQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	jesse.brandeburg@intel.com,
	sd@queasysnail.net,
	horms@verge.net.au
Subject: [RFC] docs: netdev: encourage reviewers
Date: Fri,  6 Oct 2023 09:30:07 -0700
Message-ID: <20231006163007.3383971-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a section to our maintainer doc encouraging reviewers
to chime in on the mailing list.

The questions about "when is it okay to share feedback"
keep coming up (most recently at netconf) and the answer
is "pretty much always".

The contents are partially based on a doc we wrote earlier
and shared with the vendors (for the "driver review rotation").

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
CC: andrew@lunn.ch
CC: jesse.brandeburg@intel.com
CC: sd@queasysnail.net
CC: horms@verge.net.au

Sending as RFC for early round of reviews before I CC docs@
and expose this to potentially less constructive feedback :)
---
 Documentation/process/maintainer-netdev.rst | 43 +++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 09dcf6377c27..d5cbcfd44cf8 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -441,6 +441,49 @@ in a way which would break what would normally be considered uAPI.
 new ``netdevsim`` features must be accompanied by selftests under
 ``tools/testing/selftests/``.
 
+Reviewer guidance
+-----------------
+
+Reviewing other people's patches on the list is highly encouraged,
+regardless of the level of expertise. Code reviews not only help
+the maintainers but also help reviewers themselves to learn and
+become part of the community.
+
+Reviewers can interact with the submissions by: asking questions
+about the code, sharing relevant experience, suggesting changes, etc.
+Asking questions is a particularly useful technique, for example rather
+than stating:
+
+``I think there can be a deadlock between A and B here.``
+
+it may be better to phrase the feedback as a question:
+
+``Could you explain what prevents deadlocks between A and B?``
+
+After all, patch submissions should be clear both in terms of the code and
+the commit message.
+
+Another technique useful in case of a disagreement is to ask for others
+to chime in. I.e. if a discussion reaches a stalemate after a few exchanges,
+calling for opinions of other reviewers or maintainers. Often those in
+agreement with a reviewer remain silent unless called upon.
+Opinion of multiple people carries exponentially more weight.
+
+There is no strict requirement to use specific tags like ``Reviewed-by``.
+In fact reviews in plain English are more informative and encouraged
+even when a tag is provided (e.g. "I looked at aspects A, B and C of this
+submission and it looks good to me.")
+Some form of a review message / reply is obviously necessary otherwise
+maintainers will not know that the reviewer has looked at the patch at all!
+
+It's safe to assume that the maintainers know the community and the level
+of expertise of the reviewers. The reviewers should not be concerned about
+their comments impeding or derailing the patch flow.
+
+Last but not least patch review may become a negative process, focused
+on pointing out problems. Please throw in a complement once in a while,
+particularly for newbies!
+
 Testimonials / feedback
 -----------------------
 
-- 
2.41.0


