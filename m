Return-Path: <netdev+bounces-150659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F839EB228
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 14:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB14161B37
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CDA1A9B30;
	Tue, 10 Dec 2024 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIIioZTx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754DB5674D
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838469; cv=none; b=dd71Jt3q+Vqu40k65gIp6pHZmn8cm5hRkTNiwDLyYcA1PLsj8RsFg11xP531VPMMcu0lplH2SgU+ogsCE8uYAflzKW0UNq0Jm1FjzuvmNy89Vtb4dY/NLqS9qwVhCiCwpd1iMGPpzlF4S89kWcYFht89mFAbWI0pGsnvkt+lMRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838469; c=relaxed/simple;
	bh=rzV8WuFPFKqrbo+gZ85ozOein12RDMOXWWIDdOkg/6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=N+ItQQbvys3HgLYrEqPeG713+XT3aoegSjrUV3pRBOXsTT+MZTTWNatajITLzIOf4jsS0FWGTsj10pnxyDnrLi+spFrvvoEp9jHvrY6DM5rqz4VIIUvzbrQ0dtS0p1ft82wtl+6w1wJRjBdniF6m+HDiJPbC+TRmsOlJ5DP7PaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIIioZTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B40C4CED6;
	Tue, 10 Dec 2024 13:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733838469;
	bh=rzV8WuFPFKqrbo+gZ85ozOein12RDMOXWWIDdOkg/6A=;
	h=From:Date:Subject:To:Cc:From;
	b=CIIioZTx5m6U7YuzVoF0ADYdS42TgbT1zgJIkVrQ9XD5/Njp2OqmKzPCo5zaUdMPQ
	 YX0JNTt3Wjm+RlCrrd0MxmQfcbiarVnw04k/7fmTh4rM8vfvw5pozkSqnAA9cNI4VJ
	 4tuVvL/U+n/wHQWdiMe62q67C+WwPAXsYzqyKN6vifuDIvyHkzKdBRpfD3fnS2paA0
	 F4P/XHvltUsu034ilBIfsi9lStVp7oP2wKtEO/Y+Qg5Wl7q76rfluxrbgeyxiR3U4g
	 FfFdRbG9qeQeKYJgFzMtbUjkPryaGCFYNefZMCSQANXwdkdViy4bAH2TkhPbvG+ScX
	 tAhd5/eQv2DYQ==
From: Simon Horman <horms@kernel.org>
Date: Tue, 10 Dec 2024 13:47:44 +0000
Subject: [PATCH net] MAINTAINERS: Add ethtool.h to NETWORKING [GENERAL]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-mnt-ethtool-h-v1-1-2a40b567939d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAH9GWGcC/x3MQQqAIBBA0avErBswLayuEi1CpxwoDZUIorsnL
 d/i/wcSRaYEY/VApIsTB1/Q1BUYt/iNkG0xSCHbRooBD5+Rsssh7OhQW9lpsdreKAWlOSOtfP+
 /CTxlmN/3A20zicxkAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org
X-Mailer: b4 0.14.0

This is part of an effort to assign a section in MAINTAINERS to header
files related to Networking. In this case the files named ethool.h.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f84ec3572a5d..16c76ecca3f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16335,6 +16335,7 @@ F:	Documentation/networking/
 F:	Documentation/networking/net_cachelines/
 F:	Documentation/process/maintainer-netdev.rst
 F:	Documentation/userspace-api/netlink/
+F:	include/linux/ethtool.h
 F:	include/linux/framer/framer-provider.h
 F:	include/linux/framer/framer.h
 F:	include/linux/in.h
@@ -16349,6 +16350,7 @@ F:	include/linux/rtnetlink.h
 F:	include/linux/seq_file_net.h
 F:	include/linux/skbuff*
 F:	include/net/
+F:	include/uapi/linux/ethtool.h
 F:	include/uapi/linux/genetlink.h
 F:	include/uapi/linux/hsr_netlink.h
 F:	include/uapi/linux/in.h


