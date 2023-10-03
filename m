Return-Path: <netdev+bounces-37728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0814B7B6D3C
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 17:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 499A92814C7
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560DD36B12;
	Tue,  3 Oct 2023 15:34:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBCEFBF3
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 15:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB12CC433C9;
	Tue,  3 Oct 2023 15:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696347273;
	bh=c2MHlD/e4e9PLc999mYpP1XVUoH/8fIFoZPZRwggryk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lv+BMTAUi37+q5KhnSSGfPRv6m7NOZy92hFICWL8CKs/rcGQNwjmfrASJqSiuu/SY
	 0RG24w7g9sjpFVGPIV+qWQOHPXpovBafe9E8i0o4iW0cFZV2r+XQ1XPHhqHPxVsRi5
	 vfpvrXLIu/xdoBqNK8YzGTaDglplwIUQjRYDgtRe9MbNghQFxk6QupS54oLuMgw/VG
	 6uLjLBPaMOWTu9rTh6nev1QUBiaXS8YK0vagdXDTB1dKZZa3cgW5tV9tqubTKuN95W
	 vSKKTS1YYwuh7K2UBJrpU/v8GW8E3aHaafUWu3zrWfVc9ouq1WJgHRpGBxp6x4FLBk
	 0FlMg+ByW0aVA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	sdf@google.com,
	lorenzo@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] ynl: netdev: drop unnecessary enum-as-flags
Date: Tue,  3 Oct 2023 08:34:14 -0700
Message-ID: <20231003153416.2479808-2-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003153416.2479808-1-kuba@kernel.org>
References: <20231003153416.2479808-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

enum-as-flags can be used when enum declares bit positions but
we want to carry bitmask in an attribute. If the definition
is already provided as flags there's no need to indicate
the flag-iness of the attribute.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/netdev.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index c46fcc78fc04..14511b13f305 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -74,7 +74,6 @@ name: netdev
         doc: Bitmask of enabled xdp-features.
         type: u64
         enum: xdp-act
-        enum-as-flags: true
       -
         name: xdp-zc-max-segs
         doc: max fragment count supported by ZC driver
@@ -87,7 +86,6 @@ name: netdev
              See Documentation/networking/xdp-rx-metadata.rst for more details.
         type: u64
         enum: xdp-rx-metadata
-        enum-as-flags: true
 
 operations:
   list:
-- 
2.41.0


