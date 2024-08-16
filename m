Return-Path: <netdev+bounces-119194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B119548E1
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 14:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CC52859AA
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 12:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764C31AE87B;
	Fri, 16 Aug 2024 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcrlPXyD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C7216F839
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811914; cv=none; b=rVzwyhP9Sk0hwonIpVNzjhbaVjyv0hiKhfwZhsTvB/YOGz98fjYERmqrp4fIH2j0V0tzw77UDdQjQ/dRPFL1oxveJ0ufFOwr44kPykxJ0/K3ZkirgCn1xrGeOuKf+gdDUH6d7H+ZCD8WvwIZMQu62GiKyy/SLj+D7DEqn/5zFbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811914; c=relaxed/simple;
	bh=T2Y3q6D24VT80rvA2o22gEeD788v8Gqkudz9gBxhZZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GE35QdElm+V/7zkeTNpe8J6xkRqBBhNS6Isvu5gqaRQhngxAPHWniw5yukYfWmtl38qhl/qXVY6E5mIwrp9jGLfqeEgPWrGom/wQElLn5CblKJq7+LVgxcwmWlZsnINgc5i+YiXp8NrgOnORkJKkZdwc+Dyd4aqemAb+DqKlT9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcrlPXyD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAA3C4AF09;
	Fri, 16 Aug 2024 12:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723811913;
	bh=T2Y3q6D24VT80rvA2o22gEeD788v8Gqkudz9gBxhZZ8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DcrlPXyDT+P/qCLK7BEgnB4dy5yUfXwvBnYRjrLSPLYH6LN4wg3cxslRBiRoe0d4/
	 r7Ir/UuyDaIU6Nj/S0fNVwkpqWdTqPe1M8y5k8S24j1FuPeWxLKFRALKHIjstL9dy5
	 jbzGuAaC8pFdqs/CMMQimqhp07z9myYazsOwwkVYqS47okOmapFA6/8CgULllF20AT
	 7b6kI0L6lKnVdK0R79nO0DdZXhF7goTkgRu7J+OsPKX/XZnzuJxPmAu5/4LTHsK4Wu
	 eDMW0yc+ITEwTrbWfhn2exoWOn7kFMzQK6ClNUqE0RXNxdpAvkBfkEDYwvLywLw3If
	 2Q368k70C1pRw==
From: Simon Horman <horms@kernel.org>
Date: Fri, 16 Aug 2024 13:38:02 +0100
Subject: [PATCH net 3/4] MAINTAINERS: Add header files to NETWORKING
 sections
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-net-mnt-v1-3-ef946b47ced4@kernel.org>
References: <20240816-net-mnt-v1-0-ef946b47ced4@kernel.org>
In-Reply-To: <20240816-net-mnt-v1-0-ef946b47ced4@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>, 
 Guo-Fu Tseng <cooldavid@cooldavid.org>, Moon Yeounsu <yyyynoom@gmail.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

This is part of an effort to assign a section in MAINTAINERS to header
files that relate to Networking. In this case the files with "net" or
"skbuff" in their name.

This patch adds a number of such files to the NETWORKING DRIVERS
and NETWORKING [GENERAL] sections.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 28a67b93cef1..38f3731d0e3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15879,14 +15879,19 @@ F:	drivers/net/
 F:	include/dt-bindings/net/
 F:	include/linux/cn_proc.h
 F:	include/linux/etherdevice.h
+F:	include/linux/ethtool_netlink.h
 F:	include/linux/fcdevice.h
 F:	include/linux/fddidevice.h
 F:	include/linux/hippidevice.h
 F:	include/linux/if_*
 F:	include/linux/inetdevice.h
 F:	include/linux/netdevice.h
+F:	include/linux/netdevice_xmit.h
+F:	include/linux/platform_data/wiznet.h
 F:	include/uapi/linux/cn_proc.h
+F:	include/uapi/linux/ethtool_netlink.h
 F:	include/uapi/linux/if_*
+F:	include/uapi/linux/netdev.h
 F:	include/uapi/linux/netdevice.h
 F:	tools/testing/selftests/drivers/net/
 X:	drivers/net/wireless/
@@ -15939,14 +15944,31 @@ F:	include/linux/framer/framer-provider.h
 F:	include/linux/framer/framer.h
 F:	include/linux/in.h
 F:	include/linux/indirect_call_wrapper.h
+F:	include/linux/inet.h
+F:	include/linux/inet_diag.h
 F:	include/linux/net.h
+F:	include/linux/netdev_features.h
 F:	include/linux/netdevice.h
+F:	include/linux/netlink.h
+F:	include/linux/netpoll.h
+F:	include/linux/rtnetlink.h
+F:	include/linux/seq_file_net.h
 F:	include/linux/skbuff.h
+F:	include/linux/skbuff_ref.h
 F:	include/net/
+F:	include/uapi/linux/genetlink.h
+F:	include/uapi/linux/hsr_netlink.h
 F:	include/uapi/linux/in.h
+F:	include/uapi/linux/inet_diag.h
+F:	include/uapi/linux/nbd-netlink.h
 F:	include/uapi/linux/net.h
 F:	include/uapi/linux/net_namespace.h
+F:	include/uapi/linux/net_shaper.h
+F:	include/uapi/linux/netconf.h
 F:	include/uapi/linux/netdevice.h
+F:	include/uapi/linux/netlink.h
+F:	include/uapi/linux/netlink_diag.h
+F:	include/uapi/linux/rtnetlink.h
 F:	lib/net_utils.c
 F:	lib/random32.c
 F:	net/

-- 
2.43.0


