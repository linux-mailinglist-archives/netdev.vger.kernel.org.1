Return-Path: <netdev+bounces-297310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7oypCFOJKGqBFwMAu9opvQ
	(envelope-from <netdev+bounces-297310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:44:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73135664513
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:44:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=UYbATTDz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297310-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297310-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 420E930A5220
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 21:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE724B8DF7;
	Tue,  9 Jun 2026 21:36:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006C74A1384
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 21:36:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040985; cv=none; b=sTS+Tfpb5IBjXY/YIONBKT/gJiEtYbIf72NQiCJLEPFSQAmsrJeFraJ1ix43m0DjEWxbPLuCYoOKN1vRPmDAjPro+VCMrEnUcUMQYGlNmwJF2RXH09W6au5JcRoW3WDmNiIqlEscP36L5Kd/KUG0lMoWO7qUb8oInol8kIdrJtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040985; c=relaxed/simple;
	bh=U3yUU3HGEk8cqtRWdTyBWYJU/DC7CPcUg9P+e7J6ubk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSpKpsqUjOE9q5cdxSYhzdFcdRTsW3+7yMZK68sP4HZ/4JSsMody0NnZJRnvv/EK1Ja0iOdRp7nTuF5cKPDIbCsOQQ7cZRCeo4ndoMu5ln0/TbkTf286LwwD/AwlzRdmujEGi2nzFtFo5eiiG2FtaVWvca0oL5pvSMlNLU9pWHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYbATTDz; arc=none smtp.client-ip=198.175.65.20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781040979; x=1812576979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U3yUU3HGEk8cqtRWdTyBWYJU/DC7CPcUg9P+e7J6ubk=;
  b=UYbATTDzL/3coWXtnV7yiaqnSFHhBRiwPnj9xwzetpH8tTj4P+b0oXlm
   gdpIxqsHpb+v0US5pZxrw2b0LAvRs2TioHTY9mLmMUsNUpRJN6WQcI7Eo
   u9HGBCPMvIVRMdmdt7nju+6AnSScDSl2taKYWruKJqIiJojJL+FecUl4u
   ddNcgxDceAWTcx1t7ttN+1FlZhd+NOk0y04iWh/Hd90IMp+elCeBTbyVr
   tD5t/+qnTkj3A/W98MoaLeb+A4IcqmOc7Hc2uDif9YGb6UotWeqp0H2dP
   tG1A4iKH8JdSFRhFRY+gcPFHLZrJqLDwOi/PCEDRYqhMBPsQKTT6yJzUZ
   g==;
X-CSE-ConnectionGUID: 0tfGPPxnTbWU6opPPhnAmw==
X-CSE-MsgGUID: OKNyLVJVQZaQnuRfronIEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81568599"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="81568599"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 14:36:09 -0700
X-CSE-ConnectionGUID: pgZA8PKbSpinZayBL/W4ng==
X-CSE-MsgGUID: EtO93m96Txe4XJT5BO0d1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="245838604"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 09 Jun 2026 14:36:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Agalakov Daniil <ade@amicon.ru>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	Iskhakov Daniil <dish@amicon.ru>
Subject: [PATCH net-next 12/15] e1000: limit endianness conversion to boundary words
Date: Tue,  9 Jun 2026 14:35:53 -0700
Message-ID: <20260609213559.178657-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
References: <20260609213559.178657-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297310-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:ade@amicon.ru,m:anthony.l.nguyen@intel.com,m:jacob.e.keller@intel.com,m:dish@amicon.ru,m:andrew@lunn.ch,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amicon.ru:email,linuxtesting.org:url,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73135664513

From: Agalakov Daniil <ade@amicon.ru>

[Why]
In e1000_set_eeprom(), the eeprom_buff is allocated to hold a range of
words. However, only the boundary words (the first and the last) are
populated from the EEPROM if the write request is not word-aligned.
The words in the middle of the buffer remain uninitialized because they
are intended to be completely overwritten by the new data via memcpy().

The previous implementation had a loop that performed le16_to_cpus()
on the entire buffer. This resulted in endianness conversion being
performed on uninitialized memory for all interior words.

Fix this by converting the endianness only for the boundary words
immediately after they are successfully read from the EEPROM.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Co-developed-by: Iskhakov Daniil <dish@amicon.ru>
Signed-off-by: Iskhakov Daniil <dish@amicon.ru>
Signed-off-by: Agalakov Daniil <ade@amicon.ru>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index 4dcbeabb3ad2..c15ad95c63c1 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -499,6 +499,9 @@ static int e1000_set_eeprom(struct net_device *netdev,
 		if (ret_val)
 			goto out;
 
+		/* Device's eeprom is always little-endian, word addressable */
+		le16_to_cpus(&eeprom_buff[0]);
+
 		ptr++;
 	}
 	if ((eeprom->offset + eeprom->len) & 1) {
@@ -509,11 +512,10 @@ static int e1000_set_eeprom(struct net_device *netdev,
 					    &eeprom_buff[last_word - first_word]);
 		if (ret_val)
 			goto out;
-	}
 
-	/* Device's eeprom is always little-endian, word addressable */
-	for (i = 0; i < last_word - first_word + 1; i++)
-		le16_to_cpus(&eeprom_buff[i]);
+		/* Device's eeprom is always little-endian, word addressable */
+		le16_to_cpus(&eeprom_buff[last_word - first_word]);
+	}
 
 	memcpy(ptr, bytes, eeprom->len);
 
-- 
2.47.1


