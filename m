Return-Path: <netdev+bounces-263424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOhTM2ZUp2lsgwAAu9opvQ
	(envelope-from <netdev+bounces-263424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:36:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BAB1F79F8
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C026302D081
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E645148AE24;
	Tue,  3 Mar 2026 21:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwpSVhBK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5048BD4E;
	Tue,  3 Mar 2026 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772573789; cv=none; b=C8C+N4mnd/GtbYMaUuoT5lDJJr7h4Sbudr8HOB4J66t4ZIUcoZ6ccuS8iUkTDzGnZRyAkPwzRNrJVTALBNDCenOPCzjhWHV1rlBiHPEr8PWWj4TjbdyeliQseLDHBU8Q2FgdjJxShmDlnvoPd6/nFJsrW5CGkAVKVm2gb/nO8f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772573789; c=relaxed/simple;
	bh=q0CNnHYegQa8CmN+FhYlSmtsHaxdzlcBhRzCbtvC+RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WVraIu8tPMpF2jViAhXyEMRMzO8HrO7bRiZe9VMbP42F5vrxSsQyuEfTkrnrhph0rap6za5FCGXlZ1dgrc4Kyw9XLodR6axi31YCrcWdh0FsHcvqzf5XysACqYNbwGq2zB1J1n2CrlOYan0JkvXbLQz/EqZAiFlMJej4C6KstwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwpSVhBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6F9C116C6;
	Tue,  3 Mar 2026 21:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772573788;
	bh=q0CNnHYegQa8CmN+FhYlSmtsHaxdzlcBhRzCbtvC+RQ=;
	h=From:To:Cc:Subject:Date:From;
	b=kwpSVhBKhmIpA/cZVmrSt/IqG2yaqEkfSQZM2bPJlsNrW8/0aYOIu1vdkuBrv7GEi
	 Xq4P0Q3bCxin3IbDMv9HUlFhtTo/6Gx90e/tUyCS3pfYYSlLRyHaTawYkvfx+y/vFK
	 9jehQjUYcWztx9htm7g84q6ugvPKaFOKapg/E3OfjY8UeZYW3kbXMpbbJEaHVV1NTb
	 5Cj/zC1XT4AmNB5jbtdXDB1YVr20muiit+J8Qkpgl67PrFG8Lsn62cOTItWPVUkxYm
	 RRBMzb19zolGt38aaqbFVZc7zyvBHfMJZgxFi+c94q/ZtS/SuQmWKA2bbnnf74QV6V
	 9HpkYxIslsM9A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: update the README
Date: Tue,  3 Mar 2026 13:36:25 -0800
Message-ID: <20260303213626.2320308-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 40BAB1F79F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263424-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ping.py:url]
X-Rspamd-Action: no action

I have added some instructions for driver authors on the NIPA wiki:
  https://github.com/linux-netdev/nipa/wiki/Guidance-for-test-authors
last year. Given the increasingly common use of LLMs let's add those
in tree as well. Hopefully this will decrease the number of review
comments we have to give to AI-assisted noobs.

While at it sync the overall instructions with what's on the GitHub
as well.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 .../testing/selftests/drivers/net/README.rst  | 90 ++++++++++++++++++-
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/README.rst b/tools/testing/selftests/drivers/net/README.rst
index eb838ae94844..dc70a69ee885 100644
--- a/tools/testing/selftests/drivers/net/README.rst
+++ b/tools/testing/selftests/drivers/net/README.rst
@@ -47,6 +47,10 @@ The variables can be set in the environment or by creating a net.config
   # Variable set in a file
   NETIF=eth0
 
+Please note that the config parser is very simple, if there are
+any non-alphanumeric characters in the value it needs to be in
+double quotes.
+
 Local test (which don't require endpoint for sending / receiving traffic)
 need only the ``NETIF`` variable. Remaining variables define the endpoint
 and communication method.
@@ -107,7 +111,7 @@ Example
   1..1
   # timeout set to 45
   # selftests: drivers/net: ping.py
-  # TAP version 13
+  # KTAP version 1
   # 1..3
   # ok 1 ping.test_v4
   # ok 2 ping.test_v6
@@ -128,9 +132,91 @@ Example
 Run the test::
 
   [/root] # ./ksft-net-drv/drivers/net/ping.py
-  TAP version 13
+  KTAP version 1
   1..3
   ok 1 ping.test_v4
   ok 2 ping.test_v6 # SKIP Test requires IPv6 connectivity
   ok 3 ping.test_tcp
   # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:1 error:0
+
+Dependencies
+~~~~~~~~~~~~
+
+The tests have a handful of dependencies. For Fedora / CentOS::
+
+  dnf -y install netsniff-ng python-yaml socat iperf3
+
+Guidance for test authors
+=========================
+
+This section mostly applies to Python tests but some of the guidance
+may be more broadly applicable.
+
+Kernel config
+~~~~~~~~~~~~~
+
+Each test directory has a ``config`` file listing which kernel
+configuration options the tests depend on. This file must be kept
+up to date, the CIs build minimal kernels for each test group.
+
+Adding checks inside the tests to validate that the necessary kernel
+configs are enabled is discouraged. The test author may include such
+checks, but standalone patches to make tests compatible e.g. with
+distro kernel configs are unlikely to be accepted.
+
+Avoid libraries and frameworks
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Test files should be relatively self contained. The libraries should
+only include very core or non-trivial code.
+It may be tempting to "factor out" the common code, but fight that urge.
+Library code increases the barrier of entry, and complexity in general.
+
+Avoid mixing test code and boilerplate
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+In Python, try to avoid adding code in the ``main()`` function which
+instantiates ``NetDrvEnv()`` and calls ``ksft_run()``. It's okay to
+set up global resources (e.g. open an RtNetlink socket used by multiple
+tests), but any complex logic, test-specific environment configuration
+and validation should be done in the tests (even if it means it has to
+be repeated).
+
+Local host is the DUT
+~~~~~~~~~~~~~~~~~~~~~
+
+Dual-host tests (tests with an endpoint) should be written from the DUT
+perspective. IOW the local machine should be the one tested, remote is
+just for traffic generation.
+
+Avoid modifying remote
+~~~~~~~~~~~~~~~~~~~~~~
+
+Avoid making configuration changes to the remote system as much as possible.
+Remote system may be used concurrently by multiple DUTs.
+
+defer()
+~~~~~~~
+
+The env must be clean after test exits. Register a ``defer()`` for any
+action that needs an "undo" as soon as possible. If you need to run
+the cancel action as part of the test - ``defer()`` returns an object
+you can ``.exec()``-ute.
+
+ksft_pr()
+~~~~~~~~~
+
+Use ``ksft_pr()`` instead of ``print()`` to avoid breaking TAP format.
+
+ksft_disruptive
+~~~~~~~~~~~~~~~
+
+By default the tests are expected to be able to run on
+single-interface systems. All tests which may disconnect ``NETIF``
+must be annotated with ``@ksft_disruptive``.
+
+Running tests CI-style
+======================
+
+See https://github.com/linux-netdev/nipa/wiki for instructions on how
+to easily run the tests using ``virtme-ng``.
-- 
2.53.0


