Return-Path: <netdev+bounces-258110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNWLJIdLi2mWTwAAu9opvQ
	(envelope-from <netdev+bounces-258110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:15:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB1711C612
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 16:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 376C93050ECA
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432143815FD;
	Tue, 10 Feb 2026 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Un0nVMoE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JCw05ylF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F363C3806C9
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770736472; cv=none; b=E1pw0OUaeTYPR+e/kEd/iLvS7ezNOJbFJV6/1FhgtonlNNXEQjkWTL41wCjB3cFVUgjtfCdTGr7vva8G0Glwe46FXSoy76YhsQVB6f7nftVpWAAVsScmDhDPk05T76BQ3D7Ogd3KWKvUNPcKgI1bFIMMAiVSg7HUmUvkIUocryc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770736472; c=relaxed/simple;
	bh=SKt0D/iHb8mNXh/sFbtB7gORydYNyQX7Mb4wnR1PujQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DdG7MKkAadoXsRXsPU39cxSYk2zHJ9UITzEWzx+CMGyPOMI4TNWN609/yPSZMRNB5pmXoWjgKTxayoPdNuVTrMjhBUoeBvnoCnPu1/l+TW/AcdunfYhjmYQ9uh4jU6Z5kUPhJKRgb/ADaIH96cTPvuXGMiisswtX9/7D3nrF0cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Un0nVMoE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JCw05ylF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6D2163E6FE;
	Tue, 10 Feb 2026 15:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770736465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wObBfLBo/cd37oIHRnwKKvlHbiEGRUCdZwnGZQO+6d8=;
	b=Un0nVMoEfW0zka2wN89D4uXuLAk7FOV7v/gI2XhqHZFqd4rrS0GDKDFoBvR0yH3sxL0i3c
	xS9LUB3mrUyOXfQjN/vmjysGR889P+AFCtEtXr6XGRCfiG+14P/uWTiCd6+IUqDjT2adAH
	RukTySUIFpQ5b37rps6+877IVw2gTqE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=JCw05ylF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1770736461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wObBfLBo/cd37oIHRnwKKvlHbiEGRUCdZwnGZQO+6d8=;
	b=JCw05ylFks5pOq/YuDSNDoaSyzHQB8asBEKcvfubRDCGRlylwu6BbisLRx7kafKsGfVZeA
	EOdJjKF/q/jxWGz5DwG9CdwAIfV94beIRCKavtfTyIwR9JmoeL/1pWzSPBREpKjE3MUadk
	quDBpl0MHXEePfhnX9dBkXRCYYKjXhs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29EAD3EA62;
	Tue, 10 Feb 2026 15:14:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mTe2CE1Li2lmVgAAD6G6ig
	(envelope-from <oneukum@suse.com>); Tue, 10 Feb 2026 15:14:21 +0000
From: Oliver Neukum <oneukum@suse.com>
To: netdev@vger.kernel.org,
	hayeswang@realtek.com,
	bjorn@mork.no,
	o.rempel@pengutronix.de
Subject: [RFC net-next 0/3] cleanup of usbnet descriptor allocation
Date: Tue, 10 Feb 2026 16:11:11 +0100
Message-ID: <20260210151416.42254-1-oneukum@suse.com>
X-Mailer: git-send-email 2.53.0
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258110-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 3EB1711C612
X-Rspamd-Action: no action

Currently the driver has an array of long[5]. That may or may not be
enough, so a secondary pointer was added.

That is quite complex. This series adds a field to driver_info, by
which mini drivers tell usbnet how much space they need. This allows
basically unlimited allocations.

This is the first draft. 


