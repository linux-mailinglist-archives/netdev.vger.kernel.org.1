Return-Path: <netdev+bounces-287506-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLYmCQZLBGrNGgIAu9opvQ
	(envelope-from <netdev+bounces-287506-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:57:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFA753103E
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 11:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 51CE7302C0CD
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 09:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921C137206D;
	Wed, 13 May 2026 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="aHX6osor"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401973845DA
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665553; cv=pass; b=qtN8fnzcboOP84eKGHUECmLB/T6IlUvlQYNgF/7nYtB3FUnHPlonEt6S0JyPZOizWhmiT9FoCV6S4u6KfpXVDckWEgTTXA3QwGH0bzN8peb8qjSCcmai9kigOJL0fyAN8uffXyEM3h9TokIq7cc7b7yA3960fM1Ce71jdWAQHeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665553; c=relaxed/simple;
	bh=FW2OU/f3ZtF3kcFXQyUMHwmZuntpu3GDcCnXnOS+bJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pbstAj1GkWt+yaN/ENaMS1v1rotOTBu+RhQhgQ2OqYcWsmOIPV6P1Ot+1fWO+IIUL4tm54l2Rpp5myHG1ZLiPBWQU0WvhOBsPx4eiRkI0DexTV8lo4RGFbGwWo0SuUNOSXzwPmtiieMODplt/BfmGYCaNNu67U9C0tsSGVXdUsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=aHX6osor; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1778665528; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WsXpjCBtu58V3CEa50aYqX3ItOjjLfEwhfKU234KgEuKqcOzOh6pqWecjeVodNGcSgoeqx+7ovNEb39/Tmzt69ODorcfAqZfkQzsJohs1rqu9ZXzX0LiIa/cylWGzvLB1fyQr2k0b1ckR6qS5ILph0VNOXHLfntmCTTc9F0Wpyc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778665528; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xF+dAhe7y6soi+/ARWY5j6ybPv65gDRs55gd5TLTj34=; 
	b=jGXr5qVmtDDuKRnE79LL4fyf83xX0euVLKIse/y89DrEEz4RuAui/LxcvIigcMedrteLgztPCagvw6nfHPAvrTO2giYp+bCSJwJHqKAFqC7DELSSIRNZLtF7PFALObj9zKI8QdVCq9vu/ekyDyE9TI3TRFdn+LdpY7hQni+LR4U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778665528;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xF+dAhe7y6soi+/ARWY5j6ybPv65gDRs55gd5TLTj34=;
	b=aHX6osorarAwF6x0Sr5riH34BH7NrcKH6Szz+4GET9VgKqbqfv8CscDUUtghrBfA
	uckx9fsceQWQKCg42yX9d1YAQuKJ6v7aUkr6R97a2J8OymOmOXsKYBA2YhbMBvoQ48D
	xzaKCkbIr+zMnbyJtPPO30am2PICB5C0gPjWTJ13uH+x0qAbMnCenUGhkapntTGxvEs
	Kk5stsKrFtQM4GmCckI4IoC7mLPxNY9dCVcWXKOcFrRllAfJC/JvKSVOx+t2XLRz9ze
	b3jAcKcfZ3PZ3imdFaPpEWQaxrZlavJl0UlJSZt08D+qoGv7SRfOn2FgjcPR+UVjZQj
	T3pSqFAdjA==
Received: by mx.zohomail.com with SMTPS id 1778665524961386.237538125392;
	Wed, 13 May 2026 02:45:24 -0700 (PDT)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev,
	horms@kernel.org
Subject: [PATCH v6 net-next 0/3] Implement PTP support in netdevsim
Date: Wed, 13 May 2026 11:45:17 +0200
Message-ID: <20260513094520.325693-1-maciek@machnikowski.net>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 1CFA753103E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	DMARC_NA(0.00)[machnikowski.net];
	TAGGED_FROM(0.00)[bounces-287506-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[machnikowski.net:mid,machnikowski.net:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This patchset adds support to the PTP HW timestamping emulation in the
netdevsim. It uses existing binding between netdevsim and ptp_mock
driver to generate transmit and receive timestamps.

It also adds the selftest to verify the hw timestamping functionality
running over netdevsim.

v6:
- Enable PTP Mock in the tools/testing/selftests/net/config

v5:
- Rebase

v4:
- Check if Rx timestamps are enabled before generating a timestamp
- Replace bash selftest script with a python one
- Optimized Tx timestamp generation

v3:
- Fixed shellcheck issues in the selftest/net/ptp.sh
- Added selftest/net/ptp.sh to the selftest/net/Makefile
- Modified ptp_mock to use spin_lock_irqsave

v2:
- Added selftest/net/ptp.sh
- Modified ptp_mock to use spin_lock_bh
- Populate ethtool defaults using ethtool_op_get_ts_info

Maciek Machnikowski (3):
  ptp_mock: Expose ptp_clock_info to external drivers
  netdevsim: Implement basic ptp support
  selftests:net: Implement ptp4l sync test using netdevsim

 drivers/net/netdevsim/ethtool.c      |  11 ++
 drivers/net/netdevsim/netdev.c       |  91 +++++++++++++
 drivers/net/netdevsim/netdevsim.h    |   1 +
 drivers/ptp/ptp_mock.c               |  26 ++--
 include/linux/ptp_mock.h             |   5 +
 tools/testing/selftests/net/Makefile |   1 +
 tools/testing/selftests/net/config   |   1 +
 tools/testing/selftests/net/ptp.py   | 184 +++++++++++++++++++++++++++
 8 files changed, 312 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/net/ptp.py

-- 
2.54.0


