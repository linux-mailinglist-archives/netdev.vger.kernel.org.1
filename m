Return-Path: <netdev+bounces-251534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC4sNSjLb2mgMQAAu9opvQ
	(envelope-from <netdev+bounces-251534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:36:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8242849907
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 19:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 892A7826155
	for <lists+netdev@lfdr.de>; Tue, 20 Jan 2026 16:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CB246AF16;
	Tue, 20 Jan 2026 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clemensgruber.at header.i=@clemensgruber.at header.b="s09+MPcL"
X-Original-To: netdev@vger.kernel.org
Received: from mail.gruber-software.com (mail.gruber-software.com [3.120.200.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC7743D50F
	for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 16:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.120.200.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768925626; cv=none; b=tLJweu2aQm2X4lSrBFc/rOOqqxeVQb3mHevNT3X43BfWE37/xhzmQYgh8awnHsu/s2DGDMUFKBP+MV8+g47FEcepa9pwEU5FP93gAgAfMgGVTZOjJ1PPoguA4gaROr4IVgm+RSTUmfw+jcAMEWdF3gOhS3w0i66fZEfr/iH55p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768925626; c=relaxed/simple;
	bh=6u9VQ3smuZ4xFNkub6aGClHC3hHFUo7ccwAg3eK3rEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZiSUJjp8xwF9JwtsATjo8qf9dDVjAV2PPM67SmgL6g8UxkiH2HHdoBKEGp5/+AqQZ4tBXc3S8CI/UsyT4a+o3JBFdlNFG6VgaGub6yhJu7sBxHy42wLCrDyQY9Xra1nc/t+QunfKEjEa0PlKvzxUq57+zBSKX2YoqMkeq5omEz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=clemensgruber.at; spf=pass smtp.mailfrom=clemensgruber.at; dkim=pass (2048-bit key) header.d=clemensgruber.at header.i=@clemensgruber.at header.b=s09+MPcL; arc=none smtp.client-ip=3.120.200.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=clemensgruber.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clemensgruber.at
Received: from workstation.tuxnet (213-47-81-100.cable.dynamic.surfer.at [213.47.81.100])
	by mail.gruber-software.com (Postfix) with ESMTPSA id 5B2038055C8;
	Tue, 20 Jan 2026 17:04:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clemensgruber.at;
	s=default; t=1768925072;
	bh=JsKfgJAs2masJfUaDnn/wlkoczkVyhE3PEUqqy6Qi1A=;
	h=From:To:Cc:Subject:Date:From;
	b=s09+MPcLvM4vj0LylDaD62uIATGq+eYmnL8bPN2IsN6AeeM18Jdo/dqIytTonIVmS
	 wRqhB+ZTl54dJigmtThWGjBx+LcHyaKDXSJaz03VzDkt1SWVn7bSotj8rN195KRkPg
	 0VXOHvP0z/AgyGgXC3ZUzkQdLzv+fqKXDO4tZ/CpOAeCL9Af0yB3589jasHlq6T8Ir
	 UfioQM2Xg/J+m53C94sCOtgZWZLeBP1VpOgQ74P+YY9mlZDry/X701dA3MbA1Hdg+K
	 ds/n/ul8kL1Ua2NZuRZResAN76WKO9TSK9u+ckupicB9z8bR8m6JPydKeHhydnZwoQ
	 uwVB5XohAvBbQ==
From: Clemens Gruber <mail@clemensgruber.at>
To: netdev@vger.kernel.org
Cc: Shenwei Wang <shenwei.wang@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	imx@lists.linux.dev,
	Clemens Gruber <mail@clemensgruber.at>,
	stable@kernel.org
Subject: [PATCH] net: fec: account for VLAN header in MAX_FL calculation
Date: Tue, 20 Jan 2026 17:04:07 +0100
Message-ID: <20260120160407.101273-1-mail@clemensgruber.at>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[clemensgruber.at:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[clemensgruber.at,reject];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251534-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[clemensgruber.at:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@clemensgruber.at,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,clemensgruber.at:email,clemensgruber.at:dkim,clemensgruber.at:mid]
X-Rspamd-Queue-Id: 8242849907
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 62b5bb7be7bc ("net: fec: update MAX_FL based on the current MTU")
changed the MAX_FL (maximum frame length) calculation without accounting
for VLAN-tagged frames, leading to RX errors / dropped frames.

Add VLAN_HLEN to the MAX_FL calculation.

Fixes: 62b5bb7be7bc ("net: fec: update MAX_FL based on the current MTU")

Signed-off-by: Clemens Gruber <mail@clemensgruber.at>
Cc: stable@kernel.org
---
 drivers/net/ethernet/freescale/fec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index e2b75d1970ae..f8f88c592323 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1151,7 +1151,7 @@ fec_restart(struct net_device *ndev)
 	u32 rcntl = FEC_RCR_MII;
 
 	if (OPT_ARCH_HAS_MAX_FL)
-		rcntl |= (fep->netdev->mtu + ETH_HLEN + ETH_FCS_LEN) << 16;
+		rcntl |= (fep->netdev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN) << 16;
 
 	if (fep->bufdesc_ex)
 		fec_ptp_save_state(fep);
-- 
2.52.0


