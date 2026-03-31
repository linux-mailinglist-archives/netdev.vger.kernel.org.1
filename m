Return-Path: <netdev+bounces-273713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNFPIccHzGn+NQYAu9opvQ
	(envelope-from <netdev+bounces-273713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:43:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 282F836F353
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 19:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A5FDA30022E1
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 17:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C586A3E51DF;
	Tue, 31 Mar 2026 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mR3Vd908"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C99D33263A;
	Tue, 31 Mar 2026 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978390; cv=none; b=YM8uMo5hDoi1uTuDd7LZXU5Z8doYKIZt9Yj+Egbnli8LUVOfyBUyeWJSkk/mzB8v7yMH/cPXnCENpOU+as1bvuEOFO/5PEhAoK6rDBqvCnq0hHPGPuyJBpT8iq2rnIY8a4zTIDnz0LC+OHZvJzvt92Zc9uPzgHMyYCuhogOK8u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978390; c=relaxed/simple;
	bh=apaErXGmlrjKT2LcAebdIMqMLwGunZpI7uIaWKPB7v4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kLC2202D2m7h3H7VYYPhHbFiichBZQBylN48NVh9mzc92nqqYsS+Bptocx1YYw/dx8G24AVgd2h78QLB7Bn1qEj98exs4bxoCfpMr86PMe9v8aRkn7q/oKM/QrnvVLemcyW+lQXseZTLPdMhW6Qn+iaebwTait/h8TO2MtKPtHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mR3Vd908; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625D7C19423;
	Tue, 31 Mar 2026 17:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774978389;
	bh=apaErXGmlrjKT2LcAebdIMqMLwGunZpI7uIaWKPB7v4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mR3Vd908u2RrX/wrmor+IWDTb7BZmEKL+bdofNyGYBbQ+EHSHrVtr0hPczt0N4v+C
	 IqHnpMz5WL2DVKFC1TUrDgdjewIhMQieaGbNtYzF/K19RZNyXDMpHo1f5fPMoEjlNz
	 6dNy1tfG6HCcQasPrNSJeu99p3BaY483JTd1jvGcU/NoctjkfZ0F5/8+wM/cruqCrP
	 iGuq2LgvJlY+JQkFjulxl/uycHJAVbeQJ73yKDURMsRkJrAydbNvVnGpN5QsqaLGgy
	 PcxWl26vzTmRIsZ/zVLXRaYhj16tzS8UCiXo1w+2MkABG4CbEP8dMQ3Vko0wp+tV2K
	 TfJu+esujSgig==
Date: Tue, 31 Mar 2026 10:33:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Harvey <marcharvey@google.com>
Cc: jiri@resnulli.us, andrew+netdev@lunn.ch, willemb@google.com,
 maheshb@google.com, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] Decouple receive and transmit enablement
 in team driver
Message-ID: <20260331103308.421aac59@kernel.org>
In-Reply-To: <20260331053353.2504254-1-marcharvey@google.com>
References: <20260331053353.2504254-1-marcharvey@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-273713-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,teamd_activebackup.sh:url]
X-Rspamd-Queue-Id: 282F836F353
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 05:33:46 +0000 Marc Harvey wrote:
> Allow independent control over receive and transmit enablement states
> for aggregated ports in the team driver.
> 
> The motivation is that IEE 802.3ad LACP "independent control" can't
> be implemented for the team driver currently. This was added to the
> bonding driver in commit 240fd405528b ("bonding: Add independent
> control state machine").
> 
> This series also has a few patches that add tests to show that the old
> coupled enablement still works and that the new decoupled enalbment
> works as intended (4, 5, and 7).
> 
> There are three patches with small fixes as well, with the goal of
> making the final decouplement patch clearer (1, 2, and 3).

The tests don't pass for us, any dependencies we should be aware of?

# selftests: drivers/net/team: teamd_activebackup.sh
# Setting up two-link aggregation for runner activebackup
# Conf files are /tmp/tmp.zYDeygAAcf and /tmp/tmp.y5dfmFapAj
# This program is not intended to be run as root.
# This program is not intended to be run as root.
# Created team devices
# PING fd00::2 (fd00::2) 56 data bytes
# 64 bytes from fd00::2: icmp_seq=1 ttl=64 time=233 ms
# 
# --- fd00::2 ping statistics ---
# 1 packets transmitted, 1 received, 0% packet loss, time 0ms
# rtt min/avg/max/mdev = 233.163/233.163/233.163/0.000 ms/bin/bash: line 1: pv: command not found
# Packet count for test_team2 was 0
# Packet count for eth0 was 0
# Packet count for eth1 was 0
# Packet count for eth0 was 0
# Packet count for eth1 was 0
# TEST: teamd active backup runner test                               [FAIL]
# Traffic did not reach team interface in NS2.
# ./team_lib.sh: line 87: kill: (597) - No such process
# Tearing down two-link aggregation
# Failed to kill daemon: Timer expired
-- 
pw-bot: defer

