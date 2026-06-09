Return-Path: <netdev+bounces-297242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fNHUHZ1kKGrcDAMAu9opvQ
	(envelope-from <netdev+bounces-297242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:08:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D4166385F
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 21:08:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="d/40Dx3D";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297242-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297242-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEC3C3028C94
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 19:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6970B401495;
	Tue,  9 Jun 2026 19:08:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C603EB0F2
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 19:08:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781032090; cv=none; b=WIeG7mt/UHxQn/KcSprnm6r61u6e9FE4bBBE8AsIfYKqCW+Nd57WFk9rXt+v3WcAjfKLF9KBc7OWhnDBMRZ/3dI98X/e/F8YfiVWrZWCa9p6djcqJjkXc3ThgySf9SLjzAlS1NHvwcH6LwNxfgfrK7Hv8A7RGNLsSQ1Vba0iJYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781032090; c=relaxed/simple;
	bh=/Kcf5Uy+acoAPqt4xNEW97+aHZW0gC8pVgx2xqSDLBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NphDqgSyz8ckcckeL0FLTpumSlhDWZtcLSmaH9Tv7ZY/wN1y7xqAI5okKYkzLIcLJ3BGUbPxfkNCkx4tzwVwJUJFkE5nNsOna2t8El5rRNu66IeUyXDMYF7rd4vPsRPj+d3n3fLeQxBZ/aZAxu5fvKQPqj27CIqm49miD7piFLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/40Dx3D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760081F00893;
	Tue,  9 Jun 2026 19:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781032089;
	bh=OueYawCjIWZMc+cN5Km8ZI5C4uldSDTTNN7dlAmrQM4=;
	h=From:To:Cc:Subject:Date;
	b=d/40Dx3D6E6Kc1Ssfj6JBiBRLrprcHmxdhDLu511zgImgKACtnSPFINGFbfIT6RzE
	 HQzBQ0qUeTGCb1/VJCSYbHD4c0Ukom4dGGL2iMIM7SMAsac50CyT763bPDBs52c8Oz
	 gJNRiV9Yyv29YFuoVsmJH2cEFpLGhJrRiOriTediobAbPXCdI/AghStN2XwR44oE1U
	 o6epQii9a0utZNhBTIyWwbGveFPJRhp0rwKX1ZjzD7KkCQtTgCNN4wqtthgXaceUaL
	 n2YRp7WmsQaJ2x8izyCznJ+2ICi5e2WZfBncIEqsWo+yQbaYvGwTWplLUWbAPRj9LB
	 rSN/gpnM0HbYQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	dw@davidwei.uk,
	daniel@iogearbox.net,
	razor@blackwall.org,
	sdf@fomichev.me,
	dtatulea@nvidia.com,
	bobbyeshleman@meta.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 0/4] netdev: address a handful of nit picks
Date: Tue,  9 Jun 2026 12:08:00 -0700
Message-ID: <20260609190804.1137085-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297242-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:dw@davidwei.uk,m:daniel@iogearbox.net,m:razor@blackwall.org,m:sdf@fomichev.me,m:dtatulea@nvidia.com,m:bobbyeshleman@meta.com,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2D4166385F

I got slightly concerned about the state of the netdev-genl implementation
after Gemini found the bug fixed by commit c849de7d8757 ("netdev: fix
double-free in netdev_nl_bind_rx_doit()"). I fed the file into a couple
of models to make sure we're not sitting on more bugs. The models haven't
found anything worthy of a Fixes tag but some of the nit picks are
borderline worth addressing.

Jakub Kicinski (4):
  netdev: check for nla_put_u32() failures
  netdev: correct error code in netdev_nl_queue_fill_lease()
  netdev: avoid skipping objects on race with device disappearance
  netdev: don't use dev->flags for IFF_UP

 net/core/netdev-genl.c | 47 +++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 10 deletions(-)

-- 
2.54.0


