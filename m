Return-Path: <netdev+bounces-267693-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEvnLjUrtWnNxAAAu9opvQ
	(envelope-from <netdev+bounces-267693-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:32:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A65B28C61D
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 10:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FD8330457FF
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 09:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E6E351C08;
	Sat, 14 Mar 2026 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="fQlvGUCu";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="JPrT6dta"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A6733B97F;
	Sat, 14 Mar 2026 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773480717; cv=none; b=kX46xgcstotlpmHmmTO/4xBN4plv5naI5zVn39l07Y0TSHXX6VrUwyHKNQTojiZ6La3MHNaVCWZ0ys8ZZY4O2KqPildEw2PkxKVw9umrM4sWQBToScV4wvLqB1wJagGH764WrcJLLl9bG7wBeiTzMXI0HhryZegYsaoGlxqbzrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773480717; c=relaxed/simple;
	bh=RKyQzshGVUa1z7B29iBMApIzTeMOOhOdYaPyb4r/zIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Db1oeNHHpvMbaxWxESVKIjdA4sVahP8S80tlL1u3x+QeIe6XQQajMoxx7Tp3BzEPYYD2tzoK7KlkpRLmTyfj1sIDJ2Si83dieFP9Qy0VJ5XTYgdeAX/5QQrXcb62mU1KGjqBGi/6b5yc8Xfc0qZPTV65e437akHPp1rP47dQBOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=fQlvGUCu; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=JPrT6dta; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480709;
	bh=RKyQzshGVUa1z7B29iBMApIzTeMOOhOdYaPyb4r/zIw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fQlvGUCudHeCI2lGd0BNmy0VYVUynfluGxcidgVa5QEZ0LVguScCDstX8MLH1v09h
	 /wS7p2MCKOWJiHP/pWEZMTCFHeUlKzWxb0iXp/M+oxdKWVyXStldZSPOt8AT+fOCJ2
	 4gxv8LaPfLKBHEtYABV3rjnuyJGNi4PACryPwSXCudarz0WIGDCw1Ppfeor+Jdh2I6
	 sGCdvlPMx9MleD5SA9d1+nWkrDOmtBkbAofEmgds9cmepI5ZVxZAzaB5KoO1Qi1q8k
	 4Fm/40bAfKsVC1Xt+VW58WSpFa0B99knRq0JRMSh57bcqav+p9tqTY87o83x0UpWty
	 fmLJWVOs6vddA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 781793FCCB; Sat, 14 Mar 2026 09:31:49 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773480704;
	bh=RKyQzshGVUa1z7B29iBMApIzTeMOOhOdYaPyb4r/zIw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JPrT6dta8VgPFGcPhFLhj0qlenSaO332HRM16QpuwTWSOZ+KSOh52DYbpzB8gprq/
	 3eXsFXPehs8Sl4vbM4WpdE+TmCrH8NEAtou9hUHLm7K5Mlq1sW/rj9kb+gvHA0WszO
	 Hn28yZLEmZha83wVGRKrlpGDSaPk7ro5JqQl72k8Jjan5/Ituk1vaLkOOdcb8MaCIr
	 IK2s5lftHVfItJrQngiB9oepacOelPdzEaIyHnpAPBct+NLL+zL/xqQXDbv0i06FBB
	 nQqqYTLDTChjfx3FJV3yDSEOsWpJ6un1fVJlOMyoYwSshD1H5MlDjf1PCjQzjt/qDa
	 uq4z3INwgjVUw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 2BEA73FCCD;
	Sat, 14 Mar 2026 09:31:44 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Sat, 14 Mar 2026 10:31:44 +0100
Subject: [PATCH net-next 8/9] r8152: Add support for 5GBit EEE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-rtl8157_next-v1-8-9ba77b428afd@birger-koblitz.de>
References: <20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de>
In-Reply-To: <20260314-rtl8157_next-v1-0-9ba77b428afd@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-267693-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,birger-koblitz.de:dkim,birger-koblitz.de:email,birger-koblitz.de:mid]
X-Rspamd-Queue-Id: 3A65B28C61D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RTL8157 supports 5GBit EEE. Add functionality for setup and ethtool
get/set methods.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/r8152.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index f9498c39dc6ec8bf4605b17e2c81bbe180b1b2d3..427a05d166ad98622a113df994b01a96ad6b2872 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -5815,6 +5815,11 @@ static void r8156_eee_en(struct r8152 *tp, bool enable)
 	else
 		config &= ~MDIO_EEE_2_5GT;
 
+	if (enable && (tp->eee_adv2 & MDIO_EEE_5GT))
+		config |= MDIO_EEE_5GT;
+	else
+		config &= ~MDIO_EEE_5GT;
+
 	ocp_reg_write(tp, OCP_EEE_ADV2, config);
 }
 
@@ -9473,7 +9478,7 @@ static int r8152_set_eee(struct r8152 *tp, struct ethtool_keee *eee)
 
 	tp->eee_en = eee->eee_enabled;
 	tp->eee_adv = val;
-	if (tp->support_2500full) {
+	if (tp->support_2500full || tp->support_5000full) {
 		val = linkmode_to_mii_eee_cap2_t(eee->advertised);
 		tp->eee_adv2 = val;
 	}
@@ -9510,6 +9515,13 @@ static int r8153_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
 			linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, common);
 	}
 
+	if (tp->support_5000full) {
+		linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, eee->supported);
+
+		if (speed & _5000bps)
+			linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, common);
+	}
+
 	eee->eee_enabled = tp->eee_en;
 
 	if (speed & _1000bps)

-- 
2.47.3


