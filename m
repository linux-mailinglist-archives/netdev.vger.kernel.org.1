Return-Path: <netdev+bounces-138208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 257649AC9D2
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 14:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5356C1C23960
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207851E489;
	Wed, 23 Oct 2024 12:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QODBdm+u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA103FD4;
	Wed, 23 Oct 2024 12:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685736; cv=none; b=Ohoe1lFMc27KARhyU9/G/h54O0qleHBpkd5VnfxV//RgnhqCksT4UY0FSnjgj1pr2UjI7PhGxDiCtSrrvmr3aful5kviT1N5jWACZ/bSnxWehuF0N4Sfvp2VL9JLsGEs4dJgPilnYKJUDpYBdVG2jSkrS1S6RWQGrHkOnuRLdc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685736; c=relaxed/simple;
	bh=zmEV7kzYjK4FvefIs+qoE3S15A9ktltXHDxx9f+lFC4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CN0vgTyKh57swy+GLHZIICsCt9iyl+9zSOOzVFWuguut80r6/rQndRrucow0UnwYeGtEqc5LaOUdsCIr1D6k9PN5/xJHVXpPP8Pv9VG8/D6dsZujDjLYxajDQqWsrRgHWSvGMku6iBnUCUHoebuFPynmPP9Kp21LjRTpaSviUxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QODBdm+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC00AC4CEC6;
	Wed, 23 Oct 2024 12:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729685735;
	bh=zmEV7kzYjK4FvefIs+qoE3S15A9ktltXHDxx9f+lFC4=;
	h=From:Date:Subject:To:Cc:From;
	b=QODBdm+uAODGHRZP2fHYKCDpUiFMbnIR8jUcCQmizxUAusYQc1tmjeYWYAsFzXOym
	 ++m9Run639Zf6UKyq7evfoQ1MQauQWdwFpsjWDrFxMmcdxPvjg+gil/GPGJo74vhGW
	 8gSIrdVkxxH04j6r79S823gNXDAC6md7VaJ6lAI/XN63szTW7SEbeALCdhppa/G4+9
	 1WY4Fss7CwWgFG66jV7kM0MAPFHw0seW6Xhdknb4YdGaVVATMjhFPjz4WRrtYJlvq9
	 q24NdUlH9vOaClg8cc5aWz8LEfZ6kp7cRj2r8KMofUsbsSWHsY1mrQyHIMDTU/Ptbi
	 MfEgIYmVAWMcw==
From: Simon Horman <horms@kernel.org>
Date: Wed, 23 Oct 2024 13:15:28 +0100
Subject: [PATCH net-next] wwan: core: Pass string literal as format
 argument of dev_set_name()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-wwan-fmt-v1-1-521b39968639@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN/oGGcC/x3MwQpAQBCA4VfRnE2ZReJV5CBmmIOh3Q0l725z/
 OrvfyCwVw7QZQ94PjXobgmUZzCtoy2MOieDK1xFhSvxukZD2SK2ROLKphahBlJ+eBa9/1UPxhG
 N7wjD+36j/2/XZAAAAA==
To: Loic Poulain <loic.poulain@linaro.org>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 netdev@vger.kernel.org, llvm@lists.linux.dev
X-Mailer: b4 0.14.0

Both gcc-14 and clang-18 report that passing a non-string literal as the
format argument of dev_set_name() is potentially insecure.

E.g. clang-18 says:

drivers/net/wwan/wwan_core.c:442:34: warning: format string is not a string literal (potentially insecure) [-Wformat-security]
  442 |         return dev_set_name(&port->dev, buf);
      |                                         ^~~
drivers/net/wwan/wwan_core.c:442:34: note: treat the string as an argument to avoid this
  442 |         return dev_set_name(&port->dev, buf);
      |                                         ^
      |                                         "%s",

It is always the case where the contents of mod is safe to pass as the
format argument. That is, in my understanding, it never contains any
format escape sequences.

But, it seems better to be safe than sorry. And, as a bonus, compiler
output becomes less verbose by addressing this issue as suggested by
clang-18.

Compile tested only.
No functional change intended.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/wwan/wwan_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 17431f1b1a0c..465e2a0d57a3 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -431,7 +431,7 @@ static int __wwan_port_dev_assign_name(struct wwan_port *port, const char *fmt)
 		return -ENFILE;
 	}
 
-	return dev_set_name(&port->dev, buf);
+	return dev_set_name(&port->dev, "%s", buf);
 }
 
 struct wwan_port *wwan_create_port(struct device *parent,


