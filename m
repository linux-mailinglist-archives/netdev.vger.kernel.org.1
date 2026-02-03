Return-Path: <netdev+bounces-256413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDnFGhY5gmmVQgMAu9opvQ
	(envelope-from <netdev+bounces-256413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:06:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D53DEDD4EC
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 19:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88270304AACB
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 18:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2803231B10F;
	Tue,  3 Feb 2026 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZ2GGA42"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058381FE47C;
	Tue,  3 Feb 2026 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141802; cv=none; b=HnoRXn3poPihQSkHXpMoyDG6M5zqXeXoOHIqHQcuT6ZTRpYQ+ROeaM86SAcdzns1pFYdLxSdlo8W36viu8RPKwWCRbhv0FPTvSYb2IjVRC6vmF+wYvVDboH8MwxpW6P2m+PhNghkaweil8m2nm3VTs4zj8hCc1rn0qADazLhE9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141802; c=relaxed/simple;
	bh=lKUiG9KG9h4PIORt17H2RiJFXIGKD5PuZeu/zCe3rG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KO38SSKmFZ4/58s/oqMS+afF0xwSizm5hQi8LStQDBQABRv4o/zHha7G5S9Dn7zsit2yTVU3db7zQaJdDnyT7Xh4IPsPp/mmSohCQyuzyd0JeXSMOHMLIwhCHjKzPYz7IlXAaxuL60zaSz//GLpiIWuF9WhnK9HfphrrCi+PmjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZ2GGA42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2822FC116D0;
	Tue,  3 Feb 2026 18:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770141801;
	bh=lKUiG9KG9h4PIORt17H2RiJFXIGKD5PuZeu/zCe3rG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OZ2GGA42PKOXFhtdiPTf4Q6HAotpprhl8kp10LtZ7k18w2pfLSKiBAAXnYSnZE4Jq
	 jxnsomp1m+Ivzm++6ddhUbC/b5l9rNMZnIZPpPzflCmC/QB3diKaW5HUqvYNv85e0r
	 04wUqhKOuWVCqWlk55gm7CInCzBoz5RJUJxPitcaJAbVmPKkZckVKa7Z01NcwMpSCM
	 xfG84T/cJKwg3DRTT2KzG+j+Nh6KxjLDfgfrNoyr0tLbeVBJWEqudgmAwRFNYGr2V2
	 WVRwUR6mS4TgK+6L9GrEzGPgFIBi9SifaQ1OYWRzCZr0T9ELRzueLrLDtL553z2nLP
	 BCQYj6m0t6YEQ==
From: Simon Horman <horms@kernel.org>
To: maxime.chevallier@bootlin.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	o.rempel@pengutronix.de,
	andrew@lunn.ch,
	christophe.leroy@csgroup.eu,
	kuba@kernel.org,
	pabeni@redhat.com,
	thomas.petazzoni@bootlin.com,
	nicveronese@gmail.com,
	kory.maincent@bootlin.com,
	mwojtas@chromium.org,
	daniel@makrotopia.org,
	dimitri.fedrau@liebherr.com,
	herve.codina@bootlin.com,
	linux@armlinux.org.uk,
	vladimir.oltean@nxp.com,
	kabel@kernel.org,
	romain.gantois@bootlin.com,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [net-next,v3,05/11] net: phy: Create SFP phy_port before registering usptream
Date: Tue,  3 Feb 2026 18:03:11 +0000
Message-ID: <20260203180311.2175469-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201151249.642015-6-maxime.chevallier@bootlin.com>
References: <20260201151249.642015-6-maxime.chevallier@bootlin.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,vger.kernel.org,google.com,pengutronix.de,lunn.ch,csgroup.eu,redhat.com,bootlin.com,gmail.com,chromium.org,makrotopia.org,liebherr.com,armlinux.org.uk,nxp.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-256413-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D53DEDD4EC
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: phy: Create SFP phy_port before registering usptream

This commit moves the creation of the SFP phy_port to occur before
registering the SFP upstream ops. This reordering allows passing
the phy_port along with the upstream information to the SFP bus.

> net: phy: Create SFP phy_port before registering usptream

This isn't a bug, but there's a typo in the subject line: "usptream"
should be "upstream".

