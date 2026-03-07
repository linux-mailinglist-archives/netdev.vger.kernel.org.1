Return-Path: <netdev+bounces-265140-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECqXBlUarGm4kgEAu9opvQ
	(envelope-from <netdev+bounces-265140-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 13:30:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7297922BB50
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 13:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DFEA301D697
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40661359A73;
	Sat,  7 Mar 2026 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="a8YyQ0Cz"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C22F359A88;
	Sat,  7 Mar 2026 12:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772886607; cv=none; b=bpYq2PUaIx4diSfUkDWKGp+5inaVV0PZcBL2XbSQqL7hwfQ9bySQVzD78U5Jg+N4oSiZTMAUShegsUmMmYSDSCTTVN/fulflt1F0vzyS2XfXJ+OJq7ZrZGrZ3suM1kGCKfLRlW5tFUcdxlCyepa+sULwzCvtKMG3OwFbAnssxHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772886607; c=relaxed/simple;
	bh=Tg9Q/0Nbc+j06wnP0bVZPU0nw4ZmZpWyPOXlNZNjaeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXGPZUdJOb41RIHhHjppt/2jNYSI5rEMXAbvDAEbClYNd6F+dpASvqykmGLo3qdFM0wbRMTsCn+4Z/rf1jQZW9Z730WqGUaw6gCtTk35rXwvP7O9p+/I7PS9WWHE/flKJHxpwqq//x44PHwDgb5O4TEbJqTrtVP2HX2gw3L83oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=a8YyQ0Cz; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=I35XriUiN/oytfODBA+lqS4SWsmZqu02BclJOKAhPXs=; b=a8YyQ0CzePznFSW2vk+QLqQM8g
	R6wGOJetHMCz9h59y8ELv2xoUeAnQIIjznbCN9j9YauQlvbylpC/Ih+ZUtELrazou5J+mPof7D79u
	EN4FGqZfWvqOtXzyBalVWR4rywERHO0R9+FCvqxBFvDKrsWEHGDKxYB1+1WNfsUmtUYnF9kcbQQR5
	2ytAMl/9LU+NhIPzpTk9/pWoGkc005OSHn7m3IUPOW8e20CylvitL763NhXG6TpXk8MTKAl3g1cWo
	M+Jq0bas6r53SrcleMSowyfoK5i5eBDch34cYCuySJEtKsFlYoJMVbQvPq6IrKJ0EPYUlKm6/bvEd
	Dn7DZ25w==;
Received: from [122.175.9.182] (port=64662 helo=cypher.couthit.local)
	by server.couthit.com with esmtpa (Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vyql4-00000000pP7-1N6x;
	Sat, 07 Mar 2026 07:27:50 -0500
From: Parvathi Pudi <parvathi@couthit.com>
To: nm@ti.com,
	vigneshr@ti.com,
	afd@ti.com,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	aaro.koskinen@iki.fi,
	andreas@kemnade.info
Cc: andrew@lunn.ch,
	linux-omap@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	danishanwar@ti.com,
	pratheesh@ti.com,
	j-rameshbabu@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	m-malladi@ti.com,
	krishna@couthit.com,
	mohan@couthit.com,
	pmohan@couthit.com,
	basharath@couthit.com,
	parvathi@couthit.com
Subject: [PATCH v5 0/3] Add support for ICSSM Ethernet on AM57x, AM437x, and AM335x
Date: Sat,  7 Mar 2026 17:53:54 +0530
Message-ID: <20260307122641.738450-1-parvathi@couthit.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: parvathi@couthit.com
X-Authenticated-Sender: server.couthit.com: parvathi@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Rspamd-Queue-Id: 7297922BB50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[couthit.com:s=default];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[couthit.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_X_AS(0.00)[parvathi@couthit.com];
	TAGGED_FROM(0.00)[bounces-265140-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_X_GMSV(0.00)[parvathi@couthit.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ti.com,baylibre.com,kernel.org,atomide.com,gmail.com,iki.fi,kemnade.info];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[couthit.com:-];
	RCPT_COUNT_TWELVE(0.00)[29];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[parvathi@couthit.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_X_SOURCE(0.00)[];
	NEURAL_HAM(-0.00)[-0.325];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	HAS_X_ANTIABUSE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[couthit.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi,

This series adds support for ICSSM Ethernet on Texas Instruments AM57x,
AM437x and AM335x platforms.

The AM57x and AM437x IDKs support two PRU-ICSS instances, each consisting
of two PRU cores, with each PRU-ICSS instance capable of handling two
Ethernet ports. For the AM57x platforms, the PRU-ICSS2 node has been added
to the am57xx-idk-common.dtsi, while for the AM437x platform, the PRU-ICSS1
node has been added to the am437x-idk-evm.dts.

The AM335x ICE features a single PRU-ICSS instance. A new device tree overlay
source file, am335x-icev2-prueth-overlay.dtso, has been introduced to define the
PRU-ICSS node for the AM335x platform.

This is v5 of the patch series [v1].  It addresses comments made on [v4].
This series is based on the latest next-20260306 linux-next.

Changes from v4 to v5 :

*) Addressed Andrew Davis's comments on patch 2 of the series.
*) Addressed Andrew Lunn and Nikolaus Schaller comments on patch 2 of the series.
*) Rebased the series on latest linux-next.

Changes from v3 to v4 :

*) No code changes were made, only the version was updated.
*) Rebased the series on latest linux-next.

Changes from v2 to v3 :

*) Addressed Andrew Davis's comment by placing PRUETH nodes in a new overlay file
am335x-icev2-prueth-overlay.dtso.
*) Rebased the series on latest linux-next.

Changes from v1 to v2 :

*) Addressed Andrew Lunn's comment on patch 1 of the series.
*) Addressed MD Danish Anwar comment on patch 1 of the series.
*) Rebased the series on latest linux-next.

[v1] https://lore.kernel.org/all/20251013125401.1435486-1-parvathi@couthit.com/
[v2] https://lore.kernel.org/all/20251103124820.1679167-1-parvathi@couthit.com/
[v3] https://lore.kernel.org/all/20251217130715.1327138-1-parvathi@couthit.com/
[v4] https://lore.kernel.org/all/20260105162546.1809714-1-parvathi@couthit.com/

Thanks and regards,
Parvathi.

Roger Quadros (3):
  arm: dts: ti: Add device tree support for PRU-ICSS on AM57xx
  arm: dts: ti: Add device tree support for PRU-ICSS on AM437x
  arm: dts: ti: Add device tree support for PRU-ICSS on AM335x

 arch/arm/boot/dts/ti/omap/Makefile            |   5 +
 .../ti/omap/am335x-icev2-prueth-overlay.dtso  | 149 ++++++++++++++++++
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi      |  11 ++
 arch/arm/boot/dts/ti/omap/am4372.dtsi         |  11 ++
 arch/arm/boot/dts/ti/omap/am437x-idk-evm.dts  | 103 +++++++++++-
 arch/arm/boot/dts/ti/omap/am57-pruss.dtsi     |  11 ++
 arch/arm/boot/dts/ti/omap/am571x-idk.dts      |   8 +-
 arch/arm/boot/dts/ti/omap/am572x-idk.dts      |  10 +-
 arch/arm/boot/dts/ti/omap/am574x-idk.dts      |  10 +-
 .../boot/dts/ti/omap/am57xx-idk-common.dtsi   |  61 +++++++
 10 files changed, 369 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/ti/omap/am335x-icev2-prueth-overlay.dtso

-- 
2.43.0


