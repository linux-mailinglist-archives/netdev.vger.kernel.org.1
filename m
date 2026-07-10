Return-Path: <netdev+bounces-306648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KsmdGQY1UWoiAwMAu9opvQ
	(envelope-from <netdev+bounces-306648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:08:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA3B73D381
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:08:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="dQO/lh4n";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306648-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306648-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19AA6306811E
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AB2382298;
	Fri, 10 Jul 2026 18:05:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78453815C3;
	Fri, 10 Jul 2026 18:05:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706733; cv=none; b=fe9+SzKXcFpCInGYSItbnUHoklI4CDushTtFMXld3Lc63TuFf3MVDJCQi/nbK+9G6d6gAyuFjoAb4+7zduYeWRAm4/vOyHpEVI8fK1o+b+WVvea+D64coNsLVG5yrmfoe0Cotdp2VNgFbpWKeT6WGz+GIWOBNfljK+n2L4B/dGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706733; c=relaxed/simple;
	bh=eOYR1/8A9kllDNapHQJ7JqQxvyC5i4C16svrTEG3nYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KkipCGHnsQUNJlO6oovqsEopBumaUDpxsmf3wKtmuGID7xUAf2G/ISRy5JB5DsNLY3c5m8F1LXcPTwBg8yfJOCCwcxZUTBXI+pwEwcJcKQQ0TXi9Ef1mz1MOrE4ug/7bylSuSh18YC0XiVTCg0m8o0VAuDyMw4aL8J2TOI6JL7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQO/lh4n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6421F00A3A;
	Fri, 10 Jul 2026 18:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783706731;
	bh=kciwBDf/7w91AHy6DMhCTuHZYc7umlKDbntKijLsGKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dQO/lh4ndegPa2UyJOCXFvs2KJ9mmpyUdmg9TG9rpo/dmHkLN7o8wVgKgSMejtkH7
	 eWRyKhDqeUCrBYa/UVAcWZ7yhCe9Pfg4CuG+/QucbfW1FpTUkNUsTo+TUDBKKY50J3
	 QHyPPcjiR7yIJHAB38MF6OFTqT9C5Esluc5ZaC33XwmnVm5+/1A/BGXBd1L8zH4Y1+
	 cyhYzFjdn9zFCL8wE5X1/2vQMFJKfvh88U12PpHXv7arDWAoWT9/Xhr+6p1Jk+4L3R
	 uot8XqPH2RRQjPCtwNL+5/9jCPbr/KFps3c3iTqFd+K7ErWpBWA9Tay9rkayrma0Vy
	 CCJg1Ozu+5dBQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 Jul 2026 20:04:45 +0200
Subject: [PATCH net 5/7] selftests: drv-net: increase timeout
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-net-sft-fix-containers-v1-5-a2915c294ef5@kernel.org>
References: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org>
In-Reply-To: <20260710-net-sft-fix-containers-v1-0-a2915c294ef5@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=976; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=eOYR1/8A9kllDNapHQJ7JqQxvyC5i4C16svrTEG3nYM=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLICTSIu/eAQfCVaNafddX5TWustT5aV/be6k0/9aaxm4
 /5rs7W/o5SFQYyLQVZMkUW6LTJ/5vMq3hIvPwuYOaxMIEMYuDgFYCIVtQz/VB5JZnS03p04K3Dx
 Ib5ZCpfljFvyTsuyH+i4+uN0cYu1M8P/lJK/5bt3Xvi9Sv7Iu3cyAk4311XMOZ65wHZ+lcSa/t9
 bGAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306648-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:matttbe@kernel.org,m:andrew+netdev@lunn.ch,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xdp.py:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCA3B73D381

The default timeout is 45 seconds, that's too low for the xdp.py test.

Indeed, this test can take up to 3 minutes with some debug kernel config
on NIPA. Set a timeout to 6 minutes, just to be on the safe side.

Note that the Fixes tag here points to the introduction of the xdp.py
test because I don't know when this test started to take more than 45
seconds. That's OK because a timeout of 6 minutes is not exaggerated.

Fixes: 1cbcb1b28b26 ("selftests: drv-net: Test XDP_PASS/DROP support")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
To: Andrew Lunn <andrew+netdev@lunn.ch>
---
 tools/testing/selftests/drivers/net/settings | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/drivers/net/settings b/tools/testing/selftests/drivers/net/settings
new file mode 100644
index 000000000000..eef533824a3c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/settings
@@ -0,0 +1 @@
+timeout=360

-- 
2.53.0


