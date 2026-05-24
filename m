Return-Path: <netdev+bounces-291202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kugyDG0jE2oA8QYAu9opvQ
	(envelope-from <netdev+bounces-291202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:12:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB315C30AD
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 18:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6447030097D6
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472203A63EC;
	Sun, 24 May 2026 16:12:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C865B394493
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779639145; cv=none; b=Ktjb7cQneIr+9s1CFnsWrFLJBradMlMycMQNL9q+KGDg0ZMg+ggI1Vbf0qu+TOlh0gwPSToV3Q05UszgrL6ZNas44PBmUYhXQRnSF+3K0L6pEG1gLKSBKc/gLS7V+RJ53fLJCzkLLKYqX0GZtmQASPRkvN66eXpQKKOK2znKSqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779639145; c=relaxed/simple;
	bh=w9yKY5uzhHZM7eBv6T5AwBrhui8FkBo9X3dBJUH3eeQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fdvI2rvydPAS1+ONvaAc3bgN670P05f+dqsc2d3ZNpprhbmbCVVQ8Ty9mUZjGsO1wacClt+kun4APQ1k61VstbpqOE8aSUXq5tosEQ2DlsOLoBq1ZVm3D7l+3zcGrUY5lAeYoecd+PNoP6s3rCfDZ8ywLzs14JUbc7Vyu0NBCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4855e69a5a4so1081938b6e.2
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 09:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779639143; x=1780243943;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5No0a8el/S4DN81L6TAFYHT4iKPCKKGFHoR2sjKktaI=;
        b=S+eaFT+yGesQrbvld5jl+uQb/kYl1/lSYACIdJAT2ycFHZD3gYaB+NJDRDJKvw3YX5
         AdncCNOQe4E5hIeM5Vd9vk1VOLqdF5SU++a+G4SEpFUGHY0g049NvYQ79EN61V/Od3Rw
         vX3yUHy/dsjAaZU/uu+g80FZV4Oy/wSvPL68fgOChCxxEQklRmV/BCv3RzRut3S9y4UL
         yBV3uzGRRC9KyoiNH3oWvlMJkq/RrQsudf0K+vJCOxrTt8sUsrqt0wpYgcWRNbgLLiJr
         3JKS18NT+ifhyEXrM2ZF+/A29tZeis2IOspJPGk2BVypeRGWGvh0Q6FR3ZRhUuPGtTz+
         8Glw==
X-Gm-Message-State: AOJu0Yykka2Ayf8wUcqEKrDbZuAlvE1xi7b047m0Rgp/75qSC1GK9QJ8
	pfhprS2yR3jCvtni+Oi6Z0+j9UBBJT16Pz6JBUR2Pwm1mX0jYmGRcmyYElDbolOd
X-Gm-Gg: Acq92OEcbccXMNUfpe5+uirNTSLSidsXwMgpExtNlcA8PEPTsSMI5pvHuvV/EYx+LPS
	WzI8IKynfI7GjGuO1O3Jd9uE2o6A+cubFEs1a8BVJmlUVoys0qeEmFMgBjkoHq7faEKIGI1OxFd
	RGNFQwfze2J3iqfjfr1oIICVGMeUFoTxUqB3iZ3E41VzPQlGIg7kKUCd9lUAA7e93n12z4t3zt0
	0b/LFUPdHaVZamHj/Ny5Cwlg6e8hl0fzvUKVgkySWWgiC9Cc5QCCo4T2QetL15P2izNus6OD62y
	IbYEQmAlrWUel/aGqH0fuh0I8a3ZISCYe3/jhrEZlDH6yCMrWfOrMD7QwyVr++zAYjqwErCNihz
	x5ApK1ZGyvz9gr09P47bYmO30cv1aizryvAAMhSKgQOtHspvVcU/J2qoO0sVNJG5Rm/ML1iPB9K
	mQcTLd3JKA+iVONA==
X-Received: by 2002:a05:6808:1644:b0:482:ed71:8ffa with SMTP id 5614622812f47-48549d53137mr6942537b6e.15.1779639142683;
        Sun, 24 May 2026 09:12:22 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5c::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48554041ccasm3466086b6e.0.2026.05.24.09.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 09:12:22 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/9] netconsole: stop charging every netpoll user for
 netconsole-only state
Date: Sun, 24 May 2026 09:12:16 -0700
Message-Id: <20260524-netconsole_move_more-v1-0-909d1ab398b4@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGAjE2oC/yXMWwrCMBBG4a0M/3MDab2FbEVENJnoiCYlU4tQu
 vfS+nLgvHwTlKuwwtOEyqOolAxPbUMIz1t+sJEIT+hsd7SHdm8yD6FkLW++fsq4prJxzqXIdhd
 TOKEh9JWT/Db2fPm/fu8vDsNqYZ4XReteq3gAAAA=
X-Change-ID: 20260514-netconsole_move_more-888fde03dfc7
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavold@gmail.com, asantostc@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2734; i=leitao@debian.org;
 h=from:subject:message-id; bh=w9yKY5uzhHZM7eBv6T5AwBrhui8FkBo9X3dBJUH3eeQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqEyNlrXaSTOjCYS1qAyQ0hLMOFnpzAr0uTC3N7
 KOGCC1F7CKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahMjZQAKCRA1o5Of/Hh3
 bdUrD/9TOZuwwCEIt7OGP5rNi/Rdg/msDJbVvib2zGaA8ciOszvO4bqX1S83HeRZZU+9//K6ZFQ
 K9H9Ltx+7/CHh/KTJUc96AfngF1ksiteYH7SlBY0kJHPDcJFOS6NbqoleUuNACDmLI6sWsYnjPz
 8djpxeWGjFJFiDMGVGivTpn++0oEeCLtuB8mPPAaQjLIr6eH3egwNS/kInJ+djyg9AsODKiRl7j
 UAorDvcg8Zdb0wMK0sxtokK7QzpWxtc4TK/KBjTrCzoOvM1s5JdAPz3k9ss4JAw05gXYSNh23W8
 10ndsAKHhMJY2nWsi3hHf21OJ9OyccTRv///i6PktR3VKRT7TtkUT7nMcxWa/LuFDRn6aXFzFNP
 H5iQ07pKxP2tJKjJ0AjQNKxj1m/vwE+Is5PJ0v8jaVnfwPbLVQ+h+9e0RYkShfnS8V4ZJ2WL9YS
 ycPiJDSMpCexE4x5O2MypfDnbGksRTeKDCmnu6IQ7hSnNufn5MheC8VpuBKrNjc9fwHwerLOvJj
 JEwirX8HjdDoj03wzm+OY7A1PR5y3jF5wiuPJuuZ8HPAAkTaAJh7q/6NkI2KEHUZYWqmSHtuJEk
 wBulX2JWlM355gdkVKIA8/BsNkMf031L5ahz0Gb1Ynp0TDTwYp1S+Hk8GtLbMdro9tI4GGCeWgZ
 rvP6dvnmY7ECsjg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[debian.org : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291202-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,debian.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.825];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7DB315C30AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

struct netpoll is shared by every netpoll consumer in the tree:
bonding, bridge, team, vlan, macvlan, dsa and netconsole. The non-
netconsole users only need a per-port handle that lets them transmit
SKBs.

Yet struct netpoll has accumulated a pile of fields that exist only
to serve netconsole's printk path:

  - skb_pool / refill_wq: the fallback skb pool find_skb() falls
    back on when alloc_skb() returns NULL, plus the workqueue that
    refills it.
  - local_port / remote_port / remote_mac: the source and destination
    UDP ports and the destination ethernet address used to build
    outgoing log packets.
  - local_ip / remote_ip / ipv6: the source and destination IP
    addresses and the family selector for the same packets.

Every netpoll user that allocates a struct netpoll and pays for all of
these fields, even though it never queues a single skb on the pool,
never sends a UDP frame and never looks at any of the addressing.

The fix is to move netconsole-only state out of the shared struct
into struct netconsole_target, where its only consumer already lives.

After the series, every passive netpoll consumer drops
sizeof(sk_buff_head) + sizeof(work_struct) + 2 * sizeof(u16) +
ETH_ALEN bytes per port (plus padding), and struct netpoll keeps
only what genuinely belongs to the generic poll/transmit
abstraction or what netpoll core still has to read itself.

Follow-ups
----------

local_ip, remote_ip and ipv6 are still in struct netpoll, as they are
left for a follow-up posting to keep each series focused on a single
responsibility transfer.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (9):
      netpoll: export refill_skbs(), refill_skbs_work_handler(), skb_pool_flush()
      netconsole: take over skb pool lifecycle from netpoll
      netconsole: move refill_skbs_work_handler() from netpoll
      netconsole: move refill_skbs() and skb-pool sizing macros from netpoll
      netconsole: move skb_pool_flush() from netpoll
      netconsole: move skb_pool / refill_wq from struct netpoll to netconsole_target
      netconsole: move local_port from struct netpoll to netconsole_target
      netconsole: move remote_port from struct netpoll to netconsole_target
      netconsole: move remote_mac from struct netpoll to netconsole_target

 drivers/net/netconsole.c | 188 ++++++++++++++++++++++++++++++++++++-----------
 include/linux/netpoll.h  |   4 -
 net/core/netpoll.c       |  58 +--------------
 3 files changed, 145 insertions(+), 105 deletions(-)
---
base-commit: 150061a2065192d77a4f6518b6238be81dfb8321
change-id: 20260514-netconsole_move_more-888fde03dfc7

Best regards,
--  
Breno Leitao <leitao@debian.org>


