Return-Path: <netdev+bounces-78984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3246287734C
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 19:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF321F21E5D
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 18:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32FB481C7;
	Sat,  9 Mar 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEypEXO5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE023481BD
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710009305; cv=none; b=swOWGIK1cMtugHGm7cnnqB4jWvS1tNeqxjhYmftS9vdZ9rRNQmWYp4kCW7A6RWv/xhE4tSH5TavHl8pQL6muCU3f31OF1oAoceJWizyb7ieKJ2KgAxYOXGVBmFULsuwQJsSY4Q53DfnZWbMz6TfXl2d//FMHeVOERr5dKGh5lOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710009305; c=relaxed/simple;
	bh=QqQarZgY15uMZOOjoxFPSgU1BYh2Tq32Aw0DEWAre6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgbiC9tyeVrsG5JsX0Y47IV1kwsF8OoCUnhAaLz0kQiCppiocLXom6VkT1YbGfuvXQR0d1S6jmmTRsHO8KP3XZThRjkvHm2x4bOZ0ykKZp/R1Oq0jh/Lc4HXLY1GTfAnfebvIntYB+V7IjSKbV9o4vPlQrTGYyE4Ypx+Hf6f0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lEypEXO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596C7C43399;
	Sat,  9 Mar 2024 18:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710009305;
	bh=QqQarZgY15uMZOOjoxFPSgU1BYh2Tq32Aw0DEWAre6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lEypEXO5fpKQ8qensJZY/+6qipbRvn4TE7HvHhdn/K0Q4hKc5EarhL1+SrCxAGItX
	 emYEotAzdUDMBtFwx7DjHq4vhro5PcwiJ0y1gPvlBxWHu097lweiMQIorR22RRAUPx
	 7qtnO5jRNPCaaIADyMggm1vRbMNJj8Jfz4YKBBtrzNPBWH6ij8AC7RioU6KKFUHHw/
	 GI/IzXqLiOQwEngkvWqhlECgnxH1mUEFqmXhpj2IwIjkcDf+CanKk/QPHl9l6FGpU1
	 PskCtae3kxRuuVWMUqEeXIWXWFUbKHWVPqLtu+gCNPJq0Lw7Ncc4GO4YojalhVGxZM
	 rPITIwesM5uxQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>,
	pshelar@ovn.org,
	dev@openvswitch.org
Subject: [PATCH net-next 2/3] net: openvswitch: remove unnecessary linux/genetlink.h include
Date: Sat,  9 Mar 2024 10:34:57 -0800
Message-ID: <20240309183458.3014713-3-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240309183458.3014713-1-kuba@kernel.org>
References: <20240309183458.3014713-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The only legit reason I could think of for net/genetlink.h
and linux/genetlink.h to be separate would be if one was
included by other headers and we wanted to keep it lightweight.
That is not the case, net/openvswitch/meter.h includes
linux/genetlink.h but for no apparent reason (for struct genl_family
perhaps? it's not necessary, types of externs do not need
to be known).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: pshelar@ovn.org
CC: dev@openvswitch.org
---
 net/openvswitch/meter.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/openvswitch/meter.h b/net/openvswitch/meter.h
index ed11cd12b512..8bbf983cd244 100644
--- a/net/openvswitch/meter.h
+++ b/net/openvswitch/meter.h
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/netlink.h>
 #include <linux/openvswitch.h>
-#include <linux/genetlink.h>
 #include <linux/skbuff.h>
 #include <linux/bits.h>
 
-- 
2.44.0


