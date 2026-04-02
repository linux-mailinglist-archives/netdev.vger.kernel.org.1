Return-Path: <netdev+bounces-274331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCJ4DeHYzWmliQYAu9opvQ
	(envelope-from <netdev+bounces-274331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:48:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B814382D23
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30133303EE92
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 02:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D4C248166;
	Thu,  2 Apr 2026 02:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJSyQJ4i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C881A38F9
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 02:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775097932; cv=pass; b=hFz6Bs17MqVErE4uoSL9YkDR/IL1NDdLZg13KlSKDRkOQzxrjfsGbKSJ3tfQQw8tZMtMCOoAtzkABJ733LxO1sTtetJWsXwN5UJe9wpZ2shclAyRWt/7pefVk2kNoEsBNXQwBctAba8eEh2+aLyeuNOiadlP6Z8buBykbShWRFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775097932; c=relaxed/simple;
	bh=V6xnj6ktPYBcfE+aVHDcW3TurA95unsK5QqpAy4Fn4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLFMH2jb0xBERtzTdIl5G1gg3mIYDfmmkvFaE9J4Rl6GdRs4c47K/UZMC6v/C/mk01qKv/ANwAuuM19JjKAeiwggwXOsavplyvPtplFxxRALdq+ED1ayMi0go5Y/JcMwaCsy70FefWeW1lWc3Eo8s/8tU+hwDrb9nQxf/luzHGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJSyQJ4i; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66c24b42efbso640453a12.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 19:45:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775097930; cv=none;
        d=google.com; s=arc-20240605;
        b=NgEStpaMFZWYfObs+6xxc+3z2Vkuel+dnmoZ02exjs3Y+1SpkpjtOc3zaqkLnUwISE
         VJfjcydfxxuyUAQSjrzVyukBMm4N9SvxdLXyig7Dg3tfyL4IkLgcGi5OTVqliCOiq6Oy
         hU7HoqIh3RUcHpBhV1cH5QlRtPvbkmr2WGn/OsThIvinGoyEFImhL//R7NIrML7kYioc
         +8Hn4cH0OBT0U4aYfFZmKtvLlytwLvqGlvKwmX1jwhRYZepVZO2xiGqfKRWZ5ysv35cB
         560RLifNemL/kZD9Oq2tQdNbJCiP1Io5nThWwW7bfnwXWpBW65FawqM6odDhe0tgsqq/
         ARxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cCF/CCfJ6jELwyOffcpkBnUH9phK2L09BcWgTN3msuo=;
        fh=unNi0x/3SQbbz/UjwiiQX0f0f1MYkO47S318Prk9aCQ=;
        b=PU43S7xY9eaOZeXpzuBp9q21iac+cNx0RzUNTotzTWZlJTMmTmSVsP/Embq2wqouuY
         e0t6p/Pl21I5tVeC7rGhlwzWzI5oMNmrI7Kw0UtE8WkBUSkZJFy2jm7piM+YmAWDhymx
         vB48L5eBUJj10+LM8Ms1Gxm0wreP40Pct69u4FunVttMksZ3Hk1zBrBwKRXBNeDWduKI
         zBTBhkp3GGjAzYoH5RT/uQBEnj+2/5LdqG7t4lA0HimawjmeWJ+e1TmwBc/qO0+KdBSA
         EFGO2ailrP5u+KzsYF6IKs+6r3CgCpBpRyVudwuTH1jOiuaQdSD5NOxszwHSOqnTG6HV
         BV5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775097930; x=1775702730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cCF/CCfJ6jELwyOffcpkBnUH9phK2L09BcWgTN3msuo=;
        b=SJSyQJ4ixXwAlYmnPmxPlfVtDAZSWn6UoTPxVdCqMIZ9FCtNpyEBu6O7qoo2FvhZwO
         kWujthVzdvEnD3vaRkC7xLVt+MyXQCHfseXxyLqvKFgKkcHsmlszmr3eWnyKYQ2o+ktT
         l7ga9fqzT4g5qcD/ZT8QRaTGicyAHy5q/dWNCof3Qil2b4GUeh0pCeDcB4QiKWK/SKbF
         3ILfN2ODX2mPqhdGPcc2HpCckz7D2gx84rlwpkP9u7Th3klpy147seuMwjCir6TVPuaJ
         9vAgCPnxWFmGj3HdfsXcclLuWYDWVh65/7OLzOhKwW+movPROVug625/tddLwnRsK5NA
         fqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775097930; x=1775702730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCF/CCfJ6jELwyOffcpkBnUH9phK2L09BcWgTN3msuo=;
        b=dky0eA7UI2Gdm8MV0PyrZqACykrFe9x5BelDgyZz8SEWZW5qICPN5R/RF862fFxQ0Q
         SWHLN0wEWNZw9JvHZnUlKY8hI0bCFbxVwb5N9TyzN2pMqMIe7Ffg8FipRqz2SaxCyJVP
         L1yICM63/SpCJ5aVmgRlUoTOkwoXQkfI1cBuLGP6+KtU/4V/xN8p9EjUSdyv2KrDTjVT
         4bMMSnwrZP2mFAD1NcbGbDPDhBgySSlNtX4daXw2GBdA0I+wZA6y0THquHJRCYHrbKDW
         W5aGVtPzRTudJhp2p9m/tDMDqLciNABL6u8/qcqZm9otR+ttELiC0bjqHf7npjXCaecb
         kkGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDb2tATHEcW1+N2kx/XmNxP62zH6bBiOuCzmGqTa0I58JFgmkPc1lntaA3bw+17bMm9UfqsGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJQRKRQAySQGH5jWG98gu7zHF3toBsfEGAW9swSB4StLkKiog
	OFYLpRFVZleqXGVJk1GHu0TwD4Q4mXT6JFOxWkCl8wguE3t+MZRLDZqFpA94cQl62GsACLu4XF/
	iSNOL8AzrZYmYXtMvPo9zf0oogqMzNWE=
X-Gm-Gg: ATEYQzxugSD/EaXnE9g4dPKHd3v8SpbYkWbvzO8+WBoB5Hu78ni6w1T0MoXfA4znkSw
	Po0/y0wz074tC2ko0PFMHdCf++huFCf6XeZjMT1ajzm5WXHRcEZktXUdW4PH3qpACYQt/h/HWVo
	LSCRzXYOYYcdIfZZLm+4alI20UnqA+1tKoFquWPW9zGJMM72WSJwAnCF6txOtA+I2gAaZ/8OSNe
	zihbCQsXes//weh9k7ciOVQUrWpqfkRP1HpEilRIzRc9K+S1YETQRtHihEqef+gwmlzyEg/BrWg
	ZmuYCGHT319vjT610V0wsYIZE8lcalhhh1Z8
X-Received: by 2002:a05:6402:20da:b0:668:502d:80b6 with SMTP id
 4fb4d7f45d1cf-66db9e0379emr2386026a12.26.1775097929839; Wed, 01 Apr 2026
 19:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-6-44fb63033b7e@gmail.com> <acyCmHh1IAykwycy@yury>
In-Reply-To: <acyCmHh1IAykwycy@yury>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 1 Apr 2026 23:45:18 -0300
X-Gm-Features: AQROBzCLgEdzCSiVF4-1OAwr-2nLV6HlJM6XI0X6UkMOFnb2_h_3kUFnfsw4sio
Message-ID: <CAJq09z6fUhwnbZhFF2okU07z2uj5JPr5mAerpfSxhYDgRNZvwA@mail.gmail.com>
Subject: Re: [net-next PATCH 06/10] net: dsa: realtek: rtl8365mb: add VLAN support
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274331-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9B814382D23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > +     vlan4k->vid = vid;
> > +     vlan4k->member =
> > +             FIELD_GET(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK, data[0]) |
> > +             (FIELD_GET(RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK, data[2])
> > +              << FIELD_WIDTH(RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK));
>
> This FIELD_GET() << FIELD_WIDTH() resembles FIELD_PREP(), except that
> you skip some checks. Is that intentional?

While it resembles FIELD_PREP(), the usage of FIELD_GET() <<
FIELD_WIDTH() is intentional and semantically distinct from
FIELD_PREP(). While FIELD_PREP() prepares a raw value to be written up
into a register mask, we are performing a read/unpack operation here:
extracting bits from hardware registers to populate the driver's
internal logical structure.

Using FIELD_PREP() for this would require defining a 'fake' software
mask (e.g., GENMASK(10, 8)) that does not correspond to any physical
register, which would be more confusing to future maintainers than the
current explicit reassembly.

The 11-bit member field is split across two non-contiguous 16-bit
words in the CVLAN entry:
- data[0] (D0): Contains the primary bits [7:0] via
RTL8365MB_CVLAN_ENTRY_D0_MBR_MASK.
- data[2] (D2): Contains the extension bits [10:8] via
RTL8365MB_CVLAN_ENTRY_D2_MBR_EXT_MASK.

This split layout suggests the hardware was originally designed for 8
ports and later expanded to 11, placing the extra bits in the
previously unused space in data[2].
Even if we concatenate them into a single 48-bit value, a single
bitfield macro would not handle the non-contiguous mask.

Regards,

Luiz

