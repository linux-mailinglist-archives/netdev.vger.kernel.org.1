Return-Path: <netdev+bounces-38077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383BA7B8E2C
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 14473B209D0
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD66B22EEA;
	Wed,  4 Oct 2023 20:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ/FBM+v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC833224F5;
	Wed,  4 Oct 2023 20:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21E1C43395;
	Wed,  4 Oct 2023 20:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696451903;
	bh=tWSdTi8obnFsvIC2v1iHQX7NjJHX3oSF/bftWpn0C9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OQ/FBM+vwdNEdAFLL59EakZsn7FKRfBEXOAy8NDHGXhx0fM1JXq7NGOmnHveavrRy
	 KK8xyD51c/UFymE6ON8DDtYfKLyXpXvcaag9nQ9ytV4sESUbd8DeToRk9RZYsSdSoq
	 MxQFMECDcgNF+hbRNowB1/WJP+wIL3EizgGhfs6ycyN7HOgXKGKi/G9NXLZp3Va9lp
	 re1PKrsFVTJyjx6qQxBim1W502Znqk3VMR1jieVEam2zO32vPvL5b8y7V1LogOvSEi
	 uxNa5IdqktxSp/8LLy0DIqxT6zxXktb2GCQuxFR07mlacl8edVyira/SOHyHciPBYW
	 +L/XCjmdlZ5rw==
From: Mat Martineau <martineau@kernel.org>
Date: Wed, 04 Oct 2023 13:38:13 -0700
Subject: [PATCH net 3/3] MAINTAINERS: update Matthieu's email address
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231004-send-net-20231004-v1-3-28de4ac663ae@kernel.org>
References: <20231004-send-net-20231004-v1-0-28de4ac663ae@kernel.org>
In-Reply-To: <20231004-send-net-20231004-v1-0-28de4ac663ae@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 Kishen Maloor <kishen.maloor@intel.com>, Florian Westphal <fw@strlen.de>, 
 Mat Martineau <martineau@kernel.org>
X-Mailer: b4 0.12.3

From: Matthieu Baerts <matttbe@kernel.org>

Use my kernel.org account instead.

The other one will bounce by the end of the year.

Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a0a6efe87186..c80903efec75 100644
--- a/.mailmap
+++ b/.mailmap
@@ -377,6 +377,7 @@ Matthew Wilcox <willy@infradead.org> <willy@debian.org>
 Matthew Wilcox <willy@infradead.org> <willy@linux.intel.com>
 Matthew Wilcox <willy@infradead.org> <willy@parisc-linux.org>
 Matthias Fuchs <socketcan@esd.eu> <matthias.fuchs@esd.eu>
+Matthieu Baerts <matttbe@kernel.org> <matthieu.baerts@tessares.net>
 Matthieu CASTET <castet.matthieu@free.fr>
 Matti Vaittinen <mazziesaccount@gmail.com> <matti.vaittinen@fi.rohmeurope.com>
 Matt Ranostay <matt.ranostay@konsulko.com> <matt@ranostay.consulting>
diff --git a/MAINTAINERS b/MAINTAINERS
index 9275708c9b96..0bb5451e9b86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14942,7 +14942,7 @@ K:	macsec
 K:	\bmdo_
 
 NETWORKING [MPTCP]
-M:	Matthieu Baerts <matthieu.baerts@tessares.net>
+M:	Matthieu Baerts <matttbe@kernel.org>
 M:	Mat Martineau <martineau@kernel.org>
 L:	netdev@vger.kernel.org
 L:	mptcp@lists.linux.dev

-- 
2.41.0


