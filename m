Return-Path: <netdev+bounces-285124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJiYDBX++2moJgAAu9opvQ
	(envelope-from <netdev+bounces-285124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:51:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C65FE4E27A9
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 04:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C91C3007895
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 02:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7179D284B4F;
	Thu,  7 May 2026 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KI7jHEUF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2864240DFD3
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778122257; cv=pass; b=hMoJ8N/gkEmqGiAvQ8LvaOM6HGNayg/lxsL8irKJdnRFlq2BwbQyNcN6ejO+nCLYMc443Oiw20zdUTZSXuyH8qkipLaWvix1DNrLW9RLBRAZt2tXMTmQaLzbJrZsMNql/qkeB83zQ4ejumJf0W7agFmkbFsTDetj4Vh4mOiDtsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778122257; c=relaxed/simple;
	bh=qhpxZRYyTMG+ZL5ENOsnkSV3ZWRN1eAlFLAB1rwKZc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7HERnzX2ei08yCeL/Po3PixDxOLYqVXcUMqsZQdY8voAPO4CL3QjzsOytWdjV4L116TiqbkYzAq5QaE8wZsRDEt2x2NYqYlgyc+HqjO7GbBPdiAfknt25P4u0NOGznsyjezHfpBTPlc1MgQ7vkQdFxLrKrHYQawGMi/NX8mwfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KI7jHEUF; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67b6a6bd7b8so752992a12.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 19:50:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778122254; cv=none;
        d=google.com; s=arc-20240605;
        b=WbLwD9jAdRc2ZwyLzMQJo6ydtAMSF1u6vVUZ084KCUAoqXSXOR4cW/inmKpBPekWsY
         7OYZAvA2v3V1AeIuW9bxFRhkLuSzFLC/olINPHtR/36XGJcQ6iL/vJg1+mLihHeM5ui/
         JSBff/xp2Bxau2jGJjSCtF9Xuj3dL8qTRIyMbQ9BK5ZcTC7+efJjjXgag8xeqT985pL0
         ksq9gaN3gaX3M4xILmL1sYTAEtbqBLKWc16XQs36OlyVy8xb5b2263BempZ74OOC5Cod
         hPWLRqLBa7qrLWD4pIaLfXQcWKzuJ7Y08VsQnzNaylCSO6hsloAzDVnMZwY0J7sfazTm
         rCdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qhpxZRYyTMG+ZL5ENOsnkSV3ZWRN1eAlFLAB1rwKZc8=;
        fh=1R7sTamuWqjJq+NtKMMOh9hyJiD9O9el6rjq4H++q9o=;
        b=Rsc2WQe9AeAUe95S7aN4Bv+IW4g4EJ7/Q99YRmgcSL3p7yVhQhiDEg8h2+Qe1ms3L7
         428rj+IIPLWZp8f0vIvG1L1mZcrjgbZ3GC0s+5BdRPc7TYMCXkzxgYfQ3G58gNy7MERR
         HC5Gd5y2gfrUoZsDm8pgvnkLm1+qffmJuHMvNqm7wBIn8FoNiKM4+hc/ihVpBjATIP+O
         8czrbp8HiG6A+bsjsa6m1KTGkqCwMrOC97AGxez60P5KVlAX1FMdfAGemjErSKaAs5ZE
         stguQK87MORjFcEZJuHF0/eCrWM1SYZ0H1Vxix9z7dLvV8kZnaHcEJRTMg4qsiDawi/7
         cy2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778122254; x=1778727054; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qhpxZRYyTMG+ZL5ENOsnkSV3ZWRN1eAlFLAB1rwKZc8=;
        b=KI7jHEUFQo8TH99jNLBE9HZJkZ2cUYyA1Jh9+iJtgjIuIi0NYJeJlfG3D8VD38JeVq
         8uwl40tW0uh7/UNhOHlqP0NZxM3GuUPtFR8zgf1mabmchmC/Ly2jTAHHmUCMABZoEIVk
         8Fds3+rgDSrvZt32zJLx6IjTLxP97EQeDkrUH1fDdHqHjiiLU1eaCgQ6DV4UuTENNFuS
         HEwBts46gcwiyNSAYwTY+nIkIXeysBkq9QfnFXeNtbKO3gS367+hh4d/R4UhGQRH/Z0C
         obErWYYcAvNSe6cZWhrbO2rjQpxjhzSPy4yM1t8CcWU//KDenbgmTAbQ93MU2nJfxwzq
         s4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778122254; x=1778727054;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhpxZRYyTMG+ZL5ENOsnkSV3ZWRN1eAlFLAB1rwKZc8=;
        b=BnVtNYF+K5s3ViZOTTC0TBcprczqp6ZxiMOYHQi2FuFApXNygXdl5TxN1t3UZilMR1
         4uEI+uIpYInByCVxhIUtjMkojqZBu+WouRwpTn4XddRY4CRnbThhcFuLi9RZsw67zfNU
         RTCKMQB6WdEFwlqTia2zFUJTN4xXEoKXQGrGrErw7wQNbMk6iTkQHKhPBSYwsjBHYJO6
         o5UWSpPryiOz8az29waObjMf/eJRZfmR0emRZ9J0eJAi15bB8nVx5OzN9jDwbjXtYtk0
         foBaz0avp2HbAA6b2QuVFPo/8hP0do0hEJW997HNnhLddVjdK9UDfIU5GwPXdh5ZXYz3
         4t4g==
X-Forwarded-Encrypted: i=1; AFNElJ/Tl3DYqiRC5Akm/gk84EK1U/iVUs0rnBIIO+aXpX2A6210yb6q8HWgP8aQCRje9/25qtAyM10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNaNdtnKUqGjFiql1k/M2ZCYPrHgbNjfdfnFz1OCG/35RuWkga
	1BKeRC5BQauWM2+oEOvxdE4S8NPBHN8FT0q7AyH19KxCEwI4f9pt42aQ7bTL7nH/+fLO5zbu7ag
	YEQAtBkzngtaSWrOahGwYsQdv+cX+9rc=
X-Gm-Gg: AeBDievAuJkcDvL7/bYDrDLbjTYjECmReFsNazxX6xx70lzOnvcKAmapAwdf6AzTUjQ
	q/Z6Lo53SeS+Ijn2Q8qn5sjCYGvGj81+ng4ohXIWxOTCD6Tgq7Sw0uHJeAmFPc5YX3LcRhLcJwf
	pWYm7I7W8lljvpdmEWmosWNSADfYc9VlYdl9iJ/SRJxJWJiQDZPKCNjcjq11QB1upo1p3nRpt1b
	9B8jtswP3u27GO6q8bOqe0tYmcsDOz0oR0C+SxcovJLNXO4YCiuemQvnfxEP1LdUVoX5xa2SNJN
	ZDUhWkGVDZVadpxB6ZnisHyBf1W8pfA0dxaZvPJ/qZoDVZ/b8KDSfhIS7fgCDQ==
X-Received: by 2002:a05:6402:4506:b0:676:5872:c686 with SMTP id
 4fb4d7f45d1cf-67e0dbfa7cfmr459579a12.2.1778122254359; Wed, 06 May 2026
 19:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com>
 <20260503-realtek_forward-v2-7-d064e220b391@gmail.com> <20260505182712.2aa4fb3c@kernel.org>
In-Reply-To: <20260505182712.2aa4fb3c@kernel.org>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 6 May 2026 23:50:42 -0300
X-Gm-Features: AVHnY4Ll1Bt2YuomTFX6GMdF1A_dHZjOwGAbzChrYfuG5O8ssZIWqHgA3iWqxIU
Message-ID: <CAJq09z6FWt=jf5-NZRpUJTokGVc=Tcwr_N7dNh5PB2MZCviNcQ@mail.gmail.com>
Subject: Re: [net-next PATCH v2 7/8] net: dsa: realtek: rtl8365mb: add FDB support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C65FE4E27A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285124-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Action: no action

> Warning: ../drivers/net/dsa/realtek/rtl8365mb_l2.c:243 function parameter 'entry' not described in 'rtl8365mb_l2_get_next_uc'
> Warning: ../drivers/net/dsa/realtek/rtl8365mb_l2.c:243 function parameter 'entry' not described in 'rtl8365mb_l2_get_next_uc'

Thanks Jakub, sorry for that. I missed the kernel-doc check before submitting.

Regards,

Luiz

