Return-Path: <netdev+bounces-282442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EO8OBvM58mlypAEAu9opvQ
	(envelope-from <netdev+bounces-282442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:03:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA99497EE1
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF189306354A
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4B0413224;
	Wed, 29 Apr 2026 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="DSfmBtdM";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="m2GZ74gE"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58640FDB6;
	Wed, 29 Apr 2026 17:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777482106; cv=none; b=ErThuiKYRG59DgPOz435uoBLEH+BrLdBIt2ZBACq7lisXWvSTTMBortrRdfQYimxP4yp1R3mU104udbZQPI/Gjj/X8NPhbYpZmf3t0o5KTgAZEbdrRLPeSS5JlgDGwp9JS1c7UPek6MXEMVV7IGZ//df/KmHM+sGDUv9aGIHkPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777482106; c=relaxed/simple;
	bh=8P79ieZIPwOXD8F50b9fNK6Mz7VEldq+wxBQHBh6KsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ARHHi43RsKSUiyWwj7+ea3ot+B0r8hnTl6D3b2ZWZcbjCCHpvYtYCH2qK6jy6wZh3qhq+XxW712lRwdwSjhLjP3xbiU53hEwdZms2Fk9DTHhBQmHqmKLsbKSK9Dt7+1zLlZLDXujmaOMb1LmX9eGnuPhn8LVF4URxlyYLhx8ZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=DSfmBtdM; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=m2GZ74gE; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777482103;
	bh=8P79ieZIPwOXD8F50b9fNK6Mz7VEldq+wxBQHBh6KsQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DSfmBtdMtBNkYmPKYqQzCan10Zh53LSdcu8heivSboB1y/m4gsbi0Dy2tqLwLngcB
	 qLKEVZuvE7GkbLn4q+iCdQ41KySxuSwcGIWqS2tfPwP/uc/6NgMWrWfXdT3fFJ6fdW
	 ASTRXkSqvwjGtU2li9XCRgQ+mCtIuIsBsqzV6fTeUb4OyRXJoJi7QY/vjjXb+vGDSK
	 qafEYT5JgIx+158aunJ6HksjpS5CR+aSpcmzKF5lPz2bPB7lHXa1F9aOQRfqq9Kw/R
	 XBMaahK0C0XfNPfpby4hEXG9M56pJKixbTcmdLcg6PWJOp7UFbWO20rN4LCLWTm8np
	 2JM+TxF2W70oA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A87D2481BE; Wed, 29 Apr 2026 17:01:43 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777482099;
	bh=8P79ieZIPwOXD8F50b9fNK6Mz7VEldq+wxBQHBh6KsQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m2GZ74gEkXybkCiPFCv7ykdklDVX9vWPq1eMt0MeU4rm2TD9SEs0M7GVS+XrY3YGd
	 Muyyt7RBjgY1yffwrk2IqoMeba1uYO+QHGeN+ibx7eQy5DPzHNfuSraSJxmGEv3Ac3
	 CUb4VsP7oHgeEdCJpjMLuZSM6KO40v8qgxdrUeuZp22TBR+ClJin2YFSrKutLTao1D
	 c+d63V6gJXLE4HfVH0USauuUSd4pQ1+JYd8NwUu1g4FAShqqYmmhtOL5v1PmmawnZx
	 JwFRm7LC7UB5Zd1ka6b/Asl7um7YjzVLL3d1iDlWI2x6UvqnDVMc+4B5iclKdTDyvE
	 bJQapWgiNzYvw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 4AE4C48186;
	Wed, 29 Apr 2026 17:01:39 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 29 Apr 2026 19:01:11 +0200
Subject: [PATCH net-next v2 3/4] r8152: Add irq mitigation for RTL8157/9
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-rtl8159_net_next-v2-3-bab3cd4e4c66@birger-koblitz.de>
References: <20260429-rtl8159_net_next-v2-0-bab3cd4e4c66@birger-koblitz.de>
In-Reply-To: <20260429-rtl8159_net_next-v2-0-bab3cd4e4c66@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>, 
 Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2
X-Rspamd-Queue-Id: 9EA99497EE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-282442-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:email,birger-koblitz.de:dkim,birger-koblitz.de:mid]

Add interrupt mitigation code for both RTL8157 and RTL8159 that prevents
USB interrupt callbacks with urb->status ESHUTDOWN being triggered. While the
issue is rarely seen on the RTL8157, without the mitigation, it is
common on the RTL8159:
[273.561863] r8152 7-1:1.0 enx88c9b3b5xxxx: Stop submitting intr, status -108

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
 drivers/net/usb/r8152.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 2a07dde289e2240b221664ae5c5bceec35b5a1ef..9fcad3dac76f8aa76ef074cabd3b08348dc234bc 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -8452,6 +8452,12 @@ static void r8156_init(struct r8152 *tp)
 	else
 		r8153_u2p3en(tp, false);
 
+	if (tp->version >= RTL_VER_16) {
+		/* Disable Interrupt Mitigation */
+		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04,
+				  BIT(0) | BIT(1) | BIT(2) | BIT(7));
+	}
+
 	/* MSC timer = 0xfff * 8ms = 32760 ms */
 	ocp_write_word(tp, MCU_TYPE_USB, USB_MSC_TIMER, 0x0fff);
 

-- 
2.47.3


