Return-Path: <netdev+bounces-120475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B989597F2
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A1A1C20832
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B281BAEDF;
	Wed, 21 Aug 2024 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QW8bENAL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CB81531F3
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 08:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230027; cv=none; b=FpA49ZOHvHQIvyvKva5tR30oQFDZBOmttMFRZPATqY4KqHyOvXt0WWCY+ydGPNZTkHbUeGabfGBp42WWmqhTb/pqooobmVdSC3D+aJGsTeol6+nbQhRPcVN8AydcqqYe8BY15BQO7356AXKycKhEsqk8s8rTpBNAttIwOpWf6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230027; c=relaxed/simple;
	bh=EF6rcjnbAyuOIcoXhtB5ZpzrVxZ3f6YX3ls6ndmRpBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fSHs0TM/Tp75B3E3osiHO2/QwirkpmdpJ2PphfAtXqjZwAmghNerFl6DuXZdduxXTom6Ucy1B+BiCAY50X1mpxZAbgMVJIRJc8tERkWY2EZaCAmDfV2D0Rw4nP7qKYhL22OPxxJnS0OFs3sNSS1Als2niMbdkGzYbOlfvFlGqig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QW8bENAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E6EC32782;
	Wed, 21 Aug 2024 08:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724230026;
	bh=EF6rcjnbAyuOIcoXhtB5ZpzrVxZ3f6YX3ls6ndmRpBM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QW8bENALJmAUPXGAmc5jjPa5WolZAutvkm2iD0nvnYUZeAWi+RsaaIHhoxb/weCjS
	 40oaNFX20a/QALmoMsZRvMEFA0gEFdlfZuWpr4xcVLgI7/x1sf+u97COkCTizEoVXS
	 VgC69U54Pm3KSuhzieyW56dZSb0eESthyMeB1V71LRuAVz/fclY6w3yp5DgMHp9Epj
	 L4+rJg2u1QScQzm7+4jzAH5Ir7HXkQHq2tLtqaoN6qMlGeCkhykBFX21S1oK6mGuuQ
	 UnMSJ47UxW37UFxh43uZqfjVwpZlLwUV4B81jZS4Hb7J45T6yTUCb1IgB7Wr8zjeoX
	 pmmy1r+V8mTTw==
From: Simon Horman <horms@kernel.org>
Date: Wed, 21 Aug 2024 09:46:48 +0100
Subject: [PATCH net v2 5/5] MAINTAINERS: Mark JME Network Driver as Odd
 Fixes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-net-mnt-v2-5-59a5af38e69d@kernel.org>
References: <20240821-net-mnt-v2-0-59a5af38e69d@kernel.org>
In-Reply-To: <20240821-net-mnt-v2-0-59a5af38e69d@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>, 
 Guo-Fu Tseng <cooldavid@cooldavid.org>, Moon Yeounsu <yyyynoom@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

This driver only appears to have received sporadic clean-ups, typically
part of some tree-wide activity, and fixes for quite some time.  And
according to the maintainer, Guo-Fu Tseng, the device has been EOLed for
a long time (see Link).

Accordingly, it seems appropriate to mark this driver as odd fixes.

Cc: Moon Yeounsu <yyyynoom@gmail.com>
Cc: Guo-Fu Tseng <cooldavid@cooldavid.org>
Link: https://lore.kernel.org/netdev/20240805003139.M94125@cooldavid.org/
Signed-off-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 798f1ffcbbaa..0c94ec0ca478 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11995,7 +11995,7 @@ F:	fs/jfs/
 JME NETWORK DRIVER
 M:	Guo-Fu Tseng <cooldavid@cooldavid.org>
 L:	netdev@vger.kernel.org
-S:	Maintained
+S:	Odd Fixes
 F:	drivers/net/ethernet/jme.*
 
 JOURNALLING FLASH FILE SYSTEM V2 (JFFS2)

-- 
2.43.0


