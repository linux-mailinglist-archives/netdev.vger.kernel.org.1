Return-Path: <netdev+bounces-296452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dPmDMYOTJmrqYwIAu9opvQ
	(envelope-from <netdev+bounces-296452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:03:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6ED654D49
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 12:03:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=runbox.com header.s=selector1 header.b="g0guGN R";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296452-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296452-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=gmail.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AC18307512D
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 09:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741233B7778;
	Mon,  8 Jun 2026 09:55:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8D03B892D;
	Mon,  8 Jun 2026 09:55:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912550; cv=none; b=d3D+uHgVjgrQ12iKCqotdy20VPI+27PRmH6IlRpR7zmMBmjBLnIYzE9ZBmyOrDtfl4kK8g14fx86xQJUHy2xPWY+HG4935c7rWs26M+fOeQo79ZbFDVcqaGWdhNWH9BFTiYZJDkoRI6m40Ck2bMG38ectcC5XHKfX/s4xmklmzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912550; c=relaxed/simple;
	bh=JBgBo18FOOVmxza4LLM2LjkvjKmcz6u9eYbUcIUglvU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gke0PmU0eIjsg6Ay7Sxcxg1XdZeu6mbZ+For6TxkbmDWBqVUn5uzqyrwb8aC1p7kgMRZkdjUnfOzTfUjTQ+Ar7oLZNw0/mHe4e1mjoeqvDlNgyh5uNUPVGyy78RXK4RH7S/3tmKOM/dNHOkFE2PJwOFCOICk4F1O4ZB1BxdN9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=g0guGNRS; arc=none smtp.client-ip=185.226.149.37
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhr-00BRzw-AF; Mon, 08 Jun 2026 11:55:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=oeFxy8T5rznwD5j83Z0IyKAb1mHuGRQFCq+QufcT7ww=; b=g0guGN
	RS7AepJOwOTc5K8Lpp446J38QnJEYfFLwI1sHhnUWJq8kO21ZyVcxB7vh0APUhHHctTwY/vg54yVm
	aGtmZypEYKrpfvOKyt8p+mSEBqjTzPg8J8PN/1y8hIyrDDzKwlwYlqDPZhjQNKxiVDoHXN7x6P4ph
	BIScc2V8nIh3Ylrlz/lYGahawwFDwVRwwPmWZnwsXd464/LfA6gllNKKQBht2xcecOJGjM8Ig8oh8
	HRuiIg/TxSUOJX5PyeO3gls3E9HjkqT/6ld0K97L36hTJUvdzdIA3zoz1j4EiyCPFabaxBmQy9XMv
	a1yv1g/4XDlxjG172cE0LYYjeUDA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhq-0000H7-OK; Mon, 08 Jun 2026 11:55:42 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWho-00Ag6G-5V;
	Mon, 08 Jun 2026 11:55:40 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	Chas Williams <3chas3@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthieu CASTET <castet.matthieu@free.fr>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] drivers/usb/atm: Replace strcpy() + strlcat() with snprintf()
Date: Mon,  8 Jun 2026 10:55:20 +0100
Message-Id: <20260608095523.2606-36-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[runbox.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296452-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linuxfoundation.org,free.fr,wp.pl];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-hardening@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:arnd@kernel.org,m:3chas3@gmail.com,m:gregkh@linuxfoundation.org,m:castet.matthieu@free.fr,m:stf_xl@wp.pl,m:david.laight.linux@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[runbox.com:+];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[runbox.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F6ED654D49

From: David Laight <david.laight.linux@gmail.com>

Avoid string function that are due to be deprecated.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 drivers/usb/atm/ueagle-atm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
index f3ae72feb5bf..df4477668296 100644
--- a/drivers/usb/atm/ueagle-atm.c
+++ b/drivers/usb/atm/ueagle-atm.c
@@ -1572,10 +1572,7 @@ static void cmvs_file_name(struct uea_softc *sc, char *const cmv_name, int ver)
 	} else
 		file = cmv_file[sc->modem_index];
 
-	strcpy(cmv_name, FW_DIR);
-	strlcat(cmv_name, file, UEA_FW_NAME_MAX);
-	if (ver == 2)
-		strlcat(cmv_name, ".v2", UEA_FW_NAME_MAX);
+	snprintf(cmv_name, UEA_FW_NAME_MAX, FW_DIR "%s%s", file, ver == 2 ? ".v2" : "");
 	kernel_param_unlock(THIS_MODULE);
 }
 
-- 
2.39.5


