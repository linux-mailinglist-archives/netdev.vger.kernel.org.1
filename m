Return-Path: <netdev+bounces-304834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NA1lNMs/S2rqOAEAu9opvQ
	(envelope-from <netdev+bounces-304834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 07:40:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1939270CAA9
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 07:40:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gurudas.dev header.s=spacemail header.b=jjnqiU3v;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304834-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304834-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07C60300D686
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 05:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C483BCD2B;
	Mon,  6 Jul 2026 05:38:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-03.smtp.spacemail.com (out-03.smtp.spacemail.com [63.250.43.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EA33B2FCD;
	Mon,  6 Jul 2026 05:38:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783316323; cv=none; b=IBcOZwA6kU+DKvyp8RpzLlEFtchmusfQYFHDKf3p7eddHTzYkD8DpwuK1ltlHYK6BcXexT6aUQaPMDsdXghCMjtc4kSGgOwuR6JkkczkZApq4DsYPQeP0/o2xBPCKzfec83MzCK5ZwrDHYBBRwnCTaygbTD2fwuPrj2mFmRO4ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783316323; c=relaxed/simple;
	bh=yAT5MJoniuIlPcXgGE3jbpXoCSm+A/D21GJbYDYY3MI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z2XSgblNEWXrAo9RRrsAyrhNxYSTfC+G5hbSzuFVuo2XKrSOgFgSkseE/yoVGNsl664bUvaOOS6O4I7u5okBHHpv81YBbuFYsCQA1TF7O+Cr7pyW/HnkXvBJNOian3uu/mPbmy+/aMhxPcdE+1EwYG+yEq5Sk9itPglwZNNzHwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=jjnqiU3v; arc=none smtp.client-ip=63.250.43.88
Received: from [192.168.1.96] (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gttSc1PXbz8sWP;
	Mon, 06 Jul 2026 05:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1783316320;
	bh=FikkaF+apntXrKil0+oUrCmJWEe9beoYA8oz3ud/fi0=;
	h=From:Subject:Date:To:Cc:From;
	b=jjnqiU3v5UK4DV3nGyc/ocDAL1kXHdX0RswARmoU1HX+htWmlADWdoojlKYjEhxCl
	 XVexScJpJ47u3323vtSTCJc8kMi7WJ8ud4LpVlo1fzSFB7nfW3Gn/UU+4fRwSwD6TU
	 pcN+WN8jJu2TxzR1jfZ0vNmqthU1BA7umc42eZrvJsR3l2K6i/MyAIFsyes83qKTlk
	 oZX9KGEKZQBDuKH1yGcCFbhEWrAQligGyeciSm+t8dmiVnzgk1c4+e2ZLtLIFy/vpJ
	 YFVlX4dK1ujL4AwhOh8WFxxfgPYEsLMuXX5YpciTLPYLks5GC9FQa9AlNLB53hl9M3
	 UUeZKUXCAM5lg==
From: Guru Das Srinagesh <linux@gurudas.dev>
Subject: [PATCH net-next 0/2] rust: net: Use kernel style vertical imports
Date: Sun, 05 Jul 2026 22:38:39 -0700
Message-Id: <20260705-net-vert-imp-v1-0-95a35ddff411@gurudas.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QqCQBREf0XmuQvbFS36legh17Fu0Ca7qwjiv
 7fW42HmnBWJ0ZhwqVZEzpbsEwocDxX88x4eFOsLQ5227uQaCcwyM2ax9yja+FaHs9Z9V6MoY+R
 gyy93xf4MXDJu/yVN3Ys+7zVs2xeupO07egAAAA==
X-Change-ID: 20260705-net-vert-imp-25c62f823db3
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Guru Das Srinagesh <linux@gurudas.dev>
X-Mailer: b4 0.15.2
X-Envelope-From: linux@gurudas.dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[gurudas.dev:s=spacemail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:fujita.tomonori@gmail.com,m:tmgross@umich.edu,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux@gurudas.dev,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,umich.edu,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[linux@gurudas.dev,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[gurudas.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304834-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@gurudas.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gurudas.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gurudas.dev:from_mime,gurudas.dev:email,gurudas.dev:mid,gurudas.dev:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1939270CAA9

Came across a recent commit bc58905eb07 ("samples: rust_misc_device: use
vertical import style") and found a few more locations that could
benefit from this cleanup. No functional changes.

Separating out patches per-subsystem as per the review feedback in [0].

Tested via:

    $ make LLVM=1 rustfmtcheck || echo "fail"
    $

[0]: https://lore.kernel.org/lkml/20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev/

Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
---
Guru Das Srinagesh (2):
      net: phy: ax88796b: Use vertical import style
      net: phy: qt2025: Use vertical import style

 drivers/net/phy/ax88796b_rust.rs |  7 ++++++-
 drivers/net/phy/qt2025.rs        | 10 ++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)
---
base-commit: b73bc9ca3686b78b642fb35dcc1fdf874ecb74a1
change-id: 20260705-net-vert-imp-25c62f823db3

Best regards,
--  
Guru Das Srinagesh <linux@gurudas.dev>


