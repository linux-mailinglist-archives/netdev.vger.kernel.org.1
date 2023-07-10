Return-Path: <netdev+bounces-16550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A35CA74DCB5
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 19:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8C81C20B21
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 17:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5F514275;
	Mon, 10 Jul 2023 17:46:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1806014272;
	Mon, 10 Jul 2023 17:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D988C433C7;
	Mon, 10 Jul 2023 17:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689011200;
	bh=JAxHBqgOmJqchXSR6NoBE6n0/dxS2e6Jz25wI0ASHys=;
	h=From:To:Cc:Subject:Date:From;
	b=cMCloIYV7yTHhbdKB+1ys8mQEFeldbiiR5oFxomKX/JK0UQatqANwYStqPzUS9J4d
	 QfLF9Og+sYv8+ZZeV7pKJ2p2hWvMCQuFse1NfBHIRBr3IydwCd8Nbhu6nUZINP8Pt7
	 b9sh8gqSeTs5em8PHH74xUf5tncjcmI60Xo8gN2ipN7gkw5PiFCG3gsRyEtwURnyHW
	 hP4x2tDTsBZ9yGfNIPXXCTqLAc7op+pP5l5XeHKqk9kX+cdwvULW3w30y//wzb+9aG
	 ccblALfhsNqQHSn9oVcbyw0HjwU9an1F1KrXK/03KWGhtErzXVmcSKxR/Xh+DRiM//
	 T4/BvnoNxCT4w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] docs: netdev: update the URL of the status page
Date: Mon, 10 Jul 2023 10:46:36 -0700
Message-ID: <20230710174636.1174684-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the status page from vger to the same server as mailbot.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
BPF folks, I see a mention of the status page in your FAQ, too,
but I'm leaving it to you to update, cause I'm not sure how
up to date that section is.
---
 Documentation/process/maintainer-netdev.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 2397b31c0198..2ab843cde830 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -98,7 +98,7 @@ If you aren't subscribed to netdev and/or are simply unsure if
 repository link above for any new networking-related commits.  You may
 also check the following website for the current status:
 
-  http://vger.kernel.org/~davem/net-next.html
+  https://patchwork.hopto.org/net-next.html
 
 The ``net`` tree continues to collect fixes for the vX.Y content, and is
 fed back to Linus at regular (~weekly) intervals.  Meaning that the
-- 
2.41.0


