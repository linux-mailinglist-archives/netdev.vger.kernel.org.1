Return-Path: <netdev+bounces-120474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 506FE9597F1
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 12:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 680C11C214AA
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827E81B78FF;
	Wed, 21 Aug 2024 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKlHYQKX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EADF1531F3
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724230024; cv=none; b=E+l1T/ZNYhlFqYWtTncd2HYXGnM/K8WBKiXXOcjBHBd8pe1ukWQ22PVB0QvEIfSTXN0nEQGSzCK0zy81E2ua8UJ9YBy0K7v5duin6AeNsxWh4ssh3O28XTLsTvcDpKvdJC1gGDI63kX5fxGB8uetJiWJUdX0Zauk+33PzuoVfjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724230024; c=relaxed/simple;
	bh=+Zs1kYfYdpQXPl2PEO/eNnYnLBHTmoV6WrNatc++9cE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hbTpytEiVLkbqSCn4nhPfF6IksuBO/bkZ63R9T7nse19/dIcZfek1SQ0NpNS90+brP/LUgBY9MtsB/v4HjnLppzt8UYTF45o2J0nNT3EzpRic77dmNKHlEhxQhMnxLq5zAvcCWOLrTXGg4AzmuEr8kEp8A4O8vXYBBY1D+qEDXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKlHYQKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5F4C4AF0C;
	Wed, 21 Aug 2024 08:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724230023;
	bh=+Zs1kYfYdpQXPl2PEO/eNnYnLBHTmoV6WrNatc++9cE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LKlHYQKXj0XddMb1ALJ3gq5fCZTDKsK05GJfwaKZ0+cO78HauHV5v804VjjnqZ422
	 UqemVmVDWgVkYFLK9l/4BxILl3HKIx61gQwNhnP0hdjSQaMwhzES8kJhYiYKQBvklI
	 E9YeRyHGFnFQT5qHEcypUzZP48qbxODe+4SZcur7dPv34Ct2QGonwF3pioTVKvrKPU
	 tF2+lmqrlR0pl/QheJa0OI84L58jEnCgkX1HkfjiDHm3FwHccII74Yxul2lFog3rzN
	 eBaajdl0LZFGYY4yn/FixxQpZLIuQu75QNxbRy/EoLxs2OSEcQK+pUcnZ1FxJjeMxo
	 sQS0ArVPz5dFw==
From: Simon Horman <horms@kernel.org>
Date: Wed, 21 Aug 2024 09:46:47 +0100
Subject: [PATCH net v2 4/5] MAINTAINERS: Add header files to NETWORKING
 sections
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-net-mnt-v2-4-59a5af38e69d@kernel.org>
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

This is part of an effort to assign a section in MAINTAINERS to header
files that relate to Networking. In this case the files with "net" or
"skbuff" in their name.

This patch adds a number of such files to the NETWORKING DRIVERS
and NETWORKING [GENERAL] sections.

Signed-off-by: Simon Horman <horms@kernel.org>
---
v2:
* Do not add net_shaper.h, it is not present upstream (hopefully soon :)
* Update for new, earlier, patch in series which adds more globs
---
 MAINTAINERS | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03d571b131eb..798f1ffcbbaa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15879,13 +15879,16 @@ F:	drivers/net/
 F:	include/dt-bindings/net/
 F:	include/linux/cn_proc.h
 F:	include/linux/etherdevice.h
+F:	include/linux/ethtool_netlink.h
 F:	include/linux/fcdevice.h
 F:	include/linux/fddidevice.h
 F:	include/linux/hippidevice.h
 F:	include/linux/if_*
 F:	include/linux/inetdevice.h
 F:	include/linux/netdev*
+F:	include/linux/platform_data/wiznet.h
 F:	include/uapi/linux/cn_proc.h
+F:	include/uapi/linux/ethtool_netlink.h
 F:	include/uapi/linux/if_*
 F:	include/uapi/linux/netdev*
 F:	tools/testing/selftests/drivers/net/
@@ -15939,14 +15942,28 @@ F:	include/linux/framer/framer-provider.h
 F:	include/linux/framer/framer.h
 F:	include/linux/in.h
 F:	include/linux/indirect_call_wrapper.h
+F:	include/linux/inet.h
+F:	include/linux/inet_diag.h
 F:	include/linux/net.h
 F:	include/linux/netdev*
+F:	include/linux/netlink.h
+F:	include/linux/netpoll.h
+F:	include/linux/rtnetlink.h
+F:	include/linux/seq_file_net.h
 F:	include/linux/skbuff*
 F:	include/net/
+F:	include/uapi/linux/genetlink.h
+F:	include/uapi/linux/hsr_netlink.h
 F:	include/uapi/linux/in.h
+F:	include/uapi/linux/inet_diag.h
+F:	include/uapi/linux/nbd-netlink.h
 F:	include/uapi/linux/net.h
 F:	include/uapi/linux/net_namespace.h
+F:	include/uapi/linux/netconf.h
 F:	include/uapi/linux/netdev*
+F:	include/uapi/linux/netlink.h
+F:	include/uapi/linux/netlink_diag.h
+F:	include/uapi/linux/rtnetlink.h
 F:	lib/net_utils.c
 F:	lib/random32.c
 F:	net/

-- 
2.43.0


