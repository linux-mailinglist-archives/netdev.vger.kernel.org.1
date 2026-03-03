Return-Path: <netdev+bounces-263444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KByFLLtYp2lsgwAAu9opvQ
	(envelope-from <netdev+bounces-263444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:55:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3061F7CCB
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40D8C303B364
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CF33368A4;
	Tue,  3 Mar 2026 21:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bl6zdMPU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018B233689D
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574829; cv=none; b=ObvtGa7bhXqFsthmKAHKTTh0uFJOfRNvSiEIZfncFtClGZnDDUpGlcnDDPQcrCVgCfeR2pPV0aEPDMf8xC8I5RMIXQUIIpWjuxQ/oArA8y85Ectt5pgLLDU7eGSvsS+YCGYGcLTe9yvGntkmWfzozPyMMfxr2Z65GC7eR4IuSOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574829; c=relaxed/simple;
	bh=s+bxBAW7Fds1wr0QE/kY1k9u90jC0RSPBPGEDJDGdPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9p9Lb5OLnDFGPGCSmt56WKx0MxfqUYb64WfNDsZk3Lko0FUZYBic13t73oaeaJn4rq+syjjYqdKRNvC4b1D+5hB63tz6MK5H999UVDJhSIE/bsj/uulR5c61pq2z8dXC3DVzflWfMhhceUtUtVEH6lwQQ5XEpkF6UFSk54LNaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bl6zdMPU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61309C116C6;
	Tue,  3 Mar 2026 21:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574828;
	bh=s+bxBAW7Fds1wr0QE/kY1k9u90jC0RSPBPGEDJDGdPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bl6zdMPUVVt3J+GEVm1JsjjLok0IIvP912lHqd+qGr12YPVpunmv3ephaOYzbW3yk
	 9CL47PiJkWBYf+3cOyYafk5ABrsbz7FYSEzAtuRdXuYxVieVVaPefJ+NZ+5BKr3IuP
	 z2EwNn6rEAVRSWNdOboaZKM7JhBpDtzEngFz9mpK14CuWUesEl25vm7Vo4Tywhpzax
	 B96tqpgchclk6+kFfLOEfJ66dWvlHi0BjUQB99tPTVSOdNIRMHzcnxtzuYj6NNMRwf
	 iS8A9CXhDRldDMWeBgrhybjkZF4AFQ1HSyI62rTBaM72vC+1MOjGEZNZupHZHsI43H
	 H4j7O7VK937ZA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	vladimir.oltean@nxp.com
Subject: [PATCH net 10/11] MAINTAINERS: remove Claudiu Manoil and Alexandre Belloni from Ocelot switch
Date: Tue,  3 Mar 2026 13:53:10 -0800
Message-ID: <20260303215339.2333548-11-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303215339.2333548-1-kuba@kernel.org>
References: <20260303215339.2333548-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AF3061F7CCB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263444-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,microchip.com:email,bootlin.com:email,nxp.com:email,intel.com:email]
X-Rspamd-Action: no action

We have not seen tags from Claudiu for the Ocelot switch driver
in over 5 years. He is active upstream in other NXP subsystems
(ENETC, gianfar), with 46 emails on lore since 2024.
We have not seen tags from Alexandre for the Ocelot switch driver
in over 5 years. He is very active upstream in other subsystems
(RTC, I3C, Atmel/Microchip SoC), with over 1,200 emails on lore
since 2024.
Vladimir Oltean is active.

Subsystem OCELOT ETHERNET SWITCH DRIVER
  Changes 180 / 494 (36%)
  Last activity: 2026-02-12
  Vladimir Oltean <vladimir.oltean@nxp.com>:
    Author c22ba07c827f 2026-02-10 00:00:00 33
    Tags 026f6513c588 2026-02-12 00:00:00 39
  Claudiu Manoil <claudiu.manoil@nxp.com>:
  Alexandre Belloni <alexandre.belloni@bootlin.com>:
  Top reviewers:
    [49]: f.fainelli@gmail.com
    [19]: horms@kernel.org
    [10]: richardcochran@gmail.com
    [9]: jacob.e.keller@intel.com
    [8]: colin.foster@in-advantage.com
  INACTIVE MAINTAINER Claudiu Manoil <claudiu.manoil@nxp.com>

Acked-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Cc: vladimir.oltean@nxp.com
Cc: claudiu.manoil@nxp.com
Cc: alexandre.belloni@bootlin.com
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8123339e4769..8f208f877746 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19218,8 +19218,6 @@ F:	tools/objtool/
 
 OCELOT ETHERNET SWITCH DRIVER
 M:	Vladimir Oltean <vladimir.oltean@nxp.com>
-M:	Claudiu Manoil <claudiu.manoil@nxp.com>
-M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
 M:	UNGLinuxDriver@microchip.com
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
2.53.0


