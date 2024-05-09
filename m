Return-Path: <netdev+bounces-95171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC4E8C19C8
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 01:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09D801C20F3C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 23:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8AC12D74D;
	Thu,  9 May 2024 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaWm/LKx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C061292E6
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715296200; cv=none; b=gbLSJRv9os4N31aHLD+NCzvIanNsUtOBF8n2xQo1FJd6R8UhSjiTzjAyGHoOI3BEJHjIPLVxl8DyvLRprhcbrfTGySKECy6ROz+jEFYwfPqoSOaMNBOa/mSztZjC8zgeoN5VSl4nWfBkufC3y230EShAvdJo54OXVlxQKtYd5vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715296200; c=relaxed/simple;
	bh=kbYiMDoNn6TzAktRP8/Mbm1cYY08LCZvZkjGOklwMA8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dBYflLqw5uyxG5pYdRTNNZ9K7kRj3QcBGdg0uGi/RcK1dgq6dOJmaDdDcH373CB8bx9Sw4Eoz9048aBLmW7MJYfrT95wx/5IHR67F2vJLP00BUzYSWS9LvU/EjvLO2CAGx2/XnlTXkOHhsRtsbkbmhVDE33UaZkkF1PlZcH5p0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaWm/LKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABCDC116B1;
	Thu,  9 May 2024 23:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715296200;
	bh=kbYiMDoNn6TzAktRP8/Mbm1cYY08LCZvZkjGOklwMA8=;
	h=Date:From:To:Cc:Subject:From;
	b=kaWm/LKxoCT3QxP+ciVdCvQSJQAm0FfUIXILy13NZFT43Mm0Ub7Mj2OHiqE8U2an4
	 FGKBwgA7L5XixnfiyUJW3eeIy/d8VxegxrV1vm2tN++dMu/5+zT6dM0EGBeGGY7Y8F
	 qE1GfT592kzE4q1HoNly+EIZHqKaseDzTxVfylDopBpQ3dW08EklCWgeVBbjwnjktG
	 JF8VUiMZg1PvI4L3S1wsEGH+ByAoHbDcxM7gZv25WgdZh/bRj1VwpBmXDBRIeMsWn+
	 HXPMUQ1blJJKjwops47FKBBeTpyOKdH50Cr6baj3sKG7arokpErWcY5K2khkQ6uWOJ
	 mH40j9AeDULNg==
Date: Thu, 9 May 2024 16:09:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>, Simon Horman <horms@kernel.org>,
 Hangbin Liu <liuhangbin@gmail.com>, Jaehee Park <jhpark1013@gmail.com>,
 Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, Davide Caratti <dcaratti@redhat.com>,
 Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org
Subject: [TEST] Flake report
Message-ID: <20240509160958.2987ef50@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Feels like the efforts to get rid of flaky tests have slowed down a bit,
so I thought I'd poke people..

Here's the full list:
https://netdev.bots.linux.dev/flakes.html?min-flip=0&pw-y=0
click on test name to get the list of runs and links to outputs.

As a reminder please see these instructions for repro:
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

I'll try to tag folks who touched the tests most recently, but please
don't hesitate to chime in.


net
---

arp-ndisc-untracked-subnets-sh
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
To: Jaehee Park <jhpark1013@gmail.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>

Times out on debug kernels, passes on non-debug.
This is a real timeout, eats full 7200 seconds.

xfrm-policy-sh
~~~~~~~~~~~~~~
To: Hangbin Liu <liuhangbin@gmail.com>

Times out on debug kernels, passed on non-debug,
This is a "inactivity" timeout, test doesn't print anything
for 900 seconds so the runner kills it. We can bump the timeout
but not printing for 15min is bad..

cmsg-time-sh
~~~~~~~~~~~~
To: Jakub Kicinski <kuba@kernel.org> (forgot I wrote this :D)

Fails randomly.

pmtu-sh
~~~~~~~
To: Simon Horman <horms@kernel.org>

Skipped because it wants full OVS tooling.


forwarding
----------

sch-tbf-ets-sh, sch-tbf-prio-sh
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
To: Petr Machata <petrm@nvidia.com>

These fail way too often on non-debug kernels :(
Perhaps we can extend the lower bound?

bridge-igmp-sh, bridge-mld-sh
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>

On debug kernels it always fails with:

# TEST: IGMPv3 group 239.10.10.10 exclude timeout                     [FAIL]
# Entry 192.0.2.21 has blocked flag failed

For MLD:

# TEST: MLDv2 group ff02::cc exclude timeout                          [FAIL]
# Entry 2001:db8:1::21 has blocked flag failed

vxlan-bridge-1d-sh
~~~~~~~~~~~~~~~~~~
To: Ido Schimmel <idosch@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>

Flake fails almost always, with some form of "Expected to capture 0
packets, got $X"

mirror-gre-lag-lacp-sh
~~~~~~~~~~~~~~~~~~~~~~
To: Petr Machata <petrm@nvidia.com>

Often fails on debug with:

# TEST: mirror to gretap: LAG first slave (skip_hw)                   [FAIL]
# Expected to capture 10 packets, got 13.

mirror-gre-vlan-bridge-1q-sh, mirror-gre-bridge-1d-vlan-sh
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
To: Petr Machata <petrm@nvidia.com>

Same kind of failure as above but less often and both on debug and non-debug.

tc-actions-sh
~~~~~~~~~~~~~
To: Davide Caratti <dcaratti@redhat.com>

It triggers a random unhandled interrupt, somehow (look at stderr).
It's the only test that does that.


mptcp
-----
To: Matthieu Baerts <matttbe@kernel.org>

simult-flows-sh is still quite flaky :(


nf
--
To: Florian Westphal <fw@strlen.de>

These are skipped because of some compatibility issues:

 nft-flowtable-sh, bridge-brouter-sh, nft-audit-sh

Please LMK if I need to update the CLI tooling. 
Or is this missing kernel config?

