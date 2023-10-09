Return-Path: <netdev+bounces-39357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D6D7BEE9A
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 00:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C3C280DB1
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50CB2030D;
	Mon,  9 Oct 2023 22:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERGCccyE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AAA1428B
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 22:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E97CC433C7;
	Mon,  9 Oct 2023 22:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696892205;
	bh=BTlWTB+1l64Oxw8ls3cp8V8J5xa145Pg1B80U2Egz30=;
	h=From:To:Cc:Subject:Date:From;
	b=ERGCccyEKO6+Cb8YH5RvW73EZUhN4kLKZlWfBVX6Jfwxs5PzFjwiptbF6JcljpzEi
	 kQixuG48FZkMWH9f+lN2P5661/EImy/kgFsfvzQNAcVT11c3oubzumZNbBLeGLDXG7
	 +vjEcqIEz1yNWUPajeApDSJPRVeowBXfA7gyepJ0MzURun1SlwAImgcAdtJqLsZaT4
	 eROKMdRgk2r3aGLJvoOWWSzSRrK5A7l+700vrA8KnedutQW1GI0y18bz+oBqvEGhxh
	 b+V8+01f/iDIIGM3CuZNeXxXNu42tVnCoExYjZk0FP07fKG4GYeUikx7clWhcg5HcS
	 nrjiL0DBqCu7g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	corbet@lwn.net,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	jesse.brandeburg@intel.com,
	sd@queasysnail.net,
	horms@verge.net.au,
	przemyslaw.kitszel@intel.com,
	f.fainelli@gmail.com,
	jiri@resnulli.us,
	ecree.xilinx@gmail.com
Subject: [PATCH net-next] docs: try to encourage (netdev?) reviewers
Date: Mon,  9 Oct 2023 15:56:36 -0700
Message-ID: <20231009225637.3785359-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a section to netdev maintainer doc encouraging reviewers
to chime in on the mailing list.

The questions about "when is it okay to share feedback"
keep coming up (most recently at netconf) and the answer
is "pretty much always".

Extend the section of 7.AdvancedTopics.rst which deals
with reviews a little bit to add stuff we had been recommending
locally.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
--
RFC -> v1:
 - spelling (compliment)
 - move to common docs:
   - ask for more opinions
   - use of tags
   - compliments
 - ask less experienced reviewers to avoid style comments
   (using Florian's wording)

CC: andrew@lunn.ch
CC: jesse.brandeburg@intel.com
CC: sd@queasysnail.net
CC: horms@verge.net.au
CC: przemyslaw.kitszel@intel.com
CC: f.fainelli@gmail.com
CC: jiri@resnulli.us
CC: ecree.xilinx@gmail.com
---
 Documentation/process/7.AdvancedTopics.rst  | 18 ++++++++++++++++++
 Documentation/process/maintainer-netdev.rst | 15 +++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/Documentation/process/7.AdvancedTopics.rst b/Documentation/process/7.AdvancedTopics.rst
index bf7cbfb4caa5..415749feed17 100644
--- a/Documentation/process/7.AdvancedTopics.rst
+++ b/Documentation/process/7.AdvancedTopics.rst
@@ -146,6 +146,7 @@ pull.  The git request-pull command can be helpful in this regard; it will
 format the request as other developers expect, and will also check to be
 sure that you have remembered to push those changes to the public server.
 
+.. _development_advancedtopics_reviews:
 
 Reviewing patches
 -----------------
@@ -167,6 +168,12 @@ comments as questions rather than criticisms.  Asking "how does the lock
 get released in this path?" will always work better than stating "the
 locking here is wrong."
 
+Another technique useful in case of a disagreement is to ask for others
+to chime in. If a discussion reaches a stalemate after a few exchanges,
+calling for opinions of other reviewers or maintainers. Often those in
+agreement with a reviewer remain silent unless called upon.
+Opinion of multiple people carries exponentially more weight.
+
 Different developers will review code from different points of view.  Some
 are mostly concerned with coding style and whether code lines have trailing
 white space.  Others will focus primarily on whether the change implemented
@@ -176,3 +183,14 @@ security issues, duplication of code found elsewhere, adequate
 documentation, adverse effects on performance, user-space ABI changes, etc.
 All types of review, if they lead to better code going into the kernel, are
 welcome and worthwhile.
+
+There is no strict requirement to use specific tags like ``Reviewed-by``.
+In fact reviews in plain English are more informative and encouraged
+even when a tag is provided (e.g. "I looked at aspects A, B and C of this
+submission and it looks good to me.")
+Some form of a review message / reply is obviously necessary otherwise
+maintainers will not know that the reviewer has looked at the patch at all!
+
+Last but not least patch review may become a negative process, focused
+on pointing out problems. Please throw in a compliment once in a while,
+particularly for newbies!
diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 09dcf6377c27..a0cb00e7f579 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -441,6 +441,21 @@ in a way which would break what would normally be considered uAPI.
 new ``netdevsim`` features must be accompanied by selftests under
 ``tools/testing/selftests/``.
 
+Reviewer guidance
+-----------------
+
+Reviewing other people's patches on the list is highly encouraged,
+regardless of the level of expertise. For general guidance and
+helpful tips please see :ref:`development_advancedtopics_reviews`.
+
+It's safe to assume that netdev maintainers know the community and the level
+of expertise of the reviewers. The reviewers should not be concerned about
+their comments impeding or derailing the patch flow.
+
+Less experienced reviewers are highly encouraged to do more in-depth
+review of submissions and not focus exclusively on trivial / subject
+matters like code formatting, tags etc.
+
 Testimonials / feedback
 -----------------------
 
-- 
2.41.0


