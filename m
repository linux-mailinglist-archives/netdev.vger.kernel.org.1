Return-Path: <netdev+bounces-117199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A86E94D0E9
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 15:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0E6A1F21E0E
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 13:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF923194C8D;
	Fri,  9 Aug 2024 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="Fw/ltevn"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A6194C75
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209272; cv=none; b=LOjZYl3kSYGVSMFXteatkd7NWJVsH62b52PWr3EqvcYswlOmDqP3dtVuqLb/L/xe3JwL+lyRcY6AwamW6Q3dUclZas+TM7NSG+2cTtUpsU/ag2WWYWV8ASeqYOBDfLHoOhlADxc8IcccPXxGeY2cfDtQdWYHtDRNnlTqNWj5kbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209272; c=relaxed/simple;
	bh=bEolJSCCdLQnijiAHENGikR4W9YgQCYail9qjfENyV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e408j5ceCtaXtwTpjrQJH6glFN0OZ/31ttiWZ5VUU7IObyTB1Gp/NTSz1r6dQYmktc5gre2wD4xK2RrESGhGR0JZiKrEs8Biy0iSPff7MQrgTkw6ob1M0qZdonJhAN9oh3Mgl6uLrBDbgr8mFx/6gAqQfgeTfvLbUnnWsoJNfmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=Fw/ltevn; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id CFB55200CCF2;
	Fri,  9 Aug 2024 15:14:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be CFB55200CCF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1723209268;
	bh=nJUAxlFWAHHNJToyYWUBw0GVs/2O/iv+y4XtUkvqwKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fw/ltevn1xggvmQJgWQo0gD5ypUUR5TRTGeqkObPcALDRNS0xfbG0AdQ1SY1E4if4
	 u/eLkyzMtukBYLxSAiNwZEgTz+PgseTGj5hPjlouF+u3F9qs4jQHzkqZHSFS7RIIZO
	 iZFVZpoOsFVFFC+HCNDldo7wsrBCc1Y22z+H5ApjTDFRo1G3ybNvFyEElC0Pr7vE62
	 VpqP5e2weaEHrHQ+qi7xzWn0oEKleCeYNiqAVyNq116qPKxjXIlHtIk0ZE7rfmB82D
	 qC+AG3rQMgBgYqd61aqcutr/VoEbWfv6pL1E0S9FSj2buSLUz8wngpMMH8EKhJ+TkX
	 yPUQtwqnkjOjg==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH iproute2-next 3/3] man8: ip-route: update documentation
Date: Fri,  9 Aug 2024 15:14:19 +0200
Message-Id: <20240809131419.30732-4-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809131419.30732-1-justin.iurman@uliege.be>
References: <20240809131419.30732-1-justin.iurman@uliege.be>
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


