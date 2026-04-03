Return-Path: <netdev+bounces-274847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL5KERkkz2notAYAu9opvQ
	(envelope-from <netdev+bounces-274847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:21:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C773905AC
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BA523018D58
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 02:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8425531B823;
	Fri,  3 Apr 2026 02:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="KdnhNcUF"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064D526CE2C
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 02:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775182870; cv=none; b=IDJOB1WCEbNk1LzWcNi1Us2QywvhS74d4Sgha69+2FpnTCaIIBiq69ttsI0HBZQbrDUi0bDrsNJQRvB/OYo3VrNVRqjWOdNKsKCSwvA+HWK86uN1a73N3aJm5bly6eujH2BTHCaD/EyaGJSbK5dKyAU+88VVeOiFcDK3pmXLWIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775182870; c=relaxed/simple;
	bh=WVWHd/BE2wz3v+/T3LaJ93g68oKipqJsYOlmCaJ5o0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZD/7rPA+0Z/NmjEgYLxKhjBe9dbzFMtDILUqdTt0lM3QT/qB/P9incmkEjQhGJBtrdUDTceiplustWc82Iz9z69lUvm1o9JEc3jeRjlvv4+ZRStryHYnovib53RwLMAszMUcSsIPoCCgM3uoyPWlywGXg4VkXS2HoGP6s0WlUts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=KdnhNcUF; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1775182867;
	bh=4RlNFXYXdJ5Hd2M1EG9lWk0AN9D4vaZG59GAWw8trn8=;
	h=From:Date:Subject:To:Cc;
	b=KdnhNcUFpBLfAV2RBNk+6gqSnwdQ/FV8PbY1h71VBTIIqLZHP7gh+7+bf3Flq8Acg
	 bGZKIL6v43xmVhuUawmBQVE2M1FWw6j3YAfgVBpSsGsfT4/Pv4U2yyBninqi8ZFwvr
	 4tGPEBpfgwTxSClxNDWA5dG4+5lebsXihyKzGK26YatiiheGRG93uSh9RGudqOKBUp
	 2dg5WKH+FtJKif+EqcV/U0ZSNdECWn0Or7+5RxiP0xw/p69iqL4ACZ/pdCoIHx6P4t
	 VSSYfLzbtXppJzQj9w7TsJZ0oImr2zB7fI2+Rh7PGHxIxq+pCOV87k+vccOOSrYnxl
	 SQ1Ky1FckVp6w==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 0CDE565FEE; Fri,  3 Apr 2026 10:21:07 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 03 Apr 2026 10:21:04 +0800
Subject: [PATCH net-next] net: mctp: tests: use actual address when
 creating dev with addr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-dev-mctp-fix-test-addr-v1-1-b7fa789cdd9b@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAA8kz2kC/yWM0QqCQBBFf0XmuYHNJKxfiR5s5loTtMnuKIL47
 272eLj3nIUykiHTtVooYbJs31jgeKhIXl18gk0LUx3qc2jCiRUTf8QH7m1mR3buVBM3QHuRvg1
 QoSIPCeWwh28U4RwxO93/Sx4fb4j/urSuG9djaHWEAAAA
X-Change-ID: 20260403-dev-mctp-fix-test-addr-4ee89cf80edc
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274847-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77C773905AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sashiko reports:

> This isn't a bug in the core networking code, but the addr parameter
> appears to be ignored here.

In mctp_test_create_dev_with_addr(), we are ignoring the addr argument
and just using `8`. Use the passed address instead.

All invocations use 8 anyway, so no effective change at present.

Fixes: 22cb45afd221 ("net: mctp: perform source address lookups when we populate our dst")
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/test/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mctp/test/utils.c b/net/mctp/test/utils.c
index 2f79f8c1a2b4..c3987d5ade7a 100644
--- a/net/mctp/test/utils.c
+++ b/net/mctp/test/utils.c
@@ -95,7 +95,7 @@ struct mctp_test_dev *mctp_test_create_dev_with_addr(mctp_eid_t addr)
 	}
 
 	dev->mdev->num_addrs = 1;
-	dev->mdev->addrs[0] = 8;
+	dev->mdev->addrs[0] = addr;
 
 	return dev;
 }

---
base-commit: 8b0e64d6c9e7feec5ba5643b4fa8b7fd54464778
change-id: 20260403-dev-mctp-fix-test-addr-4ee89cf80edc

Best regards,
--  
Jeremy Kerr <jk@codeconstruct.com.au>


