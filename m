Return-Path: <netdev+bounces-275349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONuEISzi0GmIBgcAu9opvQ
	(envelope-from <netdev+bounces-275349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 12:04:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EDA39AB36
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 12:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65527300623B
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 10:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BDB3537FB;
	Sat,  4 Apr 2026 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZF7PIAXr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FX3XR9zc"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAAA314B73;
	Sat,  4 Apr 2026 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775297063; cv=none; b=nmVgKpFot7hr97rjwFFlumuI98W+L4U2tchcGF6Kv6vHJ1zY2+iVhO/JBSmNVP6oMqL8xBoaa3j4lDThdeaYyaUbb39Y3VHdQeXZsEM3Ci2a2WE85D/p8aKtkgzbFy6dhFD4Ro4CZi+6o1+NVHJKrmVBhWnXIHvZ3LqR14JCreE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775297063; c=relaxed/simple;
	bh=akSC11+Jl/JVpTPDb8EeZRsE5DcFdH1Imml/PTq/nZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbY5lYjhKgdzQ24Px4XSAaOL4++F5kEhe+KMa9YHu+jGpUXIdcwyAg/MbS6wOBB36hbOpcyOJBMngaapeJDlcoPgN5/Lbarlj/+41PXTNVkNPMCO5xicPhGp1vYnRqvAlcm6cFCFMiXNUAVJX/Dcq+4CvpphPJClyVG+jVMxHxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=ZF7PIAXr; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=FX3XR9zc; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4fnrlw0DTqz9ym0;
	Sat,  4 Apr 2026 12:04:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775297052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tnZAo9nhkdOyCCVh81c/tC4ddfASyzxv134xwFAgjM=;
	b=ZF7PIAXrTAvPC88J1V67oim0k2+Ix7eqyjasRCJFt49cev+yN/mJ9B2bfRpAbWi4hxUDWh
	iQpMvboS4Nphh0gs0ZjndEy7yfmZPeRYfeDIMGvSnmeJmEeappY3tlDV899j9/BnxR74tw
	rR+oCiV73MU0tTDVfB9HR3shLLrGYH31KnDVVy4Gt750in58pnJTReOirQPfQCHbYRT4Db
	UhWT93AQ3Nj/vP5VGvIHBJBsPEQ34+yxnGttcGVLnSJRcErBLqgM+Vd6HVYeOepsvjSPOg
	1nWr5Vl/fVMWcj2ARYrmCPb9nz2qnnlUR08w3SBFNTln14zY9pffu22xUFGLRw==
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775297050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2tnZAo9nhkdOyCCVh81c/tC4ddfASyzxv134xwFAgjM=;
	b=FX3XR9zc4OgLmIh8WAD9IeEDQHmS/tFdIwx+cPh0+xUcVRtI+kpk4veBWf0lQWeTOr8HH+
	iSHiaFPZjzs9KgmXQ2KZiR1i6qD/1EyzmbbDKRIjJNQbxFpuV23jjITLr3iMyrBMY/dTSC
	PxKOIa4TwwHYdo9luoBi4TUrLCt21Cw9y8wZWorUYCNr5cHnQXSMePoF7THuMDboWJRY/o
	3FsqNCchONy/ymo9nz9vn9WK5RoGy7tRrpac+HOROOiKcGFxRIU/oDmuH8EaM/Chbk+f7D
	6hJAFK/qi/KT63QyS+Z7Jju48uwfc4forPLn5Uqdod9sVGv7jND7aHowrz4xvQ==
To: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	syzbot+ecdb8c9878a81eb21e54@syzkaller.appspotmail.com,
	ajk@comnets.uni-bremen.de,
	linux-hams@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH net v2] net: hamradio: 6pack: fix uninit-value in sixpack_receive_buf
Date: Sat,  4 Apr 2026 18:03:50 +0800
Message-ID: <20260404100350.299117-1-mashiro.chen@mailbox.org>
In-Reply-To: <20260404085658.GR113102@horms.kernel.org>
References: <20260404085658.GR113102@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 7oxg5hwnnbw187wx4397pzr4zsst7gom
X-MBO-RS-ID: 2a071e68c300f97d820
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275349-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,ecdb8c9878a81eb21e54];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 84EDA39AB36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sixpack_receive_buf() does not properly skip bytes with TTY error flags.
The while loop iterates through the flags buffer but never advances the
data pointer (cp), and passes the original count including error bytes
to sixpack_decode(). This causes sixpack_decode() to process bytes that
should have been skipped due to TTY errors.

Fix this by processing bytes one at a time, advancing cp on each
iteration, and only passing non-error bytes to sixpack_decode().
This matches the pattern used by slip_receive_buf() and
mkiss_receive_buf() for the same purpose.

Reported-by: syzbot+ecdb8c9878a81eb21e54@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ecdb8c9878a81eb21e54
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 drivers/net/hamradio/6pack.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 885992951e8a6..9e5220ae98360 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -391,7 +391,6 @@ static void sixpack_receive_buf(struct tty_struct *tty, const u8 *cp,
 				const u8 *fp, size_t count)
 {
 	struct sixpack *sp;
-	size_t count1;
 
 	if (!count)
 		return;
@@ -401,16 +400,15 @@ static void sixpack_receive_buf(struct tty_struct *tty, const u8 *cp,
 		return;
 
 	/* Read the characters out of the buffer */
-	count1 = count;
-	while (count) {
-		count--;
+	while (count--) {
 		if (fp && *fp++) {
 			if (!test_and_set_bit(SIXPF_ERROR, &sp->flags))
 				sp->dev->stats.rx_errors++;
-			continue;
+		} else {
+			sixpack_decode(sp, cp, 1);
 		}
+		cp++;
 	}
-	sixpack_decode(sp, cp, count1);
 
 	tty_unthrottle(tty);
 }
-- 
2.53.0


