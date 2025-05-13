Return-Path: <netdev+bounces-190266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFA2AB5F3A
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 00:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0124D7B401C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 22:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B621FC10E;
	Tue, 13 May 2025 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lr6Fzf7p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839251F03D9
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 22:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747174674; cv=none; b=PPpe6HgNlDOTHqO99cotBRXR//Qycv/NIPenN5pMIfDZZcEpBNVoYZc18QKrCwlhcyTVXZQnwd/vpdb1ieBhEtOArKPp/BsTwvESmO3d6iRE2ekgDKMq35OTkLBKeEinzAfgE2d/+5Focl/pzwtqrKmnWimTey3PuJ6UsdAhtrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747174674; c=relaxed/simple;
	bh=Usbyw9npU36eofCSxKUIwQfyA5HC9DVwjiQ9KbqWcyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVvsHQW5Ys173BTUggc7JxmlmQz5bsXyuwkhdtA/q5ttqtrW59egdKoeQvlJ+NFvlJGWJjucb/+7u4J88UAPJmR0LsHjzGWGeJEsYt3a6SzfuuqIZJ/BAWsPY/BEoqW8Gle5Wf9oxD+/eUcnrK6KD7Ui9vrv4Vj5uBCXFHUOSIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lr6Fzf7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC2DC4CEE4;
	Tue, 13 May 2025 22:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747174674;
	bh=Usbyw9npU36eofCSxKUIwQfyA5HC9DVwjiQ9KbqWcyE=;
	h=From:To:Cc:Subject:Date:From;
	b=lr6Fzf7peeScIqfR5j0e5kB4MCPrxmMDdWxdVF77LGr0lIJbi0sZ3WIN/piN0gY2X
	 wbMAddB5y1jz+I3PWL+cF4uiz2zSlut62oBF8wpUd2n8Dnsrkp0XUT0PAzdj4W7r5/
	 6CeRznbSQFQwvy1uCEctyK+n/AWBVKwqq5ySIFYOEeXq+A9AjV+hzGyYORVYLb/H1f
	 OQ9EXgJrpAm28BvymWLJ7I+j3OjRkX+BszQpbYXbVh/FpIcob/LoaQV4CzjAU8nkiU
	 9sFCXoTOxZ4BLydr6YF85tlDNRABGJ5Lkxp6FfsC3eooRQXjHcCRAL0fcfsXxSK+Gl
	 QwFnZjofNAlVQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Subject: [PATCH net-next] net: sched: uapi: add more sanely named duplicate defines
Date: Tue, 13 May 2025 15:17:52 -0700
Message-ID: <20250513221752.843102-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TCA_FLOWER_KEY_CFM enum has a UNSPEC and MAX with _OPT
in the name, but the real attributes don't. Add a MAX that
more reasonably matches the attrs.

The PAD in TCA_TAPRIO is the only attr which doesn't have
_ATTR in it, perhaps signifying that it's not a real attr?
If so interesting idea in abstract but it makes codegen painful.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: jhs@mojatatu.com
CC: xiyou.wangcong@gmail.com
CC: jiri@resnulli.us
---
 include/uapi/linux/pkt_cls.h   | 1 +
 include/uapi/linux/pkt_sched.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index 490821364165..28d94b11d1aa 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -697,6 +697,7 @@ enum {
 };
 
 #define TCA_FLOWER_KEY_CFM_OPT_MAX (__TCA_FLOWER_KEY_CFM_OPT_MAX - 1)
+#define TCA_FLOWER_KEY_CFM_MAX	   (__TCA_FLOWER_KEY_CFM_OPT_MAX - 1)
 
 #define TCA_FLOWER_MASK_FLAGS_RANGE	(1 << 0) /* Range-based match */
 
diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 9ea874395717..3e41349f3fa2 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -1182,6 +1182,7 @@ enum {
 	TCA_TAPRIO_ATTR_SCHED_SINGLE_ENTRY, /* single entry */
 	TCA_TAPRIO_ATTR_SCHED_CLOCKID, /* s32 */
 	TCA_TAPRIO_PAD,
+	TCA_TAPRIO_ATTR_PAD = TCA_TAPRIO_PAD,
 	TCA_TAPRIO_ATTR_ADMIN_SCHED, /* The admin sched, only used in dump */
 	TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME, /* s64 */
 	TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME_EXTENSION, /* s64 */
-- 
2.49.0


