Return-Path: <netdev+bounces-295728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eTg9EvuSImqgaQEAu9opvQ
	(envelope-from <netdev+bounces-295728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:12:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D453646BCB
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:12:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=WdT8UylD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295728-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295728-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6FE530788F0
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 08:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40ABA4A33FF;
	Fri,  5 Jun 2026 08:59:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CCB4A33EB;
	Fri,  5 Jun 2026 08:59:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780649990; cv=none; b=ZB/97tm4SLd+kMNEVs5VJ3Kogua6HZSOqKjFIMMuYcxnO5kLDuAnrx0zI8SnWdE7eQVXhThx1PvtMidL4/fYalh5IBr1ccXnWXhvtYbwEMezjJsT/l/HXL02YdU43O4vv5V9kaYpXYq8ZAzGZ/a3N2Td5uZwuydllJgSrqvDqPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780649990; c=relaxed/simple;
	bh=wkdL7mGaQ0V/PX34/0LTG76rf0QF8N/ImOtM9I8X7i8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AR8hoXt3eaRP62UdMkr58HdDR4vwm5J79ZYp7MmQb1C7ju3ajNu0yjLxZH4Il5JH4AwTAa6cYq+TFZ8c3xVaqErXF6YDeLQIPFaxqmtPjETeqq3Fzx4i8ggCmEz0z7FgjRUfOLDmFy5u33EFLkdFNt86+LPfbLrWA9V19XgcS5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=WdT8UylD; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4F112A4C0D;
	Fri,  5 Jun 2026 10:59:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780649978; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=89zGC+YeEfoyBY+MHqfcZod6/UjbGW0pbmlP5MMJv1Q=;
	b=WdT8UylDqNTsSQ7y9B/fZwdfuKfMjbdVSjr0FZiJ2a1YU+lp8UquwphnUeBOVI7fjHhqWo
	vSgk+oxeKUBYoE+eF8P11l3SThSSeggGeUsyHz7bAftxVr3WnI1WHK1uBMsa2EMwXYn6Hp
	Dntrw/LFE8d5IekWCeOAIJ+Z7b2XXUnOSuZosNAwYbyfV/Z62cH9Zy1CBhHQtTKO22ccWM
	E7WdnHk3oH/+13cl9TRzhtNAP82Z/3UiMP8j//g/jYLv5XCVjlgCr3h4SpYrC5wtprbUMF
	A/zcZSpLlpXlfSjpca5mHDtPGNvThfqe5BrJ842kXqxH4Zx3axma2Ky32rzAew==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 05 Jun 2026 10:59:34 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v3 1/4] net: phy: c45: add
 genphy_c45_soft_reset()
In-Reply-To: <20260605074328.1800-2-javen_xu@realsil.com.cn>
References: <20260605074328.1800-1-javen_xu@realsil.com.cn>
 <20260605074328.1800-2-javen_xu@realsil.com.cn>
Message-ID: <4201d4c6df0db7d6cef9ac497448d150@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:freddy_gu@realsil.com.cn,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-295728-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,realsil.com.cn:email,tipi-net.de:mid,tipi-net.de:dkim,tipi-net.de:from_mime,tipi-net.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8D453646BCB

Hi Javen

On 5.6.2026 09:43, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add a generic Clause 45 software reset helper. The helper sets the 
> reset
> bit in the PMA/PMD control register and waits until the bit is cleared 
> by
> hardware.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - no changes, new file
> 
> Changes in v3:
>  - re-order function according to the order in phy-c45.c
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai

