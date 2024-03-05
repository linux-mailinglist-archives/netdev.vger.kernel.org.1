Return-Path: <netdev+bounces-77347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B308A871549
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 06:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33CC72836C2
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 05:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA39648CD4;
	Tue,  5 Mar 2024 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3AoJbF7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BD846521
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709616795; cv=none; b=iAPv3vXvL/SI6mVLKA+eHKhnjkMzhiMwhlklq51DK4iVxLewZkcC/a/8TLGeK4h9dE1VNFM19unmvEpn+Vj4T/bRmgL7fN4LBWp107aLJ5mVSag++Yn9WeCjJRtitAb+JpfEUYFSd2q87eCfYkMt3lx9NoTAaNrJErouaC+B9a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709616795; c=relaxed/simple;
	bh=gfGhKDWqLmA1HX7FbHSjRQuNVO0z6tj8IdrIzMApVK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ta4SWme6TiisB7KRPx2n1x5r2SbpWwDuzYPMsMyLwWtcFGMwlJVhjekBKXIUXCoLXNAG6ZdnbyR+TSu8KV3iZvYMmd+dDSQM5LlWETlGkkcETxl2auImvKTu1m6piocChk+kBj7cpMCQF2+ZpPpzr3rrya3cv2oioiQIEQgmAno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3AoJbF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBBB5C433C7;
	Tue,  5 Mar 2024 05:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709616795;
	bh=gfGhKDWqLmA1HX7FbHSjRQuNVO0z6tj8IdrIzMApVK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F3AoJbF77v+Rr8FzhhQcpfZmTONOsJc8YqKXZNbsPge/jAOXxT2pR5ksdLrByF+Xx
	 Y0+KrkFZBsMIvBQebJ+z/qUT++vWDMSvxyaazg2Xzs6nIN6Z1+FKO7IVuqYJ6bYGIo
	 BTW/RbLeVFvUZF37zdJoPtIqo57b3rWdsk3fvV2SD39h6m5ta72pJHJMrP1BEjEywN
	 KW+Ibm/4ljuJGhY6BZQn2XIMA6gcPeRscl0AEarN3qq8NdLncO9nyx7OkdribH1Iaa
	 yuhNswxGkf4H9i/off4hWscxAbxRdDzlU509ajcePBSo1pfHTjXcoOsNRd6gKiYIUQ
	 T70bgZ1pK/xTQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	donald.hunter@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/4] tools: ynl: move the new line in NlMsg __repr__
Date: Mon,  4 Mar 2024 21:33:07 -0800
Message-ID: <20240305053310.815877-2-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305053310.815877-1-kuba@kernel.org>
References: <20240305053310.815877-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We add the new line even if message has no error or extack,
which leads to print(nl_msg) ending with two new lines.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/lib/ynl.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index ac55aa5a3083..92ade9105f31 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -213,11 +213,11 @@ from .nlspec import SpecFamily
         return self.nl_type
 
     def __repr__(self):
-        msg = f"nl_len = {self.nl_len} ({len(self.raw)}) nl_flags = 0x{self.nl_flags:x} nl_type = {self.nl_type}\n"
+        msg = f"nl_len = {self.nl_len} ({len(self.raw)}) nl_flags = 0x{self.nl_flags:x} nl_type = {self.nl_type}"
         if self.error:
-            msg += '\terror: ' + str(self.error)
+            msg += '\n\terror: ' + str(self.error)
         if self.extack:
-            msg += '\textack: ' + repr(self.extack)
+            msg += '\n\textack: ' + repr(self.extack)
         return msg
 
 
-- 
2.44.0


