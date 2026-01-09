Return-Path: <netdev+bounces-248485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CD6D09A84
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 13:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 24CBF304FA19
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 12:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5337335B142;
	Fri,  9 Jan 2026 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+vvwdEe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8764359FA1
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961574; cv=none; b=FWzP7YarjVyi7MVN+uWIEzgxtSNsa8zY17SKhtfBthadAy9QNXR9kD8LRY94n5Gf9Ut2mm45SgihrAaIPfxVNYwGYx3Fs4LjP7pdwvjxqEVdK8fu7h9QxvkCtfYNMCJ5DzHL+dQ9948PI6RulbkechdA1pIZUOuPa1H/7pA+k4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961574; c=relaxed/simple;
	bh=obuskN0VLM0RsO7b1MxxqOgZpp++YKGXBy4gGTPNifQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImtY/7/lCQ2kl72+j71D0/izCswtEoTeIysz8Y8kDRAzb5yKrV5nkmVIFBjfvTE3CK0ttY2QSaDHDzF7RD2NAIAYk7Fe+3trUKjxff0Mk0a0KPTCTzQH1vtEpPEbAx45EI4bDGjVFguDuR9iX+GeX5LxyPV+3Rpu0E1BX77SEPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+vvwdEe; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767961573; x=1799497573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=obuskN0VLM0RsO7b1MxxqOgZpp++YKGXBy4gGTPNifQ=;
  b=P+vvwdEeJY05whrNMH3//SpSCNiqn7DehbBOWOJO1waJ587WJFgIxqOl
   izgPYcBN16sj/S/R7X4JbSB21aiy57JgqDVBqMW5KnTAq1gwtawJJOybS
   bLq25qj9dY3BbibXyl+ZeSIJSWvwa+wyKyihFXYjEuONR6ktBJQQPU+uD
   XuW0aYsNkFghQX8ewKC9Y/eQy5fU/CJ28euuGXoYvdMCxSKUoezxaf3qT
   XMFDKbZbfN3GtEt20c5PjK/Ek2uVijlFlTyLJarioFZ/sS07YsD9Cp2aX
   xrIUABPp+BwjTw1dfPsD2UAWLQYEhbAw03t6bB8EDMpO+3Q+4a0R1QaZ9
   g==;
X-CSE-ConnectionGUID: KDDn2lwcTEaHiwVLNWmY0g==
X-CSE-MsgGUID: HSu6P+i+TwqmgFuDQfa8ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="73188974"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="73188974"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 04:26:11 -0800
X-CSE-ConnectionGUID: GolGeTdvT4eya8xGMa9krQ==
X-CSE-MsgGUID: /J/IlHwcSoGGsUgbSdfdmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="234169175"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 09 Jan 2026 04:26:08 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id E61B29E; Fri, 09 Jan 2026 13:26:06 +0100 (CET)
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Yehezkel Bernat <YehezkelShB@gmail.com>,
	Ian MacDonald <ian@netstatz.com>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Simon Horman <horms@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH RESEND net-next v2 4/5] bonding: 3ad: Add support for SPEED_80000
Date: Fri,  9 Jan 2026 13:26:05 +0100
Message-ID: <20260109122606.3586895-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260109122606.3586895-1-mika.westerberg@linux.intel.com>
References: <20260109122606.3586895-1-mika.westerberg@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for ethtool SPEED_80000. This is needed to allow
Thunderbolt/USB4 networking driver to be used with the bonding driver.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/net/bonding/bond_3ad.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 1a8de2bf8655..e5e9c7207309 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -72,6 +72,7 @@ enum ad_link_speed_type {
 	AD_LINK_SPEED_40000MBPS,
 	AD_LINK_SPEED_50000MBPS,
 	AD_LINK_SPEED_56000MBPS,
+	AD_LINK_SPEED_80000MBPS,
 	AD_LINK_SPEED_100000MBPS,
 	AD_LINK_SPEED_200000MBPS,
 	AD_LINK_SPEED_400000MBPS,
@@ -297,6 +298,7 @@ static inline int __check_agg_selection_timer(struct port *port)
  *     %AD_LINK_SPEED_40000MBPS
  *     %AD_LINK_SPEED_50000MBPS
  *     %AD_LINK_SPEED_56000MBPS
+ *     %AD_LINK_SPEED_80000MBPS
  *     %AD_LINK_SPEED_100000MBPS
  *     %AD_LINK_SPEED_200000MBPS
  *     %AD_LINK_SPEED_400000MBPS
@@ -365,6 +367,10 @@ static u16 __get_link_speed(struct port *port)
 			speed = AD_LINK_SPEED_56000MBPS;
 			break;
 
+		case SPEED_80000:
+			speed = AD_LINK_SPEED_80000MBPS;
+			break;
+
 		case SPEED_100000:
 			speed = AD_LINK_SPEED_100000MBPS;
 			break;
-- 
2.50.1


