Return-Path: <netdev+bounces-296500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pxQaFUymJmo4agIAu9opvQ
	(envelope-from <netdev+bounces-296500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:23:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3598655A5E
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:23:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=O+Sx+AI5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XLImaz90;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=O+Sx+AI5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XLImaz90;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296500-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296500-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78E383019C93
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 11:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8796365A11;
	Mon,  8 Jun 2026 11:23:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774E235BDC2
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 11:23:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780917802; cv=none; b=ngOaJ75etJs8lJWQVkyoInqm4t6WJo2mAmd1+CIpZBfaW24URlzp4puUkvYA7nOfv2AfK9xrlsU5a2Fm4sOkV4Sdt7FeJuYUCy+F7ZL1Uol3YtlxAnyiDoImD30jBuuOhaFWE9+EnHpc7VFvkHqKexzfuWOROnH/17605DcSabw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780917802; c=relaxed/simple;
	bh=9fG9aWtDLbm1DUXxXS0Yzc1GE5U+QNsgUti9y/WQDWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rmg5RqIn3ZmuIE2Sif0gQOUMhWQhvs5bPeEPi8cWKucAPWqYMNvD1Jt5jGtrsPVxUzvSrSGp515gEnlVixa9uuNCCgR0UCLW15KX6Vy7W7+r/a7fknqr66kCUoSbiW62woD4KtrWJnv9V09vLTUHiCufMEa/cYBMyHijQ4iHScQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O+Sx+AI5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XLImaz90; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O+Sx+AI5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XLImaz90; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E616676CA;
	Mon,  8 Jun 2026 11:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780917799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C4LaITGSXT3kK6TwJJPySCgLKMGWGp5lXTcW4/d4BNc=;
	b=O+Sx+AI5PDiPu+JWQj1TmIeqAfflgee5neQG8zr2UITYivR0wtmrGxfRKOGRKaoBMCE78u
	3Fv2twici8JXnhBVfdqisMwnsmEuPG1haEMtGAUOG8IWHxwHHQoVL3ZZfjoD3RykDmJmc8
	HDxbdcHOb8wEzBrVX40CMUosE3y3SNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780917799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C4LaITGSXT3kK6TwJJPySCgLKMGWGp5lXTcW4/d4BNc=;
	b=XLImaz90T9UgXAYIdGmcZTOaoJfaMDVdhcZTTPWvSE0t/ZvEVl7y17zCvJ0G2Y74RT+40t
	IwENS66xrkNsSQCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780917799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C4LaITGSXT3kK6TwJJPySCgLKMGWGp5lXTcW4/d4BNc=;
	b=O+Sx+AI5PDiPu+JWQj1TmIeqAfflgee5neQG8zr2UITYivR0wtmrGxfRKOGRKaoBMCE78u
	3Fv2twici8JXnhBVfdqisMwnsmEuPG1haEMtGAUOG8IWHxwHHQoVL3ZZfjoD3RykDmJmc8
	HDxbdcHOb8wEzBrVX40CMUosE3y3SNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780917799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C4LaITGSXT3kK6TwJJPySCgLKMGWGp5lXTcW4/d4BNc=;
	b=XLImaz90T9UgXAYIdGmcZTOaoJfaMDVdhcZTTPWvSE0t/ZvEVl7y17zCvJ0G2Y74RT+40t
	IwENS66xrkNsSQCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F461779A7;
	Mon,  8 Jun 2026 11:23:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lVTEBCemJmrleQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 08 Jun 2026 11:23:19 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	leitao@debian.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net-next] selftests: net: add getsockopt_iter binary to .gitignore
Date: Mon,  8 Jun 2026 13:22:59 +0200
Message-ID: <20260608112259.4022-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296500-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:leitao@debian.org,m:fmancera@suse.de,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.de:mid,suse.de:dkim,suse.de:from_mime,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3598655A5E

The generated binary for getsockopt_iter.c shouldn't show up as an
untracked git file after running:

make -C tools/testing/selftests TARGETS=net install

Let's just ignore it.

Fixes: d39887f55d8e ("net: selftests: add getsockopt_iter regression tests")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 tools/testing/selftests/net/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 02ad4c99a2b4..c9f46031ac73 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -6,6 +6,7 @@ busy_poller
 cmsg_sender
 epoll_busy_poll
 fin_ack_lat
+getsockopt_iter
 hwtstamp_config
 icmp_rfc4884
 io_uring_zerocopy_tx
-- 
2.54.0


