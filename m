Return-Path: <netdev+bounces-278239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HF1L5OD3WmffAkAu9opvQ
	(envelope-from <netdev+bounces-278239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:00:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC7B3F454E
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 02:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68508303AF3F
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 00:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01837311975;
	Tue, 14 Apr 2026 00:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orzh+HD6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340926ED37
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 00:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776124815; cv=none; b=Ju/4r9Yni6QWUZAmTKX73Q7TF6OrfJiuGv5AIwKHZ1plg1dvdglre2iwYcJTSTpUJ2gluHXBcyZ8d6JsDcZCSJ6Jramz2XFKTdmBYJ0Ap0o7O3JOh4rpCgorNePP9EmFoBHaw6OsrOqhHNhN0YDW1MhP1cN4uAYw/+YGlG2hhqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776124815; c=relaxed/simple;
	bh=kFyfZfnVR+Envy0zTDLbT0E/ED/giUx0bH3sC01QXKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IWQQujZf8IhpAijAQs3E5t89nz1gk1ZHM8VxCqPenugOm/Vpo2Sitb+XeSAaZ8dp+rJ1DM43wQDFcGg9nIvIQ6gyO/6KqW1JKhsSJoSrb/21TJMhxydEDsA4dK6H73R+tpFXLAFzHFVHdDhc65lahjfSTtcInZTIPMTLU2/Y3DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orzh+HD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8EFC2BCAF;
	Tue, 14 Apr 2026 00:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776124815;
	bh=kFyfZfnVR+Envy0zTDLbT0E/ED/giUx0bH3sC01QXKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=orzh+HD6lCjaJfUqKUxyzLI+fi1YBeR0X0SPJTNCc3EobtcK0XaEH/6+QyNcC+jQG
	 hhEwJxT4wm+kDp6aDPd7GJGnH1Qkiq8ducYC5CpFNqwllk7WT5BGcg1UsevRtasofh
	 P4ghVBjbVT5+fWtOMIkrsIuvaeWdAbhujz9ATROLSZx5VfuNUPXtURX484kRPc0SZ5
	 JTwwGjJJZCKU7HWuXPAclqTvQyMzae7/dDiYZqqraO+ddxisGTKyF9FfheztKsZOU0
	 OAHiM0tvXmFo24LGuCMT9wneJYXlyFuhBaMffk4cCDsrKVKVgHHzVHppL0vp1weeAt
	 8iBLhHCtuAT9A==
Date: Mon, 13 Apr 2026 17:00:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, Sabrina Dubroca
 <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 2/5] selftests: ovpn: fail notification check
 on mismatch
Message-ID: <20260413170014.12316e9b@kernel.org>
In-Reply-To: <20260412221121.410365-3-antonio@openvpn.net>
References: <20260412221121.410365-1-antonio@openvpn.net>
	<20260412221121.410365-3-antonio@openvpn.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278239-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,test_mark.sh:url,test_symmetric_id_tcp.sh:url]
X-Rspamd-Queue-Id: 1FC7B3F454E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 00:11:18 +0200 Antonio Quartulli wrote:
> compare_ntfs doesn't fail when expected and received notification
> streams diverge.
> 
> Fix this bug by trackink the diff exit status explicitly and return it
> to the caller so notification mismatches propagate as test failures.

Hm, this series nicely cleans up test_mark.sh failures
but test_tcp.sh now always fails on debug (slow) kernel
builds with:

# TAP version 13
# 1..12
# ok 1 setup network topology
# ok 2 run baseline data traffic
# ok 3 run LAN traffic behind peer1
# ok 4 run iperf throughput
# ok 5 run key rollout
# ok 6 query peers
# ok 7 query missing peer fails
# ok 8 peer lifecycle and key queries
# ok 9 delete peer while traffic
# ok 10 delete stale keys
# ok 11 check timeout behavior
# Checking notifications for peer 3... failed
# 1,9d0
# < {
# <   "name": "peer-del-ntf",
# <   "msg": {
# <     "peer": {
# <       "del-reason": "expired",
# <       "id": 12
# <     }
# <   }
# < }
# validate listener output for peer 3: command failed with rc=1: ovpn_compare_ntfs 3
# not ok 12 validate notification output
# # Totals: pass:11 fail:1 xfail:0 xpass:0 skip:0 error:0

Similar failure in test_symmetric_id_tcp.sh

Only the debug kernels tho, non-debug kernels seem to pass.
So probably some race / slowness.

More runs if you want to compare
https://netdev.bots.linux.dev/contest.html?executor=vmksft-net-extra-dbg&test=test-tcp-sh
This series landed in net-next-2026-04-13--06-00

