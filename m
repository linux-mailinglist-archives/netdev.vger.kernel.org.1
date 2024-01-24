Return-Path: <netdev+bounces-65389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4499183A500
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B2E1C220AA
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0A217BD5;
	Wed, 24 Jan 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVJdT5/H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959BC17BBA
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706087789; cv=none; b=l3I/ezGp9UrDxuJAfk06W7VNYTfzG1AksNRWC8Ktle7T4iU0IXgPP45wg9wKbfcips2OhmhLxSlD0+ay8GSVGCA+V0+OFqNkJf0IldyN42XKYHoxDQ4zumKsjcB+4T/2YXUBwX2sLYY9nqmtzbyGULexWC+kluIAukmtpWz9HkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706087789; c=relaxed/simple;
	bh=KTFp4rMu4AOWVKnnPJeG6Zwc5PkwGn4jaLh6mXeYDfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W87i8OJFBku8hZMPBfF6w3DyoARQAkAx1MCoowmN2mhpqUqTjhwBtBgTi7OfAEvr/AU7CY1mavlgIF5yRzaHiKWYEHp8RYSF2SOgT5qzr/HztCJeAVpHrufa+Oj4FxSIBC/+o080Znxx4yM0XtvVVG+qaC3I/5vuE/KZMkblWqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVJdT5/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E67C433C7;
	Wed, 24 Jan 2024 09:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706087789;
	bh=KTFp4rMu4AOWVKnnPJeG6Zwc5PkwGn4jaLh6mXeYDfA=;
	h=From:Date:Subject:To:Cc:From;
	b=AVJdT5/HbHNO4+WE22LzkBGuABg9lfccRKbGL4Fw4HVH1PG/a2bk3rOJoJWfv9BFt
	 TFIjETVcpAh3kJ/Q/rZtqI8SoG0Qm0Yfv+ac3CJnSeUR49apt5404eBOgDaRoZ4E1+
	 MFtSgfiCkItVr6xySU8J3ZGjbnQtIEtv7ocAoh0k09caex6OzsEOKvzyCLfvUPlGey
	 4Q6o7AtDOArUJw68948B7h48F6y2SoWwrsRiOybE6dB1k9EyEdvJ0TFHAx1BZjtHnM
	 crC2ijb7p8nW/2+QLm+FNrIZgLS6pPP+cdVR20x7iE9GGKAw3lsKVcZ3GfFFHvNwUn
	 erBrc4YtD1/Jg==
From: Simon Horman <horms@kernel.org>
Date: Wed, 24 Jan 2024 09:16:22 +0000
Subject: [PATCH net] MAINTAINERS: Add connector headers to NETWORKING
 DRIVERS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-connector-maintainer-v1-1-a9703202fd9a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGXVsGUC/x2MwQqDMBAFf0X23EASImh/pfSQxKfuwU3ZhCKI/
 97QwxzmMHNRhTIqPYeLFF+uXKSLewyU9ygbDC/dyVsfrPPB5CKC3IqaI7K0DtS4NFrEyfk4J+r
 pR7Hy+d++SNDofd8/LV54RGsAAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, netdev@vger.kernel.org
X-Mailer: b4 0.12.3

Commit 46cf789b68b2 ("connector: Move maintainence under networking
drivers umbrella.") moved the connector maintenance but did not include
the connector header files.

It seems that it has always been implied that these headers were
maintained along with the rest of the connector code, both before and
after the cited commit. Make this explicit.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8709c7cd3656..8e5cb3e1dac9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15158,6 +15158,7 @@ F:	Documentation/networking/net_cachelines/net_device.rst
 F:	drivers/connector/
 F:	drivers/net/
 F:	include/dt-bindings/net/
+F:	include/linux/cn_proc.h
 F:	include/linux/etherdevice.h
 F:	include/linux/fcdevice.h
 F:	include/linux/fddidevice.h
@@ -15165,6 +15166,7 @@ F:	include/linux/hippidevice.h
 F:	include/linux/if_*
 F:	include/linux/inetdevice.h
 F:	include/linux/netdevice.h
+F:	include/uapi/linux/cn_proc.h
 F:	include/uapi/linux/if_*
 F:	include/uapi/linux/netdevice.h
 X:	drivers/net/wireless/


