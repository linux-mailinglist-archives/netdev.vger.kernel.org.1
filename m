Return-Path: <netdev+bounces-299357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ns81MfSxL2qBEgUAu9opvQ
	(envelope-from <netdev+bounces-299357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:04:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62028684632
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:04:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=ut2EIy60;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299357-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299357-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3CC43006B63
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 08:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CDB3C0A0D;
	Mon, 15 Jun 2026 08:04:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3E7846A;
	Mon, 15 Jun 2026 08:04:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781510642; cv=none; b=kxI/KneHkVg1H8gVSRTLp1KkjDR15Fqjem247gwT6i+zDX9hNVP01tu5fj6k9ZzqeykD7Vz6nZvpEuZvACfeL1/gpAJa8gV2cMGiCg9TycfKQVBGi2yZUFCvt7J1JIk6ieQ4rgbWFzynP8EbU21YN2HRXT90QwKQI4aMh9GyIRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781510642; c=relaxed/simple;
	bh=nM8M62c0tUBOuJFn2CCUvgOrKNqVVgQyAo0K563ANFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GOV/XMIT7uAfQpijBk+nBUZnEsT5nkw7pH+LcVpDDNkNS3RYzZqDedZoYp/3pytTBqECGL6llzTva08bZXzyh29KqYxrfDMZbLZHgdVGQ3KqR2K/x6hR4QEoRoq3CauAj/mR2ctwfS24Epe61pX7peuuf5wtUMqBG6mX0tpY5og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ut2EIy60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D341C2BCB4;
	Mon, 15 Jun 2026 08:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781510642;
	bh=nM8M62c0tUBOuJFn2CCUvgOrKNqVVgQyAo0K563ANFE=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ut2EIy60sF2YcTUiEAmhL2pZN6SrEpUCat/4wrwE09w7n/pojQzRpX1iyuYJftH8B
	 /pumH3JK5kAKum/XbuZQbPLWTGTj1LBbW4ssqZOisx0N5jFwQ4I8BfmqunixS7x1WJ
	 8W6bRtgNKasN9FtB36wv1LyENAn3PyqegFDxVmsH8RkldEAlbJCvbI3zT+Flvysc3k
	 pW7mFYDL9ImcHBqNM3qpsiYcwUiRU7mmcT1+NJMeR5aHgCwIleZsxpfPgqV39npchp
	 ++U38JWnQMJX9B3TDuFqA4IYGRmEL4yT6wlQeYbuN5FrpagJFGCth6GxvsNwJiKoVW
	 vVg7sMOP0UlbQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F60CCD98DE;
	Mon, 15 Jun 2026 08:04:02 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Mon, 15 Jun 2026 03:04:02 -0500
Subject: [PATCH] nfc: fdp: reject an oversized device-reported packet
 length
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-disp-f42dce2d-v1-1-186ff3dcbf37@proton.me>
X-B4-Tracking: v=1; b=H4sIAPGxL2oC/x3MMQqAMAxA0atIZgMxthW8ijhUm2qWKi2IIN7d4
 viG/x8oklUKjM0DWS4teqSKrm1g3X3aBDVUAxM7cp3FxWDQcmI0HFbhgGQt9VZ8PyweanZmiXr
 /y2l+3w8CUnDGYgAAAA==
To: David Heidelberg <david@ixit.cz>
Cc: linux-kernel@vger.kernel.org, Robert Dolca <robert.dolca@intel.com>, 
 netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev, 
 Samuel Ortiz <sameo@linux.intel.com>, Kang Chen <void0red@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781510641; l=3491;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=YWNzYrdEVobq/LRKI1zxupMwajgzI8infZUte46uWMI=;
 b=lMWqMpt5U5MP/GG7ddKRwOwBSd9MWJ6TtlybHae3my9qt/5BoiELZa8mYaGivOliaUImlcVXw
 XeqDRfTa97nCfUbJ6+R0/geT6IxOaSw4EwpnMcWuaNBfy6+opjMso78
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299357-lists,netdev=lfdr.de,hexlabsecurity.proton.me];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:linux-kernel@vger.kernel.org,m:robert.dolca@intel.com,m:netdev@vger.kernel.org,m:oe-linux-nfc@lists.linux.dev,m:sameo@linux.intel.com,m:void0red@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,lists.linux.dev,linux.intel.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[hexlabsecurity@proton.me];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,proton.me:replyto,proton.me:email,proton.me:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62028684632

From: Bryam Vargas <hexlabsecurity@proton.me>

fdp_nci_i2c_read() reads the length of the next packet from the device
into phy->next_read_size and uses it as the i2c_master_recv() byte count
into a fixed on-stack buffer:

	u8 tmp[FDP_NCI_I2C_MAX_PAYLOAD];		/* 261 bytes */
	...
	len = phy->next_read_size;
	r = i2c_master_recv(client, tmp, len);

When a "length packet" arrives (tmp[0] == 0 && tmp[1] == 0), the next
length is taken verbatim from two device-supplied bytes:

	phy->next_read_size = (tmp[2] << 8) + tmp[3] + 3;

next_read_size is a u16, so this can be driven as high as 65535 - far
larger than the 261-byte tmp[] buffer - and it is never bounded before
the next iteration's i2c_master_recv(). A malfunctioning, malicious or
counterfeit FDP NFC controller (or an attacker tampering with the I2C
bus) that sends such a length packet makes i2c_master_recv() write up to
about 64 KB into the 261-byte on-stack buffer: a stack out-of-bounds
write that clobbers the stack canary, saved registers and the return
address.

Reject a next_read_size larger than the receive buffer the same way a
corrupted packet is already handled - drop it and force resynchronization
- so a device can never drive an over-length read.

Fixes: a06347c04c13 ("NFC: Add Intel Fields Peak NFC solution driver")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
I reproduced the out-of-bounds write with an in-kernel test that drives
the fdp_nci_i2c_read() buffer geometry verbatim under KASAN
(CONFIG_KASAN_STACK=y), modelling i2c_master_recv() delivering
next_read_size device bytes into the 261-byte tmp[] buffer:

  next_read_size = 281, no bound:
    BUG: KASAN: stack-out-of-bounds in i2c_master_recv...
    Write of size 281 ... [48, 309) 'tmp'   (the 261-byte buffer)
  with the device length bounded to <= FDP_NCI_I2C_MAX_PAYLOAD (what this
    patch enforces): no KASAN report.
  a well-formed packet (length <= 261) is unaffected, no KASAN report.

The full device range - next_read_size = 65535 (tmp[2] = 0xff,
tmp[3] = 0xfc; the u16 field truncates the + 3), a 65535-byte write =
65274 bytes past the buffer, smashing the stack canary and the return
address - reproduces the same way under userspace AddressSanitizer on
both -m32 and -m64.
---
 drivers/nfc/fdp/i2c.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index c1896a1d978c..0392bb49bb4b 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -166,6 +166,20 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
 		/* Packet that contains a length */
 		if (tmp[0] == 0 && tmp[1] == 0) {
 			phy->next_read_size = (tmp[2] << 8) + tmp[3] + 3;
+
+			/*
+			 * next_read_size is taken from the device and is used
+			 * as the i2c_master_recv() count on the next iteration.
+			 * A value larger than the receive buffer would overflow
+			 * tmp[]; treat it like a corrupted packet and force
+			 * resynchronization.
+			 */
+			if (phy->next_read_size > FDP_NCI_I2C_MAX_PAYLOAD) {
+				dev_dbg(&client->dev, "%s: corrupted packet\n",
+					__func__);
+				phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
+				goto flush;
+			}
 		} else {
 			phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
 

---
base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
change-id: 20260615-b4-disp-f42dce2d-055035ea37ba

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>



