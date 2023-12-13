Return-Path: <netdev+bounces-57111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CAF8122AF
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7F91F21A45
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2A583AF7;
	Wed, 13 Dec 2023 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maQ9uCAT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33A483AF2
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 23:14:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E888CC433CA;
	Wed, 13 Dec 2023 23:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702509285;
	bh=flIAwSaSh6m73uz9lzNhB5DEbgY2pOxoagoNKljRwys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=maQ9uCATWUEqNjK4wk+HcGj0zrcxTy9roil7Esa4/Jzj5ocWE3KkYjeIBolHdwV9U
	 XhJNQp9wt7Di23qrcEncb7fDSP6za0Y0U9yrqXSs/R/F2pnr9zBBqxUuSL9KPyw02P
	 fwEvuVPL+1inQ23KgNS8yQRYvHKZlVZ4xIWSuUufIhVXf4ICWXUGTPKACeKt7bvoR/
	 37jkYN1kQ4rc/BUadVXHIw3EZqNQpL6HIi8xwie1hdEWOy6SQTUEaX2i6Z/6N5n2VA
	 S0b3NBrQp5G3SDyAswLThR24dLxeFWg3gIwFzYGfAf+2nTKQHUBvirRZbIyoZPJaZ8
	 4NIjTohsQYAVA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/8] tools: ynl-gen: add missing request free helpers for dumps
Date: Wed, 13 Dec 2023 15:14:25 -0800
Message-ID: <20231213231432.2944749-2-kuba@kernel.org>
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

The code gen generates a prototype for dump request free
in the header, but no implementation in the source.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/ynl-gen-c.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
index 266bc1629e58..9484882dbc2e 100755
--- a/tools/net/ynl/ynl-gen-c.py
+++ b/tools/net/ynl/ynl-gen-c.py
@@ -2771,6 +2771,7 @@ _C_KW = {
                     ri = RenderInfo(cw, parsed, args.mode, op, "dump")
                     if not ri.type_consistent:
                         parse_rsp_msg(ri, deref=True)
+                    print_req_free(ri)
                     print_dump_type_free(ri)
                     print_dump(ri)
                     cw.nl()
-- 
2.43.0


