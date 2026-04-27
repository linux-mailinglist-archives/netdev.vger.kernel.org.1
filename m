Return-Path: <netdev+bounces-281410-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK6xEBKU72ktDAEAu9opvQ
	(envelope-from <netdev+bounces-281410-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:51:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFEB476AC4
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0B4C3011F0A
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0993A0B39;
	Mon, 27 Apr 2026 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="kbK8oeVX"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E0A3D88FD
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 16:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308468; cv=pass; b=lQ4eJ7DOFih91yuY7flcVex25328IjWYD1dNPP+5YijEgMS7Uqv7DLCjPPQH1GiEIwDJzoUy8xWSX3hXGina4yv5AFPsop5yIPzJX2xpCTvW+Ct9GTXftYtOV7ENmANeAfGw8+xhrlq1/42ixePynhXknR+Ja3JlR+XLfYEc+iY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308468; c=relaxed/simple;
	bh=k4Wpv2255wgpvE66nVDykwtZ3S+IJVn+Qqq8ykDj2LI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=osa5JtBCQ2xot/vxY2vsw+Z6AzRn6KTNMXhrJpCHrZt9BZH4zO/xJwPeq9Nn84PfyA+soL0l5KlOInAARGxz3O4T3ENnN7/PaPDSt+IOxYFCKcDeauENCiGe63dxoUMissBIQKJlRAVFi0TORDkaFdm9HmICenvSx8rjJmM893s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=kbK8oeVX; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1777308454; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nCC8h7G3S/INMYXpTP+y5Zka8B7YE87+kXPmFTT6hcOU0OgT5y0Wi1MGQDCCV+364gL36HuIF02s3sumV4W7ue9v9mxRhf6TxTTfhsSTPRHsCg5so61/HKecfJqND7PhfV3zN8lr1udwQWrm/hGFKDK4NguFuT4RLd3WnUXeYog=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777308454; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cZGGg5bXpBKcPXokZeod01fYLGGMCMtSgJLxMc0cu2Y=; 
	b=SfyUgtcA4TiM8OykzkSnu7bDiXkD8LKUAZWKKZNPrEBpkPSq8AZgAOMn1IW/pPmggcdBjKogGbrVodrJDfa3YC8HrPkfA6t6mpHp5eBXA375DLzMgZ2qm61tC+AbNliE5CZDKqOi1bh99Hr9JwUrRPtdXbCs1uFjPlI7/xU5r10=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777308454;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=cZGGg5bXpBKcPXokZeod01fYLGGMCMtSgJLxMc0cu2Y=;
	b=kbK8oeVXtlQtwoSsC7zcNKQ81Fzgim8OadunZqy5B4fDQfbdJk2dl33JQFYte8qS
	2MI9el1YNjgpLC7e6Xe1VBaf1sSc9ohElshmM+HWrMaukc+4x4UavYypwwEh78S6wIG
	C2KXymRHtUGrLwx7RC+iet+wbn+zYBzHg93NCOGtn8sUpMsLAvXeIlXJ+0bdansy49y
	vYI3BCLdhUfhXf/ha/yEvVA1dEhdGk3UBxOSjDIbKj7s5bZVPnt0EzolEalLlGQ7frl
	WlZdSjbek63hYK9jjq+WjbRdHjuZ9lPzniuSbqZQT3TsmmHGZPp1KI8fyPrhUzRJwL8
	XPAsXXzMLA==
Received: by mx.zohomail.com with SMTPS id 1777308450995784.1068878180829;
	Mon, 27 Apr 2026 09:47:30 -0700 (PDT)
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
Subject: [PATCH v4 net-next 0/3] Implement PTP support in netdevsim 
Date: Mon, 27 Apr 2026 18:47:24 +0200
Message-ID: <20260427164727.15418-1-maciek@machnikowski.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 8FFEB476AC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	SUBJECT_ENDS_SPACES(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[machnikowski.net:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-281410-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[machnikowski.net];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,machnikowski.net,gmail.com,intel.com,lunn.ch,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maciek@machnikowski.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[machnikowski.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,machnikowski.net:dkim,machnikowski.net:mid]

This patchset adds support to the PTP HW timestamping emulation in the
netdevsim. It uses existing binding between netdevsim and ptp_mock
driver to generate transmit and receive timestamps.

It also adds the selftest to verify the hw timestamping functionality
running over netdevsim.

v2:
- Added selftest/net/ptp.sh
- Modified ptp_mock to use spin_lock_bh
- Populate ethtool defaults using ethtool_op_get_ts_info

v3:
- Fixed shellcheck issues in the selftest/net/ptp.sh
- Added selftest/net/ptp.sh to the selftest/net/Makefile
- Modified ptp_mock to use spin_lock_irqsave

v4:
- Check if Rx timestamps are enabled before generating a timestamp
- Replace bash selftest script with a python one
- Optimized Tx timestamp generation

Maciek Machnikowski (3):
  ptp_mock: Expose ptp_clock_info to external drivers
  netdevsim: Implement basic ptp support
  selftests:net: Implement ptp4l sync test using netdevsim

 drivers/net/netdevsim/ethtool.c      |  11 ++
 drivers/net/netdevsim/netdev.c       |  91 ++++++++++++
 drivers/net/netdevsim/netdevsim.h    |   1 +
 drivers/ptp/ptp_mock.c               |  26 ++--
 include/linux/ptp_mock.h             |   5 +
 tools/testing/selftests/net/Makefile |   1 +
 tools/testing/selftests/net/ptp.py   | 184 +++++++++++++++++++++++++++
 7 files changed, 311 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/net/ptp.py

-- 
2.53.0


