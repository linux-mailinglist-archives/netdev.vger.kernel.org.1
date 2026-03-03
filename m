Return-Path: <netdev+bounces-263439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIUuOIBYp2lsgwAAu9opvQ
	(envelope-from <netdev+bounces-263439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:54:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 850A31F7CA6
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E46D304CA42
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791654EA391;
	Tue,  3 Mar 2026 21:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3Q8/jJm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574DE4DBD8E
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574826; cv=none; b=o7ysFKzonBf8459HlmMIdiU8w9Ad5NAS003HO5wDNU+qfqnKET90NxdShGHxwCmFRwrWNT9/9Rya6QHG/oYRpxLbhtNl604RBQ+hy4qsSU5tDMkXhxxtNNf/e6+yS6bfLhrO6K5jJLeMMDCjZa+Vb5SbvYIzRswpUUKuMKl2AYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574826; c=relaxed/simple;
	bh=HV/MAOLbE1xrIUxwL4rOA9IL0GJzb/KynqQZua+PdxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WA5LXBy5yoUptsFVGzo34k/x21dTYCPUei74S1NFLkl0y+BTrNPeurryGVX6iA+QhNT8i0G7TJ5QVSyCeYC8T/HQGYV6mj6faScE++Hp8Z1LggzNRcrpMmleHxwGsG4fzAdcgzbIJRg7AwVhh2LIdIy02YHxdaVKcUDKEUexJJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3Q8/jJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71375C2BCB2;
	Tue,  3 Mar 2026 21:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574826;
	bh=HV/MAOLbE1xrIUxwL4rOA9IL0GJzb/KynqQZua+PdxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J3Q8/jJmMJTLQBsXX89pYUUETGHtHK4ZDMl/O4rxaWqygHiticfdYb5x3JIDQpiVE
	 fyxFplAk/05CVfWpP34H5EMR4fVlOCp5b9Tazta5ttBWjilRYh9JS46uFV1hpZZ5PF
	 U+XN8hNHRSdIuOlm/uKuBK02vq/Mr+5ft0AzG7Lt2R3z+JNps9hBY0HOAUDzTZQ7jT
	 votD7+p+WZzBtKXkuTnGaXl2rc/1k12Ak+3OG2mfDjm+Vv6PnzLexCizwu4XzOChtr
	 fNP8KOCYfYlBEJOERkFktenF3CpEImcLOByZo/jYLDgc5gSCw2Idwn2yfgBVElzlZz
	 vYcNR4rQzgbpg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	lorenzo@kernel.org,
	daniel@makrotopia.org,
	dqfext@gmail.com
Subject: [PATCH net 05/11] MAINTAINERS: remove Sean Wang from MediaTek Ethernet and switch
Date: Tue,  3 Mar 2026 13:53:05 -0800
Message-ID: <20260303215339.2333548-6-kuba@kernel.org>
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
X-Rspamd-Queue-Id: 850A31F7CA6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,arinc9.com,nbd.name,mediatek.com,makrotopia.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-263439-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

We have not seen tags from Sean in over 5 years,
with only one mailing list post since 2024.
Felix and Lorenzo are active for the Ethernet driver,
and Chester, Daniel and DENG Qingfang are active for
the switch driver.

Subsystem MEDIATEK ETHERNET DRIVER
  Changes 55 / 113 (48%)
  Last activity: 2025-10-12
  Felix Fietkau <nbd@nbd.name>:
    Author d4736737110f 2025-09-02 00:00:00 3
    Tags d4736737110f 2025-09-02 00:00:00 4
  Sean Wang <sean.wang@mediatek.com>:
  Lorenzo Bianconi <lorenzo@kernel.org>:
    Author 96326447d466 2025-08-13 00:00:00 35
    Tags 3abc0e55ea1f 2025-10-12 00:00:00 40
  Top reviewers:
    [26]: horms@kernel.org
    [5]: andrew@lunn.ch
    [4]: jacob.e.keller@intel.com
    [3]: shannon.nelson@amd.com
    [3]: michal.swiatkowski@linux.intel.com
  INACTIVE MAINTAINER Sean Wang <sean.wang@mediatek.com>

Subsystem MEDIATEK SWITCH DRIVER
  Changes 26 / 70 (37%)
  Last activity: 2025-12-01
  Chester A. Unal <chester.a.unal@arinc9.com>:
    Tags 585943b7ad30 2025-12-01 00:00:00 7
  Daniel Golle <daniel@makrotopia.org>:
    Author 497041d76301 2025-04-23 00:00:00 2
    Tags 3b87e60d2131 2025-12-01 00:00:00 14
  DENG Qingfang <dqfext@gmail.com>:
  Sean Wang <sean.wang@mediatek.com>:
  Top reviewers:
    [4]: andrew@lunn.ch
    [4]: florian.fainelli@broadcom.com
    [4]: arinc.unal@arinc9.com
    [2]: olteanv@gmail.com
  INACTIVE MAINTAINER Sean Wang <sean.wang@mediatek.com>

Acked-by: Chester A. Unal <chester.a.unal@arinc9.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Cc: nbd@nbd.name
Cc: sean.wang@mediatek.com
Cc: lorenzo@kernel.org
Cc: chester.a.unal@arinc9.com
Cc: daniel@makrotopia.org
Cc: dqfext@gmail.com
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b9b8a7695ddb..a90d106efc24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16159,7 +16159,6 @@ F:	drivers/dma/mediatek/
 
 MEDIATEK ETHERNET DRIVER
 M:	Felix Fietkau <nbd@nbd.name>
-M:	Sean Wang <sean.wang@mediatek.com>
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -16353,7 +16352,6 @@ MEDIATEK SWITCH DRIVER
 M:	Chester A. Unal <chester.a.unal@arinc9.com>
 M:	Daniel Golle <daniel@makrotopia.org>
 M:	DENG Qingfang <dqfext@gmail.com>
-M:	Sean Wang <sean.wang@mediatek.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/dsa/mt7530-mdio.c
-- 
2.53.0


