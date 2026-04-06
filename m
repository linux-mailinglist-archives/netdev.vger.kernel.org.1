Return-Path: <netdev+bounces-275619-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J2VH9zG02mqlgcAu9opvQ
	(envelope-from <netdev+bounces-275619-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:44:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1614F3A4560
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 16:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4878A300826A
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 14:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6539F3845B3;
	Mon,  6 Apr 2026 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W23Ii5gw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4170C334681;
	Mon,  6 Apr 2026 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775486680; cv=none; b=fH3Z98p+PU9AiXbzkWbK0Wl1HDJ5tgn+eSzoWqPd1o4wzwe7yb8r2faFdTsxCQICkdbTuQSMNZ9CWcsOfYJXvPd43wvrbo+5R0MLJvLyoKU84SMBiNEHH5EqYxzd2EIPO82Q4Na+FdfLU6WN9lCTxhtLcP+LnRalP6ykmUNmFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775486680; c=relaxed/simple;
	bh=cUc/USTOXTckbKII2P/K3rxyrbVtnkvsLV7A5OMbn7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vxe3xOLUPLLa7Q+gjcSur52kgxHYqKbF+9nsam+dCO0/Upck4PEIu2gf0SUXH1saQrKQ1IBQE1YPsKRX7FtbzeBb5G8wYxSslWnkOOGSkLtpfOMsZHIsGRp/BLuIcpCb4jAEY19pY8EJNE7EvPTnyNlqFsNH2xxDWo1We2/IqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W23Ii5gw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC3FC4CEF7;
	Mon,  6 Apr 2026 14:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775486679;
	bh=cUc/USTOXTckbKII2P/K3rxyrbVtnkvsLV7A5OMbn7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W23Ii5gwcwcRvfER1ccWlIiqmxwU9wzIZXlCqrHkFRhFZwQOHXRfXUJj/K++9KvgY
	 btTRTrODvylC9A4M4pmP2JGRWp+d2EUMGFODnwX/ytO0Ojou8PARizHNVKOQRGvFhT
	 Wrl2QfUVrMIQ8MRsUeULqDdHJu1HZUzRrchoc0oz5vLBS6gqQk0Nvc5LlvLJdvhNwz
	 RarrnYtUp4Aa7zkY/ostKNc+KgtAKh8luaqos140WwK92lBpfmznQi8ZBCJ89VdES6
	 PoyrNgEt9iXWJeY899NO5JQfuui+yf2TowRb+ucJlaX5dWzaxANZHckKbPIRf2juZN
	 sMxVsOMnw73Lg==
Date: Mon, 6 Apr 2026 07:44:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Harvey <marcharvey@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/10] Decouple receive and transmit
 enablement in team driver
Message-ID: <20260406074437.3ebb904a@kernel.org>
In-Reply-To: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
References: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275619-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,teamd_activebackup.sh:url,transmit_failover.sh:url]
X-Rspamd-Queue-Id: 1614F3A4560
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 06 Apr 2026 03:03:36 +0000 Marc Harvey wrote:
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

activebackup:

TAP version 13
1..1
# overriding timeout to 2400
# selftests: drivers/net/team: teamd_activebackup.sh
# Setting up two-link aggregation for runner activebackup
# Teamd version is: teamd 1.32
# Conf files are /tmp/tmp.ydjNK9Um7H and /tmp/tmp.xZuc3cWbN0
# This program is not intended to be run as root.
# This program is not intended to be run as root.
# Created team devices
# Teamd PIDs are 21457 and 21461
# exec of "ip link set eth0 up" failed: No such file or directory
# exec of "ip link set eth0 up" failed: No such file or directory
# exec of "ip link set eth1 up" failed: No such file or directory
# exec of "ip link set eth1 up" failed: No such file or directory
# PING fd00::2 (fd00::2) 56 data bytes
# 64 bytes from fd00::2: icmp_seq=1 ttl=64 time=0.753 ms
# 
# --- fd00::2 ping statistics ---
# 1 packets transmitted, 1 received, 0% packet loss, time 0ms
# rtt min/avg/max/mdev = 0.753/0.753/0.753/0.000 msPacket count for test_team2 was 0
# Waiting for eth0 in ns2-lZ0gqd to stop receiving
# Packet count for eth0 was 0Packet count for eth0 was 0
# Packet count for eth1 was 0
# Waiting for eth1 in ns2-lZ0gqd to stop receiving
# Packet count for eth1 was 0Packet count for eth0 was 0
# Packet count for eth1 was 0
# TEST: teamd active backup runner test                               [FAIL]
# Traffic did not reach team interface in NS2.
# Tearing down two-link aggregation
# Failed to kill daemon: Timer expired
# Failed to kill daemon: Timer expired
# Sending sigkill to teamd for test_team1
# rm: cannot remove '/var/run/teamd/test_team1.pid': No such file or directory
# rm: cannot remove '/var/run/teamd/test_team1.sock': No such file or directory
# Sending sigkill to teamd for test_team2
# rm: cannot remove '/var/run/teamd/test_team2.pid': No such file or directory
# rm: cannot remove '/var/run/teamd/test_team2.sock': No such file or directory
not ok 1 selftests: drivers/net/team: teamd_activebackup.sh # exit=1


transmit_failover:

TAP version 13
1..1
# overriding timeout to 2400
# selftests: drivers/net/team: transmit_failover.sh
# Error: ipv6: address not found.
# Setting team in ns2-yxjiUo to mode roundrobin
# Error: ipv6: address not found.
# Setting team in ns1-Jht6kA to mode broadcast
# Packet count for eth0 was 0
# Packet count for eth1 was 0
# Packet count for eth0 was 0
# Packet count for eth1 was 0
# Packet count for eth0 was 0
# Packet count for eth1 was 0
# TEST: Failover of 'broadcast' test                                  [FAIL]
# eth0 not transmitting when both links enabled
# Setting team in ns1-Jht6kA to mode roundrobin
# Packet count for eth0 was 0
# Packet count for eth1 was 0
# Packet count for eth0 was 0
# Packet count for eth1 was 0
# Packet count for eth0 was 0
# Packet count for eth1 was 0
# TEST: Failover of 'roundrobin' test                                 [FAIL]
# eth0 not transmitting when both links enabled
# Setting team in ns1-Jht6kA to mode random
# Packet count for eth0 was 0
# Packet count for eth1 was 0
# Packet count for eth0 was 0
# Packet count for eth1 was 0
# Packet count for eth0 was 0
# Packet count for eth1 was 0
# TEST: Failover of 'random' test                                     [FAIL]
# eth0 not transmitting when both links enabled
not ok 1 selftests: drivers/net/team: transmit_failover.sh # exit=1
-- 
pw-bot: cr

