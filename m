Return-Path: <netdev+bounces-254801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO0XDQBge2kdEQIAu9opvQ
	(envelope-from <netdev+bounces-254801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:26:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA871B05F8
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 14:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C1DE30004D9
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 13:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FE928150F;
	Thu, 29 Jan 2026 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oQ8c05IG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDF527AC45
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 13:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769693180; cv=pass; b=EfNzsFJm3GZUAx+rOx2FmNPDCW6UkuK8aOHHAXNI4M2MLvwhzYj7ejsvWzNjh91HsMinY3j2HqUsjep6SlHcNN7xkHcymbiesjKBGdD0g2fHs/JbudayfN7jvM3BBhOhPKfY8wKYGevcWredOgteT3/LGPsdTTHFfy3UMfkim0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769693180; c=relaxed/simple;
	bh=wsidljbUOheDDhJRTDJXoKGXzNID+L+tmRs8iTD+1bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfUUZEu6x+Qx42x6oN+X9nBXD+wb04pyXL5ujyEmfUK3/e5ezbvoR3IAhiT0shOzaX+bZFlUoTuWVyGeLznVtp7XQudn7TeYqR10DdJ+T6mPbQg/58QA36As91OBlAhGDMVTW8XAAYvmq3kVMhTS42Cahq8uUrP2NImlocDyn1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oQ8c05IG; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-658d3d3ac37so915194a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 05:26:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769693177; cv=none;
        d=google.com; s=arc-20240605;
        b=T/X9s7cyINCkD5iGTeYTMQK5Tq4O6sxGi4vdEyYc0svXdNySx58wEmGAKCpQ1F+ikP
         j2oWt28vB+s7R7ZvdYJo1z4CQdsW+91FG4vJGhgMoY6YP877FGtlqlcPT5MBN/i2Khvf
         Jm6r0kCIihX9k9Y4tUexu7dOCCeBSScvDeEpSZ7IGGgQa6aWWAIgcQh2GVdvSofgIZWB
         Oacpk6z9ANw/KXjJOEYmgj1amBEJbqcrZEAjitEyCERP5sW59NgFh5GwFoJJ973rd2ru
         dsfVdsQn9+O8XJ4JUoKqSvbzQ6aZu2XlhNzklo0e0pjrhey/bT52ykbhVM9e+Zs1oHQI
         ENyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3FAbLg0n8TvG7sx8QobTC/6/6GD1GFWRF9jfzZ0OiBM=;
        fh=GB/aW/+VTUFXhyY9xAf2tQN33QoSPDpEDmyoAeu70mA=;
        b=UhxYmYIE2IiiGM5fowiReoDRM50Yr3AcflCajkOig2N9DAQdLcmUBZp/Su+rpsXMzI
         KYgwqiDwIMURRkMpPodtZYlMZC1McDRzlCXGvaWrRJ/E8FwAUphSdgsqVFSHE+v+Gref
         xRgD/aDocmHwrkQpkI/gpZY4X1Hr0gpghv0hCIlTL9ZUvISnH5xAd9YZrotw12TmXv8L
         IIWmZwzDeEckeu2sxh+lnwhpjFIs05YZ3542w4wgrkbphVYzsPPwgzYWJ7d4wUbfCyrr
         nJUhCfpyeKvPnp0x5STFP6uiGmQGSQCck6qJk0ncmDuGoBGgyeREvK2v1AP4M5PCNUBj
         gM3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769693177; x=1770297977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3FAbLg0n8TvG7sx8QobTC/6/6GD1GFWRF9jfzZ0OiBM=;
        b=oQ8c05IGXOqyhroNUuHiaW+NzpdpvSHBIsNSXk4BVfyLFHBEWbOqy7B+3jff0P/bYL
         WqBoLGdKIYJbpTrLX68nIv2+vBklLhWxtvE3dPCDw0zecHc1Drvvoy5PDjvu5zMK/iqY
         OjKGpX2cdlZgZK12SiJPYP+n3vrLII1t2Ux5wdgnxdR5iz70bPXJ05jb+CYKrSfoeFZJ
         qY/y1I7mLDE0w645m3EYQo0g5Tcq75yMJWtIVTl/xGFEwJiy5fOIie8dRM83zpzFtiYf
         ogv1PjW5EOEh+ByLRx3UtMc8Xg2T/t7OVgY9eM9vPXpVH+oClx02joW3WCX/20Q397g2
         ibaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769693177; x=1770297977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FAbLg0n8TvG7sx8QobTC/6/6GD1GFWRF9jfzZ0OiBM=;
        b=Y16SZefRRoaKcy4qMbm8FkC9tYlPQMVpyavpFXtJmgF8ib1rZHRbBCML1JJbItt+dC
         zAZBKq+rUdwINf/HXhDsplLbEgm9zlYyRGchKazc4iVaUHkLuy7BXS96hQtbZUAInHnd
         WkvyywhsWpYUXSzbz9aa5spzlnHeqV38yJwJCcLIg0sJAap1a/78bz3eIrhwU5GbnpTQ
         lHAz+V+yGAltMukJIkQxir375Zp9CKQCBe8rMS3Hr8Qn6C2sc7eB+kuM83lqRJ96T3TJ
         JRE4vyPvNKXIBrqyzn61SyRy/rIjNA7jQlxXmSEwvA6jF822NhB0Z4pGnKiKzMLQ+cbu
         GEXg==
X-Forwarded-Encrypted: i=1; AJvYcCWRgH8rxUc6a0g5ExlJmGxkNe9sSaHFQ2JY+/UDVWnfmqcCp6THeyLsrICN7nlxx1e1iRejCSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJ3PDqVz/rzLHVa58qOOv2lQp5WsJ0za4W/nMW9FnC07alJsE
	GeRiY60uQpVnZucm2vFt5h/w78frT9xgbKcAioF6JYgtbEC7KhZPtwK60RxnH6nKC1Wk7vhTZWL
	jYxgWOV9881nMaVOB6nKf6Uey82VwLFH2ksRg1dzcLw==
X-Gm-Gg: AZuq6aK7Xf5g7lyTBcGvBMh+nLjyLUDkLzIcEViKHTQNy7ErMqJTJUp/bn9RekfEva/
	JpZ+O4aHWsDfh+h7QJMcD9K369zaElWK//AyWn1r/Ct0h8elFyHbYjYRB+61cASaJkuq6X14Qux
	CRJRQMU7RmJ0EEgWaA+KXdtWBU5v5cxrhpGsvkV918Arbm0ZtvpCeJJ9TsPj+nfMl/4MDf9CGiq
	7xPzWnyuIe2fqnpF9Chyk1JnRrzx9sR8ZkXGbZKXWLEUzVNa/9r/Z6j7rXl2Y6UEm5q4Qk4R7n7
	L4mqsbeahW9obsOcubkH+Il1
X-Received: by 2002:a05:6402:1d50:b0:64b:6e44:217 with SMTP id
 4fb4d7f45d1cf-658a5f8e7cdmr5148739a12.0.1769693176886; Thu, 29 Jan 2026
 05:26:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126092159.815968-1-vincent.guittot@linaro.org> <aXtUNxEmxcvuNj6J@shell.armlinux.org.uk>
In-Reply-To: <aXtUNxEmxcvuNj6J@shell.armlinux.org.uk>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 29 Jan 2026 14:26:04 +0100
X-Gm-Features: AZwV_QjGAIu9W6_VpH3QHcTFTkleDIzRR41H4AQo5SaX9LTdvMXOOFKWjz1rXio
Message-ID: <CAKfTPtC6TOnrHbyS4mH05wF78OFOMp_ST1UOeEgNZ7+hhh8gvw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Serdes: s32g: Add support for serdes subsystem
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ciprianmarian.costea@oss.nxp.com, s32@nxp.com, 
	p.zabel@pengutronix.de, ghennadi.procopciuc@nxp.com, Ionut.Vicovan@nxp.com, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, Frank.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254801-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.guittot@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:url,aka.ms:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,mail.gmail.com:mid,linaro.org:dkim,armlinux.org.uk:url,armlinux.org.uk:email,n:email,xp.com:url]
X-Rspamd-Queue-Id: CA871B05F8
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 at 13:36, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> Please drop these addresses from future patch series:

Yes, will dorp for next version

>
>   alexandru-catalin.ionita@nxp.com
>     host nxp-com.mail.protection.outlook.com [2a01:111:f403:ca09::7]
>     SMTP error from remote mail server after RCPT TO:<alexandru-catalin.ionita@n
> xp.com>:
>     550 5.4.1 Recipient address rejected: Access denied. For more information se
> e https://aka.ms/EXOSmtpErrors [AM4PEPF00027A62.eurprd04.prod.outlook.com 2026-0
> 1-29T12:31:01.197Z 08DE5971FB66165F]
>   bogdan-gabriel.roman@nxp.com
>     host nxp-com.mail.protection.outlook.com [2a01:111:f403:ca09::6]
>     SMTP error from remote mail server after RCPT TO:<bogdan-gabriel.roman@nxp.c
> om>:
>     550 5.4.1 Recipient address rejected: Access denied. For more information se
> e https://aka.ms/EXOSmtpErrors [AM3PEPF0000A798.eurprd04.prod.outlook.com 2026-0
> 1-29T12:31:00.781Z 08DE596525364766]
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

