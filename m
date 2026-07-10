Return-Path: <netdev+bounces-306646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bT7hJqU0UWoIAwMAu9opvQ
	(envelope-from <netdev+bounces-306646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:06:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF7473D327
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:06:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HMnYlT01;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306646-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306646-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E85C6302FD63
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BD637FF63;
	Fri, 10 Jul 2026 18:05:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B9037F8AF;
	Fri, 10 Jul 2026 18:05:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706728; cv=none; b=qLt0TacZFPlQ3wdc46rRrfcY1siV9V2Dz5OmQx7Biu1999jb4BECAjErl90hXZRmMhOEf4EcxYzxF06vDOjXt6veor/N7N0gOgMXlZ1G7JKRbTYlShVsunccle/krBdr0JnLN4TGlur2O6Q40n/SGvSey0CxjQ/LiHZE89BlQvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706728; c=relaxed/simple;
	bh=L5i/YJgNhRL2IXLTOg959njSEcZsBBHBQ0v+nBGsp4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n2cEHtw6YYfYLxEbVAE0JngMYikDKySXbU8k/5XAekM4Lwmnhobom0Z1V/lEJdYZVlxKw5ggiljB3MHzMYW00zO/qGP8TRxltOd7K/1AR/6UZTk8BSQdlDk9t20d3aeSB8R0zG9k79luj+OSxfJ+urcCjohKs4DrckU+wsqU2xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMnYlT01; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559B41F00A3A;
	Fri, 10 Jul 2026 18:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783706727;
	bh=746iBKKoIqBKEu5UX9LQWkEwwoEDcoxxFAYwiKIfnp4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HMnYlT01Khz+BsQnBWSbl+dq+ph4BQ1oZ604Mt3/Z74W+WFoico3fcAn9uDRBuT/j
	 gaxN+yURBf7V00gmaN9E4QBb5Op7JSf10sv7HLfElUHJluML5HKCBrobdEOzzXN7WR
	 695GhSxb08VmwZOzIEUPiorpsC+LjWK3d7+INAq86w59WaNYs/5dFwa8IkWrX6Mxxy
	 9rfwdvcaHFx3hnMstjwjpZW5QEbBK8eJ/McM+H3FcuwgHcHJsxQli6gZj7GJOrCxvR
	 Zuuu9Rc2IONyN+PwAyPADJGi0vA+ZaxObWWz3lz3eshM68Q1Amvza8aCWzD3y0Kkak
	 AA35dFNT1wxOg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Jul 2026 20:04:43 +0200
Subject: [PATCH net 3/7] selftests: ovpn: add IPV6 and VETH configs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-net-sft-fix-containers-v1-3-a2915c294ef5@kernel.org>
References: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org>
In-Reply-To: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Antonio Quartulli <antonio@openvpn.net>, 
 Sabrina Dubroca <sd@queasysnail.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1385; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=L5i/YJgNhRL2IXLTOg959njSEcZsBBHBQ0v+nBGsp4s=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLICTcJe/2mUDSs21c6cWPHt2K3fGacTPk9Zw3R6xvnit
 Pq7a7SOdpSyMIhxMciKKbJIt0Xmz3xexVvi5WcBM4eVCWQIAxenAEzkhT0jw4WDX58EqlvIThEv
 eS7OZn+0sst/l3TzY9UAh/8OS3L6IhkZHqy7MinfuJlD9Nrcj2YfHf1dUyd16z8Q4zWX2jrzgsl
 PRgA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:matttbe@kernel.org,m:antonio@openvpn.net,m:sd@queasysnail.net,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-306646-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,openvpn.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BF7473D327

They are required to run the selftests:

 - Tests are executed in v4 and v6.

 - Virtual Ethernet are used between the different netns.

This has not been seen on NIPA before, because the 'ovpn' tests are
executed with the 'tcp_ao' ones, merging their config files. These two
kernel config are present in tools/testing/selftests/net/tcp_ao/config.

This issue is visible when only the ovpn config is used on top of the
default one. This is the recommended way to execute selftest targets.

Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Antonio Quartulli <antonio@openvpn.net>
To: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/ovpn/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/ovpn/config b/tools/testing/selftests/net/ovpn/config
index d6cf033d555e..6b424762e46e 100644
--- a/tools/testing/selftests/net/ovpn/config
+++ b/tools/testing/selftests/net/ovpn/config
@@ -4,6 +4,7 @@ CONFIG_CRYPTO_CHACHA20POLY1305=y
 CONFIG_CRYPTO_GCM=y
 CONFIG_DST_CACHE=y
 CONFIG_INET=y
+CONFIG_IPV6=y
 CONFIG_NET=y
 CONFIG_NETFILTER=y
 CONFIG_NET_UDP_TUNNEL=y
@@ -11,3 +12,4 @@ CONFIG_NF_TABLES=m
 CONFIG_NF_TABLES_INET=y
 CONFIG_OVPN=m
 CONFIG_STREAM_PARSER=y
+CONFIG_VETH=y

-- 
2.53.0


