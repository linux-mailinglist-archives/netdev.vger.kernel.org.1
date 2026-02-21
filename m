Return-Path: <netdev+bounces-259807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id W+qgFh4ImWn1PAMAu9opvQ
	(envelope-from <netdev+bounces-259807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 02:19:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE3016BAC9
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 02:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C28530363BF
	for <lists+netdev@lfdr.de>; Sat, 21 Feb 2026 01:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2052930DD3B;
	Sat, 21 Feb 2026 01:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIEfJjLr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28F5285CAE
	for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771636745; cv=none; b=bDcPPfgLgyTVried7bBxNZQ0YY2RzSUMuucvT8FW2ISQFmvTIlqw64XPrD/QvyU6RvmYXHn0eUALiecFf0gI08vQpaEakbVt91+4mh5PWKYro4pRIzg49GJ4v3T+jss7B8UqNpPsezK7uoRXnTrdbESLWJ0qVAB0b6MsT3HFF9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771636745; c=relaxed/simple;
	bh=I8DDi9D8wu1hRlT0VTpYdJGWsQQF8jZ/o5NTTZYqpHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rasonGnwI/i+vjp49LvjzmQ5KXDm6CT3R3aDAkDW7VHgFFlpxBVJfkNe5L+cqDwpl6WhWo7GKQlvEHmiP0YysqC6tmJ+hgQ78J4K5JKRfA7+M9JtiDM3u5DONpvPdr6SssA9iac5lOmcVNWjuKib83fNPecgEjCmkQET1kiKsmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIEfJjLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80249C116D0;
	Sat, 21 Feb 2026 01:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771636744;
	bh=I8DDi9D8wu1hRlT0VTpYdJGWsQQF8jZ/o5NTTZYqpHc=;
	h=From:To:Cc:Subject:Date:From;
	b=RIEfJjLrOHxbMuLdsN3wbTmUjaJZmTJCkfGHYG46PgU1ooGQqwmZxah06CeElEx5j
	 QReE/LpO6Hd42fSmOxBO6I4f/ibPAwllenfKkhIGfX55Cdd0twxsc29CPlI33u8kL0
	 qFI08HMohZW0X7X9akS5Q5OyR0tEaw7+aZ+VuJwQOiu5iBlZxqpjY5BTnw+nMYjLuz
	 XVgP/MkZFVLfWDf1U0WQfYOw8a8wuCmBrK2rNznjo+PieW1nlcaPvYnW9TfynRG6hg
	 jRVsPZbV+17/tUgUFLmZH6B7x8G3BXvWWxUYt/qSqgx9avVZzRnzCT0thUdxyDK20/
	 BUmnA+NB6HXdw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	herve.codina@bootlin.com
Subject: [PATCH net] MAINTAINERS: include all of framer under pef2256
Date: Fri, 20 Feb 2026 17:18:58 -0800
Message-ID: <20260221011858.3403605-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259807-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CE3016BAC9
X-Rspamd-Action: no action

The "framer" infrastructure only has one driver - pef2256
and is not covered by any MAINTAINERS entry of its own.
This leads to author not being CCed on patches.
Let's include all of framer/ under the pef2256 entry.
We can split it in the very unlikely event of another
driver appearing.

Link: https://lore.kernel.org/aZefB5f3EAkQQM1m@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: herve.codina@bootlin.com
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b8d8a5c41597..0ec39b6ea6b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14411,9 +14411,9 @@ LANTIQ PEF2256 DRIVER
 M:	Herve Codina <herve.codina@bootlin.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/lantiq,pef2256.yaml
-F:	drivers/net/wan/framer/pef2256/
+F:	drivers/net/wan/framer/
 F:	drivers/pinctrl/pinctrl-pef2256.c
-F:	include/linux/framer/pef2256.h
+F:	include/linux/framer/
 
 LASI 53c700 driver for PARISC
 M:	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
-- 
2.53.0


