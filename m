Return-Path: <netdev+bounces-14812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88030743F52
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 18:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42ED22810AD
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 16:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928231643C;
	Fri, 30 Jun 2023 16:00:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4F6168A3
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 16:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D6BC433C0;
	Fri, 30 Jun 2023 16:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688140834;
	bh=uYDvEiWptSjKoEmPqZloji6Rv0TWhRiCflg3ZFi70eY=;
	h=From:To:Cc:Subject:Date:From;
	b=XjF1ac0CCyldB3FBFPlLtog+nztvqTBxaZRDeoB5rLQFdOeX4pjLmJjjgCltOMHqp
	 Ou7eQ9YBr77wATpMKZm8CkNvuFtRf700U/v+aUWFohOv7wRlW9Yy1KlocolrGBxE1a
	 I5pFhqs9XzUKjoyATq7u6Zrm56NzdcsYUjKg7fnwJ3OleL8/2831WRplVJe++cioG7
	 Auk/jmJ37NfZGo0Whleh6A2rf3qQs1S4LDu8WoTJgt2JcltAruL5R9QP9abWJmN2xz
	 CgeAw/2ZuqU1L8ZMy7FSNC83wqlZOQbNo0UzcCtTOYPeSO33M+ZBwY06Evj8sOEmtl
	 zjaryK6L8ZQgg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] docs: netdev: broaden mailbot to all MAINTAINERS
Date: Fri, 30 Jun 2023 09:00:25 -0700
Message-ID: <20230630160025.114692-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reword slightly now that all MAINTAINERS have access to the commands.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/process/maintainer-netdev.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 83614cec9328..2397b31c0198 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -149,8 +149,11 @@ themselves. No email should ever be sent to the list with the main purpose
 of communicating with the bot, the bot commands should be seen as metadata.
 
 The use of the bot is restricted to authors of the patches (the ``From:``
-header on patch submission and command must match!), maintainers themselves
-and a handful of senior reviewers. Bot records its activity here:
+header on patch submission and command must match!), maintainers of
+the modified code according to the MAINTAINERS file (again, ``From:``
+must match the MAINTAINERS entry) and a handful of senior reviewers.
+
+Bot records its activity here:
 
   https://patchwork.hopto.org/pw-bot.html
 
-- 
2.41.0


