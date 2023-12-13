Return-Path: <netdev+bounces-57114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B728122B2
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A76FB2119A
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BFA8183A;
	Wed, 13 Dec 2023 23:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQEdwAbp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD6D83B15
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 23:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CEAC433C8;
	Wed, 13 Dec 2023 23:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702509286;
	bh=KdHOpyFcGGsmqQNpJLnfkjqiJp+rC9mvWsykT9W5jxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gQEdwAbpze3DYLH2tzzcgeGW884SQV7nTCYXk6HzyBZhxTBXC8EDXdntRHYGoTDOe
	 gWxu9CIyC5dkfURGvATF5eHQBr4i6nlevhz6dWWF1+OYuTb9xE+Ar5ThkjjFswMy4u
	 s9NMCSvUTlvvIGhHC3LPqk9gwn4yFOfJzI0Vqd0L748Juq1guIMnDCOrqQN/O1UGNl
	 inEskPldBr/TGPd+MX8ssXHHvpFB8oRh66eI/7WOLw1rEzUQSRBiRwgzM7hjrIrdBK
	 jC6B/G4UwtXoVuOpvdlZ22kJ0SgiQS5uN8y8jJC2Yo7fj3YQ+vM/aF8PGoGmaT8F8g
	 i1LFEd8IHke3g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 4/8] tools: ynl-gen: fill in implementations for TypeUnused
Date: Wed, 13 Dec 2023 15:14:28 -0800
Message-ID: <20231213231432.2944749-5-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213231432.2944749-1-kuba@kernel.org>
References: <20231213231432.2944749-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fill in more empty handlers for TypeUnused. When 'unused'
attr gets specified in a nested set we have to cleanly
skip it during code generation.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 70e2c41e5bd6..2b7961838fb6 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -264,6 +264,15 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
     def attr_policy(self, cw):
         pass
 
+    def attr_put(self, ri, var):
+        pass
+
+    def attr_get(self, ri, var, first):
+        pass
+
+    def setter(self, ri, space, direction, deref=False, ref=None):
+        pass
+
 
 class TypePad(Type):
     def presence_type(self):
-- 
2.43.0


