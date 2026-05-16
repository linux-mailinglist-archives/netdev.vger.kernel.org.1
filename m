Return-Path: <netdev+bounces-288654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJCjCPesCGqz0gMAu9opvQ
	(envelope-from <netdev+bounces-288654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 19:44:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF0C55CFAD
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 19:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E40A33010C22
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655253ECBE8;
	Sat, 16 May 2026 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kn1EM7eA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414113E8351;
	Sat, 16 May 2026 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778953458; cv=none; b=eDZt+M1nf5AZLalE6e9HC+29eV7IQDGHlfdOshO2zCK8GGFhkUUgxcARiLaFbnYT7cmSYdvfT7+XEIYQwqc1wGKoT3Vv02PRIxv4szSkF6bUhYBquW6XqSOTX3u63fdSeHcU1dPNV27xMmzqca/ht5UFlCA6tca1eAImkL9XVyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778953458; c=relaxed/simple;
	bh=PDxzanIY5EwjpSShAm3tgDsQyopS9CktlitMPG3Kw+I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrOt81ewK826UV1i/qgNMClhstCDnnYabLxwod6f4yDrg9xlt0ZD6cUcLX3VWd3Vcm/biZzxW84aaico/7dGyGWU6QynQ0W4oO24tq1v/ctbSb7KpzNeePZAX6KE91ZiwTCBhOajJEJ1q8v+FqSWIkeKdunlHXJpG1Y5sw/zFyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kn1EM7eA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781D1C19425;
	Sat, 16 May 2026 17:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778953457;
	bh=PDxzanIY5EwjpSShAm3tgDsQyopS9CktlitMPG3Kw+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kn1EM7eAUJ47v82cYIQjG3LEgYSpdyRgGNMBoqVV92mmmxThTm8ZOTEiGREfkG9Do
	 SPfMNI2gNtPCPQTcrFpnT40o2QaSnoB67T2uDHf0D+nYngIOUVwUU3Wzv9MZQYZl6H
	 sDq9BgzMtqZMKTuCp8AkhVgVtB5wsQbCxDtIy+5HMjXH99OwSWGhlFbPGI9LyaKU6p
	 LuBpN2GuFKGcxLgUwDScI9Zeb9tpX3Z07tt+c41F7TKk0MU+JFMtaqP29NNTilVVMr
	 AQ2FROLaDBl/Cw5ppNt+yZQ6gGLlmWtXs9UZyseiteAK3BmWtFK+T2Wumwnhe8QrUQ
	 UzFGcvnVVQrAQ==
Date: Sat, 16 May 2026 10:44:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Neil Spring <ntspring@meta.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, dsahern@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/2] selftests: net: add local ECMP rehash
 test
Message-ID: <20260516104416.09aa5458@kernel.org>
In-Reply-To: <20260513204048.2721843-3-ntspring@meta.com>
References: <20260513204048.2721843-1-ntspring@meta.com>
	<20260513204048.2721843-3-ntspring@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8FF0C55CFAD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-288654-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, 13 May 2026 13:40:48 -0700 Neil Spring wrote:
> Add ecmp_rehash.sh with nine scenarios verifying that TCP rehash
> selects a different local ECMP path for IPv6:
> 
>   - SYN retransmission (forward path blocked during setup)
>   - SYN/ACK retransmission (reverse path blocked during setup)
>   - Midstream RTO (forward path blocked on established connection)
>   - Midstream ACK rehash (reverse path blocked on established connection)
>   - PLB rehash (ECN-driven congestion on established connection)
>   - Hash policy 1 negative test (rehash attempted but path unchanged)
>   - No flowlabel leak (mp_hash does not alter on-wire flowlabel)
>   - Dst rebuild consistency (route replace does not change path)
>   - Dst rebuild consistency with syncookies (same via cookie_v6_check)
> 
> The policy 1 test verifies that fib_multipath_hash_policy=1 computes
> a deterministic 5-tuple hash, so txhash re-rolls do not change the
> ECMP path while TcpTimeoutRehash still increments.
> 
> The flowlabel leak test sets auto_flowlabels=0 and installs tc
> filters that drop TCP packets with nonzero flowlabel, confirming
> that fl6->mp_hash does not leak into the on-wire IPv6 flow label.
> 
> The dst rebuild tests stream data, replace the ECMP route with
> identical nexthops (invalidating the cached dst), and verify that
> traffic stays on the same path.  This confirms that the initial
> route lookup in tcp_v6_connect() and cookie_v6_check() uses the
> same hash as subsequent rebuilds via inet6_csk_route_socket().
> Set ECMP_REBUILD_ROUNDS=N for statistical confidence.

Hi Neil!

The test appears to be too flaky:
https://netdev.bots.linux.dev/contest.html?test=ecmp-rehash-sh
-- 
pw-bot: cr

