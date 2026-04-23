Return-Path: <netdev+bounces-280883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGYiNoSY6mkz1QIAu9opvQ
	(envelope-from <netdev+bounces-280883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:09:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 763A14580BB
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08B9A300B9F1
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 22:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1A834BA5A;
	Thu, 23 Apr 2026 22:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTY+eeMM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83A978F26
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776982145; cv=none; b=BEO26kdSNn7HPjtCFdBqZ4Nj42JCfJXSynFNQJzgTzu+Hhu+NmqcQxHApy70h7nED8urnVrBFX81vQggeBvMlNIKC2E2qY44D0jrEZdeIvjeZGMLbHRK0xBvN2xWsnF5kjifllkof83WM2DpoC8NgzuXuIWSovjV/w+Smt96MvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776982145; c=relaxed/simple;
	bh=C1PfzQIkeCYsipAWZrYnB6HgJnx1wNSweYztcUdqYpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M4YmG/iNtQOJ13RxpnU2xZkyqsmRAdFawbgl9Zl4qqRzIWJkdp/mXvNT6JFRTfOo8Bn5JiGX+MGRMYBMMBLndgcGAOrHp/xICRh8UXtkP90jrHue805/xK7LYkQMAwSFSaHmR59MZgIJcuL8OOSPWashzBgEdGRIzrOqCU3skAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTY+eeMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F88DC2BCAF;
	Thu, 23 Apr 2026 22:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776982145;
	bh=C1PfzQIkeCYsipAWZrYnB6HgJnx1wNSweYztcUdqYpc=;
	h=From:To:Cc:Subject:Date:From;
	b=UTY+eeMMGD0veHaTk7tXknWuaicK5sQ8dYVAe6cI2sdCWj8mEs6WJ5Wi7wclCgdVW
	 4FobWslx4x40PzVq7nFA16ENOzXS6qSzAzVoAIMPv589ANv+h4RIH6J/77qcUAHxzV
	 XUH6nxS9F2JKRI6co3+lb08c6jaoG6kzRu3qnWjkB5dQl5oSP4hG4bfCwgHdUyLGgV
	 LFE2huwtvGsyHDed7PGiX5Prcp3TbEjDiqM7bN6vDLHw/h2deFTu/UEOvE7LIV4JKL
	 cX6wPrFqwwRAElJVKZ/PwTIlaItduFz1l1CqFhi1LTubCU7PCv2T2TDAEXsnKFadQM
	 v9vFJq0bJqn0g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	linux@dominikbrodowski.net
Subject: [PATCH net] MAINTAINERS: add pcnet_cs to PCMCIA
Date: Thu, 23 Apr 2026 15:08:57 -0700
Message-ID: <20260423220857.3490118-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280883-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 763A14580BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Per discussion under the Link make sure Dominik can help
with the patches to drivers/net/ethernet/8390/pcnet_cs.c

cc: linux@dominikbrodowski.net
Link: https://lore.kernel.org/aeomUh5JqFvkLTH7@scops.dominikbrodowski.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dd7d9a55327c..27a298c13424 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20567,6 +20567,7 @@ M:	Dominik Brodowski <linux@dominikbrodowski.net>
 S:	Odd Fixes
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git
 F:	Documentation/pcmcia/
+F:	drivers/net/ethernet/8390/pcnet_cs.c
 F:	drivers/pcmcia/
 F:	include/pcmcia/
 F:	tools/pcmcia/
-- 
2.53.0


