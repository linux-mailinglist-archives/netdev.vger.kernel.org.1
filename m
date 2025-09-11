Return-Path: <netdev+bounces-222306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94125B53D46
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4587416C28F
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EF92D595A;
	Thu, 11 Sep 2025 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXyPWB7x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458CD2D542F
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757623760; cv=none; b=Po+b6uWXz41iueGlsWM6Igpm3fIG7c4VXm23OUzET/7Nmh0/+NAXSCaXzqWB+ntZq6BCAiI0idJKGDKH5H5pwTTWQ+oB9C9ykSuMhaVDbZKyvIlnNJM1NFFmUgcnvIwyx2yWgJEk00A1yjSzphggcTzskhJ1e1WsqhTh+lfSUcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757623760; c=relaxed/simple;
	bh=LmndKSpmpKNxiggWVNP389otji3g7BLwTGFJ0GObOg8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=afcXzELY9aLisrogtFRTteKidzQGXDJzCBpYa/sGYqQ82fCM1jSPbxDX/VlLavATXGeyZ43Sgp0DC9EDOnkMAsGYaE8FdSNc84xJMVrjwJntgeCaKg5bwVr2Giev6kqUazkKsB0LKMyaLyDPrQgjFXtR59w9CRIVTv/8rDxesyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXyPWB7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4267C4CEF0;
	Thu, 11 Sep 2025 20:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757623759;
	bh=LmndKSpmpKNxiggWVNP389otji3g7BLwTGFJ0GObOg8=;
	h=From:To:Cc:Subject:Date:From;
	b=DXyPWB7xjlrKlEL99GHzhtCpe9yjoAhTeVdD7txj3kNMQr4XUhsxJFTfy6Uy1Te6s
	 fvhNoiFuLhrz0zgj13Zm94pU8c84L6njKLPnTihFkRrgKWTh6lEiCCUI0nIxzlIT6Y
	 /WosbTjjInqngekzUZy0EiK3MeNQVwK4C1G4wsFQldl11B+0G/nPMEttxoox3eJx6H
	 e9PrEdKmczCEjCRnSvSyhVX9N4Udvrp8LPG+iXF8Qn/ZhqUcqERMAVphBKR/TgLwP0
	 i/TeFq9BdJMtfOGOaMYa4bg6jFn3C3BLTbRFXhtWGiCEE1CQ7BuRTO7bdgZ+fO83RD
	 D9yKZAd95+2+Q==
From: David Ahern <dsahern@kernel.org>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2-main] Update email address
Date: Thu, 11 Sep 2025 14:49:15 -0600
Message-Id: <20250911204915.2236-1-dsahern@kernel.org>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kernel.org address everywhere in place of gmail.

Signed-off-by: David Ahern <dsahern@kernel.org>
---
 .mailmap    | 3 ++-
 MAINTAINERS | 2 +-
 README      | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index fd40c9175052..da57466fd371 100644
--- a/.mailmap
+++ b/.mailmap
@@ -19,4 +19,5 @@ Stephen Hemminger <stephen@networkplumber.org> <shemminger@osdl.org>
 Stephen Hemminger <stephen@networkplumber.org> <osdl.org!shemminger>
 Stephen Hemminger <stephen@networkplumber.org> <osdl.net!shemminger>
 
-David Ahern <dsahern@gmail.com> <dsa@cumulusnetworks.com>
+David Ahern <dsahern@kernel.org> <dsahern@gmail.com>
+David Ahern <dsahern@kernel.org> <dsa@cumulusnetworks.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 82043c1baec9..c2daf2b686c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21,7 +21,7 @@ T: git://git.kernel.org/pub/scm/network/iproute2/iproute2.git
 L: netdev@vger.kernel.org
 
 Next Tree
-M: David Ahern <dsahern@gmail.com>
+M: David Ahern <dsahern@kernel.org>
 T: git://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git
 L: netdev@vger.kernel.org
 
diff --git a/README b/README
index a7d283cb809d..6ddf6015fa7b 100644
--- a/README
+++ b/README
@@ -52,4 +52,4 @@ Stephen Hemminger
 stephen@networkplumber.org
 
 David Ahern
-dsahern@gmail.com
+dsahern@kernel.org
-- 
2.43.0


