Return-Path: <netdev+bounces-306647-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m476I9w0UWoUAwMAu9opvQ
	(envelope-from <netdev+bounces-306647-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:07:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E57673D351
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:07:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SOiCSI54;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306647-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306647-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 238A03018609
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC99380FD6;
	Fri, 10 Jul 2026 18:05:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F1537AA96;
	Fri, 10 Jul 2026 18:05:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706731; cv=none; b=QyeMecyd220cL5NZMt53Izh9lK8DE5y7kdfV8HMmbOnlCtC1Y12rq29fSZb1irdJs84FRzP/jphd23xuW3bSmDyW4fNayY5ROVCNSQi9Uzb0H5+h3y2qbkmRCgrl4VQWFZ8bouzCTdAt6s/BhSmLtrKjO0bzjxYaJVF+MglVvLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706731; c=relaxed/simple;
	bh=ikQbe/6nBjijkDIRx1EEo9JlxWKuS3tTkFmcxFQ4JQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hfksTcJqIhOBlKrZFlJ2Xr9QOUsJppk8SfOsxvrlNKMxw8aTX2o1rQYq9Is6v7rlVK8BVYBr9O6iM4KnBwhNA6whAkCUFZX8Ia2eAy2zqV7t83qu/8wa3mN3tf+6UBOu83Qrpa/M9Jy2LJ8/LHl+QtAvGCR2Q49EaOKBUYcNP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOiCSI54; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA54A1F000E9;
	Fri, 10 Jul 2026 18:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783706729;
	bh=Gkm9cmXQHdFz66jn50yWDPWBch4PTFuWBHMjtX+glmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SOiCSI54fF5tSw1/DQAg6x0Kz9u418EaW+v8fI4jEDYKwjphwM0NJd1mWQe46ZA+K
	 gL1qQAoTLo7FGh0L/eAxEyB+sTFZovMeK3KTO2gg2Dbn3G0sSPNzEXBaMGcQ2vFc4D
	 TUoOTEfG1WwpP8mBEm01BfLq59zGxtyxllaLyz1Cb1iwME99wHUY1t1Dt9Wnwc30TJ
	 7HvWJL4FiQYoo5R/VgLpA31Q2zmlUqFjXL4kFmFh/VhfQjnYMlfeWeN8YYaLuMsxj5
	 xwKqcjFhkdLE5i4ZdFz3tJDsjO0I0L2autqwP7NMT0tZKZsIAb1E+C9fdX8bOchK4F
	 wjC7nZMfUA6uw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Jul 2026 20:04:44 +0200
Subject: [PATCH net 4/7] selftests: ovpn: increase timeout
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-net-sft-fix-containers-v1-4-a2915c294ef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ikQbe/6nBjijkDIRx1EEo9JlxWKuS3tTkFmcxFQ4JQk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLICTcL9Slqe/izLXtm5yGd/7jEXNskdcuyyK4yelDayl
 P0XlH/SUcrCIMbFICumyCLdFpk/83kVb4mXnwXMHFYmkCEMXJwCMJGvvxkZJlddXqcjYdh6Q3DC
 3BmrmLYXJXEUXkluYVy/er3Ikd/GhowMDxQkz078p7RG6+XbNYwNn1NTPNmjFuyKuK9rmzEt1Sm
 HAwA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-306647-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,queasysnail.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E57673D351

The default timeout is 45 seconds, that's too low for a few ovpn tests.

Indeed, these tests can take up to 50 seconds with some debug kernel
config on NIPA. Set a timeout to 90 seconds, just to be on the safe
side.

Note that the Fixes tag here points to the introduction of the ovpn
tests because I don't know when they started to take more than 45
seconds. That's OK because a timeout of 1.5 minutes is not exaggerated.

Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Antonio Quartulli <antonio@openvpn.net>
To: Sabrina Dubroca <sd@queasysnail.net>
---
 tools/testing/selftests/net/ovpn/settings | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/ovpn/settings b/tools/testing/selftests/net/ovpn/settings
new file mode 100644
index 000000000000..ba4d85f74cd6
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/settings
@@ -0,0 +1 @@
+timeout=90

-- 
2.53.0


