Return-Path: <netdev+bounces-137489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FA29A6B32
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 15:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6393CB214DF
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 13:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF821F471D;
	Mon, 21 Oct 2024 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClrbPVfC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67531D7E52;
	Mon, 21 Oct 2024 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518977; cv=none; b=cUu1IuiQBtZoTTZHmOoVkUEQphn7yu0WnHbilIcrrpOyO4ho8kwkQhzzEqIqZERxcCTpDbNtW7CS94XS5WmUcuy2Rmlod1PvLT/D2kRMArdgPV4R8l5PN61Peu+/cF6sKWxQD0eC4lGHglDX2C9SomPaySMT88S30ldEMZhc6kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518977; c=relaxed/simple;
	bh=1kT8mMFgb/IKCsmMgTUIdT47GPA0qud5s6rqKGRQZtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QxmKc6P6P9TkG+8ksRHDslAtYg8TugYHLOsSBVb3oFmcwIl7UNuYwynzE0riBDSzBLFr/WK4GS46WnOdHzNo1vaA03nzccBtaosyPRuXQ7+pM7jVquBzOtCY0qVvzYczk1l06BMk4At3xp2NqVtjfIZzVrb8Sno1eX1FxID5oBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClrbPVfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AB6EC4CEE4;
	Mon, 21 Oct 2024 13:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729518977;
	bh=1kT8mMFgb/IKCsmMgTUIdT47GPA0qud5s6rqKGRQZtA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ClrbPVfCBs+Iz8TmtI9bFvTW8m8QZUAzKVlf0pfqyRGp1A3BBK0N03YsIEIY+Y+Dl
	 7qe5pzHvLvDJo4HR3Va/hdEZ8ybJiEi5xmOFF+nxxFfZw73kWBq2+cVp5B5ixo3j/7
	 mhpqzONxnfbN06PjJ/S5MfTltL/O/PzwqGtcjdO8N25pI5x9neuIXZkdyp8j6Tb0vk
	 +aAPLJwEq5Z3sep3xitWJxVRR23uM3DhGurPPB5d8iEquPQzaswK0XQDCLEhj6osIU
	 XU3qHljIO+7xpNp8y7cJRZiCnS+JEDeuE/k2BGUMwzhHvddDgj/Ipg83I1ywgh370b
	 mLC5EuVDr/zXw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBBED15D98;
	Mon, 21 Oct 2024 13:56:17 +0000 (UTC)
From: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Date: Mon, 21 Oct 2024 21:55:49 +0800
Subject: [PATCH net] docs: networking: packet_mmap: replace dead links with
 archive.org links
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241021-packet_mmap_fix_link-v1-1-dffae4a174c0@outlook.com>
X-B4-Tracking: v=1; b=H4sIAGRdFmcC/x2MUQqAIBAFrxL7naAWFF0lQsRetVQmGhFEd0/6H
 IaZhxIiI1FXPBRxceLDZ1BlQW6xfobgMTNpqWsltRLBuhWn2XcbzMS32divArIeXYOmrSQopyE
 iu3/bk8dJw/t+KkwZRGsAAAA=
X-Change-ID: 20241021-packet_mmap_fix_link-e04dc7e7830e
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Levi Zim <rsworktech@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1633;
 i=rsworktech@outlook.com; h=from:subject:message-id;
 bh=Tqm24mciBlPvfXzUkyHHyeW7l0+/0A++Nb0XfZNXVQ0=;
 b=owEBbQKS/ZANAwAIAW87mNQvxsnYAcsmYgBnFl14aAbfvjyean9OX/0IBGVcmOBWNnuHcCtyg
 31/aaoIkcKJAjMEAAEIAB0WIQQolnD5HDY18KF0JEVvO5jUL8bJ2AUCZxZdeAAKCRBvO5jUL8bJ
 2IMYEACm3r3q3gqs1RP2TQcq3S4pgdxgYPd5tH0Y6o1ZrDy4rPqEXLhB0mlbCxGamVgZQPYG7DB
 putaxZBiGJxHaZBppQrguFkBWj5R3SjLUtBe/MfRzFepFtL79VLEZcjrcPJlngkRU9lWl9/oanZ
 8c/DvnkQRET1xE+EaapJXXfoecczAjkwebQ4pZ3YOyokWXMzkwjrkwGP5+86yLlkQqaC0fKfwhb
 7l+qpTaoR5MlSIZdKMoQNAvwPFWBEEbdLDdHWV3DV/OwMqkP0vIM4x30uPELAEOP0acVVIT0Cfj
 uSWKz1fu3m7bKEHsYZxANf+gkLiG4t5+x6wsOgoBAY/7kCFfN1zKjrKAs/VBsTMXX7tldKo0gSp
 7eBGarHOz2LWynuk9+HdKqmqVydD2h3uALxow1Tc/jlGks7w5ko/BgTvIjKa6WAPSEDxIsu36E8
 z0gSvqZh99Hrt2MmLKVAMKZSkFrz27z9PYlGOA+9KSRvdKv3V2jS5flm8TDRQajMNJ0ULb9ZhEp
 lx4uZH/byQBEXVXg4CWuMqRiJO/j4hYGopTeLkUFuw+gXpW4EZQkASJMwhzMEmR6grYyGR70hyQ
 DYJKzGHeGM9yYSHUEBKAr8rI+Rp1E8tYnB+IsjDLX8jsbDE8N5hjPPLeo4XnEGTa5Jm+QhNOFcF
 OI7XcRZKDEMdeAw==
X-Developer-Key: i=rsworktech@outlook.com; a=openpgp;
 fpr=17AADD6726DDC58B8EE5881757670CCFA42CCF0A
X-Endpoint-Received: by B4 Relay for rsworktech@outlook.com/default with
 auth_id=219
X-Original-From: Levi Zim <rsworktech@outlook.com>
Reply-To: rsworktech@outlook.com

From: Levi Zim <rsworktech@outlook.com>

The original link returns 404 now. This commit replaces the dead google
site link with archive.org link.

Signed-off-by: Levi Zim <rsworktech@outlook.com>
---
The original link returns 404 now. This commit replaces the dead google
site link with archive.org link.
---
 Documentation/networking/packet_mmap.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/packet_mmap.rst b/Documentation/networking/packet_mmap.rst
index dca15d15feaf99ce44d2a73d857928c3eac56da0..02370786e77bc1219f75478cee07264ea12627b5 100644
--- a/Documentation/networking/packet_mmap.rst
+++ b/Documentation/networking/packet_mmap.rst
@@ -16,7 +16,7 @@ ii) transmit network traffic, or any other that needs raw
 
 Howto can be found at:
 
-    https://sites.google.com/site/packetmmap/
+    https://web.archive.org/web/20220404160947/https://sites.google.com/site/packetmmap/
 
 Please send your comments to
     - Ulisses Alonso Camaró <uaca@i.hate.spam.alumni.uv.es>
@@ -166,7 +166,8 @@ As capture, each frame contains two parts::
     /* bind socket to eth0 */
     bind(this->socket, (struct sockaddr *)&my_addr, sizeof(struct sockaddr_ll));
 
- A complete tutorial is available at: https://sites.google.com/site/packetmmap/
+ A complete tutorial is available at:
+ https://web.archive.org/web/20220404160947/https://sites.google.com/site/packetmmap/
 
 By default, the user should put data at::
 

---
base-commit: d95d9a31aceb2021084bc9b94647bc5b175e05e7
change-id: 20241021-packet_mmap_fix_link-e04dc7e7830e

Best regards,
-- 
Levi Zim <rsworktech@outlook.com>



