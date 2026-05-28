Return-Path: <netdev+bounces-292812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFiILOGUGGoMlQgAu9opvQ
	(envelope-from <netdev+bounces-292812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:17:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B38A25F6F90
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E97630074CB
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880B833D4F0;
	Thu, 28 May 2026 19:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoUD7fXs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B3A3FF892
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779995748; cv=none; b=b329WjxMXgjaJKDQjZRhuINtjsDbr2x+h268yixzfqffbab47W+cM5tOfGxsSTZFWseBEMUO8Q/1mjYzWdAO1IFV+4DhRe48g2M3l0x0Q92D/PTvX8bY6sccctuFLhk/NFoBzqYXVZu0Rimx/fUWgS3Ci8D1/rf822aYTcWzQgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779995748; c=relaxed/simple;
	bh=W22UafAh0AyczgKEf/VO+Av1vudPqxYmIdaI1huLeDE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=YBLN2uNYohrvw9GjMJnVVjqDr6TtSDF79PRunHFm8sJxcZCEMIF7+UqoM/a4uIJQZ8nVOiFUADk783fz1rI3JbUP9xKn9u1lvCGFAnXHNrLgksdgiAhuohaPlzX/v3CjplGid+uv2m8Z37gwy2L9Zg2rZh4sZhwYPyw5dZq8xHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoUD7fXs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso84796795e9.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 12:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779995745; x=1780600545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W22UafAh0AyczgKEf/VO+Av1vudPqxYmIdaI1huLeDE=;
        b=VoUD7fXsVQD8VpH6aevZRrOIciWpBdq8kfhyr/fn73fapia8Z6Hk1YrJ3cqaZg9iwR
         /AzzbfQEB9yMsiHhcsqSO1FEyTWaUrSRFfxa4IbZ/Om7QQVTxl1XnDNc2c7dmNW7NwXq
         60a7XZButeH7dG89n+rw+Mnj4FRfTXSfhnl+hgiwi4aZo6MBU3cxUJJFDbZ3tGGBln20
         ctGaMP/OevlOXZEbS4bo1fCvi6HH9xbWlNbrxLf/BkZL1qErYbMst1sFnvbhmWymX4vW
         NDcELP8/1seEmH4TdT3lr5VdmWr/9Shy2fNsIedCW8nPAq9hdIweouDHgeBdI9UzX+ip
         CRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779995745; x=1780600545;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W22UafAh0AyczgKEf/VO+Av1vudPqxYmIdaI1huLeDE=;
        b=n/mposiQzWXWhUiY5a4P16CiILsxFdFYPTntZmNTLBzeQysncN0lQvR8T6yeJ1dHtK
         mr0EoHNCMW0neYtkUP9IGFg4zGwRhgvTzTeh4uPPFYn3XhtMy+HrbdMWMGHTmO1a0mFd
         pHJpUuBqoGeH9bk1vgysqjJ3TZ9/Os/MRpuI8UrgoEJSOl2D9W7ioMz9XFhRo5ky2PwA
         XunnYIyoaLJve7pqnPQUbmf0VbSATwuxqsqb60ShBi5+jIKhLNijEXH5JVx+UpPhDQZp
         3LxRzHQOgWpESZ4tsyX3uaYkTk7pCItiPzHZfryudvAuYZ4OfHj2qMdg2Ns9+/1ICpiy
         NesQ==
X-Forwarded-Encrypted: i=1; AFNElJ9zNXgDaub896Yk3PL09+iktwv2YrgcjLIYkGrrb00wjz1xbxGPBMvrqbJkidSqXFgLPfFOrho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDyV9YPANSDlXGmtshPRFJal5FYOI8vSmMNKFVZf1X3xyUgC2/
	34H5S/uvShda8wdJrnX3sdPyX8lG7jgLIhSrNb8d8AjXObrwTkZXYpKJ
X-Gm-Gg: Acq92OGMjx9mbHbzabt00A5LLnfrUBdbCjVHfkMy1Kz52xezcfJ9ZKfxGdLLHVezyPH
	EHGe/bqsAf3XHkSiOf8pgZXCMAuPkZO5bu8uNYxscHEJp1qR32j3opI8v9z0ibHyScLYGyHaVym
	9PrDgurF23bCT8OZUVtnocuiK5Cl0Pt5j0NQq62Sh8qDdQjiSkszqKAgqjtWn+aPEPubn3SRiNc
	WmPtm0Bx8EkGnfDGZDmWaNc9dS0U9+AyzWn7LuZHhMLoDXZJFIHjDxbysLh2cmB+PjHBVCqIsfs
	aTeJCFev5ZRbFiPuS9P7jj1iznO9pXeH5MyFsjH3ReW4gLX+n31TnmZ45m7qkolIky/H9Hsn/XO
	0OeR/TlXj+lds7sv8FiQks+FSGzUOmSnMD7TMhHv/nAsCmy+nRgjapO25pQ9NO5cY0yyR9PuWFS
	eUIqL0ZjCrqc3oRFJ+YJ2uJYhftxXpz/dM2AlX7r3pN+U1cM/xH41WHrWLNA90kuV4QKNw+pMTD
	oxrSYxhRAeCvM2amzP1UMz29svbffVIX9pYsoj+NYUvPV8=
X-Received: by 2002:a05:600c:8b86:b0:490:58f4:ba2f with SMTP id 5b1f17b1804b1-49058f4bb2fmr379578265e9.23.1779995744652;
        Thu, 28 May 2026 12:15:44 -0700 (PDT)
Received: from ?IPV6:2001:9e8:f104:6501:10da:a6ca:b9c4:f578? ([2001:9e8:f104:6501:10da:a6ca:b9c4:f578])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ee5a84e92sm6664031f8f.35.2026.05.28.12.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 12:15:44 -0700 (PDT)
Message-ID: <e00048dd-1ed3-40c3-9912-59bccf015ad5@gmail.com>
Date: Thu, 28 May 2026 21:15:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: devnull+corey.leavitt.info@kernel.org
Cc: andrew+netdev@lunn.ch, andrew@lunn.ch, corey@leavitt.info,
 davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
 kory.maincent@bootlin.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, netdev@vger.kernel.org, o.rempel@pengutronix.de,
 pabeni@redhat.com
References: <20260423-pse-notifier-decouple-v1-4-86ed750a9d62@leavitt.info>
Subject: Re: [PATCH RFC net-next 4/4] net: phy: own phydev->psec via PSE
 notifier and remove fwnode_mdio hook
Content-Language: en-US
From: Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <20260423-pse-notifier-decouple-v1-4-86ed750a9d62@leavitt.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,leavitt.info,davemloft.net,google.com,gmail.com,bootlin.com,kernel.org,vger.kernel.org,armlinux.org.uk,pengutronix.de,redhat.com];
	TAGGED_FROM(0.00)[bounces-292812-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jelonekjonas@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,corey.leavitt.info];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: B38A25F6F90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

this patch seems to cause a deadlock with PHYs which provide SFP 
ports. Noticed this downstream in OpenWrt with Realtek RTL8214FC
using an extension to the upstream driver [1].

I suspect the deadlock happens because phy_device_register takes
rtnl_lock with this patch. But further down in the call chain,
phy_sfp_probe is called, calling sfp_bus_add_upstream which in turn
tries to take rtnl_lock again.

While the downstream driver part still calls phy_sfp_probe itself,
backporting the phy_port changes to 6.18 and adjusting the driver
doesn't help. If I got it correctly, the phy_sfp_probe just moves
into phylib core but still causes the deadlock.

Kind regards,
Jonas Jelonek

[1] https://git.openwrt.org/openwrt/openwrt/tree/target/linux/realtek/files-6.18/drivers/net/phy/realtek/realtek_multiport.c

