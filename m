Return-Path: <netdev+bounces-260018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBl8HHZJnGnuDAQAu9opvQ
	(envelope-from <netdev+bounces-260018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:35:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E424F17625B
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7927C3029AD4
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 12:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F082716F288;
	Mon, 23 Feb 2026 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="IyT1ip3y"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC039FD4
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 12:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850099; cv=pass; b=lCn/TKPQ7VzybANK3vJ9AtxE2tE0F1RvPrpfbymbMtyrEZmSTXAkcjgCInSV6OJFbvfLBQUnVLohoOAr12ApYRUE3RqnExlP8LC3h8NLGFKJqE7o3zd9vVNq6GeqlnAru4BQ1xatvTZ1I/joprf0dxC330pUXTXPzKqC0t/NhhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850099; c=relaxed/simple;
	bh=0/KkUOpRBKrZd6nSUwqVCEfuGKtOAxH1QqBQq9gsAmA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=boJZCf0/ljIdnPh9GqXEfCjJKtP+Ez4LUqcayQpwquj1fP+unn5scYPEyxxfdREK1pKyJ0i/TQNCjg9oi18Nu17eDceFc3Z+UyJeKOWk41jTNi0e9GmKVPxahH+FYC7e5lFUul5IcpO8BRFXoPum6Q/2lz7FQlAIyO4wLMWuKjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=IyT1ip3y; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1771850077; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e+nfRFKHiiVHfaYgiBd68wUbaKqhNL1xyp6nTJ1okGZ+w0E9UD4OrRFbdiP8R2twx95tnpPSsvCaaiHdyf69dzw0nWVrVkkWOzxcq8xGa8/Cdt8+7lTZXvUXXdMz6T5eH7RDYYtwKSa3LWhJR7J5DPm2AOJL5mD5XjQxlm3Gayk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771850077; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8HBDiLkHGx1tVaVOVB0N4Uj2KUpXM8USyb1fBwZciNo=; 
	b=RMHFU4FSwzebpiwiRwqd02ykwH7WFYwnd6kvrgCar9EG+quv6XtNBI885HqgdvAryaLAbitmGb3UNw9G2rcYAc8xTLPyrgyIOkrUZ75Gb1Vg41jq8RI0LLo+JzGyjJmr+9rdsfzoEqBvL/imc9/si1FL3sYpuf27XHXxsJ3AqCI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771850077;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8HBDiLkHGx1tVaVOVB0N4Uj2KUpXM8USyb1fBwZciNo=;
	b=IyT1ip3yysbGxTX/4P9H+dnQO1YmVIZp4ZwG5RRSnPbvsoV0DKk+wbUvru/nStGE
	ZXdoD+iM9l4xN5VoCviVVaCdG1SDVumzrkYAF3EhNs21EySRK7ERX+L+hG6tPWE44Fl
	ce3aTNgTWa6m2vSJf/RdyHf8ipRtFIopKpmy78EYy5Te24wOnAOkLByCoTDdnkvfhEk
	l+uQBDhR413mYd7I6Jb37zPB5QF/hUofVcLqNbvCrzKUDnOwg87IUgqzhUHJAhAWZRT
	tMTAieVo6hoI9uzlhaZhSKpGsCG53XzlH0FvhGKyngHgjKoJAjR6dLvRsUwP29XmiVO
	pLUa0/xoyg==
Received: by mx.zohomail.com with SMTPS id 1771850074446335.20182915951636;
	Mon, 23 Feb 2026 04:34:34 -0800 (PST)
From: Maciek Machnikowski <maciek@machnikowski.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	maciek@machnikowski.net,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	willemdebruijn.kernel@gmail.com,
	andrew@lunn.ch,
	vadim.fedorenko@linux.dev
Subject: [PATCH v2 net-next 0/3] Implement PTP support in netdevsim
Date: Sun, 22 Feb 2026 10:41:07 +0100
Message-ID: <20260222094110.127927-1-maciek@machnikowski.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[26];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	TAGGED_FROM(0.00)[bounces-260018-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[machnikowski.net];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,machnikowski.net:mid,machnikowski.net:dkim]
X-Rspamd-Queue-Id: E424F17625B
X-Rspamd-Action: no action

This patchset adds support to the PTP HW timestamping emulation in the
netdevsim. It uses existing binding between netdevsim and ptp_mock
driver to generate transmit and receive timestamps.

It also adds the selftest to verify the hw timestamping functionality
running over netdevsim.

v2:
- Added selftest/net/ptp.sh
- Modified ptp_mock to use spin_lock_bh
- Populate ethtool defaults using ethtool_op_get_ts_info

Maciek Machnikowski (3):
  ptp_mock: Expose ptp_clock_info to external drivers
  netdevsim: Implement basic ptp support
  selftests:net: Implement ptp4l sync test using netdevsim

 drivers/net/netdevsim/ethtool.c    | 11 ++++
 drivers/net/netdevsim/netdev.c     | 90 +++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdevsim.h  |  1 +
 drivers/ptp/ptp_mock.c             | 22 ++++---
 include/linux/ptp_mock.h           |  5 ++
 tools/testing/selftests/net/ptp.sh | 93 ++++++++++++++++++++++++++++++
 6 files changed, 214 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/net/ptp.sh

-- 
2.53.0


