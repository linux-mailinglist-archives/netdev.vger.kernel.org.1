Return-Path: <netdev+bounces-306897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KuEaJJ+aUmq0RQMAu9opvQ
	(envelope-from <netdev+bounces-306897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 21:33:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC64742B47
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 21:33:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=oSe5W3QJ;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306897-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306897-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDDA530087F0
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 19:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B182866;
	Sat, 11 Jul 2026 19:33:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDC930D3F7
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 19:33:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783798426; cv=none; b=Pscp4G1fMYYA3ZlLxUeIxCK/+UekogstJP+JuX+uqSGB0vLOeNFTaEBYiPFjqcRMGHauAMyX1cCmZfmpdpCAC2dBps+Kowm/PcbHtMG+iTsMmeBQ4KrKCAfv2ZH40cIhBu1cWy/zdZFVQ5EpwzgSDcbB4//vKoRI65Dn0Nc8nuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783798426; c=relaxed/simple;
	bh=O5WkeiR/zs1RpUms8+jAU2ZtuF80HK8dFcrVDrHcDa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=od/FZHE3hKnggN4NgkyKIB6rHEPO6Pj1DnLeaOL9ajNZiCrYQtZ1l17aL1q0Efrlr2BVdbzucdnXaoc2+bb+Tb/7g4jse+Ianuc0kQZvWWpNmR8fz+XiBOEw028yNtwQGtUO0+u/JRdaj7P0FFRrV6Lg8kaDAV4jPqtno1pDe1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oSe5W3QJ; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E9D104E41214;
	Sat, 11 Jul 2026 19:33:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BC37A6034B;
	Sat, 11 Jul 2026 19:33:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5B1111BD3396;
	Sat, 11 Jul 2026 21:33:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783798414; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Mhr3znqPdzk4zl43zlZdcWAMeZe4rPLdwME/lipWPio=;
	b=oSe5W3QJo41GVdLzKzA54gNzzv/rtfCFyPIHqjMtFO0Rf/c/SaYqw0BmghYV6qR5Nm8/tl
	4UbJZMrM5hv2dJVJM6h3hM1vkpzAoI+WqTQv2mQMDavLA+/jBfI7C1xX9LnyC03U/SDhPS
	S186BaQXir5st5OPap+gze65dxaqRZLAtVF5J8FBrrMdp89kO1ZRnWgKpgBMNPSwjXYPq2
	cIfHH6zQeor03eb4suEobf9ssexsM0CoAMsGy3uH//WDwUYCUCOa0nXBdZkM+2a7W1g8+S
	ZnXUd6HBeEvyR4w4z8qJFUQjY8jIMGLt2f6f2i6VFafdEAh56WVi+gQrgXA/aA==
Message-ID: <0dc5b763-1e05-4ded-bc4d-f89867f24500@bootlin.com>
Date: Sat, 11 Jul 2026 21:33:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/7] net: phy: phylink: add helper to modify
 pause
To: Andrew Lunn <andrew@lunn.ch>
Cc: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, daniel@makrotopia.org,
 linux@armlinux.org.uk, enelsonmoore@gmail.com, daniel@thingy.jp
References: <20260709100237.541-1-javen_xu@realsil.com.cn>
 <20260709100237.541-3-javen_xu@realsil.com.cn>
 <0c188a7d-3637-4e08-9ac8-c1d824b461ed@bootlin.com>
 <18a5cd81-49ab-4b97-ba68-121e22cba874@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <18a5cd81-49ab-4b97-ba68-121e22cba874@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306897-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:javen_xu@realsil.com.cn,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:linux@armlinux.org.uk,m:enelsonmoore@gmail.com,m:daniel@thingy.jp,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[realsil.com.cn,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,makrotopia.org,armlinux.org.uk,thingy.jp];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bootlin.com:from_mime,bootlin.com:dkim,bootlin.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BC64742B47

Hi Andrew,

On 7/10/26 19:02, Andrew Lunn wrote:
 
> Once you start reusing existing code, i then wounder if it is just as
> simple to allow any of the mac_capabilities to be changed, not just
> pause?

Yes indeed, but should we ? There's a valid case here for dynamically
changing a MAC's pause support based on other factors like MTU, but
is there a point in letting the supported speeds / dpx be changed
dynamically ?

Maxime

