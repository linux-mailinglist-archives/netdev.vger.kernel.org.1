Return-Path: <netdev+bounces-302312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zcQAHsqNP2rCUQkAu9opvQ
	(envelope-from <netdev+bounces-302312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 10:46:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A58C6D17EC
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 10:46:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=I0Km5rlj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302312-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302312-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 659D0300B522
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 08:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C463016E0;
	Sat, 27 Jun 2026 08:45:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876982949E0
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 08:45:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782549956; cv=none; b=jUQ/glpLOwh4ZPE4m4DLL1XUMDkeoS7H4dfC2GFHcgbmBRr5OltGi4DyOODBFxcJ0r1I9ChUgt2OAbgMFKYNNlGaROirWy+1zu0tq3GPNzuo/h9j5+fCYO0WvdmIjEsPE+M3EQnJNvLwi07cqeDTevjUyKVBZk+BSJ85p8uihL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782549956; c=relaxed/simple;
	bh=jt0EBY+LImM/A8tZgmXPsqoQLL5bfBy2QOw0BIWnCeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u08MomqMdu8ku3egcJlDwiT1AHqJvU/P3w0uIGSJodKA24/AIXYdIRcMPnA1XgISoUjTno40LsdjakR0YkxTgw8HEAhy04o8gG48U1Xk+ecNpyRuMLsYlAaL4n1v4YCQwDhy8H3zdWyU4ivv3iTRpmiOtzmXw+GkQ+uilUr/kY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0Km5rlj; arc=none smtp.client-ip=209.85.128.49
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493a287b8c1so260975e9.0
        for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 01:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782549953; x=1783154753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aApX5Xg5U2zMCX27/6SQYv+4H7RcS2fyony6licKWuk=;
        b=I0Km5rljpizTSznKp/varLO65/YWNRk8QBiuYepwdj1h84IxQx3N8lbnXLWAecVKbt
         3do3UtvK6wtHYIt1QLG0kVN80UYmpIb6I2kIz8TdHncr6HWaVT056ZniQHcUirc/T9W6
         NTwztbYH4W5pIydfYe8GhmCgTGCDikmZihZee4H/94/LYooVABjmcg5lH6d5nHfncsN9
         zndeMDbCOis30mdsqOZdrZgTmdpyN0DSeFkuHYeZVx4HE2da4PNo6qZmJ23CsUUgqgY9
         wlsLi7Jkn4bGGl/z5EfZLOgDtVVOPCovMl/Ng44AYAp+Nah7/AxNDoQSqo/PZTShO8Ng
         PQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782549953; x=1783154753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aApX5Xg5U2zMCX27/6SQYv+4H7RcS2fyony6licKWuk=;
        b=ZP9nr23NxIlsiD90aHptLayHBsiwkdR6wVrMrc45wQCSiF3l6lhBRoYzVzFN497pUv
         Wqau6rIQP3FR9JoEP0x3x8lmglokNzTZMFN7n82vOMqLuVVmdATD2QyCaECqJEz+2uJz
         NTCpAPkdGOe+1aKp0uC9p5B6gzlcsgjRd2f0KeKhxL4Xq0m8Jrjdu5yyxoTtHaP88GKh
         mmhMZeewwVdWSYRbN/+Ezzwcp6vyT2a+7fKbwzAHyIxoPJLk0pK4Yg8thycJm7HAO7Kg
         e4OPmUh5/XwD1ZuYJkJJ3uPb6bOONJEHpuxA3BDoPee+Rd1AM1ntm83K74I+H6T8EZGT
         HjoA==
X-Forwarded-Encrypted: i=1; AFNElJ+IDb2yt8XNXyWEYD4UardoPApCvVYgXOZhODcNPZdjJ5sCefzTtpyNNf+lQY1aj42l6Ic+e0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH1w/k5bq1oZvRUuQSXireTflXZB+qcMdOpC0GlpdBNC2++7T6
	JJ8TCavLH9ZQ0HOMX2tKKm7rr8bXfRob7kOoM0XY7yz18bG6Q77zL10xqtBDlw==
X-Gm-Gg: AfdE7cmFeo+k8rvt/J3j0ACdY9U7oG4HRiEIiEkbXdOrPHmvTNGRsJwI/4HyhQC1+0J
	X6dSLgoowz3HeI6dzTHZOmRtZr2G/egB6CH/YL91LlHOOq4R5dWKvnCjZ6DKMp0wdVx6PR13LiW
	+DrbIyIV50iv1rJzsKQTf4TsctHUGMUcWQp6PAz+bYgCNZsQktxK+jpnoqtLw7bjHeAoSwaah5v
	ULTrxjF4oLhcVxlLbVIno6a8O3sk2mPEQo028LXRn8pV5wpYytKOt6qVQgLbgHRG4W6G+UkyWed
	vDoJZAw2JDRnPDOmdLTkF72N0H2HdkHwc3N+tECS/TB7bX+z01MEYRDwRZIHS7xNab/GSYe96IR
	dyri/klGNq5lqOV3IncD+JXL1Lq026AuwnzPTqqxxK3ej5z8n7yH2DLLMOhcIs14fSQV+tQWXSm
	QjHYQyMDXpHzRpfI2Q7n4sTa7l+fss+cnQA9/Wa1dBWi2Mff8e5ud5yDg2MEjKPWwfBZ72eEF3k
	TsaUEHY0pXzM+E=
X-Received: by 2002:a05:600c:3593:b0:492:6cd0:41b2 with SMTP id 5b1f17b1804b1-4926cd04404mr71506295e9.32.1782549952575;
        Sat, 27 Jun 2026 01:45:52 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f106:e901:6d7b:bd22:a37c:4eb1? ([2001:9e8:f106:e901:6d7b:bd22:a37c:4eb1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690988e0sm157844555e9.14.2026.06.27.01.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2026 01:45:52 -0700 (PDT)
Message-ID: <9d65d91f-f48e-4580-b32a-5b8c1126c003@gmail.com>
Date: Sat, 27 Jun 2026 10:45:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 0/3] net: pse-pd: decouple controller lookup
 from MDIO probe
Content-Language: en-US
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Corey Leavitt <corey@leavitt.info>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Russell King <linux@armlinux.org.uk>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>
References: <20260626165929.2908782-1-github@szelinsky.de>
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260626165929.2908782-1-github@szelinsky.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302312-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:github@szelinsky.de,m:corey@leavitt.info,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:linux@armlinux.org.uk,m:o.rempel@pengutronix.de,m:andrew+netdev@lunn.ch,m:hkallweit1@gmail.com,m:kory.maincent@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[leavitt.info,kernel.org,vger.kernel.org,redhat.com,google.com,davemloft.net,armlinux.org.uk,pengutronix.de,lunn.ch,gmail.com,bootlin.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,szelinsky.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5A58C6D17EC

Hi Carlo,

On 26.06.26 18:59, Carlo Szelinsky wrote:
> This is v3 of Corey's series [1]. It takes the PSE controller lookup out
> of the MDIO probe path, so a modular PSE driver no longer makes the
> PHY/DSA probe spin on -EPROBE_DEFER until the PSE module loads.
>
> v2 was four patches. The first one (a regulator handle fix) is a
> self-contained bug fix, so on Jakub's suggestion it is going to net on
> its own [2] and is not part of this series. The three patches here are
> the notifier rework and target net-next. net-next was closed for the
> merge window when v2 was posted; it is open again now, so here they are.
>
> How it works: pse_core gets a notifier chain (REGISTERED / UNREGISTERED).
> The phy layer subscribes, owns phydev->psec, and attaches the PSE handle
> when the controller shows up instead of during probe. fwnode_mdio loses
> its PSE awareness, so no -EPROBE_DEFER leaves it and the probe-retry loop
> is gone.
>
> Tested on a Realtek rtl93xx PoE switch with two HS104 PSE controllers on
> i2c:
>
>  - clean boot, no probe-retry loop, no watchdog reset
>  - 10G SFP+ port: module hotplug works, no deadlock
>  - ethtool --set-pse enable/disable cuts and restores power to a PD
>  - i2c unbind -> rmmod -> modprobe: PSE detaches on unbind and re-attaches
>    on reload with power restored, no reboot. No lockdep splats.
>
> Tested-by: Carlo Szelinsky <github@szelinsky.de>
>
> Changes in v3:
>  - Drop patch 1 (regulator handle fix); it goes to net separately [2].
>  - Rebase on current net-next. No code changes to the three patches.
>
> v1 was an RFC by Corey [3].
>
> [1] https://lore.kernel.org/netdev/20260620112440.1734404-1-github@szelinsky.de/
> [2] https://lore.kernel.org/netdev/20260624204017.2752934-1-github@szelinsky.de/
> [3] https://lore.kernel.org/netdev/20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info/
>
> Corey Leavitt (3):
>   net: pse-pd: add notifier chain for controller lifecycle events
>   net: pse-pd: fire lifecycle events on controller register/unregister
>   net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio
>     hook
>
>  drivers/net/mdio/fwnode_mdio.c |  34 -------
>  drivers/net/phy/phy_device.c   | 168 +++++++++++++++++++++++++++++++--
>  drivers/net/phy/sfp.c          |   2 +-
>  drivers/net/pse-pd/pse_core.c  |  54 +++++++++++
>  include/linux/phy.h            |   2 +
>  include/linux/pse-pd/pse.h     |  41 ++++++++
>  6 files changed, 258 insertions(+), 43 deletions(-)
>
>
> base-commit: 805185b7c7a1069e407b6f7b3bc98e44d415f484

Thanks a lot for continuing the work!

since you need to do a v4 anyway because net-next is still closed, feel
free to include:

Tested-by: Jonas Jelonek <jelonek.jonas@gmail.com>

The issue I reported before, specifically with RTL8241FC, is fixed now.
No deadlock anymore.

Best,
Jonas

