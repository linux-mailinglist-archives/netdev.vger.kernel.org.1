Return-Path: <netdev+bounces-291042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKXKIklEEWo4jQYAu9opvQ
	(envelope-from <netdev+bounces-291042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:08:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E4A5BD642
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 08:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7513F3013244
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 06:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2C323909C;
	Sat, 23 May 2026 06:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxjL0nOZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9953438B5
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779516486; cv=pass; b=W6YNrS+xb9z9Vfm49Glv/0MiGJs0T1YGoEacSZ8650PBpUIvPfcffyQlK2ILaKpXU3p9tyG9On578pTfAl+SSdtLTM7WUWOmqeLLha5XZQjueXz7eiVqJ0FaXYPeJET7DPNJCURyeYaMFCFGhDm5arvIUP4f6GaF3rdUXsCQfhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779516486; c=relaxed/simple;
	bh=H2YuEhDuFI2BMzPrhLRQAHHgnDvCC8hup3rMKgN8TYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OagQk69TigorVgQF5PUcUzlGdOTlcjOkX8wRihrvHTcq7ygKZ66QKbAps5LhZKgAaDzhkxbpSOtAU31EJNii49WEG20e2li29u+BC/3rY2ZR0ek9r0538iGfW2rZAK/diMeScH/NW4nLFkHrgakdkOOGSx6UjRmOBY4HbmHsM1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxjL0nOZ; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bcc9fdc959cso1465078966b.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779516484; cv=none;
        d=google.com; s=arc-20240605;
        b=C6ZjJUcgylzoQjgORl+/W++HBX2sz7fGwPv0w6zoiMWZ39D7mAnE3+e/kcDUi7rL8p
         5f9nzxMVI3tKGFRoqjF9UCSI1B0FaKTej9Brq3XbvocHE2AnWwgjw0iZ6dGw7+89a3JM
         etCDxZqfTZNSJn319J1iO2IWdge1psHyEYNUzdu+tTrJ8H9BB3NmANbEWM0/uxir7lUZ
         HnJ5cr7YygY22B/UFelIS6Ri5p8uMT+7DBZEwYqDOFlZsNCVNlZLVpW1jOiU2LdaYo6f
         AAUbDHdT2K4tNYFSNaq9QEARS+ZWv8g0yuwxpfrVx2lnQ0cS76lg6xaBL5HoJCkJx/rQ
         9Rdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZvvyRKpTVIl22LQs46Ac2u2Ct8pa8wNy+U+cdieY8pk=;
        fh=CuHgFMv6y89Ffa+R0fq3uv6YDQdxG17FUsBp8kJ5ZOU=;
        b=BbVpJieV66y/qrPbDcM1Eu6CXjfZJHLJFSaMGAuPjBZU1b9vgaMOrCoDPeSSLFLBbP
         i9afhB0KN7siO7NC1FIqDGkpBvGPXeG4AQJqEAuFcSKD9eCnf+6vyiTxN2rOyzyORAj6
         ovkWn/uClZkfQ+b+WW/12HOSjxdFQnD97uubprKHleafSF/Db0j7AnpiLw2TdUn65CTK
         Ya33pVrVaDzXulwmEUuNM+VhTmHaQtOzxx3HM0c7GSYx5vpAIF7TpkjOAXkz2rKEcUfz
         L0ozfnWWzFoVh9eEdQomcdUWjfOzyqFg6zK1iLv28Lgxon7kfC+r8JnIhzzn9rMOahQw
         /6kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779516484; x=1780121284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvvyRKpTVIl22LQs46Ac2u2Ct8pa8wNy+U+cdieY8pk=;
        b=jxjL0nOZgLR5e59+P9cIsEW50iibsk9mP33hpJR9mn2+djWniFoSU/ewHYA5c0etcG
         qTWLknSMcnkVWJr+Vk4kgEH3Cy69320gvyVS1zRGpnsPR2OTCqecA1InZkigD6g8oYEv
         KX6WvDJweHxDY+t7pfLOAoUI2ih2oNvPg4r2meEYbA/YvRAc3o9kYd6Zs7kCvgbWdjsk
         PZblMkvdLK1be9O5g7KnVY1H2SUQUOYtwHMmb38wz8i+rp5wpk6BFfGHDPtZofXVRq6N
         MnZPNmVBI3H6tZI8i4pfE4grhlwq+bBSt9fUOZ2Q7kP5quL2uZTl9y1JBYMuWkAZrymk
         6PkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779516484; x=1780121284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZvvyRKpTVIl22LQs46Ac2u2Ct8pa8wNy+U+cdieY8pk=;
        b=UaACJcRpebExBsa6k7R3nF9Y+sM/TPdS/fG371+s3I4BWlPegGKYjN96DSPzXaLJ8B
         mVXcaYDi0+2FXIGimaTHkNmM74cqSb0YRF4Cf5qca0telSgqWhGNy0VKP6YaKW8vlaRi
         4WBYHSKl6S3cPJlerzM2JmJCqyE5yiB4Dv2BZoyoBT+tYh9z2Dfg8kwyrkaTqEAjCX5J
         BHR5jVCfh8+xI/Vss/sLiOyz9WAs0bMs2KPsyKOeArlM9FPSARqIH3rznQ4z74jX407+
         Q4At+Svi3bnpA3VKTJWalBvLXVvi473NGeNcS7F2dUCL8aQe5OBc0BBEa+z7+vHNYPVl
         19AA==
X-Gm-Message-State: AOJu0YxuhyAkeqETeLg3Mp7DDRQ8vKvifZJZ1ZsFbtDIXPpnx6XxOOTG
	KNiDA2dTJf2dz21GWj63ObxCOIKVgJBYk3JdY450yEI8hg9x+5M1SPqvpMpX3LnMCWhV3ypt4QF
	O6d1UdSToH/YxeZO2rh563TK6rWDJy6vj07wvgnsHug==
X-Gm-Gg: Acq92OFzeE2/gLVa/NUOReNCq8VRnt19DZ3ilezK2lSpoGQHBUClYb0gzny+Corl0zo
	IWAqXvmghVmKW2k2lllxlDvo6j8w0j67NpV/sYFwTdbtIMhluHLAA8oaesrbk0TUpX7+lgMZQdK
	TwjCaWuZTDzYYjB3ifZG0x9BoZJizhma6bpQX9x6zzzuHyebB4PjJdnuGWBCO7CWj2IxwfOalO/
	l6fmOTVmeUV669O59LQOIz3BmigqKzYCwljZbeRWUmS5jlgJK6yMatUm5fBxL/tCZlSKtdiExdH
	/qWO964kG9MgbKZhpE+1VzXGgK9vkujHM9+7wISV7CRiv8grlw==
X-Received: by 2002:a17:907:3e0c:b0:bd4:d0f2:67b4 with SMTP id
 a640c23a62f3a-bdd25fdcb0cmr425830166b.34.1779516483372; Fri, 22 May 2026
 23:08:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523-realtek_forward-v7-0-313805e218f3@gmail.com>
In-Reply-To: <20260523-realtek_forward-v7-0-313805e218f3@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 23 May 2026 03:07:51 -0300
X-Gm-Features: AVHnY4LYHhplJkdAj_OX3DMX4DrrAjzAJk1gfZZiz8hcrLk3PF7mA4LhAT_5p90
Message-ID: <CAJq09z4t3pKpbBBn6U_0GDC7u2ORWTpp4fK+88T2RKLx_yYxiA@mail.gmail.com>
Subject: Re: [net-next PATCH v7 0/8] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Abdulkader Alrezej <abdulkader.alrezej@gmail.com>, Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
	Yury Norov <ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291042-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,yahoo.com,nvidia.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,msgid.link:url]
X-Rspamd-Queue-Id: E3E4A5BD642
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Changes in v7:
> * Patch 2 (DSA helpers):
>  - switch from dsa_switch_for_each_available_port() to
>    dsa_switch_for_each_port() in irq_teardown() to properly dispose
>    of unused ports' mappings.
>  - reorder the !cpu->enable check in setup() to run before chip
>    configuration.
>  - add a detailed comment explaining the limitation of the unsupported
>    cascading layout.
>  - expand the commit message to document the pre-existing IRQ handler
>    guard and the new -EINVAL probe failure mode.
> * Patch 5 (VLAN):
>  - replace br_vlan_get_pvid() with rtl8365mb_vlan_port_get_pvid(), which
>    uses the HW info directly.
>  - rename the existing internal static helper to
>    rtl8365mb_vlan_port_get_pvid_idx() to cleanly export the new PVID
>    retrieval helper.
>  - add a logical guard check in rtl8365mb_vlan_pvid_port_add() to prevent
>    accidental deletion of VLAN MC entries when reconfiguring an identical
>    PVID.
>  - removed spurious rtl8365mb_vlan.c.orig file.
> * Patch 7 (L2):
>  - clarify CPU port EFID and assisted learning comment in fdb_add().
>  - comment that EFID computation in mdb_add/del is for debugging only.
> * Patch 8 (bridge flags):
>  - added missing '\n' in rtl8365mb_port_pre_bridge_flags() dbg message.
> - Link to v6: https://patch.msgid.link/20260521-realtek_forward-v6-0-d391bbad38c3@gmail.com

Hello Jakub,

I am addressing Sashiko's reviews as soon as they come in. Patches 4
to 7 are almost entirely dedicated to answering Sashiko's comments.

In this last cycle, the Gemini model caught two or three genuine bugs,
whereas the Opus/Claude model mostly asked for clarifications and
started raising broken comments. Gemini also raised a pre-series
possible issue that I'll investigate after this series is done.

Regards,

Luiz

