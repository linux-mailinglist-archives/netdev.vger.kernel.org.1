Return-Path: <netdev+bounces-306460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UR+mE1irUGqv3AIAu9opvQ
	(envelope-from <netdev+bounces-306460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:20:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D8356738603
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 10:20:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=mPtOGxo0;
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306460-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306460-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DCF33024B54
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 08:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761B43EF0D3;
	Fri, 10 Jul 2026 08:20:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7213EEAF8;
	Fri, 10 Jul 2026 08:20:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671614; cv=none; b=GZLhSSMu3bwzuCMBbACLQMTFQ+UQKnH5jkvlEjVC4p7yk9xI8heJpWzA0ggD/qrNAeafU8mV//l5octOpaHdB5j5W2/wMJnwl2URE9Gt5Y1XjUuYH24yz80jwyNIItD5XA1OeffZ6zG0cp4VNqd3Fo3BO4NOpNLcrofGQ8ya8aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671614; c=relaxed/simple;
	bh=WBv4g3SERUXVfGCwMZXdY1BqMEw5ovh8+sE1MB26oOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ps7tmPSoB/fENEW27tLPebjTBILsgynchKkWp29om7s1OVKIr9+DRTsGw1V/cdLGlJpFFP93LXa7iSUGJm5O+1i22w66b2brpmeu2PZVfrrkm8ZUND9awEt3lE61RsRW35mhZWkPqN/0Qd+ZBPe3ra6S3N0OOFs1Nzt9xQAiAZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=mPtOGxo0; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=K6D5rhqdc9cjQivBsJt7uQxaSWphCdpgMsHZkpUgSGo=; b=mPtOGxo0IcJ0LlIFhsBANc2Njt
	DlF74zV6UPkJCOHGVm7rgCk20p/hBxHvYYKDow7yeMDeHv1+Fp5oLZo7xV6BQxA2AhyA/Hb9VBq0K
	PauR3gsqxngfflaufXLF6qc/Y4BwepGXSK5gniH45PJ+BB54amPraLavHkFFXpiaNdH0D2RCKJWQo
	1MwEnSAcaVWuXKhJ0kyaSBDwyx1EjtJzVIjCaWsV2HsJgLXTfsslFgjQQYo1kJZ5Ii7jM8tsNVtp4
	Ov8sdeOg5T+K4/CBw6xrfDr41QgQYzeufV+2qKYdh2lHRAtzHnBaWn+sv1yIrhNf3cr89yFUT7x5E
	EKR40Jkw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wi6Sd-004LUY-1f;
	Fri, 10 Jul 2026 08:19:51 +0000
Date: Fri, 10 Jul 2026 01:19:45 -0700
From: Breno Leitao <leitao@debian.org>
To: xiaoning.wang@oss.nxp.com
Cc: Frank.Sae@motor-comm.com, andrew@lunn.ch, hkallweit1@gmail.com, 
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, xiaoning.wang@nxp.com
Subject: Re: [PATCH net V2] net: phy: motorcomm: read EEE abilities in
 yt8521_get_features()
Message-ID: <alCrGOlOj2oof7Xm@gmail.com>
References: <20260710080018.1070789-1-xiaoning.wang@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710080018.1070789-1-xiaoning.wang@oss.nxp.com>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306460-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[motor-comm.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,nxp.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:xiaoning.wang@oss.nxp.com,m:Frank.Sae@motor-comm.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:imx@lists.linux.dev,m:xiaoning.wang@nxp.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8356738603

On Fri, Jul 10, 2026 at 04:00:18PM +0800, xiaoning.wang@oss.nxp.com wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
> 
> In phy_probe(), genphy_c45_read_eee_abilities() is only called when a
> driver uses phydrv->features. Drivers that implement .get_features are
> responsible for reading the EEE abilities themselves.
> 
> yt8521_get_features() does not do this, so phydev->supported_eee stays
> empty for YT8521/YT8531S and "ethtool --show-eee" reports "EEE status:
> not supported", even though the PHY has the standard EEE capability
> registers.
> 
> Call genphy_c45_read_eee_abilities() at the end of yt8521_get_features()
> to populate supported_eee.
> 
> Fixes: 70479a40954c ("net: phy: Add driver for Motorcomm yt8521 gigabit ethernet phy")
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

