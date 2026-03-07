Return-Path: <netdev+bounces-265171-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PC9xGSR6rGnIpwEAu9opvQ
	(envelope-from <netdev+bounces-265171-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 20:19:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9C022D55B
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 20:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8A5630151F4
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 19:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A922D7DD5;
	Sat,  7 Mar 2026 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="ZmXtY5L4"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2C14F112
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772911137; cv=none; b=M+rr7sCp02KyHn5jAUJYlyVx2RrEgb7FdCJc7vZgIsidWZc5tq4czAaVzSmPOfbbhpAGrz0pxZ7y1vQjKDc66Pb26Gy1FPkUNL+TRxsHt8qtrYBMuZCEo5k0Zhdlst9XnCWLRY8of67we084EWdYHw0IKQLj4RUoEsD1tS9chRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772911137; c=relaxed/simple;
	bh=K4xwmjYUEo2GVF3WpYkFACCmptZv31TPK1nlexo6lUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C5ZcPzYD8Fgm+pM+Ty3fBlPhMHDBhdQ6u0Cw2whSI38Y2ODIyFSOnHxBJAjrpMUQU4fcaRXjS7/sCBpk8InJH3vcPvuA3+vj0vgLCwHlkwVMhTY6Wq1YMc56FYKdf1o5otdLq8blm1OM0R2VZ0RP3oCKf8SjUE/1gHktifdkMzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=ZmXtY5L4; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from ms-a2 (79.25.31.150.dy.iij4u.or.jp [150.31.25.79])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 627IS9o2043132
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 8 Mar 2026 03:28:09 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=xw4m4OYj1kiX/5z7U5EmezmMROr17D8a2T9m4a8VOEY=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1772908090; v=1;
        b=ZmXtY5L4guy2PE3b7i0o8VcNXrDqgH0/Nbtbw6cj3XLFZPLCR4p6nP56Mv2ofxzM
         hRUnu3qCjhpjcB5SDTawK1ckoWGX9k/tlndBlO3/io0gvxK/usyejZagTpO+1FUU
         1O1pE6kqGzr1xPhCouV0f7GNZYYn+7xSdmICcDPPYM66DuEruXqma/IzNrapvw9r
         8JXX6fiTVvF9JhomYbDsid2M7X8d4zBcGhZTfkGyeXiFnbsP/Y6IquF6aN+enM3t
         99eH2q0M1t7kdgMpmVB2TSm8k9xxHxTAQ3MFEOpDuy93PgPQv6e7R/5ahaI2tJbg
         Xz7aUIbNOsux0/63RTCO2A==
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kohei.enju@gmail.com,
        Kohei Enju <kohei@enjuk.jp>
Subject: [PATCH iwl-next v1 0/2] igc: enable build_skb path
Date: Sat,  7 Mar 2026 18:27:37 +0000
Message-ID: <20260307182808.155027-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC9C022D55B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,enjuk.jp];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265171-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This series enables the build_skb RX path in igc, which is currently not
enabled in any configuration.

Patch 1/2 adds missing RX hardware timestamp handling in the build_skb
path.
Patch 2/2 enables the build_skb path when XDP is inactive and other
conditions are met.

Tested on Intel Corporation Ethernet Controller I226-V (rev 04).

Kohei Enju (2):
  igc: set RX hardware timestamps in igc_build_skb()
  igc: enable build_skb on the non-XDP small-frame RX path

 drivers/net/ethernet/intel/igc/igc.h      |  4 ++++
 drivers/net/ethernet/intel/igc/igc_main.c | 22 +++++++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

-- 
2.51.0


