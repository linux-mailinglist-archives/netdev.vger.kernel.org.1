Return-Path: <netdev+bounces-262449-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMELOrGQpGnZkQUAu9opvQ
	(envelope-from <netdev+bounces-262449-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 20:17:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCB41D138D
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 20:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08C5C300B462
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 19:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7492E0B48;
	Sun,  1 Mar 2026 19:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="I0usXRHJ"
X-Original-To: netdev@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350254C97
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772392623; cv=none; b=pwM/GNTpO4s3K5Gs4ERmtgH5o08K0LIxRaawYERRBZJcc09/pphl5ueUo4qOVIYEpxTuSueyV675pVl3/zUkNr2vg1FlwWfYYTj2rO6whvnV8vXXUnQe6q7zg+TI59EJugLDj9otL1pdJlByy4/hUoxu9k/9oGCO7FVZNi9x4Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772392623; c=relaxed/simple;
	bh=GpOb4LGrFdAq9mAafD+Qnt+TboL5vrOKeZdHvAgZ0ng=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h2haNhzK/FfHaznfEWrgRVHnbqzh9EKoDkseWGpnyqusUly+mL7uQmMF8p2KWU7ZSV8HrIcVsE7yW6Idm30GMMqNasBz6LfX/WdWE2mSkqBA+M9pU7T91sahyF99M9b9EPW90c/f7s8cH/jkHe7mCW09PBFpCb37oyp4JgoBYnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=I0usXRHJ; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1772392622; x=1803928622;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c9HRLeMaruSCu91Dhqimd63v2xXJrc18d9JUlbHAUw0=;
  b=I0usXRHJ/Eztj/L3vR7wTCZwYblHSI7QhiPGhCwOrC8q7m+deTmiBXeW
   8dfrkzt1CS2irs1S3wEegoU3g9FPvpw6dDdolF22XPsKH0Svlu2NPruRx
   aeMjYSiQ/H1OUJ+M+Bd/pI7qdybRzETz+w5v5NXBTq2u19874m04ZrCmP
   5TZWGj+WV9QDznH9GaS37R9vxdktwBHrCIjsp/WYlNIOENf1n29exe7Kt
   ntPG8q99yD0aqF+Pw6W2DgKL/RCSuWO+2PmqyPJkJzehbD0aiRnl+Dkcl
   n6JgXFL6ae8QAgvCFkpfRvsOohhGaJT4GLFjoDC+JGPN4Zp0zPebN56AQ
   A==;
X-CSE-ConnectionGUID: iut9V1UmR+Cjl2qFBWQc+w==
X-CSE-MsgGUID: 5OmW93UTRYqCfqInxtmhSA==
X-IronPort-AV: E=Sophos;i="6.21,318,1763424000"; 
   d="scan'208";a="13830849"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 19:16:59 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:10900]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.3:2525] with esmtp (Farcaster)
 id 48a9ce61-14c7-4f10-93fa-6ee7fba1eb52; Sun, 1 Mar 2026 19:16:59 +0000 (UTC)
X-Farcaster-Flow-ID: 48a9ce61-14c7-4f10-93fa-6ee7fba1eb52
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 1 Mar 2026 19:16:59 +0000
Received: from dev-dsk-akiyano-1c-2138b29d.eu-west-1.amazon.com (172.19.83.6)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Sun, 1 Mar 2026 19:16:55 +0000
From: Arthur Kiyanovski <akiyano@amazon.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>
CC: Arthur Kiyanovski <akiyano@amazon.com>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David"
	<dwmw@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, Saeed Bshara
	<saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori, Anthony"
	<aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, "Schmeilin,
 Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin"
	<benh@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay"
	<shayagr@amazon.com>, "Arinzon, David" <darinzon@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>
Subject: [PATCH v1 net] MAINTAINERS: ena: update AMAZON ETHERNET maintainers
Date: Sun, 1 Mar 2026 19:16:51 +0000
Message-ID: <20260301191652.5916-1-akiyano@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262449-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_NEQ_ENVFROM(0.00)[akiyano@amazon.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4BCB41D138D
X-Rspamd-Action: no action

Remove Shay Agroskin and Saeed Bishara.
Promote David Arinzon to maintainer.

Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
---
 MAINTAINERS | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2265e2c9bfbe..7829ff2180ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -993,10 +993,8 @@ F:	Documentation/devicetree/bindings/thermal/amazon,al-thermal.yaml
 F:	drivers/thermal/thermal_mmio.c
 
 AMAZON ETHERNET DRIVERS
-M:	Shay Agroskin <shayagr@amazon.com>
 M:	Arthur Kiyanovski <akiyano@amazon.com>
-R:	David Arinzon <darinzon@amazon.com>
-R:	Saeed Bishara <saeedb@amazon.com>
+M:	David Arinzon <darinzon@amazon.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/amazon/ena.rst
-- 
2.47.3


