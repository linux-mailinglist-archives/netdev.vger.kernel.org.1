Return-Path: <netdev+bounces-302733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m9uxBjCrQmrw/QkAu9opvQ
	(envelope-from <netdev+bounces-302733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:28:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3F56DDBA0
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:28:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=TuiglFxj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302733-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302733-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D38530A0E16
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 17:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE89E478E20;
	Mon, 29 Jun 2026 17:23:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D20646AF35;
	Mon, 29 Jun 2026 17:23:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753836; cv=none; b=VZWpCL9Rdr/dmN5GGakm2+hFdfZfkXq6yvQUSbVk3+CR+8L0k/MjJ4oRgWgSW7/uJ0BCniLY0K2BPwGYus38atAZaFrKPV6M72e0pUVKQT6LkAOdwnLwWiWJxz3XaVQYShAplEKKGgofpez5EWl7Bz+uCdKjHaS/AHwRq9JPwag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753836; c=relaxed/simple;
	bh=v2bhTWofwIq1u6dQ26RZ9EcuC1J3UYNYlDOpncgof+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pB7n7MZOQyul1sQjGvcGPamsyxSxa7aKyN5GCLr/QE0mCGUtFIBFCYwjWGjb2KeyX1WUIkhjW7gnjBX38njDe9vv/5G9KVFm8G4TqlcbzgncsHGETMAi1+bbhg1GsBenUZ+XCtcDaStt+ODAdwb1gWPfvzjt7Wm6+mKq07AOI8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuiglFxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E0F3C2BCF7;
	Mon, 29 Jun 2026 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782753836;
	bh=v2bhTWofwIq1u6dQ26RZ9EcuC1J3UYNYlDOpncgof+w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TuiglFxjkQzw4w41b5kNRxkPim2seSxOzILQ9Wv203S/Qzujl0L6/WdwnX0a+s1SD
	 yl2xRRnIhTP80lyN8gsNLm4EG0K077BqkeD0ckLucWpjnbARxYxh50gNwRwNugZQgN
	 gyLL9EibKkb/C5Pa+B9bF2ZM/srhSojH8jgLNhpwd+pC2bl91W1+AvPbbWBRf0/Jl3
	 kjABCV3W6+K2OPWLzY0GHNOru5pCA3SBJ/9yXEGROjBb9k9Ea5RtnD5z0ouZmZMjY3
	 KN4cIE1Dc/S7D0pKLA1gpm6+vdeZs0cn777ilOB6IfO92gF2qppbsU6WfdvZD7G6F/
	 jrB6UpV56xfzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35941C43327;
	Mon, 29 Jun 2026 17:23:56 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Mon, 29 Jun 2026 10:23:41 -0700
Subject: [PATCH net-next v6 11/15] net: phy: ncn26000: Support for loopback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-s2500-mac-phy-support-v6-11-18ce79500371@onsemi.com>
References: <20260629-s2500-mac-phy-support-v6-0-18ce79500371@onsemi.com>
In-Reply-To: <20260629-s2500-mac-phy-support-v6-0-18ce79500371@onsemi.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782753817; l=1377;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=n6wnqFumkncBrmAvtq9QIJMD441WhYr3+8aUgDKFH4I=;
 b=CFUoULEaRwWRLmFG5aeoK27G0Bc5+9N7k7jnOImejp9y9FhaWbwFaCiGB6xIUzeGA1AGoHJRp
 QJfVfV/HBBhBQOYSDGzw9B8E2ZmzaVaQ0mrOnKitXjiOAefQRA3dnFk
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302733-lists,netdev=lfdr.de,Selvamani.Rajagopal.onsemi.com];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:pier.beruto@onsemi.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:parthiban.veerasooran@microchip.com,m:selvamani.rajagopal@onsemi.com,m:richardcochran@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-doc@vger.kernel.org,m:jerry.ray@microchip.com,m:Selvamani.Rajagopal@onsemi.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,onsemi.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,lwn.net,linuxfoundation.org];
	FORGED_SENDER(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[Selvamani.Rajagopal@onsemi.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[onsemi.com:replyto,onsemi.com:email,onsemi.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A3F56DDBA0

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Adding loopback support for S2500 internal PHY to help running
loopback test through ethtool.

This instance requires only manipulating the loopback bit in
the PHY. nothing else. The existing genphy interface
implementation for loopback, does more than flipping the
loopback bit. This is the reason to add a new API.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v6
  - No change
changes in v5
  - No change
changes in v4
  - Moved the onsemi implementation to a new, genphy API to
    make it vendor agnostic.
changes in v3
  - Addd loopback functionality for onsemi's PHY driver
  - First patch
---
 drivers/net/phy/ncn26000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
index c3a34b2c524d..afafa81dc22b 100644
--- a/drivers/net/phy/ncn26000.c
+++ b/drivers/net/phy/ncn26000.c
@@ -178,6 +178,7 @@ static struct phy_driver ncn26000_driver[] = {
 		.config_aneg           = ncn26000_config_aneg,
 		.read_status           = ncn26000_read_status,
 		.handle_interrupt      = ncn26000_handle_interrupt,
+		.set_loopback          = genphy_loopback_fixed_speed,
 		.set_plca_cfg          = ncn26000_c45_plca_set_cfg,
 		.get_plca_cfg          = genphy_c45_plca_get_cfg,
 		.get_plca_status       = genphy_c45_plca_get_status,

-- 
2.43.0



