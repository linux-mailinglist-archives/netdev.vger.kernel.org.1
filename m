Return-Path: <netdev+bounces-283861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJtxETCt+GkuxwIAu9opvQ
	(envelope-from <netdev+bounces-283861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:29:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4804D4BF893
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0AAA305FE6A
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE813DEAEC;
	Mon,  4 May 2026 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="IUinIam6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245BB3DE428
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904175; cv=pass; b=lZedE+j43McDSeJUyPqlJj1dZ8FU/bvQtgMMgBzm6Ij61RL8g0Wtve9wt9Rl9yAj8+dSrwmFX74jeZl0Wohn/w1uvFlEKt21zIO4vIU0KXBbmzClL50OQtrjbgNj4BmR5l7Rlrl1YBsJyvaNoPAax+daHxJcZ8PPRjKyKDmRf5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904175; c=relaxed/simple;
	bh=aSqe4HTBnnCiXeuThlWr1tp64VwP4F/+mQ4NzEuHJms=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=BHbt3zYB3XSSbAdP7Ghj1rdVsqAO95c83ruJ338aq1hdiILc8YXuKyGW+Fl0Yweo2pIHG88s4Eyqrweqtk32dWhiwQtIpDWzS21gzfuKaDVbN30xlZ3/Ddz1p/YY8U7DyBDLCAL49YC+T2tAWLweg53LZu9S+TyRaesXdpONraU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=IUinIam6; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7bd8cb26219so4002767b3.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 07:16:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777904172; cv=none;
        d=google.com; s=arc-20240605;
        b=Uqf0igjz/y2SPqDzX8b9KUKrsXevFru3YPa2eutkrjobRbj/pCA7YYXslz57gicIr0
         xlOlS13KtD9GkOPCOLjQa9TMGqgTs9LEZQee5KafFomcBPCXr5eoiS9feWMsx5mDudhw
         062oknSI+7jUvaIz2KlcAMAAFaRurOxw2EmuCluJ224WbdWnXNp18WSl3ywQA9q3v8lS
         Lx/0toZQzHAduLnhpWvH47bDY5lHYLP8oSh10TjDVRuOj7yn4nYab4Uz/IZUIeTpZaHv
         tleP3vJKIU5nCx7pNzgPuUOZbF3/HW+skwbFLg6q9lzD8C/duU33b36S2y9eyqVCTo4D
         0wrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=c3jgVhbnA9PiNUDUKJWWXg4N4o4wEhFshJKHx6mDKD0=;
        fh=Q4wgaZzpfUg8xis1MzxfMQluX7TCxxnvBxy/5IfdQhw=;
        b=GeFLayFUojvs4wOXWsudchcU+DwK/T2RQlYtLg+rcfZzF9Yogc10vx3WVSjf8BNm+C
         gyPj3d5q/V+mWm4/JpP724Py2KEpKRHyaYvjKyPm7VCY3FUeEinH+PWKr+jZjoxeXWjU
         qYX7LsHChoJ31bYq8NJ0cz0t8uALT+wB9nm6XPQsPD6tpLmpPwmenoyT15YhlwxXKsO2
         NPN1qULYX/GUVNM/l+KQNHImw/vBdAfEfVPUQvPVhB7lDMg5WkJv1FPu0bf1Bs9D5ke3
         eQoxHKvB1RCzxbJcQAwLYiJ+LDud8SZdvDf7PXVX8qpBL/Wq6QGkLg2RKpV1qoSb92c5
         +SWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777904172; x=1778508972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c3jgVhbnA9PiNUDUKJWWXg4N4o4wEhFshJKHx6mDKD0=;
        b=IUinIam6aUys461t2vh3v9sq1v1HF+rXpBRUhOqJtslVJ2d9pGAYDnYyplVTDUa/kF
         E8iGOoYWXlNiKatwaZ5yPSWRWpdIpU0Ypb3eVVZfHXsXwCgaQiAKAZSwaUYdhDd7YOq/
         xNKbMM1BazzAGz7Wt/kNb+1deh5RIwKnV2msqPXIBgd2rgAKntHdIthVSZT7AXIogIdL
         CDSNbyg6hgF7TJY1Bur4+zZxccZzZWwGCLMM3uZJf6eCrKL5/UGZEiJ6TB6dgQ8CU7AJ
         8CIS7HAMyQsleifA41R16IpdBIfKC1BTIMjljx6jT2MpCddiEyzJN37BPhQ0QH+dA+ZH
         Wekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777904172; x=1778508972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3jgVhbnA9PiNUDUKJWWXg4N4o4wEhFshJKHx6mDKD0=;
        b=Lo7JK1tL9GrWHWgtif+gaI1pjTFBSJIy7UIaetrPYmjPhMfbMd2C3xbIEmcczf5xkp
         t7HgKSw+pV9/+9C4+1rnTMYmm8RqBmtMJkySD4ZrZUy+/Oi0JbpKNQ3SlfZXidBgYbmu
         HQuNnKKFN93QNrMcZc8PCBF4c9jiiTNMCJiHv0HljACQ7N1bAeQZsfHlbImChZG3tzTl
         Wd+HQLpJt9jDL9oxZtu7vXx89WjsdRTv5Z/jK7Na8ipg5BsLkvYgEhMRm3/z3MLl+lgO
         NpSxzrjmAi0bXdZOLo2a+A3dobbyEq6b7MQHoGhyJEOSsxTP+C3RxYhSYNf33oz4NVxJ
         /nsw==
X-Forwarded-Encrypted: i=1; AFNElJ/ccg+IAT4vNpTqLX5jDjyRX4CzA9hDRSwBE1nD/vRILWCruBuy42LWvu/7rzstlms9i+IZzLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDVJzzoiB2R4QWg4C4M0qgfpYPoYSPoeOE7X92IRRsYGFkvlMo
	vLKENM8re1gY/QW33dDp4RgZw3+uvExSXYFmvQvaFS0+PP7zJoYKdAVED1XvNEOnJbc0jzuEw7T
	wuLL/+wMEJMe5PQz9n/6Hd9lVl3jn7os9QqoIadiwk7Td3DtXrB1tUlHU
X-Gm-Gg: AeBDietAJQJnm7JcBMnKP+ZXUe95BljCcpXztSp7wJggELH4c61B8IJNbIVacwZNQ5u
	xoziAVERo8Klwx2AoZvej1LObA0Va5NV0n7Qi0UChtSqWi88/oyfnwfFX3bUeJfnQyd1f46TAAY
	Ml0eWWzf4wuUTLWHN3nt7ww15mfwOkMN1RmrVUPY4hxwoWIQibUz9DwA0/0C/tB2zXrgV8LOnzh
	e7whS63eFZQ+JjniazA+ZQVnE1Xdzvasg1OUtDmLDZhk1AowlSnwRS9xEiV1MelD/gztFkIFk8w
	Lpi0gxzg/wBoamVqHyLdmtCXZrJ1fxIW
X-Received: by 2002:a05:690c:6c0b:b0:7ba:f414:cd2d with SMTP id
 00721157ae682-7bd772c7168mr98215377b3.50.1777904171994; Mon, 04 May 2026
 07:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Victor Nogueira <victor@mojatatu.com>
Date: Mon, 4 May 2026 11:16:00 -0300
X-Gm-Features: AVHnY4LMomlt4-sBZr5wUn0CL5GXQWu9fa5qQIVEWi7kURvw4SbKPVW3PLjUYu4
Message-ID: <CA+NMeC-VCxWfzwHQTiY-eGA=FEmLY7_7AHgBrZ+dK+LC-d7pUw@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/5] net: mdiobus: Provide fwnode_mdiobus_register()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, 
	Linux Kernel Network Developers <netdev@vger.kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4804D4BF893
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283861-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu-com.20251104.gappssmtp.com:dkim,intel.com:email]

Hi!

On 04/05/2026 04:29, Andy Shevchenko wrote:
> Provide an agnostic helper to register MDIO bus independently on
> the firmware node provider.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> [...]
> @@ -187,3 +189,16 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
>       return rc;
>   }
>   EXPORT_SYMBOL(fwnode_mdiobus_register_phy);
> +
> +int __fwnode_mdiobus_register(struct mii_bus *mdio, struct fwnode_handle=
 *fwnode,
> +                           struct module *owner)
> +{
> +     if (is_of_node(fwnode))
> +             return __of_mdiobus_register(mdio, to_of_node(fwnode), owne=
r);

Build seems to break when CONFIG_OF_MDIO is not defined:

drivers/net/mdio/fwnode_mdio.c: In function =E2=80=98__fwnode_mdiobus_regis=
ter=E2=80=99:
drivers/net/mdio/fwnode_mdio.c:198:24: error: implicit declaration of
function =E2=80=98__of_mdiobus_register=E2=80=99; did you mean =E2=80=98of_=
mdiobus_register=E2=80=99?
[-Wimplicit-function-declaration]
  198 |                 return __of_mdiobus_register(mdio,
to_of_node(fwnode), owner);

cheers,
Victor

