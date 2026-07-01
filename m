Return-Path: <netdev+bounces-303527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M7/7FkHMRGpY1AoAu9opvQ
	(envelope-from <netdev+bounces-303527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:13:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9E46EAFE1
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 10:13:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OC4rkXT8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303527-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303527-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94A03305BF2E
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 08:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02D63C81B5;
	Wed,  1 Jul 2026 08:10:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A20539448F
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 08:10:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893404; cv=none; b=I4MITteKfMSYX2LGi5MpR59dVb4XejvEL5+cUK/D11imr9MW9Y33hLRSCahtGhGyUkFsOtx0lFSeVb1XBnaR337R9uy3sTRVAD2rCQIybejRDu/XmWlZtXfRROx6uQh/m9vY5RVv3GCBBG32fCfHKk4OqoIssd0rrkSEmY9FxHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893404; c=relaxed/simple;
	bh=yTRawrKVegQG5BUoTT/+9E9+UM7+4PTuqDCiCmLEKxY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mEgSdeR+iib0T6pFtsAr2BNXw8LvcXk8HRxKVAxXrFbzLxJsiXkBp6XxPfv4zZaahe0aWH2IBSYMZzwb2SWu/JrzTMuD8HSIF/LLrSxlkmN1YmZb4kBCpdxhPiG8csboCovS0YionRiQ1uytbv/Xf+Sm9NGSvWoOi3EpZEHo9dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OC4rkXT8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E1E1F00A3A;
	Wed,  1 Jul 2026 08:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782893402;
	bh=mFHD8RRGJkLeLGm/699c6/1NPhNrhPx5wfXpMOoTjPI=;
	h=From:Subject:Date:To:Cc;
	b=OC4rkXT8wZoc1FGaN/bsXZNkwylvmxM3DF3XkjnaolvmlcuodcpxThi+y0YIaEYRV
	 pY4K6TZXrU8vpjP0RZmurbpD2aJFJBvQWrEdZM3uPhr32XjZwjuooj1973nCOlVs6j
	 Wlqs/C6xcckOu3QwjKTkgqRIKkjU+PiSnYJLFvSyjld4LUOK6z0fDDIejGOcHBNETG
	 RWobs2SNwGY1H7AREqtOPRVC5gI5KNWsy55MJ4Ew03Vi6h4wxnQMdfONMKZBg1QJXa
	 kAwkRLv4IbGcK9Fko8C2L3j7dj8o3cymC5r3VBGfHhCSoeY2L08DX/t/64fG0PJefX
	 WBE4lZnysLhOQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net-next v7 0/3] airoha: add the capability to configure
 GDM3/GDM4 as WAN/LAN on demand
Date: Wed, 01 Jul 2026 10:09:24 +0200
Message-Id: <20260701-airoha-ethtool-priv_flags-v7-0-b4153bd44428@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43Q0WrFIAwG4Fc5eD1HolbtrvYeYwxrYysr9WBLO
 ePQd5/0ylEoIxD4CfkCebKFcqSFvd2eLNMWl5jmEszLjfnRzQPx2JfMBAgNpbiLOY2O0zquKU3
 8nuP2FSY3LLzTzhnwpVlgZf+eKcTHYX+wmVY+02Nln2UyxmVN+ec4uuEx/4e/IUeuADvh20Btw
 PdvyjNNrykPB7uJmjJXlCiUUcIb55DQihMla8peUbJQkizJ3stgsDlRqqIQrijFgWsg2/ogbCB
 3opqawiuqKZRH7Amssro//0pXlGivKF0oqzuvAXqJnf9D7fv+C1idWAdEAgAA
X-Change-ID: 20260606-airoha-ethtool-priv_flags-b6aa70caa780
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, Madhur Agrawal <madhur.agrawal@airoha.com>
X-Mailer: b4 0.14.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303527-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lorenzo@kernel.org,m:horms@kernel.org,m:aleksander.lobakin@intel.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:madhur.agrawal@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC9E46EAFE1

Add the capability to configure GDM3/GDM4 as WAN/LAN on demand when QoS
offload is created or destroyed.
Make dev->qdma an RCU pointer so the TX path can safely dereference it
without holding RTNL.
Introduce airoha_qdma_start() and airoha_qdma_stop() helpers.

---
Changes in v7:
- Fix ETS stats accounting in patch 2/3
- Reset ETS stats accounting in airoha_dev_set_qdma().
- Link to v6: https://lore.kernel.org/r/20260629-airoha-ethtool-priv_flags-v6-0-86bc600d31bc@kernel.org

Changes in v6:
- Rebase on top of next-next
- Add patch 1/3: "rename airoha_priv_flags to airoha_dev_flags"
- Drop patch 2/3: "refactor QDMA start/stop into reusable helpers"
- Link to v5: https://lore.kernel.org/r/20260611-airoha-ethtool-priv_flags-v5-0-c11de08486d1@kernel.org

Changes in v5:
- Add patch 1/3: use int instead of atomic_t for qdma users counter
- Protect dev->flags with flow_offload_mutex mutex.
- Introduce AIROHA_PRIV_F_QOS in order to handle better WAN/LAN
  switching.
- Link to v4: https://lore.kernel.org/r/20260610-airoha-ethtool-priv_flags-v4-0-60e89cf28fea@kernel.org

Changes in v4:
- Move back QDMA TX/RX DMA enable to airoha_dev_open()/airoha_dev_stop().
- Configure GDM3/4 as WAN if GDM2 is not available in ndo_init()
  callback.
- Protect qdma pointer in airoha_gdm_dev struct using RCU.
- Rely on rtnl_dereference() to access qdma pointer in the control path.
- Add airoha_qdma_start() and airoha_qdma_stop() utility routines in
  patch 1/2
- Link to v3: https://lore.kernel.org/r/20260608-airoha-ethtool-priv_flags-v3-1-3e8e3dc3f715@kernel.org

Changes in v3:
- Do not introduce ethtool private flags support to configure LAN/WAN
  for GDM3/4 and rely on tc qdisc offload for it instead.
- Set GDM3/4 ports as LAN by default.
- Move QDMA TX/RX DMA enable from airoha_dev_open() to airoha_probe()
  and the corresponding disable from airoha_dev_stop() to airoha_qdma_cleanup().
- Link to v2: https://lore.kernel.org/r/20260607-airoha-ethtool-priv_flags-v2-1-742c7aa1e182@kernel.org

Changes in v2:
- Rework airoha_dev_set_wan_flag routine
- Enable GDM_STRIP_CRC_MASK in airoha_disable_gdm2_loopback()
- Do not always reset REG_SRC_PORT_FC_MAP6 in
  airoha_disable_gdm2_loopback() but use the same condition used in
  airoha_enable_gdm2_loopback().
- Link to v1: https://lore.kernel.org/r/20260606-airoha-ethtool-priv_flags-v1-1-401b2c9fe9f1@kernel.org

---
Lorenzo Bianconi (3):
      net: airoha: rename airoha_priv_flags to airoha_dev_flags
      net: airoha: fix ETS QoS stats counter underflow and cross-channel corruption
      net: airoha: defer GDM3/GDM4 WAN mode and GDM2 loopback to QoS offload

 drivers/net/ethernet/airoha/airoha_eth.c  | 239 ++++++++++++++++++++++++++----
 drivers/net/ethernet/airoha/airoha_eth.h  |  26 +++-
 drivers/net/ethernet/airoha/airoha_ppe.c  |   9 +-
 drivers/net/ethernet/airoha/airoha_regs.h |   1 +
 4 files changed, 233 insertions(+), 42 deletions(-)
---
base-commit: 1c664ec4b9ea827b609d296921ed5bad8a40a158
change-id: 20260606-airoha-ethtool-priv_flags-b6aa70caa780

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


