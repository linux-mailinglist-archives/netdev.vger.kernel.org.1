Return-Path: <netdev+bounces-134680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA5999ACBD
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 21:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969121F22DDC
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E97F1D07B6;
	Fri, 11 Oct 2024 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iH0GxxP6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F371D07AE
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 19:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675190; cv=none; b=RreCvpRiIyLrXwfb+E0xKyglR3klhk2H/nsIP7/eBvz6PTbZFWSBkDaAmlUmHN3jEJpXkQRhxbFVuTsCUtkLWjmBPFnl+t6Y9q4VfhIGQu1BsKkJ+N3FBHMdhJtg2xb5scKCA5k4wfkiuENy1VHBoNHNZ/31HbDPOK1BRG5GuxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675190; c=relaxed/simple;
	bh=c2WiAkVNOZQ6wd0rx4188voQxJtCOm0yiqpnATco/fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qxwHHQbOiLuGghItvuY8PVBEBn1iC8myApFg1thadDNPLPDyIj4AmAxzg+cmt1aCP5silnBZfZLgPA6B59P08kWrd3gcFfoVXD0gzEl8moaYDKIYV62xdgBJbVN9ui9FQC+YrwlZxVxp+/KNL0rZB9YejwGXsQlVPxhm1KBUnsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iH0GxxP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE374C4CEC3;
	Fri, 11 Oct 2024 19:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728675190;
	bh=c2WiAkVNOZQ6wd0rx4188voQxJtCOm0yiqpnATco/fo=;
	h=From:To:Cc:Subject:Date:From;
	b=iH0GxxP6mo4DDISsEisax+d1unBRBgiHE484v8Wo4P5seaojM8zG+uo+MsJkwejk5
	 h6/tPdwXx8PqibBxifirfQeL4VYccPrn5vOr2oJu6iRjp97GbwsfBfpUgloiKE+GAo
	 JAS0t0nMhmBGDy3nMLpaQY9dbRl/W1ZCWUo5cAkUY7aZMc5GLiXsedXrAzXtj34zfm
	 YVrsLPKMYSsHl3sHZp6EsSPZrsoBWlSHoG3KpbCdCzcsuQQR59Nna7ifQKFSB5f2zS
	 u78V2HMH0+QbYtofVyAyn2QEyyTf3uGex13EO10+Z5tOj2TEa/Cbx1QjLO7TWrEbQk
	 8vGouLjvnFdVg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] MAINTAINERS: add Andrew Lunn as a co-maintainer of all networking drivers
Date: Fri, 11 Oct 2024 12:33:03 -0700
Message-ID: <20241011193303.2461769-1-kuba@kernel.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Andrew has been a pillar of the community for as long as I remember.
Focusing on embedded networking, co-maintaining Ethernet PHYs and
DSA code, but also actively reviewing MAC and integrated NIC drivers.
Elevate Andrew to the status of co-maintainer of all netdev drivers.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1d95b276f0f..fc1a19809ea1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16104,6 +16104,7 @@ F:	include/uapi/linux/net_dropmon.h
 F:	net/core/drop_monitor.c
 
 NETWORKING DRIVERS
+M:	Andrew Lunn <andrew+netdev@lunn.ch>
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Eric Dumazet <edumazet@google.com>
 M:	Jakub Kicinski <kuba@kernel.org>
-- 
2.46.2


