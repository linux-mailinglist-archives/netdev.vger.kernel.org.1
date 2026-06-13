Return-Path: <netdev+bounces-298974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jQlSDl5zLWrbgQQAu9opvQ
	(envelope-from <netdev+bounces-298974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:12:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B63C67EE11
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 17:12:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=s0j1aOV7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298974-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298974-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B100F3004F07
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 15:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FCE3385A1;
	Sat, 13 Jun 2026 15:12:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE3A2F8E80;
	Sat, 13 Jun 2026 15:12:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781363543; cv=none; b=UfwwxZmlw4AGw0WP8STj8RdEJ12d2PNxO23eoqrXKbzJ37Yc8c3Uq3DfGjATz8qhePOuFZFYv6bIeJ2JHH0J/y/ysI/CLq3TNa1U9GlX1MReqM+fGlHLfQRtZSDJcFmr4TX1CuL5uMFw/FYN/13rUfHUh50yw333Avim2+rMtDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781363543; c=relaxed/simple;
	bh=Y9R2ftg/Zc8pbqLpM48ZXxFjcwcH8ONf9PZJEZvCuaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OMsi1fvFs0eJSs4Hn63uU9l1HqkHNuq1e0WndnIdUN5bl5xnTjuXj5XI+IO9Yt6vZIGUwRMqnLnI72YKmO3QAhAdkJgJCFj3+UlE/hGZ66Z0piQBrLhP4y+QU8Ww6N1piWEa+tHQymiwwD2++xcny7il5bZZP0GVxhD4ZZXFfU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0j1aOV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29567C2BCB9;
	Sat, 13 Jun 2026 15:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781363543;
	bh=Y9R2ftg/Zc8pbqLpM48ZXxFjcwcH8ONf9PZJEZvCuaA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s0j1aOV7Odja4j36Q/MtOdhw6EbRWzEpFJpsFNiMzx7onHlghFDlocV1U6wCRZLQJ
	 YpmFoCScf0KHQL3AYG+qs+PFaDCbNNrNjrF2JbqMjJUfKwbSrRUfhfxLLIXsmsuSfZ
	 yksU8sYSa/SkvxYdweQzZ30mkmRegcGC5GgKkDnqkVqIUFhqNdjlLfcKU2qX7HON9f
	 Fg4mIfPxp4L0IJIhVqlnSuaqGD8+k64laNJhFDLBasDugvqhm7+B9cVZPyrcqs6T+L
	 hVONEn19QU5Y54ONjDi4p/V4fPRVhp2ERdT8wqmeNUn+MhQCnj2xYc+SvIRjjrJYqH
	 fOCUH2e3b3WOQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1540CCD98DA;
	Sat, 13 Jun 2026 15:12:23 +0000 (UTC)
From: Laika Price via B4 Relay <devnull+laikabcprice.gmail.com@kernel.org>
Date: Sat, 13 Jun 2026 16:12:18 +0100
Subject: [PATCH net v2 2/2] selftests: pmtu: fix incorrect PMTU exception
 generation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-master-v2-2-061b70fd45dd@gmail.com>
References: <20260613-master-v2-0-061b70fd45dd@gmail.com>
In-Reply-To: <20260613-master-v2-0-061b70fd45dd@gmail.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Laika Price <laikabcprice@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781363541; l=1559;
 i=laikabcprice@gmail.com; s=20260613; h=from:subject:message-id;
 bh=EB7JD3oI/Fpm2bkrfDJdH/qbu3251WqBWWjNhI2DYYM=;
 b=f4F5woWRmK8h6Q1dIwcyXaCXS6wPgWhwk96cSQywjZ8iRa54P16GPL9ImVtdSAot/J81rhPrd
 xHM7r6GJtNlDCWq45emc4ZR2JDx7elaIM3e9y+SeBzfn4x/6GHL1P4+
X-Developer-Key: i=laikabcprice@gmail.com; a=ed25519;
 pk=mFSMw2odvyxt1H4QHAdwZVuwHduNzUMDKbWFOcwhDCg=
X-Endpoint-Received: by B4 Relay for laikabcprice@gmail.com/20260613 with
 auth_id=819
X-Original-From: Laika Price <laikabcprice@gmail.com>
Reply-To: laikabcprice@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:laikabcprice@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298974-lists,netdev=lfdr.de,laikabcprice.gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[laikabcprice@gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B63C67EE11

From: Laika Price <laikabcprice@gmail.com>

pmtu_ipv4_br_vxlan4_exception generates PMTU exceptions by pinging an IP
on the other side of a tunnel. This was incorrect as it would return upon
the first ICMP Fragmentation Needed due to the -w flag being used in
conjunction with || return 1.

This patch updates pmtu_ipv4_br_vxlan4_exception to be in line with how
PMTU exceptions are generated in other tests such as in test_pmtu_ipvX

    run_cmd ${ns_a} ${ping} -q -M want -i 0.1 -w 1 -s 1800 ${dst1}
    run_cmd ${ns_a} ${ping} -q -M want -i 0.1 -w 1 -s 1800 ${dst2}

Signed-off-by: Laika Price <laikabcprice@gmail.com>
---
 tools/testing/selftests/net/pmtu.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index a3323c21f..9498d9f53 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -1456,8 +1456,8 @@ test_pmtu_ipvX_over_bridged_vxlanY_or_geneveY_exception() {
 	mtu "${ns_a}" ${type}_a $((${ll_mtu} + 1000))
 	mtu "${ns_b}" ${type}_b $((${ll_mtu} + 1000))
 
-	run_cmd ${ns_c} ${ping} -q -M want -i 0.1 -c 10 -s $((${ll_mtu} + 500)) ${dst} || return 1
-	run_cmd ${ns_a} ${ping} -q -M want -i 0.1 -w 1  -s $((${ll_mtu} + 500)) ${dst} || return 1
+	run_cmd ${ns_c} ${ping} -q -M want -i 0.1 -w 1 -s $((${ll_mtu} + 500)) ${dst}
+	run_cmd ${ns_a} ${ping} -q -M want -i 0.1 -w 1 -s $((${ll_mtu} + 500)) ${dst}
 
 	# Check that exceptions were created
 	pmtu="$(route_get_dst_pmtu_from_exception "${ns_c}" ${dst})"

-- 
2.54.0



