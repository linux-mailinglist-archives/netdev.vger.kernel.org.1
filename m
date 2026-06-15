Return-Path: <netdev+bounces-299577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qoX+B1dWMGoXRwUAu9opvQ
	(envelope-from <netdev+bounces-299577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:45:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D05689878
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:45:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=enrQF0wJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299577-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299577-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBB243068458
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842C03AEF4C;
	Mon, 15 Jun 2026 19:44:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71305396B7F
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 19:44:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552660; cv=none; b=Dt791QQKBD75D+ICjOK27RxJrkNF/FVOUhqwFizMfJYisXydVNM2nBtWLpEmYXPiKZKEi92wcrTIDhJEAd1NMGVcT4iJjcSY+2sPHp+dH+UtjBWZBVRDHTS8Ex54ZSLVMZNxqVcS1o0dpFRUh6LwKGb7pku0iVYUBNjtRKulwqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552660; c=relaxed/simple;
	bh=DaQ+bInqi6MfHuGHKlDIMPSWqgjpb7ucG8SVRX72WQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jTsX3myJ4j2yOrdg/yH+VWd09ut0HKuoVcpmpBKHirCiQZOeQ4XFruozs07K7iIGhqN0XE5IV0VVqMznL5DfpGB2DJcETX3DeoAmgKondqhcGXHJCTValWWqm7gBQo7rc3pLDMzIU4ogeu080pMkfLyLuenBnVzkl+7v2VkBYQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enrQF0wJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D0E1F000E9;
	Mon, 15 Jun 2026 19:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552659;
	bh=X7BTtysa7IzX4B8v/CmQewNbwhKGI9JBqYofOrifuEc=;
	h=From:To:Cc:Subject:Date;
	b=enrQF0wJG8jbUbGmotEsdEMmMqMCzakn9u+9TJfWoTinMOqpozaIGSaeO+jHLEZwQ
	 WRNW/2+YfEMTqoQ8W110CalYLQq/16IZhABy9UNgz/y9MWQMH88lemzuthoADGb73C
	 XjYwSLalblCM9oGitS9yZmx+ySld+My/JxjefIyjVFETZn5/HrAFPD+HbTP6FlrPcl
	 1M8E2B+nbc7X1jk2FyoWaGo8lFoX4FGDnEXryE4lh2blettmGzRfv7D7rL+0GuGJsk
	 K7nXp0FQLEmqcGmLWFgi1YHM7cbBB7dlkFMViAiGxTdYnnz6rsYhFN17QyK8lBLYZU
	 Hv/ILAbiM/x9w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	3chas3@gmail.com,
	mitch@sfgoth.com,
	linux-atm-general@lists.sourceforge.net,
	dwmw2@infradead.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 0/9] atm: remove more dead code
Date: Mon, 15 Jun 2026 12:44:07 -0700
Message-ID: <20260615194416.752559-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,sfgoth.com,lists.sourceforge.net,infradead.org];
	TAGGED_FROM(0.00)[bounces-299577-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:3chas3@gmail.com,m:mitch@sfgoth.com,m:linux-atm-general@lists.sourceforge.net,m:dwmw2@infradead.org,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71D05689878

Commit 6deb53595092 ("net: remove unused ATM protocols and legacy
ATM device drivers") removed a good chunk of old ATM drivers.
Our goal going forward is to limit the ATM support to PPPoATM
used in ADSL deployments.

A recent burst of AI generated fixes for net/atm/signaling.c and
net/atm/svc.c made me look closer at the remaining code. PPPoATM runs
over permanent virtual circuits (PF_ATMPVC) with a statically
configured VPI/VCI. We can drop switched virtual circuits (SVCs)
and user-space signaling (atmsigd) support. While digging around
I noticed a few more obviously dead pieces of code.

Annoyingly, I have applied one "fix" to QoS config which will
now make net conflict with this series :/

v2:
 - fix build warning on patch 4
v1: https://lore.kernel.org/20260613201032.77274-1-kuba@kernel.org

Jakub Kicinski (9):
  atm: remove AAL3/4 transport support
  atm: remove the unused send_oam / push_oam callbacks
  atm: remove dead SONET PHY ioctls
  atm: remove the local ATM (NSAP) address registry
  atm: remove SVC socket support and the signaling daemon interface
  atm: remove the unused change_qos device operation
  atm: remove the unused pre_send and send_bh device operations
  atm: remove unused ATM PHY operations
  atm: remove orphaned uAPI for deleted drivers, protocols and SVCs

 net/atm/Makefile                  |   2 +-
 include/linux/atm_tcp.h           |  24 --
 include/linux/atmdev.h            |  70 +--
 include/uapi/linux/atm_eni.h      |  24 --
 include/uapi/linux/atm_he.h       |  21 -
 include/uapi/linux/atm_idt77105.h |  29 --
 include/uapi/linux/atm_nicstar.h  |  54 ---
 include/uapi/linux/atm_tcp.h      |  62 ---
 include/uapi/linux/atm_zatm.h     |  47 --
 include/uapi/linux/atmarp.h       |  42 --
 include/uapi/linux/atmclip.h      |  22 -
 include/uapi/linux/atmdev.h       |  18 -
 include/uapi/linux/atmlec.h       |  92 ----
 include/uapi/linux/atmmpc.h       | 127 ------
 include/uapi/linux/atmsvc.h       |  56 ---
 net/atm/addr.h                    |  21 -
 net/atm/common.h                  |   5 -
 net/atm/protocols.h               |   1 -
 net/atm/signaling.h               |  31 --
 drivers/atm/solos-pci.c           |   4 -
 net/atm/addr.c                    | 162 -------
 net/atm/atm_sysfs.c               |  25 --
 net/atm/br2684.c                  |   3 +-
 net/atm/common.c                  |  73 +---
 net/atm/ioctl.c                   |  58 ---
 net/atm/pppoatm.c                 |   3 +-
 net/atm/proc.c                    |  56 ---
 net/atm/raw.c                     |  21 +-
 net/atm/resources.c               |  59 +--
 net/atm/signaling.c               | 297 -------------
 net/atm/svc.c                     | 695 ------------------------------
 31 files changed, 15 insertions(+), 2189 deletions(-)
 delete mode 100644 include/linux/atm_tcp.h
 delete mode 100644 include/uapi/linux/atm_eni.h
 delete mode 100644 include/uapi/linux/atm_he.h
 delete mode 100644 include/uapi/linux/atm_idt77105.h
 delete mode 100644 include/uapi/linux/atm_nicstar.h
 delete mode 100644 include/uapi/linux/atm_tcp.h
 delete mode 100644 include/uapi/linux/atm_zatm.h
 delete mode 100644 include/uapi/linux/atmarp.h
 delete mode 100644 include/uapi/linux/atmclip.h
 delete mode 100644 include/uapi/linux/atmlec.h
 delete mode 100644 include/uapi/linux/atmmpc.h
 delete mode 100644 include/uapi/linux/atmsvc.h
 delete mode 100644 net/atm/addr.h
 delete mode 100644 net/atm/signaling.h
 delete mode 100644 net/atm/addr.c
 delete mode 100644 net/atm/signaling.c
 delete mode 100644 net/atm/svc.c

-- 
2.54.0


