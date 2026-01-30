Return-Path: <netdev+bounces-254983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLswHc4afGlgKgIAu9opvQ
	(envelope-from <netdev+bounces-254983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:43:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E538FB686D
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AA2A3019143
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049253164D0;
	Fri, 30 Jan 2026 02:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBOowMJb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38A01E1024;
	Fri, 30 Jan 2026 02:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769740999; cv=none; b=NSs2RjFAn2GRYlvivUSTqV55mnW6RZrZTf6jJ7KCZsCEBVrS5jr2npc+Uow52g/1uEXh00PYtioz4qsDyDZaeoCTeYXLKeOYwC/lVpmXcEAPLd1VKPUlJzIYz4KtRFSXevGQrcE8glghqQx5uU5E85iGrzuc7eG1AvmaFYAQ9+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769740999; c=relaxed/simple;
	bh=ERbeiUIYUnhqnTkv+lkant+gYUBDq4x7E8WNc0zXjps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATynHm/bAtvcQLcLKuNCIXfauCFvOjnzxl9XLIkdh0Jsn+IfqEr97NeCae/xjQBAWPGW1JsP0c6+A2P7qlJVDPjI7ohAXgjidJpGMmTjt3l63IMOjZE/tE5mYWOHzKuDj/qDoy1nKxhuAo5TRx8ogyhAgBJfyrXSlEXpuBjKEbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBOowMJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2194C4CEF7;
	Fri, 30 Jan 2026 02:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769740999;
	bh=ERbeiUIYUnhqnTkv+lkant+gYUBDq4x7E8WNc0zXjps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EBOowMJbJENHprsyT0HESWLxhOifou73xl2JEcACaO/dcqAHmp0rrMdRzH4I5QtRc
	 TGvA/NEOImttes36vwW9c42qPBf1OdYGqx+eGkvhjpyaq57N8ZvkevqE6PQmn1tEKh
	 9IH+EYt5sx0OlYKEktjeRL6MyRTZMMODE9hOWTcZ81ccYMYloPjYxT9jtpKdx/aVX4
	 7KdaYa334L8C6Xdm4qjLGfnMKf7k96NTpAKpniI1PcO7hsglFUtzVr3jAchujXVjHL
	 NTOnZU92rUWnE+Nwye7laSgazHs9wFsafLqauLpV4YDUThCiTDab/grWAl16Mdc9AY
	 leNT2ip3icChA==
Date: Thu, 29 Jan 2026 18:43:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Shuah Khan
 <shuah@kernel.org>, <devel@linux-ipsec.org>,
 <linux-kselftest@vger.kernel.org>, Tobias Brunner <tobias@strongswan.org>,
 Simon Horman <horms@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 2/2] selftests: net: add ICMP error source
 address test over xfrm tunnel
Message-ID: <20260129184318.53b1dabf@kernel.org>
In-Reply-To: <af9a189bee31f7d8f3759ed71d09ab5a82437592.1769595011.git.antony.antony@secunet.com>
References: <cover.1769595011.git.antony.antony@secunet.com>
	<af9a189bee31f7d8f3759ed71d09ab5a82437592.1769595011.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254983-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E538FB686D
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 11:20:45 +0100 Antony Antony wrote:
> Test that ICMP error messages generated by an IPsec gateway use
> the correct source address (the gateway's address, not the
> unreachable destination).

could you check / fix shellcheck warnings?

+In xfrm_state.sh line 115:
+	$ksft_skip)
+        ^--------^ SC2254 (warning): Quote expansions in case patterns to match literally rather than as a glob.

+In xfrm_state.sh line 157:
+	[ -n "${NS_R1}" ] && ns_r1="ip netns exec ${NS_R1}" && ns_active="${ns_active} $NS_R1"
+                             ^---^ SC2034 (warning): ns_r1 appears unused. Verify use (or export if used externally).
+
+
+In xfrm_state.sh line 162:
+	[ -n "${NS_B}" ] && ns_b="ip netns exec ${NS_B}" && ns_active="${ns_active} $NS_B"
+                            ^--^ SC2034 (warning): ns_b appears unused. Verify use (or export if used externally).

+In xfrm_state.sh line 166:
+	local ns_cmd=$(nscmd $1)
+              ^----^ SC2155 (warning): Declare and assign separately to avoid masking return values.
-- 
pw-bot: cr

