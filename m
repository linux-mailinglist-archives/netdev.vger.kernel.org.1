Return-Path: <netdev+bounces-265646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHI5JuX8rmkxLQIAu9opvQ
	(envelope-from <netdev+bounces-265646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:01:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 967C623D42D
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07A453023D83
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 16:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5938C3E8C65;
	Mon,  9 Mar 2026 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IZ7MDoIg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IZ7MDoIg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB273E959D
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 16:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075411; cv=none; b=WiLYahGayFRVEiSyvNWDHqrn++EW4ieaNl33rRru/uct9eMBE1P6qr1duzOWXy2SIkiSxBnDuKj5xXct8WN+BZj7eJU+ZHEC2tCegDE3hrBQDjiDhIC5NDhz9Y6C4xr1NdHYYT3YbcixKpSBbaPLY5LPL2qHnGpSDd+8zRA3AQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075411; c=relaxed/simple;
	bh=maLE8TyixkJDvRb8hUnFmCqgWOiYx1NQer+NClbBli0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZ6MM9QKhfAuorpn5NVhGa417PZvC5oejxuldJ6En3u9/pFTYNU6C4NsmsdrqdoruRcPfyDf16V69t2O7ULNXikOB8hDWDcurKdMYNGPu4V/waW6bhNZR4mRkC0TgNHol3wJeYkgdkzYE0jyHFAKd/JLUUjS8V5RTVgmadq+AwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IZ7MDoIg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IZ7MDoIg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D31C05BE55;
	Mon,  9 Mar 2026 16:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773075384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oj1nKl5tTTpX9qhWiZwy3/8YjbUoBTIHY3sqjZU78p0=;
	b=IZ7MDoIg5Qi47AUQCGoGfZ/fh3jLlUKlXrBFXRmtT+AZGSJd7ZByAvEOT9q0Ld44XXeBwa
	0w8NR0B6xcPLP6QwIbCtXrAeSBy/qtLK8tttQ96fmgrQSzhjJoCqPsFfeFluwLY7sYcLJs
	J0XgY9aU0KaD9z/GPTT7s98VuCZ/SSk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=IZ7MDoIg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773075384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oj1nKl5tTTpX9qhWiZwy3/8YjbUoBTIHY3sqjZU78p0=;
	b=IZ7MDoIg5Qi47AUQCGoGfZ/fh3jLlUKlXrBFXRmtT+AZGSJd7ZByAvEOT9q0Ld44XXeBwa
	0w8NR0B6xcPLP6QwIbCtXrAeSBy/qtLK8tttQ96fmgrQSzhjJoCqPsFfeFluwLY7sYcLJs
	J0XgY9aU0KaD9z/GPTT7s98VuCZ/SSk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3CEA3EFDA;
	Mon,  9 Mar 2026 16:56:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +DjMKrj7rmlXZAAAD6G6ig
	(envelope-from <oneukum@suse.com>); Mon, 09 Mar 2026 16:56:24 +0000
From: Oliver Neukum <oneukum@suse.com>
To: andrew@lunn.ch,
	bjorn@mork.no,
	netdev@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>
Subject: [RFCv3 09/13] net: usb: use allocation on demand for usbnet
Date: Mon,  9 Mar 2026 17:53:32 +0100
Message-ID: <20260309165614.861929-9-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309165614.861929-1-oneukum@suse.com>
References: <20260309165614.861929-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 967C623D42D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265646-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.983];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

This converts the simple cases for allocation of
private room for mnidrivers to dynamic allocation.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/net/usb/ax88172a.c | 1 +
 drivers/net/usb/cdc_mbim.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/usb/ax88172a.c b/drivers/net/usb/ax88172a.c
index f9b4364e0a0f..489a09759593 100644
--- a/drivers/net/usb/ax88172a.c
+++ b/drivers/net/usb/ax88172a.c
@@ -355,4 +355,5 @@ const struct driver_info ax88172a_info = {
 		 FLAG_MULTI_PACKET,
 	.rx_fixup = ax88172a_rx_fixup,
 	.tx_fixup = asix_tx_fixup,
+	.required_room = sizeof(struct ax88172a_private),
 };
diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index 5522dc137d45..e319fe37986f 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -557,6 +557,7 @@ static const struct driver_info cdc_mbim_info = {
 	.manage_power = cdc_mbim_manage_power,
 	.rx_fixup = cdc_mbim_rx_fixup,
 	.tx_fixup = cdc_mbim_tx_fixup,
+	.required_room = sizeof(struct cdc_mbim_state),
 };
 
 /* MBIM and NCM devices should not need a ZLP after NTBs with
@@ -581,6 +582,7 @@ static const struct driver_info cdc_mbim_info_zlp = {
 	.manage_power = cdc_mbim_manage_power,
 	.rx_fixup = cdc_mbim_rx_fixup,
 	.tx_fixup = cdc_mbim_tx_fixup,
+	.required_room = sizeof(struct cdc_mbim_state),
 };
 
 /* The spefication explicitly allows NDPs to be placed anywhere in the
@@ -601,6 +603,7 @@ static const struct driver_info cdc_mbim_info_ndp_to_end = {
 	.rx_fixup = cdc_mbim_rx_fixup,
 	.tx_fixup = cdc_mbim_tx_fixup,
 	.data = CDC_NCM_FLAG_NDP_TO_END,
+	.required_room = sizeof(struct cdc_mbim_state),
 };
 
 /* Some modems (e.g. Telit LE922A6) do not work properly with altsetting
@@ -616,6 +619,7 @@ static const struct driver_info cdc_mbim_info_avoid_altsetting_toggle = {
 	.rx_fixup = cdc_mbim_rx_fixup,
 	.tx_fixup = cdc_mbim_tx_fixup,
 	.data = CDC_MBIM_FLAG_AVOID_ALTSETTING_TOGGLE,
+	.required_room = sizeof(struct cdc_mbim_state),
 };
 
 static const struct usb_device_id mbim_devs[] = {
-- 
2.53.0


