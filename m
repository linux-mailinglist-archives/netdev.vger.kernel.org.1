Return-Path: <netdev+bounces-295258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3V3BGCmFIWrJHwEAu9opvQ
	(envelope-from <netdev+bounces-295258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:01:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C23806409F7
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 16:01:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Ajr89mnh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295258-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295258-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B331305A863
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 13:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D6B47DFB8;
	Thu,  4 Jun 2026 13:49:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CCB47DF80;
	Thu,  4 Jun 2026 13:49:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780580980; cv=none; b=TANC2ZEt0qJKe511jJFoKRAkYDC+YbIDLLaurOVNE/fOw06yefJxTIGB0jABwiMyoz24jxqyRJfl42VyDgWVrnOjSvJPJZ8gXYPwkVeoUoJcD83m3W9Von4oAUDxDWoi4pi1Qt4RNrsC2fb6A4bcBlc7tnxBdhtfrPBtTH5dA6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780580980; c=relaxed/simple;
	bh=BPRdMmaRPoAzDy2txM1c7slXtl4d+YM1n5L6bM/nl1Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ULMVKgD3OLz+pTCOxN6Dui2TGooCU5kHitYeG3kxBn9H15B4NTiKc3vFoJHTfMfpfH3a1NKH650vgv5hCdtTOh9ctyaI6AgWqby4M0i6QEWdhlFDu6TTw15DRtzw/lHa3UiykfFAwp5tfk4Tjjlte5DsrZLbgnZnbdmF5voRJ2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ajr89mnh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20681C2BCB8;
	Thu,  4 Jun 2026 13:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780580980;
	bh=BPRdMmaRPoAzDy2txM1c7slXtl4d+YM1n5L6bM/nl1Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Ajr89mnhdErLC+NnBDym5aAJlkXwZR0IanAylCKyzL9ZRndP4yxJUhLYc1hFvzFbN
	 3kcZBNqu4ki+EF1iFZiq9c36NucIPFE/IF+jOUzDOVaq8reXT1GIZsm6MM9w9hvTbE
	 K/c3USgv33i3EXlmFP06QkdrGmyqFnDUPNw6aPkuKA7Vgx8Cch1Ggrmh2p7kXVdeg1
	 rVTmfTwVyXi2VzDcq/QTLLA+0KI4Pa3lfNM2Us1SJ7/KAvGLZW5oUa3Hzzkckh5pAp
	 jOxz1AIRit9bbnHj4riIlgoueinyEaMIebInmA5r7xJWOsu5AfhCnUzgUl0LsQJECO
	 Bd4+9OJm2GlWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F5BCD6E6D;
	Thu,  4 Jun 2026 13:49:40 +0000 (UTC)
From: Cedric Jehasse via B4 Relay <devnull+cedric.jehasse.luminex.be@kernel.org>
Subject: [PATCH net-next v6 0/2] net: dsa: mv88e6xxx: add support for
 credit based shaper
Date: Thu, 04 Jun 2026 15:44:07 +0200
Message-Id: <20260604-net-next-mv88e6xxx-cbs-v6-0-b68c01142d1e@luminex.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACeBIWoC/3XQzW7DIAwA4FepOI+J/5+d9h5VD0BgRVrTKWSIq
 cq7z0OaliniwMEYf7Z5oBKXHAt6OT3QEmsu+T5DoJ5OKFzd/BZxniBGjDBFBCd4jiuctuJbNSa
 q1hoOvmBGGaXKBueUQVD8scSUW4fP6LcGXSBzzWW9L1+9Y6U933HJ2AivFBMcjHZw50Mg4fX98
 5bh4bOP3axs76ihw8ChPHphA7Pe8IPD944eOhwclrjR0cuU1NERe8cMHQGO8RPl3hIlpD448s9
 RZPw/8mcvq6yWZqLJ/Z9n27ZvIXfwRecBAAA=
X-Change-ID: 20260430-net-next-mv88e6xxx-cbs-2121169caa68
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luke Howard <lukeh@padl.com>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Cedric Jehasse <cedric.jehasse@gmail.com>, 
 Cedric Jehasse <cedric.jehasse@luminex.be>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780580978; l=3173;
 i=cedric.jehasse@luminex.be; s=20260213; h=from:subject:message-id;
 bh=BPRdMmaRPoAzDy2txM1c7slXtl4d+YM1n5L6bM/nl1Y=;
 b=pkt/oMgPUCDGgNP2MncR1/9haiWJ9xntAbUsEcyv11ntH8GIiwN31RDKxa4ZXzmyXPRaRi0do
 0ho25DMLVlSBQibBYdaqcX69v1E4O+SyqaS+/0lmTEyMb4zyi3h2L0p
X-Developer-Key: i=cedric.jehasse@luminex.be; a=ed25519;
 pk=DL2RaHc2bc7tTDTMJdugm42BtJk4Ip+7V41Gkj+Avjk=
X-Endpoint-Received: by B4 Relay for cedric.jehasse@luminex.be/20260213
 with auth_id=638
X-Original-From: Cedric Jehasse <cedric.jehasse@luminex.be>
Reply-To: cedric.jehasse@luminex.be
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295258-lists,netdev=lfdr.de,cedric.jehasse.luminex.be];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lukeh@padl.com,m:kabel@kernel.org,m:cedric.jehasse@gmail.com,m:cedric.jehasse@luminex.be,m:cedricjehasse@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,padl.com,kernel.org,gmail.com,luminex.be];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[cedric.jehasse@luminex.be];
	TAGGED_RCPT(0.00)[netdev];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[luminex.be:mid,luminex.be:email,luminex.be:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C23806409F7

Several of the switch families in this driver have switches with AVB
support. The switches with AVB support have support for Credit based
shaping. This series adds support for the 6341, 6352, 6390 and 6393
families.
The difference between the families is:
- total number of queues
- which queues support credit based shaping
- shaping granularity

Eg. setting up 20mbps credit based shaper on a 1GBit link:
tc qdisc add dev p8 parent root handle 100: mqprio \
    num_tc 8 \
    map 0 0 6 7 0 5 0 0 0 0 0 0 0 0 0 0 \
    queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
    hw 0

tc qdisc replace dev p8 parent 100:8 cbs locredit -1470 hicredit 30 \
    sendslope -980000 idleslope 20000 offload 1

Signed-off-by: Cedric Jehasse <cedric.jehasse@luminex.be>
---
Changes in v6:
- consitently use hilimit naming isof a mixing hilimit and hi_limit
- Link to v5: https://lore.kernel.org/r/20260602-net-next-mv88e6xxx-cbs-v5-0-1969758d1fa3@luminex.be

Changes in v5:
- only set the scheduling mode when no queues are active
- use u32 for rate calculation to avoid truncation
- Link to v4: https://lore.kernel.org/r/20260528-net-next-mv88e6xxx-cbs-v4-0-8bd13b906457@luminex.be

Changes in v4:
- add qav info for the 6341
- remove max_rate from mv88e6xxx_qav_info. It looks like the max rate
  mentioned in the docs is just the maximum rate that fits in the
  registers. This is already represented by rate_mask.
- remove validation on sendslope. This isn't used by the driver.
- use accessors for qav_write and set_scheduling
- Link to v3: https://lore.kernel.org/r/20260527-net-next-mv88e6xxx-cbs-v3-0-2f387eb5ff63@luminex.be

Changes in v3:
- clear cbs_active_queues bit when the rate is set to 0 on
  port_set_scheduling_mode failure
- wait for the MV88E6390_PORT_QUEUE_CTL_UPDATE bit to be cleared after
  writing the scheduling mode
- add num_tx_queues for mv88e6191 based on it's family, as nobody is
  able to find a datasheet for this device
- reverse christmas tree variable declarations
- fix egress queue selection for devices with 4 queues
- Link to v2: https://lore.kernel.org/r/20260526-net-next-mv88e6xxx-cbs-v2-0-13eb49c29b83@luminex.be

Changes in v2:
- tx_queues defined for all devices (which could be found). Thanks to Marek Behún.
- Link to v1: https://lore.kernel.org/r/20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be

---
Cedric Jehasse (2):
      net: dsa: mv88e6xxx: use the hw tx queues
      net: dsa: mv88e6xxx: add support for credit based shaper

 drivers/net/dsa/mv88e6xxx/chip.c        | 169 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/chip.h        |  21 ++++
 drivers/net/dsa/mv88e6xxx/global2.h     |   3 +
 drivers/net/dsa/mv88e6xxx/global2_avb.c |  21 ++++
 drivers/net/dsa/mv88e6xxx/port.c        |  63 ++++++++++++
 drivers/net/dsa/mv88e6xxx/port.h        |  20 ++++
 net/dsa/tag_dsa.c                       |  11 ++-
 7 files changed, 307 insertions(+), 1 deletion(-)
---
base-commit: 022bdd9c0d036863c4bacd1688b73c6be3001cee
change-id: 20260430-net-next-mv88e6xxx-cbs-2121169caa68

Best regards,
-- 
Cedric Jehasse <cedric.jehasse@luminex.be>



