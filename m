Return-Path: <netdev+bounces-306528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N1VbGnzdUGox6gIAu9opvQ
	(envelope-from <netdev+bounces-306528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:54:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E8273A73C
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 13:54:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=UiJP6mi1;
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306528-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306528-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B1FE3000890
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C54F3B83F0;
	Fri, 10 Jul 2026 11:54:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203224071C0;
	Fri, 10 Jul 2026 11:54:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684468; cv=none; b=T9nAxEIeOvqq7O6G9IaVWLacXnNlY4SHbsPPwLRujId6+wjeTllX080S0n4dzMNPv/p3dyjCFWaQWS7jBqoUOtGyo+bRIUU2w1obYQQmhMIbagjlEHU08T6Dp/fawcYt97A4Ukscb9vBCqApzx5wtZndHdaj0MfdlIi3Wbu7gek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684468; c=relaxed/simple;
	bh=JJEImsDOAoplKT7IIKdfb7HUUGsqYRZMw0laIJe5Ijs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CTn7BhM/3F9fclpmIkq4verACruzZvZfhxHVgi5sWXhH4SSwLvdPY6hJ6se/GOeUbB6mrXzbfThTrdr7l86YZWncmrVmEjSTT0WfJfQKrkGiz6k00fOLnPiPt6YTrzMYs2lFF/rzWQav6BY/3nncgAZTnZp0sugL5cXC3Z6RVTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=UiJP6mi1; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=OyEtWdpelATZm7GtucoX6ShND2X9sxAuy6C0oFS0uSo=; b=UiJP6mi1MHjmETxcflaEgizP3a
	YpsfvO+p+Cnn883clDh6qgGG6cFEV3Vzgns6jZijn39Oq05yPfborrCSWl53yI24C5GqTpcqJkF3m
	LKrwtq+iDnxEjFkYjFqa2QIyHngYOL8f9OVNrF+5nh2oGrDmDiuFHGim26nJXxYMYAjpJvDFpND6u
	ig3U7UcBkkpRaFWvULyVeYenN8WLPWlAd5Kg/3wEbSYCrs4Y8QP+UP/l6N95w6jJMnSRJRe/CBQ2e
	HGOqzxaspMRywsPiunHvqleO0gfdJANWKu+sOeEwmxp024L6so2CT2+xPkhgv48P+QWwu2kAgyDh1
	B0aIpmvA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wi9o7-004SXQ-33;
	Fri, 10 Jul 2026 11:54:16 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v3 0/9] netconsole: stop charging netpoll users
 for netconsole-only data
Date: Fri, 10 Jul 2026 04:38:52 -0700
Message-Id: <20260710-netconsole_move_more-v3-0-6f63f76b28bc@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM3ZUGoC/3XNQQvCIBjG8a8i73mGutXcTn2PiJj6bhNKQ0UWY
 989skN02OW5/OH3rBAxWIzQkxUCZhutd9CTuiKg58FNSK2BnoBg4sSOvKEOk/Yu+jveHj5/JiC
 VUo4GWW1G3UJF4BlwtEthL+AwUYdLgmtFYLYx+fAqf5mX/qXFDp05ZbRjneGDqjupmrNBZQd38
 GEqYhY/pWViRxGUUY4KjekEN1r9Kdu2vQHqiMXdCQEAAA==
X-Change-ID: 20260514-netconsole_move_more-888fde03dfc7
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, asantostc@gmail.com, gustavold@gmail.com, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=4033; i=leitao@debian.org;
 h=from:subject:message-id; bh=JJEImsDOAoplKT7IIKdfb7HUUGsqYRZMw0laIJe5Ijs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqUN1jyUYT62KVqYbm6OUM1JuFrhXO8gct7C4QV
 NcrsaH55ICJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCalDdYwAKCRA1o5Of/Hh3
 bf0JEACjWK3ZIyX1VOvOw9oO3N1zNax0ygfRTN4ctd1cK+2sMzatbQCQQFemP+Gwgb80CD3niTC
 HawD4hW8aiUULrq/gtXzvWmfvPwKfqgwpTxC1hAE0pkD168ltfE8inWCRf/Q2pIIhlpbO3zTWQk
 8G4hv1H+qDQMu9nP6pTxHJnGqqo9/OP1SVUcteD6sMxM8IyEaAY4jm4Qndz6Rv0wrFaBmFvg0Oo
 gGgFEx5USE3SddtANThu3JBehlZvk+v4mPVl/WaZrBT1CbgWdspgZ6uuZMDBB8To5/VQSfxjDkS
 6lVvuMj+StcAbCnM2sYrysU8XWxy/0OGXhOgAI9LM8W/LTfLL8uD94b3YXFlFvC3V8+nd22hClB
 DIjoukWB8dFNXoTWTBUEqRDZ+6v+lSxh2V1BiYfMnPqjQFORx2YrtomNosux2eXYfZEtd7XyFQl
 En4UZm3QJN+MB7q36O2crf1FfYf5s823GGSwZZa3mumMwivjbjwbMPGWeP4zRscbj+zWNOdr8+V
 DpR/T54R6I49KDEZzQTn6OI7Uo5AxQEqhLmMLHYrP0rD8nSpZGx5hvna+CS5b9Nvebdkq2sm7pL
 LqNtRhHhGcUEkOKCco79WDBzGi58Wx2+463u4e/jXayme2ZBNwLR+lVjqzwVucEOiE83iisfAfJ
 hB1O25SUJpXwZtw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306528-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:linux-kernel@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64E8273A73C

This work continue to untangle netconsole and netpoll, improving
memory usage for netpoll users that are not netconsole.

struct netpoll is shared by every netpoll consumer in the tree:
bonding, bridge, team, vlan, macvlan, dsa and netconsole. The non-
netconsole users only need a per-port handle that lets them transmit
SKBs.

Yet struct netpoll has accumulated a pile of fields that exist only
to serve netconsole's printk path:

  - skb_pool / refill_wq: the fallback skb pool find_skb() falls back
    on when alloc_skb() returns NULL, plus the workqueue that refills
    it.
  - local_port / remote_port / remote_mac: the source and destination
    UDP ports and the destination ethernet address used to build
    outgoing log packets.

Every netpoll user that allocates a struct netpoll pays for all of
these fields, even though it never queues a single skb on the pool,
never sends a UDP frame and never looks at any of the addressing.

Move this netconsole-only state out of the shared struct into struct
netconsole_target, where its only consumer already lives.

After the series every passive netpoll consumer drops
sizeof(sk_buff_head) + sizeof(work_struct) + 2 * sizeof(u16) +
ETH_ALEN bytes per port (plus padding), and struct netpoll keeps only
what belongs to the generic poll/transmit abstraction or what netpoll
core still reads itself.

Follow-ups
----------
local_ip, remote_ip and ipv6 are still in struct netpoll. Moving the
addressing additionally requires relocating netpoll_setup() -- whose
only caller is netconsole -- and its IPv4/IPv6 helpers, so it is left
for a follow-up to keep this series focused on a single responsibility
transfer.

This is pure code motion with no functional change. The pre-existing
target/device teardown races reported against v1 have since been fixed
independently (as suggested by Jakub) and are already in the tree, so,
re-posting this one.

--

Changes in v3:
- Added a fix for a pre-existing cleanup-skip leak (released/joined targets).
- Added an skb-pool init-once patch closing an init/teardown race; rebased.
- Link to v2: https://lore.kernel.org/r/20260702-netconsole_move_more-v2-0-1ebedd921dcb@debian.org

Changes in v2:
- Rebase on net-next, now that the prerequisite netconsole
  teardown-race fixes are merged.
- Squash the local_port and remote_port moves into a single patch.
- v1: https://lore.kernel.org/r/20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org

To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org
Cc: asantostc@gmail.com
Cc: gustavold@gmail.com
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Breno Leitao (9):
      netconsole: clean up released targets dropped before the cleanup worker
      netpoll: export refill_skbs(), refill_skbs_work_handler(), skb_pool_flush()
      netconsole: take over skb pool lifecycle from netpoll
      netconsole: move refill_skbs_work_handler() from netpoll
      netconsole: move refill_skbs() and skb-pool sizing macros from netpoll
      netconsole: move skb_pool_flush() from netpoll
      netconsole: move skb_pool / refill_wq from struct netpoll to netconsole_target
      netconsole: move local_port / remote_port from struct netpoll to netconsole_target
      netconsole: move remote_mac from struct netpoll to netconsole_target

 drivers/net/netconsole.c | 199 +++++++++++++++++++++++++++++++++++------------
 include/linux/netpoll.h  |  18 -----
 net/core/netpoll.c       |  51 +-----------
 3 files changed, 152 insertions(+), 116 deletions(-)
---
base-commit: 34cf6dafc47441dfb6b356a095b89c3585a93714
change-id: 20260514-netconsole_move_more-888fde03dfc7

Best regards,
--  
Breno Leitao <leitao@debian.org>


