Return-Path: <netdev+bounces-302861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id c42jKX0KQ2qSNwoAu9opvQ
	(envelope-from <netdev+bounces-302861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 02:14:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF606DF593
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 02:14:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Oc3FbIfR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302861-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302861-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2199E302DF95
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 00:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DBC1FC8;
	Tue, 30 Jun 2026 00:14:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE2C40D591
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 00:14:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782778491; cv=none; b=S1qaQhIvY1JS9Y/8xZk9rCRjHTAijfHrp6B9ot0caVNhIGWrbRX7G1G6NEdhThu8dZ9GPk4weim+OyA7aRLpHg2TM15qgX4YzaM28Nz7qIQLk/1+F/ZVCJ+gcFUq3Z0P7+7TWg8/gOjwB3oTIo/F7OmJPnDzfYU1QNiS2Y5w9hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782778491; c=relaxed/simple;
	bh=wzgklKqTT/oXdLvAuwCRYA0niHjTjIrl3LWTdhCoAGw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RcEK51yCpOFjnK/eVT7NlZYrQsnrCtYLOyLUDjuL/u+/AIJTD2RCC/8FDZd2m16D3dBNKUgZkz6cefc0lmRLzfE5PJUYACDLRKuVdRWC/kYccCoTmSq1u5xJR2Omt3ESx/4bjeXdww2YQO7ZA2kdotDBoIadjuuMCsl36hRIGGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oc3FbIfR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1071F000E9;
	Tue, 30 Jun 2026 00:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782778490;
	bh=4Sz8NDRrP7lGuiro/kMVJOZ5950TZHeBzEKf8Emf5ho=;
	h=From:To:Cc:Subject:Date;
	b=Oc3FbIfRLe+9B7XAxlSrmbg05opfQIXXDO+HlzGZTtLdQNnHxsAja8TazKgeS1qZ2
	 HpldPGaBk/+d8yocMpPvt6T47O53/g58l9sfzKk5n/3LT4k9SZBzzjaSbSU8tLuo0M
	 PI0F4Wo+GAWgazkajDCdo7AbntgHoSbjXOkUeN91lgaRYgbBCwNaOVBb6povlrDa5k
	 kLvJ/mYuJDjiuRVOAPQcD0sZNF0p06UHksiaJJyKKyHQK3z0NKL8hJLNNcSs98bUb+
	 CbDj52ELg0mxpSzUfsuT5lc9ksNDX6AdKfQ9LlgHBCfb3flIukBDhptP3W/DUMqE4T
	 OiH8Z0HLJZWIw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	gal@nvidia.com,
	jstancek@redhat.com,
	ast@fiberby.net,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/2] tools: ynl: pyynl: minor library ease of use improvements
Date: Mon, 29 Jun 2026 17:14:30 -0700
Message-ID: <20260630001432.2204298-1-kuba@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302861-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:donald.hunter@gmail.com,m:sdf@fomichev.me,m:gal@nvidia.com,m:jstancek@redhat.com,m:ast@fiberby.net,m:kuba@kernel.org,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,fomichev.me,nvidia.com,fiberby.net];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EF606DF593

A couple of improvements for using pyynl. I was writing some scripts
to check / set up things in NIPA over the merge window, and wished
pyynl was easier to bootstrap.

Jakub Kicinski (2):
  tools: ynl: pyynl: re-export the library API from the package root
  tools: ynl: pyynl: pull the --family resolution logic into the lib

 tools/net/ynl/pyynl/__init__.py     |  9 +++++
 tools/net/ynl/pyynl/cli.py          | 53 +++++------------------------
 tools/net/ynl/pyynl/lib/__init__.py |  3 +-
 tools/net/ynl/pyynl/lib/nlspec.py   | 14 +++++++-
 tools/net/ynl/pyynl/lib/specdir.py  | 51 +++++++++++++++++++++++++++
 tools/net/ynl/pyynl/lib/ynl.py      | 19 +++++++++--
 6 files changed, 100 insertions(+), 49 deletions(-)
 create mode 100644 tools/net/ynl/pyynl/lib/specdir.py

-- 
2.54.0


