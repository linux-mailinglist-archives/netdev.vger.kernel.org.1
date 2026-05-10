Return-Path: <netdev+bounces-286396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJlnOh/nAGo7OQEAu9opvQ
	(envelope-from <netdev+bounces-286396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 22:14:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B81506281
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 22:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 370E43002E04
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D9832BF41;
	Sun, 10 May 2026 20:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tKKAYX0F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76192877C3;
	Sun, 10 May 2026 20:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778444058; cv=none; b=b+nPcUXl/jxrLcRM6Ou+YREqZKZ0+XSKTro3Rf00VJXDdvQ52GWSq7G8c0Ztch9MRHl8dGNZ1U1uptKxJ/2Zabf0S9KMaCdf5AEoqJhtolxt5ZgU34l1t7Qi8SiMSeIIk4jJZ3AQnlDAzRPQet40k6iu0gEZ+Et5hSK7d9eq/LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778444058; c=relaxed/simple;
	bh=rDVkNd2WMkgMRAdl2SG+jRrcWpiaAUfMuzLmFKcvD0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YZ8oBpl8hDunHWK5SALQ0ZXgnrO8XfYrpdpbJ+CqnBaqHuZHfxSGW8e2FlGmceX+9ByFlgfzGXP15wHi97ilHivDNuGDEP6RJEluPaZ1qpqZ7mmBsY5Zn3XrQ9yEdUoJpxqvdY3s1LBl0xyFXh8DMC8/F0TnKTz/UGBmhcHjar0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tKKAYX0F; arc=none smtp.client-ip=80.12.242.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([10.64.95.105])
	by smtp.orange.fr with ESMTP
	id MAWSwPk0NfaigMAWSwajDo; Sun, 10 May 2026 22:13:08 +0200
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id MAWGwR6PjEbAgMAWGwTzjE; Sun, 10 May 2026 22:12:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1778443979;
	bh=XolC0r9oYNCS4EPOsPRFpC6rNlihVAxe7GPmi9ew9/Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=tKKAYX0FsnkHgAo7jQ2IgSFGN5qj9FeBQFid32FxQxdOg+SycBk/Q7IqHOCBdXp2B
	 84rm8RsiW4e+6cgEuqdasIdwUUkBUWmtASrjLzu+L4Q54gIQCC24WpyUME7NisVd52
	 BVwcax2lLyWXi0nvKsPK2yG4zH8Ly1h0i197ZBmIro+PEu7cWs3DDHhJKV5X0qsDBD
	 2Yrfb4hGLm+RKzU13vLuuX11+eWJAsp6Jrjkg0QbnzBEErhR2j8AI1cZWGTnUpqq+n
	 x/PuZ3+LQthPZ9ZhjoErIwAavIrCTpCv/hhUp+SrM/iPcfmm/kxhERaPrFiDllOUcA
	 7Jczv5NV8A96Q==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 May 2026 22:12:59 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: David Heidelberg <david+nfc@ixit.cz>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH] NFC: nci: uart: Constify struct tty_ldisc_ops
Date: Sun, 10 May 2026 22:12:52 +0200
Message-ID: <c756755a72cdfde2877a18ddee01eaa4f633c220.1778443960.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 67B81506281
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[wanadoo.fr,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[wanadoo.fr:s=t20230301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,wanadoo.fr,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286396-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[wanadoo.fr:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[wanadoo.fr];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christophe.jaillet@wanadoo.fr,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

'struct tty_ldisc_ops' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  11454	   3352	    256	  15062	   3ad6	net/nfc/nci/uart.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  11646	   3160	    256	  15062	   3ad6	net/nfc/nci/uart.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 net/nfc/nci/uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/nfc/nci/uart.c b/net/nfc/nci/uart.c
index 5a3aed7f84f5..aa20e8603f32 100644
--- a/net/nfc/nci/uart.c
+++ b/net/nfc/nci/uart.c
@@ -421,7 +421,7 @@ void nci_uart_set_config(struct nci_uart *nu, int baudrate, int flow_ctrl)
 }
 EXPORT_SYMBOL_GPL(nci_uart_set_config);
 
-static struct tty_ldisc_ops nci_uart_ldisc = {
+static const struct tty_ldisc_ops nci_uart_ldisc = {
 	.owner		= THIS_MODULE,
 	.num		= N_NCI,
 	.name		= "n_nci",
-- 
2.54.0


