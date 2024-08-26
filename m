Return-Path: <netdev+bounces-121911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F00095F34F
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 15:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5F51F22260
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 13:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCAC188583;
	Mon, 26 Aug 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="wmaMqneF"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C17FC08
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680373; cv=none; b=AUoF0ZgkxU2IjIjQO/wEYD13B6O0oxxM76jRG9wxjjCQa3Sysh2jzsALiI6vUM1A5PhQnvduI/XuTzRJVD/VMxyNg1hsWw3kqVoHI0MJqzdmX23LvKNhm23l6qpuzZFVFzCBMRW3Za0s8p6ZFaABErFhcsy273qZzJiHBycNGpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680373; c=relaxed/simple;
	bh=bEolJSCCdLQnijiAHENGikR4W9YgQCYail9qjfENyV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nBmPTbvLesq6yYfnMpNtERfL9eUSR5eOhLI8E/fQx5VQQnPQFWr6MQ+7O9Ze/IuBUBT1M9aQAjBlUwWbGlTuPEdq7WOZiLJwZcAQaCKUg177tkNqjopV+JQ38Y5PiVlnqacN2YdhvARb0uErteM9rKyTjUFhF/qXHO2RbzGQs9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=wmaMqneF; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 96F18200BE73;
	Mon, 26 Aug 2024 15:52:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 96F18200BE73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1724680363;
	bh=nJUAxlFWAHHNJToyYWUBw0GVs/2O/iv+y4XtUkvqwKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wmaMqneFCkf0S6BzXlfQ2LXW5bvSxI1m0uqfMmIu1fahKhhHg2b2IzaTFXS0yEzRC
	 VKFbVAyEsl4PQboe9btzjgoosGnE/4lEf8usrM7rN3PtMY1/KDUf1qSSvjYZN0M5bI
	 oBPQ6UE9+J/mKRjQM1Bj4tjOqTBisxHnjRWbjFMB66+gkKj1aCLl48kzygoZ/LkoZS
	 uJDN+ahaIldfWV2dF+WnuVjsZRzhpB1/vF+2Dm95g0RaqWnfKEA3W0jgZvg6rInSbw
	 +hvz6n54MyF4zVQGtSR8CmP0fzsJW3dxq1EBARjMrGSN4EdyPs1lhYIX4CiMQjBQxx
	 7aTriFBiyG0jw==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH iproute2-next v2 2/2] man8: ip-route: update documentation
Date: Mon, 26 Aug 2024 15:52:29 +0200
Message-Id: <20240826135229.13220-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826135229.13220-1-justin.iurman@uliege.be>
References: <20240826135229.13220-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include "tunsrc" in the man page.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 man/man8/ip-route.8.in | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index df49f8b0..676f289a 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -253,6 +253,8 @@ throw " | " unreachable " | " prohibit " | " blackhole " | " nat " ]"
 .IR K "/" N " ] "
 .BR mode " [ "
 .BR inline " | " encap " | " auto " ] ["
+.B tunsrc
+.IR ADDRESS " ] ["
 .B tundst
 .IR ADDRESS " ] "
 .B trace
@@ -1037,6 +1039,12 @@ divisible by 8. This attribute can be used only with NEXT-C-SID flavor.
 packets.
 .sp
 
+.B tunsrc
+.I ADDRESS
+- IPv6 address of the tunnel source (outer header), not used with inline mode.
+It is optional: if not provided, the tunnel source address is chosen
+automatically.
+
 .B tundst
 .I ADDRESS
 - IPv6 address of the tunnel destination (outer header), not used with inline
-- 
2.34.1


