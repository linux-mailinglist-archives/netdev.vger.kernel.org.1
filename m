Return-Path: <netdev+bounces-296739-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZPg3Cw84J2rWtQIAu9opvQ
	(envelope-from <netdev+bounces-296739-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:45:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EC565AB94
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 23:45:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZrDFEXGO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296739-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296739-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F157D301CF98
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 21:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691AC2FC01B;
	Mon,  8 Jun 2026 21:45:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7870C223DFF;
	Mon,  8 Jun 2026 21:45:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780955146; cv=none; b=LdoBdqYpYQE0qGWuZEvW8s3TZVOs2dK4kM2HclGzuxtOYE8AHDY27ULX+iW5sYng/d2D/xUIUEVqTpNCxLt7dv0ipcS1RgFFVQGPWTiMrVXbd6sLq/RByD6TWT3xScmY2ej9tS5yawPWTxOK9PDtH3uUxuOybw+FTNdsHRdh1vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780955146; c=relaxed/simple;
	bh=iOwJ/7Euy/KG28mRKlqtjPJM3c6LNCZVxuvF1KkxNfs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e9blTvSQYiCqyQvwZ2ze/DASi1KMFMqXtp7HCZzaoVw67dpSgsTMvA4Y3Splmwijp062/UndpIcdmO7SOOA9zyNt8X2E+yFJrAJgreg6w5YkpxxJa3DZgCKi0MOCqSkXGjwCAxWz88gGLabWwdFU+6S8RGVoKiy9UosQUBJNHg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrDFEXGO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF111F00893;
	Mon,  8 Jun 2026 21:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780955145;
	bh=H3LHubm5D/73GEYpGyqkEmorFSGUCxZRANDwiJ57XM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZrDFEXGOyRt25Q/XmMeJPKMRNFhBfwCZVzoZYA06p9vg7zmb3KEbatOrZ0wfHH9W9
	 K5TOGtqUCSyRAEeBZDBiVvIvrGE7flcAJ38PrBAhdtFOuzxZ1gnI0iRA1Y9a22RrE5
	 Q5xU3oIzmDcIjm1vDCyLw8Aky4U6XXj+1gRi9T1H9qMzDWLUyl3GFZKCaHVM+pvxyk
	 +wTZE74lZhL5E/GA5foRQbQovwW/TiVEXsnp2zCXhcatdMohsEjBVQTGGNzDVCFMu5
	 2G1ctBj9SZa6UKXEkCvhX6trFr0kzpmX2nOyCo1uIrrco/zEyZlhRpN+3fW4vz4ZQ1
	 HOqnlDDkqVLlQ==
Date: Mon, 8 Jun 2026 14:45:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: javen <javen_xu@realsil.com.cn>
Cc: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <freddy_gu@realsil.com.cn>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <daniel@makrotopia.org>,
 <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v3 3/4] net: phy: realtek: add support for
 RTL8261C_CG
Message-ID: <20260608144544.229f7c52@kernel.org>
In-Reply-To: <20260605074328.1800-4-javen_xu@realsil.com.cn>
References: <20260605074328.1800-1-javen_xu@realsil.com.cn>
	<20260605074328.1800-4-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296739-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,realsil.com.cn,vger.kernel.org,makrotopia.org,nxp.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1EC565AB94

On Fri, 5 Jun 2026 15:43:27 +0800 javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for Realtek phy chip RTL8261C_CG. Its PHY ID is
> 0x001cc898.

transient warning here, please move this chunk to the next patch:

drivers/net/phy/realtek/realtek_main.c:345:17: warning: unused variable 'dev' [-Wunused-variable]
  345 |         struct device *dev = &phydev->mdio.dev;
      |                        ^~~
-- 
pw-bot: cr

