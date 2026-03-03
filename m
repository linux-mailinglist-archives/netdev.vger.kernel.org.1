Return-Path: <netdev+bounces-263442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBsiFr5Yp2lsgwAAu9opvQ
	(envelope-from <netdev+bounces-263442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:55:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C591F7CDA
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D426230B5B60
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA53C4F7998;
	Tue,  3 Mar 2026 21:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZSRc47C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866A4F7992
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574827; cv=none; b=VDu9ilY2jMaHt6b5d5plc4BucOGca1TsC/jUATCxQBMjQQSO/2WBoc87GhsanrUiRh5kjjgdlfH8krQL93n1jwUARo13mxEeYjCGbH8ekHHVfhepzQvv/uG3+dOS3Ej1uOoFOx93u5runPeUIsMvWzzCPzNZ4UGR4a0RfJ1bHCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574827; c=relaxed/simple;
	bh=lEBKAklM0OyF/HUpgtDTOfVs/ElnKlulYfZqBbfjIso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZuJOGm3q8msBjZbxYeQy1obXMtFSfwGl6EUE1CFZj4kjMkyorMlTw44yCZ/jlcPPlinqUW7tI0iAJS1a3SXnz7W+jFWSp8+1DSfLEUal+nZdbHI8wFq8lq+y1foTY5FKofypHor1RrgQp/XNGbb4Fk8OyuReGTqEiF0/WqB18U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZSRc47C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4882FC2BC87;
	Tue,  3 Mar 2026 21:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574827;
	bh=lEBKAklM0OyF/HUpgtDTOfVs/ElnKlulYfZqBbfjIso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iZSRc47CHwys4KNh4tcOc0NCApAMHMkM25cp2HBmwzrRLTiHL9wkX2AQKM0meT0Jy
	 IuQvY5dul620OEPOya8QHrTfzLchIaUrit9lVN+FciP59phXlI4ZjaBHjeRTBqzOuW
	 NdV6+0sY3T8ltZM/V9bvoWup14hx7s+Ct5EQaV2MvO5hlA1xeILra2VCImNr6yHJ7P
	 LH3KjWDE4w9lng59E+9eY2b5O49cKAZsghxH6QyVMa+JIpYvsD+IenYDKWIcQ/adOt
	 xopS8tlYPt4yFwLH+hTAVMiAwgCYAazG9iOcdQJUFXo0Sw4SbOPHMQbU47l/qgc/3A
	 /KpWguPV0ewPw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	jonathan.lemon@gmail.com
Subject: [PATCH net 08/11] MAINTAINERS: remove Jonathan Lemon from OpenCompute PTP
Date: Tue,  3 Mar 2026 13:53:08 -0800
Message-ID: <20260303215339.2333548-9-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303215339.2333548-1-kuba@kernel.org>
References: <20260303215339.2333548-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D6C591F7CDA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,linux.dev,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263442-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nvidia.com:email,intel.com:email,colino.net:email,geekounet.org:url,linux.dev:email]
X-Rspamd-Action: no action

We have not seen emails or tags from Jonathan in over 5 years,
and there is no recent mailing list activity.
Vadim Fedorenko is active.

Subsystem OPENCOMPUTE PTP CLOCK DRIVER
  Changes 49 / 130 (37%)
  Last activity: 2025-11-25
  Jonathan Lemon <jonathan.lemon@gmail.com>:
  Vadim Fedorenko <vadim.fedorenko@linux.dev>:
    Author d3ca2ef0c915 2025-09-19 00:00:00 5
    Tags 648282e2d1e5 2025-11-25 00:00:00 20
  Top reviewers:
    [7]: horms@kernel.org
    [4]: jiri@nvidia.com
    [3]: richardcochran@gmail.com
    [2]: aleksandr.loktionov@intel.com
  INACTIVE MAINTAINER Jonathan Lemon <jonathan.lemon@gmail.com>

Add Jonathan to CREDITS as the initial author of ptp_ocp.

Acked-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Cc: jonathan.lemon@gmail.com
Cc: vadim.fedorenko@linux.dev
---
 MAINTAINERS | 1 -
 CREDITS     | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 165147562e1e..61fd624c673d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19805,7 +19805,6 @@ F:	arch/*/boot/dts/
 F:	include/dt-bindings/
 
 OPENCOMPUTE PTP CLOCK DRIVER
-M:	Jonathan Lemon <jonathan.lemon@gmail.com>
 M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
 L:	netdev@vger.kernel.org
 S:	Maintained
diff --git a/CREDITS b/CREDITS
index 98aaf196567a..339712b62e99 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2415,6 +2415,10 @@ S: Am Muehlenweg 38
 S: D53424 Remagen
 S: Germany
 
+N: Jonathan Lemon
+E: jonathan.lemon@gmail.com
+D: OpenCompute PTP clock driver (ptp_ocp)
+
 N: Colin Leroy
 E: colin@colino.net
 W: http://www.geekounet.org/
-- 
2.53.0


