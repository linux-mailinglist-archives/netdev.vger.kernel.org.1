Return-Path: <netdev+bounces-285137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAYYAu0F/GkpKAAAu9opvQ
	(envelope-from <netdev+bounces-285137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 05:24:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD2E4E2940
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 05:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EE2B300D16A
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 03:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEE92D0C62;
	Thu,  7 May 2026 03:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeqJqr1b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BAE1C6FF5
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 03:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778124266; cv=pass; b=tuivNNGgCd+lxasHvpjsvRnl9QWc8tln/F/OHCwy6jypiCuyZfRFe4A7a07ARxlj4h9raYjsUneEnF6dzmAnEm4GFnINYv/SOekhcE1hLtmRY5qIsKrybGEyQDy82sCYxRlEP7LLijGDeHDm49m1M9U/ZvLlXhHhtLTggSx6cro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778124266; c=relaxed/simple;
	bh=xhtkEjsWQvked7D/5ZjZKOaVudZtm2Lj2kaM1sTHzp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwUDaH+H8uVBn7QxomJqB4atl0VWvHAhsQT6LB4t8BqeemdwHxOFURG0RzpiXcr/qeAAzB5/th2rarwfNndIIGnadSVcnvnafHyVlalIOd7UGP32U+QLpx2t202tGHFOSREl+/Y4e13vDDAwFIYgfls6OXClucOwzraCdp2AIE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeqJqr1b; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b936331786dso36852966b.3
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 20:24:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778124263; cv=none;
        d=google.com; s=arc-20240605;
        b=KVP1e0czTt1bCqUEE+0Z5CNVfCYMyfjpo47rU7OugTXByu16i4Xak9HU5RoSjI9tTH
         VF0JUE45WOWDg0UtoYt8HQPtZdGuCRNUP3JMPc2onydiG7Ygylp4vDnZ3uKZZQiYqnEq
         /QjIbYsv0hoMzA6SlCI//MptZCDH6EF7sVB9EHo244OukCpglBf3LPw/N9VI+ppEAWq5
         rpFOvwYmIoKmXEy5Lp7MLHM1+SWg+VgT3C1QoIW30A7u3y4ixw27aP/m7VNjfnfuZ8UM
         efmmLbGQCkWsWEpJdTKXL8pQoijLM2g8zusM2M/oF4/AgEINaKKaQ14y/hipJFJAAM5+
         TEKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SyJU6gW4FlWMbUSkvNwEGK+wID8AKdNL6lGsIUjUEWI=;
        fh=7dXxcCTkxsqkphrKyArnf6zs55GnaKkj1qHA0O9FFZQ=;
        b=QgDvXEz3ALd03UGzn4b1GXb++ujzFPL0Xseum6meHeSiBB3I4rhK/ud62oHEgGRfrp
         BnhO343NgwplsI5lZ8Ni5rPgWWTP/XHJU188KqrqxgEcTERo9jCeomISCcQe3cTcinNB
         nM5BKEqS64VfvUxPSjoswREkxbQ3qGIOqdnmOMTJ4Dd2wVcU5blLrHq2YD5Mm/wwg8Cw
         Iesugb3Kvq+G17Ulv9aqSXlroWelkwHRE+kBPsx4I/xymw0Et5yflHqb4TrlvXLkBJ4z
         BBEM1l/SXfoRg+ktoklJ7rwA97aOQgVRDzvG9sVxujNFIH7d5aM+K0aUWALh7ZKRzyjj
         Y2fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778124263; x=1778729063; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SyJU6gW4FlWMbUSkvNwEGK+wID8AKdNL6lGsIUjUEWI=;
        b=CeqJqr1bjpMWiVgXTorGr2debjBZzUmPwoUFQBYIcM1qgyHCKphKhWAFOeyOnjltug
         fjN1sIh47+FhxsQJ8sEcuLjvMC2F3E7FWSH0JCyXhOiDeFx5vOP/bqZ5L4g0rwWj2aVN
         4PtJnrJRzKcF+GisLo/3Nx86zsPD6pYBJNJCIdrdKtrX/ontyuNgYRBC9J7HTPknpmmq
         +rX+Zx3jtngTED0vIRtiOT12Kp6Ud7TyrBoXCJ1kKNA6k/FBzbcDHm4+8Xbf2nlXr0CF
         0/qz4lDB+sb3WKJCOT4SmSJZTIQyfKExUYjo+3UAU2d9HFtmYBJ4CGmnEkQVKcHKdel8
         KQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778124263; x=1778729063;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyJU6gW4FlWMbUSkvNwEGK+wID8AKdNL6lGsIUjUEWI=;
        b=exW07zpD3QbP92Lj/pMY1KEOsFZA0fyMeHSflENw35DBlk8GOpFjAlXVHjvZpJx4dI
         7htvO0+8xjxBmWr0qHOE60prtJXFnh5q7oCAVHhqKcjzMhecxOu+ONQv2WuNyAKfpBPM
         rHrdKaBLwRSkYpQ7GPa6FZf4EZr75aMPQMiQeA+gLHQHrDe3oTCPhH2Yh1DtCZEgUwcd
         CwH1R2TSgPZwwEqUg2UzbGpAgEa3lVTz7mHEm1tmJjTcz9uryoe9txWK1K8V8x/NFgUb
         QeJBvrbCoz3s26lo7HIHI0UiOrbN9Q4dHvREUmP9kgzM4ZkvI/Wu13HuMAuIUP9/XANZ
         prxA==
X-Forwarded-Encrypted: i=1; AFNElJ8VjdgjPTo6TwF4y37rNoUfmEV9vCVnJQ7+OyVib3ezWIGTUhB8ju4MwBDixqmQfmdZu/Gd5Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA5wPVa9r3CMkfLh9CqGhC6FLNFDJ8daXLPXqwKuNQRF5Al4Wt
	80DSmf7GsQA2wbXhmN6Gf8F/7bHUwV5XGWDaVDRJ6xjq+MbtnenqwfHHWgbQ0rzsaoRH9cUPW0v
	E2jvzxgAW3fn0N1Px16Ha6NKM93N+zjc=
X-Gm-Gg: AeBDietEgfxJAGj2bzJBtUha3RiGoR4G5Q7ft3wTP4mOn4e4B1jABrJJkeCt8S/M6rR
	EdAFZ2Wsc3bMLKXDqwTjkLSxVIEUvPiN2YIVw5t/UGCaQIhwZb5RHJjbMLRCEQVn7zmU4IrGAuN
	WMQtzA+4J8fzQueI7KQFu04JkdU4pIBgmjVgnGkbrPkD3RQjfPgY88Tvybt9BHcbdzHaB6tZLvb
	DdfIqDaA7Z1rMm6BFJM1wMqJEG87rq7/wwjuvNGsAiq2Ee9JOyPFMykNA56GN97c1u+PCizUXlk
	X4hgjjx/Fmps2Now+NjIg0QPeW6DgmO5S5jLUDLuBKOYsABDYkA=
X-Received: by 2002:a17:907:7ba6:b0:bc3:d996:684f with SMTP id
 a640c23a62f3a-bc56dd129famr337839066b.42.1778124262624; Wed, 06 May 2026
 20:24:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <05921e1f-693b-4322-a762-c8f03c386a78.ref@yahoo.com> <05921e1f-693b-4322-a762-c8f03c386a78@yahoo.com>
In-Reply-To: <05921e1f-693b-4322-a762-c8f03c386a78@yahoo.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 7 May 2026 00:24:10 -0300
X-Gm-Features: AVHnY4JxNFbbLXRILKhVvgBqnP3BZk1Lzw9wfHFi8i55wP6YbhXakRkf976Mn14
Message-ID: <CAJq09z5Uz2Spm5yWe=742C2cxnz9gEkXkV6-ja_oDLnPh3eFCA@mail.gmail.com>
Subject: Re: [PATCH v2] net: dsa: realtek: rtl8365mb: add support for RTL8367SB
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 5BD2E4E2940
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285137-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,jsdelivr.net:url]
X-Rspamd-Action: no action

Hi Mieczyslaw,

Thanks for the patch.

> Add chip info entry for the Realtek RTL8367SB switch. This device has
> chip ID 0x6367 and version 0x0010. It exposes two external interfaces:
> port 6 supports SGMII and HSGMII, while port 7 supports MII, TMII,
> RMII and RGMII. Use the existing 8365MB-VC jam table for initialization.
>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> ---
>  drivers/net/dsa/realtek/rtl8365mb.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
> index 073f12ca8028..84d6fdb94a96 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb.c
> @@ -545,6 +545,18 @@ static const struct rtl8365mb_chip_info
>                 .jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
>         },
>         {
> +               .name = "RTL8367SB",
> +               .chip_id = 0x6367,
> +               .chip_ver = 0x0010,
> +               .extints = {
> +                       { 6, 1, PHY_INTF(SGMII) | PHY_INTF(HSGMII) },

While reviewing the port capabilities, I noticed the description for
the RTL8367SB is identical to the RTL8367S (which does not make
sense). Documentation suggests the SB variant is more versatile. The
RTL8367SB appears to be a functional union of the RTL8367RB-VB and the
RTL8367S regarding its external interfaces:

+----------------+--------------------------+--------------------------+
| Port ID in API | EXT_PORT0(GMAC1)         | EXT_PORT1(GMAC2)         |
+----------------+--------------------------+--------------------------+
| RTL8367RB-VB | MII/TMII/RMII/RGMII | MII/TMII/RMII/RGMII |
+----------------+--------------------------+--------------------------+
| RTL8367SB      | MII/TMII/RMII/RGMII      | MII/TMII/RMII/RGMII      |
|                | SGMII / High-SGMII       |                          |
+----------------+--------------------------+--------------------------+
| RTL8367S       | SGMII / High-SGMII       | MII/TMII/RMII/RGMII      |
+----------------+--------------------------+--------------------------+
Source: https://cdn.jsdelivr.net/gh/libc0607/Realtek_switch_hacking@files/Realtek_Unmanaged_Switch_ProgrammingGuide.pdf
(last page)

It seems GMAC1 (Port 6) on the RTL8367SB actually supports the
standard (T)MII/RMII/RGMII modes in addition to the SGMII/HSGMII
modes.
Could you please double-check the datasheet?

Regards,

Luiz

