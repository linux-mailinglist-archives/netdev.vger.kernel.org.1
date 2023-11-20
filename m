Return-Path: <netdev+bounces-49105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D157F0D8C
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A7822817A8
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0915EF4EB;
	Mon, 20 Nov 2023 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ig6RPiZa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D0E63C6
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 08:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B2EC433C8;
	Mon, 20 Nov 2023 08:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700468950;
	bh=3CouQvwHRCHLRdvaRjTMN428V1X6HNQeCsP2HwMtMDw=;
	h=From:Date:Subject:To:Cc:From;
	b=ig6RPiZaPLBgrhmzxG3MPBdxSHECiwVFeH8xRLVZrl+HM8bQ660m1ZGBJNwKILIXC
	 ro+bv8h9ta70hh8Px567vwTjh98qHW90zYGqjB+Rfk5+lcQv36GjZ0re8Lj/zogRrg
	 NCRclp0VUDFPu/YpLH9dRktBaiJjuI9a6QTgch3xWaVGxd9v369exKdPcz339ZA1/b
	 IxFHbyXGnRXAW1ucMh3+WYosTYXfdPNrEJkvG4cey/QSQcJWU5i8wperC6sy8ZlLb4
	 9yE+KXS86U9uchqR6+kbz/3UlznadpX9jpoTjFrVsXB7jXotWYiIJUe1cgsKQf1PYQ
	 Tr7I4Fw4iWupg==
From: Simon Horman <horms@kernel.org>
Date: Mon, 20 Nov 2023 08:28:40 +0000
Subject: [PATCH net-next] MAINTAINERS: Add indirect_call_wrapper.h to
 NETWORKING [GENERAL]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231120-indirect_call_wrapper-maintainer-v1-1-0a6bb1f7363e@kernel.org>
X-B4-Tracking: v=1; b=H4sIALcYW2UC/x2N0QrCMAxFf2Xk2ULbgVN/RWRkbaaBGUtadDD27
 4Y9HLjn5Z4NKilThVu3gdKXK3/EJJw6SC+UJznO5hB97EOI3rFkVkptTLgs40+xFFL3RpZm2Jy
 n6Tr0wZ8zXsBuitLM65G4g1BzQmuDx77/AWMD7S58AAAA
To: Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.12.3

indirect_call_wrapper.h  is not, strictly speaking, networking specific.
However, it's git history indicates that in practice changes go through
netdev and thus the netdev maintainers have effectively been taking
responsibility for it.

Formalise this by adding it to the NETWORKING [GENERAL] section in the
MAINTAINERS file.

It is not clear how many other files under include/linux fall into this
category and it would be interesting, as a follow-up, to audit that and
propose further updates to the MAINTAINERS file as appropriate.

Link: https://lore.kernel.org/netdev/20231116010310.4664dd38@kernel.org/
Signed-off-by: Simon Horman <horms@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 482d428472e7..b0493ebd361a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15055,6 +15055,7 @@ F:	Documentation/networking/
 F:	Documentation/process/maintainer-netdev.rst
 F:	Documentation/userspace-api/netlink/
 F:	include/linux/in.h
+F:	include/linux/indirect_call_wrapper.h
 F:	include/linux/net.h
 F:	include/linux/netdevice.h
 F:	include/net/


