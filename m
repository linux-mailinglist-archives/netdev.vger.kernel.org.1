Return-Path: <netdev+bounces-230916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CBEBF1B0C
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 16:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAF674F7BE9
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324F331AF21;
	Mon, 20 Oct 2025 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lSPBhfZr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ShTbOYO4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="050ruSX8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sYbl2EOP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0AB2F658A
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968579; cv=none; b=YyGs9tnauHR7AffHtqq/U1SDSKHkgCs0BJsKKYxRwEVzYw9ZFGSkbI19PT4yDJMcMnNavwwK4OHzCYUl+A4vXMozZx3Ym4D2m2Yr5rirbM/Rb+HLOMMyH6tW+W533JPbwDnT7FistpeVkzA7GftX4FNXC1fc2xdvNtyUYcnVCMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968579; c=relaxed/simple;
	bh=1/xorSSVQM5S+DUjeNfIdpcxxqZNnoFSnufDcDvnfTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J+f7L6+pc42NnDc+Ua7xmYXwKT7G4NaHGX+mOtJcR5j2t/hiQh4M7N9FuQl920wiEl16VmUGl7vtE3LeS4MQuXcPzjUcGtDl+imFkE//r3ndzPqHFm0tVaT5SAUjEfu6g3E2f3M3SOJmQFXqp1Pi3shrw5d4dpBIygskeJ0w7Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lSPBhfZr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ShTbOYO4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=050ruSX8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sYbl2EOP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C9561F385;
	Mon, 20 Oct 2025 13:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760968571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ryn9uE0Mex1ifN/E8rKvDRw394lk6uAn1WuQSF1m7Ig=;
	b=lSPBhfZrl4s2v+fbN7/0xbMGxdu2UyotNDaPmTDj8n0GxHrGajHFCYNKaIHmvIQ6qlCx0+
	oNR25NOVB5GgEGCH/YilpC+Kg2OR2WUgkQ3z8oC78nJdg5F6pPX8eLU7aVU4q8lH9dBsh0
	b+wVsua67z+R0E0ZN6lXHcOk67ktdPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760968571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ryn9uE0Mex1ifN/E8rKvDRw394lk6uAn1WuQSF1m7Ig=;
	b=ShTbOYO44pgA4UDGAP0uEIoq8oJYMf9Q6366CsCHz/2e9L/QezG7ltpyeIjigyxmO6bHwq
	scbNePfrIfdt/OCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760968567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ryn9uE0Mex1ifN/E8rKvDRw394lk6uAn1WuQSF1m7Ig=;
	b=050ruSX87O7LRPjXfR16NY3uMSUY1PM3NNOKCu0oSb3gtWrHxCgtmt8LXO1Eysr+O7L3YB
	N3jve166QdqlJU6HhPk2F+F6ZJ5RUoxOGQKjLEacCwLE1ABrR6RAE6zAAJEGYoBStYIbbl
	jYvbjZNUPdHU3A8uFpXJFmCmin/OCP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760968567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ryn9uE0Mex1ifN/E8rKvDRw394lk6uAn1WuQSF1m7Ig=;
	b=sYbl2EOP7yM2nlY2T/8H/igFhLD/OHhMWGlncIAlcVoKQaGg8+rtqvi864WwKosJV/NG+z
	xlkHdx/geN2QldBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7F9413AAC;
	Mon, 20 Oct 2025 13:56:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8da0LXY/9mg3BAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 20 Oct 2025 13:56:06 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH net] net: hsr: prevent creation of HSR device with slaves from another netns
Date: Mon, 20 Oct 2025 15:55:33 +0200
Message-ID: <20251020135533.9373-1-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

HSR/PRP driver does not handle correctly having slaves/interlink devices
in a different net namespace. Currently, it is possible to create a HSR
link in a different net namespace than the slaves/interlink with the
following command:

 ip link add hsr0 netns hsr-ns type hsr slave1 eth1 slave2 eth2

As there is no use-case on supporting this scenario, enforce that HSR
device link matches netns defined by IFLA_LINK_NETNSID.

The iproute2 command mentioned above will throw the following error:

 Error: hsr: HSR slaves/interlink must be on the same net namespace than HSR link.

Fixes: f421436a591d ("net/hsr: Add support for the High-availability Seamless Redundancy protocol (HSRv0)")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/hsr/hsr_netlink.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index b120470246cc..c96b63adf96f 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -34,12 +34,18 @@ static int hsr_newlink(struct net_device *dev,
 		       struct netlink_ext_ack *extack)
 {
 	struct net *link_net = rtnl_newlink_link_net(params);
+	struct net_device *link[2], *interlink = NULL;
 	struct nlattr **data = params->data;
 	enum hsr_version proto_version;
 	unsigned char multicast_spec;
 	u8 proto = HSR_PROTOCOL_HSR;
 
-	struct net_device *link[2], *interlink = NULL;
+	if (!net_eq(link_net, dev_net(dev))) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "HSR slaves/interlink must be on the same net namespace than HSR link");
+		return -EINVAL;
+	}
+
 	if (!data) {
 		NL_SET_ERR_MSG_MOD(extack, "No slave devices specified");
 		return -EINVAL;
-- 
2.51.0


