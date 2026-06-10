Return-Path: <netdev+bounces-297505-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vBszBU8YKWopQgMAu9opvQ
	(envelope-from <netdev+bounces-297505-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:54:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E4D666D0F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:54:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FK0bOpYz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297505-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297505-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1562D31E94BE
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 07:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A135F3939B0;
	Wed, 10 Jun 2026 07:48:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ACE30C60C;
	Wed, 10 Jun 2026 07:48:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781077708; cv=none; b=dL5utnP3sQ4WCEDdcrgX333+Wilk2Fat5TCeW1vfebUt4iPLw162WH/haZtFFbi40Bs8g3mUCJHLpQYo9d13qUqVScCDCWy4GC4cY5y2ACsBdgt3fNu94L2h1U+yQTjqebBqYTO0FfRRRNDvVmkI4D8r24y9dkUeLXRrhplGmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781077708; c=relaxed/simple;
	bh=AP0KvO7FRfIaPrQuLAGpmKUfEUalxOS01TFwrGE3Jww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHQrUoZX021DQK3nTUR30wajQRPCVBrgeZOu0OX65SGqGBtT7/y6H66hIWj6m9cb0tLhdedBlrajiuqqvFkwAxGlTcuSb6WojjweF/DP6rr/U16vpRws1U9wmIHDRmVK0czIg1Hagt4XjnbyYwdmtYTJ1RL9hw1PXgDrUh3V+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK0bOpYz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638011F00893;
	Wed, 10 Jun 2026 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781077707;
	bh=BpByu+4r0Jil7SYcQMOmxaSrcuGydaoH1G97vA7TyoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FK0bOpYzoKJfCd+JrVcWYUAIFZoIBh4UCnTtHQCKR4logrCAnDloZBixOMfssTwe7
	 g+LWVyrPK9AYBKWe1wnFVgfnjdOy9s6JpAK7L7E3LC4Y2+IjqXY0iQP0RTP0Mngybu
	 JEl6eBIX2Koz3bm0VnYqi7LvTZ09aWkdz5kAzQbLt20ZJmIydbIx81Ss7+3VWKUWkx
	 aR/Q+lQsxDzk7BlmNB+9OQYITyG8SmsYoue7CN4g3NZPaJyETnsb9hTAth7WfTnGPf
	 GIfLdSdU0RarWauHvFD4y4p73vExRvAphu1LaPhWc8p8JcSPL5jvLGtlKYVxEDUEGL
	 l/LQIljbn7N8g==
Date: Wed, 10 Jun 2026 09:48:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz, daniel@makrotopia.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/5] dt-bindings: net: realtek,rtl9301-mdio:
 Add RTL931x series
Message-ID: <20260610-prompt-aquatic-bison-ceedd8@quoll>
References: <20260609052856.3142922-1-markus.stockhausen@gmx.de>
 <20260609052856.3142922-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609052856.3142922-2-markus.stockhausen@gmx.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:markus.stockhausen@gmx.de,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_SENDER(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297505-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,gmx.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57E4D666D0F

On Tue, Jun 09, 2026 at 07:28:52AM +0200, Markus Stockhausen wrote:
> The 10G Realtek Otto switches are divided into two series
> 
> - Longan: RTL930x up to 28 ports
> - Mango : RTL931x up to 56 ports
> 
> The Mango based devices have 3 different SoCs RTL9311, RTL9312 and RTL9313.
> The MDIO controller of these switches works like the existing RTL930x
> logic but has different characteristics and different registers. Add new
> compatibles in the device tree.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> ---
>  .../devicetree/bindings/net/realtek,rtl9301-mdio.yaml    | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


