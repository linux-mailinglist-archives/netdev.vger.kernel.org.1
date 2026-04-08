Return-Path: <netdev+bounces-276646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCYYMLOF1mmwFwgAu9opvQ
	(envelope-from <netdev+bounces-276646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:43:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7B03BF010
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 18:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 137F93019151
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F683D1718;
	Wed,  8 Apr 2026 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbZDXXJS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21F2349B1F;
	Wed,  8 Apr 2026 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775666419; cv=none; b=mTAY/QMlh6FPTDY31E4IUUKo+uV35dZu1oBdALprg/7zm/fZXme99f+kyDfX33ky5qzmD14K53jbHInu9HJodz7SegvG2pyJGu7xGvYcpmk4UAbeCLzYJCIPHd33J8dJ/DlI23AGSnVxRX2Tk8HPJvFbWJJmE2E3qpNjs9mrT/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775666419; c=relaxed/simple;
	bh=kN1N5HiwbTc9gELWzJ4pnNv4U0PMd1J9f9+F/1Nk/Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHnSogW4w3X2RUhMZGaHkNek3B9yjTL5D843KeuzT3EzAWDtz60NntSvr349IqyYjJnHAYJaykXT7QWFNx7+0nN296eMVcDm6p/eNMBocTawukhrNd8OqJrZmWomMwMU8RmIyXVNs4uvpwddcqdUsDa33KDW76wXj5Lm09Wt8w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbZDXXJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF52C19421;
	Wed,  8 Apr 2026 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775666418;
	bh=kN1N5HiwbTc9gELWzJ4pnNv4U0PMd1J9f9+F/1Nk/Fg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CbZDXXJSo4bLUwSeLwf6xoLPrYZDnx6Q7XbJcDVVhx1Mx9baYv0AfO30y5NlTMsWB
	 phIipkR2NOMVNQy8AKczMQc75fCSbYq5X2Zx4Zp+I5JRm0BmyRrZVsK6iJbV9YI8PK
	 Po4fdP6TKRGE0FYEfNUJ+M4urOqx9rHjA5LKIwP9nnfrSRy2Gw1uh5SDo97FDjqLOE
	 57p3RbiAawqFfH3Q4d5Q1LL4+EhGQKiXsEYqX49+L0na47dONuOziZ64c2Aroth0X0
	 riH6tAS2+1ZI5n6LpVcO6TnrK3PnfRDUOc/2CcDIOFD3066dYDeH6CIWmlmeOo2nI6
	 Eo4BKZ8cw1kpQ==
Date: Wed, 8 Apr 2026 09:40:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Harvey <marcharvey@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v6 00/10] Decouple receive and transmit
 enablement in team driver
Message-ID: <20260408094015.3b8359c1@kernel.org>
In-Reply-To: <20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com>
References: <20260408-teaming-driver-internal-v6-0-e5bcdcf72504@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276646-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,teamd_activebackup.sh:url]
X-Rspamd-Queue-Id: 7A7B03BF010
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 08 Apr 2026 02:52:19 +0000 Marc Harvey wrote:
> Allow independent control over receive and transmit enablement states
> for aggregated ports in the team driver.
> 
> The motivation is that IEE 802.3ad LACP "independent control" can't
> be implemented for the team driver currently. This was added to the
> bonding driver in commit 240fd405528b ("bonding: Add independent
> control state machine").
> 
> This series also has a few patches that add tests to show that the old
> coupled enablement still works and that the new decoupled enablement
> works as intended (4, 5, and 10).
> 
> There are three patches with small fixes as well, with the goal of
> making the final decoupling patch clearer (1, 2, and 3).

It pains me to report on non-debug kernels:

make: Entering directory '/srv/vmksft/testing/wt-9/tools/testing/selftests'
make[1]: Nothing to be done for 'all'.
TAP version 13
1..1
# timeout set to 45
# selftests: drivers/net/team: teamd_activebackup.sh
# Setting up two-link aggregation for runner activebackup
# Teamd version is: teamd 1.32
# Conf files are /tmp/tmp.ZeEAwlX4kB and /tmp/tmp.Q8XVmtXmXY
# This program is not intended to be run as root.
# This program is not intended to be run as root.
# Created team devices
# Teamd PIDs are 30274 and 30278
# PING fd00::2 (fd00::2) 56 data bytes
# 64 bytes from fd00::2: icmp_seq=1 ttl=64 time=0.037 ms
# 
# --- fd00::2 ping statistics ---
# 1 packets transmitted, 1 received, 0% packet loss, time 0ms
# rtt min/avg/max/mdev = 0.037/0.037/0.037/0.000 msPacket count for test_team2 was 121
# Waiting for eth0 in ns2-yYZzD5 to stop receiving
# Packet count for eth0 was 0Packet count for eth0 was 0
# Packet count for eth1 was 243
# Waiting for eth1 in ns2-yYZzD5 to stop receiving
# Packet count for eth1 was 0Packet count for eth0 was 365
# Packet count for eth1 was 0
# TEST: teamd active backup runner test                               [ OK ]
# Tearing down two-link aggregation
# Failed to kill daemon: Timer expired
#
not ok 1 selftests: drivers/net/team: teamd_activebackup.sh # TIMEOUT 45 seconds


Retry:

make: Entering directory '/srv/vmksft/testing/wt-9/tools/testing/selftests'
make[1]: Nothing to be done for 'all'.
TAP version 13
1..1
# timeout set to 45
# selftests: drivers/net/team: teamd_activebackup.sh
# Setting up two-link aggregation for runner activebackup
# Teamd version is: teamd 1.32
# Conf files are /tmp/tmp.0pmbsXgdH5 and /tmp/tmp.ehbGB6jJTZ
# This program is not intended to be run as root.
# This program is not intended to be run as root.
# Created team devices
# Teamd PIDs are 1314 and 1318
# PING fd00::2 (fd00::2) 56 data bytes
# 64 bytes from fd00::2: icmp_seq=1 ttl=64 time=0.032 ms
# 
# --- fd00::2 ping statistics ---
# 1 packets transmitted, 1 received, 0% packet loss, time 0ms
# rtt min/avg/max/mdev = 0.032/0.032/0.032/0.000 msPacket count for test_team2 was 121
# Waiting for eth0 in ns2-H0Yrq8 to stop receiving
# Packet count for eth0 was 0Packet count for eth0 was 0
# Packet count for eth1 was 243
# Waiting for eth1 in ns2-H0Yrq8 to stop receiving
# Packet count for eth1 was 0Packet count for eth0 was 366
# Packet count for eth1 was 0
# TEST: teamd active backup runner test                               [ OK ]
# Tearing down two-link aggregation
# Failed to kill daemon: Timer expired
#
not ok 1 selftests: drivers/net/team: teamd_activebackup.sh # TIMEOUT 45 seconds

