Return-Path: <netdev+bounces-253109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Rw1eJ3w1dWnUCAEAu9opvQ
	(envelope-from <netdev+bounces-253109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 22:11:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F089E7F030
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 22:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78C9E300B86A
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 21:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B5527EFE3;
	Sat, 24 Jan 2026 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aUZnN8bR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D7B27A907
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769289079; cv=pass; b=IxVLfhM2iXoN+iShQ2SfGqjB5UiHAh+/EnwFxNBYEwt1foUDWzki7/b/fvKpIwHFNvAtk3fULM+dZRqYOfH9TYkdLLTOY9tPnhIc2xli6BH4UQ13k96ZK2IKuRiUPURLUURnL9u/9VxwBwkOGXteXMCNTCOW931hdWDfGATFv/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769289079; c=relaxed/simple;
	bh=kiFIK6l3fQ8jRlvxIxqA/vQFUYDACBhvkCt3X+WfX6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRhKGDefwTRDsHqtlhXbAvbum4pplG0lcVuwQ2T97xsgaa+EyAUVVn2x77bb+HQFhr/iOgrAQj/3cHPuvo3hb8ovF08BNhhdIA8lJgRTPopoQMS+6tnE9Yn2uMf0aRlDpjZyHcMFLp6JQBBoX4ZVVmsXttJrx/BYSKkbx33dXJ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aUZnN8bR; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-88a2e3bd3cdso42089516d6.0
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 13:11:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769289077; cv=none;
        d=google.com; s=arc-20240605;
        b=k8PHYq5AAXkF+JuNH8noNWKNpx75aZVWtRcZ8mTocQy6QBLNz46rDZVkXa1Hqh+FZY
         5UsgBJw0SF14WJXc24N9SaJtaaHVePW/C9Efnw6WsZyGTl+eWdkwYGSJz58BTbvz19Um
         dOZ86xkQsNiOmSex4NRoLUhtAd68RS5X2FEtTYME9ep6ya+BqEjOZqbjKctJ1fzVMXPA
         NZyjI3F7UXWbE0jy36DTkFAwh9zGhw8nYr+2TqTFoqD2T9HZ+nvDvoQl5l0NSoch/PBa
         cb8o0MuXz0OG1OtWErFSulD2m05Ouiu1AXYm3+zbCPO1IwPQvRytEOAMRPbeM5UHQsYx
         aqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kiFIK6l3fQ8jRlvxIxqA/vQFUYDACBhvkCt3X+WfX6E=;
        fh=z9zjIoDrsDqYJuJ4dPq6IVjXG0nYOeh3HzCdg1d2UFI=;
        b=J0dAOQDdd9RJmtf9RcsOVuXt+m++CCNJLmy2ztPfiiF9nfN96eco6L1VuiKGRB6xpS
         AD/rjvzx/oKjfa7NNK4+Ppud4yjmlRhJppRumh6VDQRmRwOMjBrWcspsgwo/B0QGSkWP
         x+71Qq2PJ+Q5I+0x8HH9RXUiVSOsgNz+EB0YnRQqdaVlVquxBdxlva4MGV+XrscorrwH
         tbVaGOcTrTPAEd60pQ6l3ZDM5Gk7IhSE01hLd45wZzL6qrBer9kRt4mPV3NYL/eyUzv8
         l8y51XkCwEDa9DNK0yDiQsrw0eiIXq/x9IiSwdLywnouyqu4R5TJWV26Y7NjsHSxGYn/
         g/yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769289077; x=1769893877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiFIK6l3fQ8jRlvxIxqA/vQFUYDACBhvkCt3X+WfX6E=;
        b=aUZnN8bRiqXroa9zct3uOYszdYWjfuhKzx2UzWLgqOblVa7sQbFroDUJkPs5H2Xb66
         AXum3biBrqI8Pgcz0iHareowTOy3wUq/F5kIF6EmPHlOx6CA2DJAzVZu2o2YGLegS3VH
         8Zq9cv59BG/qkqmO9GjdG94y6Q7vH2GxuqAfgzamX2u4vpStIXRHqz2Dqa1gBQVQhttD
         PrFt1XBzR4twuvnGPDhswCgZi39qUvbvAvv6lVOddoR+fLh9VOJ/log2e119LgVOkftM
         6XzR89uZ/SNVputVjFH0VNgGXk/gmE77NhMxehPHa4JGYZZmiw+BlulpvVHdMBRUYblM
         BBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769289077; x=1769893877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kiFIK6l3fQ8jRlvxIxqA/vQFUYDACBhvkCt3X+WfX6E=;
        b=JlcrpdjYNqamvo6Xb5VhohWGKTRe6jPimxRf2fv26HkyUd3yONQ0EN4pfoy0Sno5FX
         Yh4tMJT+bm2RwRCGV7jy+4yGDatRVnnnkdiU9SxzKYs5loEtozwBKerosLFb6CJQHQIZ
         MUZ4WpRy5zOud7Vp6kdakj/S/RKoRJbPNdrr+/AvDmEGUhyE0zreWv2md5XWPFB9fCw+
         1+hI98J8jz2pnbJte+4icJ4uAxHhYOIC+FFOPRCsbF7bIi3ccC3c+3Ns4ZkSxmMMc1mE
         iccZ0I2URCB5MKfVEoSW02+urmpQjxdHavmqd+9d9sgZmj0B/zaE4brAgrBotmfTwuTV
         Nu/g==
X-Gm-Message-State: AOJu0YwphzvG5deNPbR0se1zO3LrljVIljOiQNmf9jb32UAwhosjhmr9
	Ab86JqZ4L8SaCH++WNtduo7HhVa2F+/idBUChNGS/7Hh4IOBPgS1g7Ld6AMucsAnYVTq9xXR7Wm
	v+VrJfkAfiYkUpDyIrx0zg7b7hEK7PdA=
X-Gm-Gg: AZuq6aJt1YeRbGZ1NOWUNaYAHIL12smdOUWabaVd+YaEywiF3QETMvLbtSVnaMJDPMJ
	XWeliHGJVKzhQGpwLAFouJxx2FEvYF3j6F+O8IIn1cuNfM1U3AL+k2MBPzXpk7pomN411ycbQRS
	ow2t6iksLYcdqq6iJIP20ZMGFx65xVnMI7UhHiHuJjYHN50V1FMP/8FKcxSquLAwScliKEaYB7J
	vC1YdYnw4ALCQ+3Ef6VRE67n6PjgrUZp6fvedcU9OzzdV9RnjUqRnR+eAxzI5sZB8tWJ8s6HwVt
	vM6YtABVW0/CV1mhCWJiK9UmfTRDr5/leWLqBXdmVDyiXfdSCyuQl9+U
X-Received: by 2002:a05:6214:19c8:b0:892:66bb:fdbb with SMTP id
 6a1803df08f44-894904b5044mr98724906d6.23.1769289077093; Sat, 24 Jan 2026
 13:11:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260124102042.112101-1-enelsonmoore@gmail.com> <aXTHhI710LK1EsTG@smile.fi.intel.com>
In-Reply-To: <aXTHhI710LK1EsTG@smile.fi.intel.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 24 Jan 2026 13:11:06 -0800
X-Gm-Features: AZwV_Qjo5OttDk4_JH7C9yZYSHf7L5itJ9UGsDGOS0KJi77gP4CJVRASoAKFFVk
Message-ID: <CADkSEUjwCmowmo_AwZ7TNS2gDt0CLz6buvfjjXz7BrLfuokM4Q@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net: usb: remove unnecessary get_drvinfo code
 and driver versions
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Peter Korsgaard <peter@korsgaard.com>, Petko Manolov <petkan@nucleusys.com>, 
	Steve Glendinning <steve.glendinning@shawell.net>, UNGLinuxDriver@microchip.com, 
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>, Oliver Neukum <oneukum@suse.com>, 
	=?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>, 
	Deepanshu Kartikey <kartikey406@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Max Schulze <max.schulze@online.de>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, 
	Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253109-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,korsgaard.com,nucleusys.com,shawell.net,microchip.com,fintech.ru,suse.com,piap.pl,gmail.com,pengutronix.de,online.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F089E7F030
X-Rspamd-Action: no action

On Sat, Jan 24, 2026 at 5:22=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> There are three problems with this version:
> 1) you haven't taken my tag, why?
> 2) there is no changelog to understand what's going on;
> 3) the v2 was sent too quickly (usually should be 24h+ between the versio=
ns).

Sorry about that. The only change is that I had overlooked smsc[79]5xx
in the original patch because they had a version definition but didn't
use it in get_drvinfo. I will follow these procedures even for trivial
changes in the future.

