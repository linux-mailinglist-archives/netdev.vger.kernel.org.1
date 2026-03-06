Return-Path: <netdev+bounces-264609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QH+WDlQ3qmnUNQEAu9opvQ
	(envelope-from <netdev+bounces-264609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:09:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A2E21A7AD
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 03:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E8A3302E7AB
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 02:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EE62D1F40;
	Fri,  6 Mar 2026 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNaoiV+o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBCA1E0DE8
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 02:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772762961; cv=none; b=U8U7AKc0GYpOKoKJAkCOB78Fjqqp3QYWhmPrFsjCcc/1ht5TSyRu26Lf4z5/V3j+xftSmNRosoVRcyxKRiXQ43eRY3sE2yiVCkQ/kc9K4wWa4eLkP2JpjIf2EKqYt8i6DF7LN3N/5Z57FvFf9GTP2yjRJffvzw5JZcggWJMYsKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772762961; c=relaxed/simple;
	bh=KM5gVzQ5Jw6d3BcO7OnYNm8t9gtDXP1HoJnyuYbhRAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aTTipJkIqQ8H1CwjxRJdwRnE8DR/bRJGTMnwTEOjjng+CIxYyzMs/4uIcU+7U04PYvrLrlxXT5YlIEvJxaIzMYT8SwzDjzSKYmuDR7adKviinJ+hsTo3YGVV86/SPWRDlvKS8tOsumWXOHITcMRVZodj9IFb+z8zzSDH5NAWWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNaoiV+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4D6C116C6;
	Fri,  6 Mar 2026 02:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772762960;
	bh=KM5gVzQ5Jw6d3BcO7OnYNm8t9gtDXP1HoJnyuYbhRAo=;
	h=From:To:Cc:Subject:Date:From;
	b=YNaoiV+oLMXGmD+1Q8hC+wvrZCxBto+SIBqdMZusArCb/iRPMwTe6s5bHB82SR0O8
	 /z06leDuYNH/qu/MpOwIixbJ+LVOXzyxwnm6RzUnky4sJ/s2vTWBU47NUqMsZba+iL
	 b1Hy101wLCNK8LYvkxn0E9jfZgp7vUnB2oUPo1/rq/x0f+ZSHGapjAzJV5Ths28kTW
	 GvEoMIaUcVxi88sE1JnqZoFi5J640hZIqUpDo2APdaATxnG1v+EzB2U9WBUFBZWnv7
	 TAgFEcxZZIkoHUuKLxcSPMgqQERcZj5HyPOuGfRwpcf5oLFpVqs9fhLG5x8WcJj5gd
	 g9LXjvTAIxmSg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	liuhangbin@gmail.com,
	matttbe@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/10] tools: ynl: convert samples into selftests
Date: Thu,  5 Mar 2026 18:08:51 -0800
Message-ID: <20260306020901.524105-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C4A2E21A7AD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264609-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The "samples" were always poor man's tests, used to manually
confirm that C YNL works as expected. Since a proper tests/
directory now exists move the samples and use the kselftest
harness to turn them into selftests outputting KTAP.

Jakub Kicinski (10):
  tools: ynl: move samples to tests
  tools: ynl: convert netdev sample to selftest
  tools: ynl: convert ovs sample to selftest
  tools: ynl: convert rt-link sample to selftest
  tools: ynl: convert tc and tc-filter-add samples to selftest
  tools: ynl: add netdevsim wrapper library for YNL tests
  tools: ynl: convert devlink sample to selftest
  tools: ynl: convert ethtool sample to selftest
  tools: ynl: convert rt-addr sample to selftest
  tools: ynl: convert rt-route sample to selftest

 tools/net/ynl/Makefile                      |   4 +-
 tools/net/ynl/samples/Makefile              |  36 --
 tools/net/ynl/tests/Makefile                |  70 +++-
 tools/net/ynl/samples/devlink.c             |  61 ---
 tools/net/ynl/samples/ethtool.c             |  65 ----
 tools/net/ynl/samples/netdev.c              | 128 ------
 tools/net/ynl/samples/ovs.c                 |  60 ---
 tools/net/ynl/samples/rt-addr.c             |  80 ----
 tools/net/ynl/samples/rt-link.c             | 184 ---------
 tools/net/ynl/samples/rt-route.c            |  80 ----
 tools/net/ynl/samples/tc-filter-add.c       | 335 ----------------
 tools/net/ynl/samples/tc.c                  |  80 ----
 tools/net/ynl/tests/devlink.c               | 100 +++++
 tools/net/ynl/tests/ethtool.c               |  92 +++++
 tools/net/ynl/tests/netdev.c                | 231 +++++++++++
 tools/net/ynl/tests/ovs.c                   | 104 +++++
 tools/net/ynl/tests/rt-addr.c               | 111 ++++++
 tools/net/ynl/tests/rt-link.c               | 204 ++++++++++
 tools/net/ynl/tests/rt-route.c              | 113 ++++++
 tools/net/ynl/tests/tc.c                    | 407 ++++++++++++++++++++
 tools/net/ynl/{samples => tests}/.gitignore |   3 +-
 tools/net/ynl/tests/config                  |   8 +
 tools/net/ynl/tests/devlink.sh              |   5 +
 tools/net/ynl/tests/ethtool.sh              |   5 +
 tools/net/ynl/tests/rt-addr.sh              |   5 +
 tools/net/ynl/tests/rt-route.sh             |   5 +
 tools/net/ynl/tests/ynl_nsim_lib.sh         |  35 ++
 27 files changed, 1492 insertions(+), 1119 deletions(-)
 delete mode 100644 tools/net/ynl/samples/Makefile
 delete mode 100644 tools/net/ynl/samples/devlink.c
 delete mode 100644 tools/net/ynl/samples/ethtool.c
 delete mode 100644 tools/net/ynl/samples/netdev.c
 delete mode 100644 tools/net/ynl/samples/ovs.c
 delete mode 100644 tools/net/ynl/samples/rt-addr.c
 delete mode 100644 tools/net/ynl/samples/rt-link.c
 delete mode 100644 tools/net/ynl/samples/rt-route.c
 delete mode 100644 tools/net/ynl/samples/tc-filter-add.c
 delete mode 100644 tools/net/ynl/samples/tc.c
 create mode 100644 tools/net/ynl/tests/devlink.c
 create mode 100644 tools/net/ynl/tests/ethtool.c
 create mode 100644 tools/net/ynl/tests/netdev.c
 create mode 100644 tools/net/ynl/tests/ovs.c
 create mode 100644 tools/net/ynl/tests/rt-addr.c
 create mode 100644 tools/net/ynl/tests/rt-link.c
 create mode 100644 tools/net/ynl/tests/rt-route.c
 create mode 100644 tools/net/ynl/tests/tc.c
 rename tools/net/ynl/{samples => tests}/.gitignore (87%)
 create mode 100755 tools/net/ynl/tests/devlink.sh
 create mode 100755 tools/net/ynl/tests/ethtool.sh
 create mode 100755 tools/net/ynl/tests/rt-addr.sh
 create mode 100755 tools/net/ynl/tests/rt-route.sh
 create mode 100644 tools/net/ynl/tests/ynl_nsim_lib.sh

-- 
2.53.0


