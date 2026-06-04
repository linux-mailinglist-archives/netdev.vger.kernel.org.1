Return-Path: <netdev+bounces-295093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aVf1Arc2IWrVBAEAu9opvQ
	(envelope-from <netdev+bounces-295093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:26:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B42C63DFBA
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 10:26:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=Q7rptp2N;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295093-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295093-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1C69304A6E8
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 08:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702703A1E9B;
	Thu,  4 Jun 2026 08:18:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0AA39DBE8;
	Thu,  4 Jun 2026 08:18:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561082; cv=none; b=OgV1e7Evwv3i6Z6RAl6FbP+bwkLGSBLBUF8J+SOT9cfTur4uj1oa5F9KMUrLhzRDdmVrZ4qi5/JuExGsZ3Z4tV8e8Bzk5zkDAEUDydkNnds3DawFXScNPJKSAPWkc4EdumqLwpuIP15b9jzvGgj+OWHuRIY/wSnOxl7e+WeU6fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561082; c=relaxed/simple;
	bh=ByEm3TUK6eUzjF5SjlhbvOJ6jVwo3FM3oHJbVBvrrmc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PgvqQ0YDdmU4PTU1xNHBw6+gcCBIiS0EBhZy9pXkoSDW1Rz9KekVNAGInS6H2Ln6pHfoy0SqXeyngPE8liqE3Da0LmAqA4gfny9tTB6nxd4JxaAZE1dAZ+pWjnKb2B85amtJkOTHOc+Q/gWtLDSpW/n7Dsg1oGNxJzL1UMu18PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Q7rptp2N; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A66EFA4C2B;
	Thu,  4 Jun 2026 10:17:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780561078; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6A98WJJ7gTV9m+rio9++J4CMz0Lll/v+T5HkaBJuKnE=;
	b=Q7rptp2Nomp+MyBrxG2yQVSXEtIAccyjmKvrCIzs+J/JXf/EfDv0f44QJi/b6p7c/HGkfb
	QlJs70qIhOMdn+/P7aZc/qYW1IxGvn4NI3lBb45PgyVFsx2fE9jq+ZJaWi1G8mjtoRnME2
	xTUFJSWYyIeKlUQgxG8cluzuOsMU28QeQTdxtCZ3DDItq0Cym8Sl+IKV1Xqf4WjcuyfxdI
	3Gg2y7P97/8NqYPjtYTLn33bFESjZ8yazXgkzaGcfkJ21xgal0GtKHtUNOe917QY30OKDy
	i20mXqa5IRW3szQjf6EvD0D5tINk6UY96LbrlNJ/lx3ZIoPn8lDXC7ydFIg8hg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 04 Jun 2026 10:17:55 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v2 1/4] net: phy: c45: add
 genphy_c45_soft_reset()
In-Reply-To: <20260604074209.93-2-javen_xu@realsil.com.cn>
References: <20260604074209.93-1-javen_xu@realsil.com.cn>
 <20260604074209.93-2-javen_xu@realsil.com.cn>
Message-ID: <e0fd12f5a19611e6fa4a1fff64baed51@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-295093-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,vger.kernel.org,makrotopia.org,nxp.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:from_mime,tipi-net.de:email,realsil.com.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B42C63DFBA

Hi Javen

On 4.6.2026 09:42, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add a generic Clause 45 software reset helper. The helper sets the 
> reset
> bit in the PMA/PMD control register and waits until the bit is cleared 
> by
> hardware.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

> [...]

> +
>  /**
>   * genphy_c45_restart_aneg - Enable and restart auto-negotiation
>   * @phydev: target phy_device struct
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 199a7aaa341b..25a66320df56 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -2309,6 +2309,7 @@ int genphy_c37_read_status(struct phy_device 
> *phydev, bool *changed);
>  /* Clause 45 PHY */
>  int genphy_c45_restart_aneg(struct phy_device *phydev);
>  int genphy_c45_check_and_restart_aneg(struct phy_device *phydev, bool 
> restart);
> +int genphy_c45_soft_reset(struct phy_device *phydev);
>  int genphy_c45_aneg_done(struct phy_device *phydev);
>  int genphy_c45_read_link(struct phy_device *phydev);
>  int genphy_c45_read_lpa(struct phy_device *phydev);

nit: Ordering in c and header files mismatches, but this probably my OCD 
:-)

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

THanks,
Nicolai

