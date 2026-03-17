Return-Path: <netdev+bounces-268676-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNLaK7R+uWmxHAIAu9opvQ
	(envelope-from <netdev+bounces-268676-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:17:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BC92ADC81
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A1C43047F87
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1871E32CF;
	Tue, 17 Mar 2026 16:15:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E462D63E5
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764133; cv=none; b=Td0arW6IpIoH4BiPvvF8Lbkwy4yATa5bh8wHBiTUbhv1sT23/rkRxmzm4h78777CY0ANI8R4095s73uXhv4gpvsPDIyA1yfM8ZO71XvAIDE598VtDarquH/j5TBK8eul1cYcZkhzp7mATkqFpC8Mu4uPN++Kfqi+s+5PaB10MsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764133; c=relaxed/simple;
	bh=JpuNcXAUnz9p4OJygOPh4/7FUlRl3uj4sIh8x/TCmn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RebeA+KNR4W2Zq7Isg5XdFB1Mhqs39VDWJ+mYlXHgc6nKPoEdPCQ2OezB3C4XYbbDlPOonPBvDQtItaxl7jv7ToB8YHZPBhrut5m5jM2rXfq97PmPA0VM4sb5869vCkKTi11tQ/AQGvUlvjz0AVJQsRV4KirCdB+Ieqtay5yk9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56a8fdaddebso2174098e0c.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 09:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773764131; x=1774368931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dICWkMmyuTmNF364Pzh8uUC2Sv1l+UoGtlNAuC5g+WY=;
        b=mjJ0BCldrnsc2hMcFigLc4iUHhWqp+wVt5A5T67KzpKUY5TvswqPRcgBeuz2xBVyG2
         PkFy1bkMVxZCHiF+8EUjwwjR+Ofx0ZU6qwWKmPrTcNjxr2dYpWyyJgKRItYHedpN91bw
         UrZLr7q0WQ50NuC3ODbIJyBcYzfcjC5RWmrKzumtTs4rgw0yS/ExYTPfknfAiNBornXW
         55KywiJEJKGCm4e1zOt+Egu74iwRlsYOVh+tMElpbNhN26PxDx+JaU7RqcFHepjnsuNf
         gKzMFGFd3XtAvRbur2mJx8uXs4YQEPVpR5BqPifQQ9+w/6JNmhLM+GFBpKv9vo8lLv+U
         xHXA==
X-Forwarded-Encrypted: i=1; AJvYcCVBV7tqbhPE8hAvkRi+bd9SQ+/FRTEzPkwI2pyXlySfG+bO52mJ3YytXuZ6Oqy991avLzV1Mjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9iasRcFLn198+FPUcrcGGtxJ0C7X3NBz222mc8wyXNy/Z78NE
	KYvNwcketxFzylZolzQmK5apRzHVgvhMpDjouTVHek4Owb+edP8KgZhKihhYSQ8men4=
X-Gm-Gg: ATEYQzwptccj7AS3hqVpbvwQJfSwDvD3lgbHoFEYzrCHuq9VBEntyQAffjDGATp5j0m
	21aTR/Pa3IxTeZFqqMeQ8NSNsQpNgNjG+DoJym5SLMhjshorinkg0yr/RVgedhL094QexENLMWB
	s0STA0Lo3oawNMDKxKqzFu6QZhg6G1M7PS+nAK1UCJa9T3ZNstnIQxkGay2pXnSP3tMhZyqzMoy
	lNqydgStMLggwnM9I+1TFV5oe28Xc25sYetFPqIn484CM4PxsjLb/dh1mauN0Fq0sV22FEHgDO9
	PvfpytqE4e13xUKpLC6vex34WqYetskhOQuANAaG4/s6tCaBUFziz8ASMMzSOahSuX5YpQ9Q54o
	dCIHbKxqmnBC34pDHRroB6hvKB2g7w8GbO3bYapsxNSUWt6AALX6Y12XU9WWS0hW09MSajP5d0I
	U49Ik1f6a0Qr8ShKFD6Hov1mPwxQwIqULORLITXYqMxhJfS9tipB7K/Bqc7FBP
X-Received: by 2002:a05:6122:6e04:b0:56a:897b:8344 with SMTP id 71dfb90a1353d-56ba71e2a10mr144515e0c.17.1773764131541;
        Tue, 17 Mar 2026 09:15:31 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56ba7069460sm144359e0c.16.2026.03.17.09.15.26
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 09:15:27 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-94de664b541so1604875241.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 09:15:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTZCPfxEn7G7CyCyxR1fNQILHg7bHctjLZ85d3ZPbDIeAFr2ieBQX4YmZKxjrGPDBLO/gQ3Aw=@vger.kernel.org
X-Received: by 2002:a05:6102:358d:b0:5ff:2426:94ed with SMTP id
 ada2fe7eead31-6027d3bc90bmr139185137.28.1773764126619; Tue, 17 Mar 2026
 09:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317-rswitch_add_vlans-v1-0-3a57bfa0f2d1@renesas.com> <20260317-rswitch_add_vlans-v1-6-3a57bfa0f2d1@renesas.com>
In-Reply-To: <20260317-rswitch_add_vlans-v1-6-3a57bfa0f2d1@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Mar 2026 17:15:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXKthoDYtNKimB6S8m+ukWQVMEOuLbZFkWrwqre4c1V5A@mail.gmail.com>
X-Gm-Features: AaiRm537AkTROl3nLdQemkDiRiXSF3TuQr0OjAH_I1sZc0Qa1zvlHweun1p94TQ
Message-ID: <CAMuHMdXKthoDYtNKimB6S8m+ukWQVMEOuLbZFkWrwqre4c1V5A@mail.gmail.com>
Subject: Re: [PATCH net-next 06/13] net: renesas: rswitch: add forwarding
 rules for gwca
To: Michael Dege <michael.dege@renesas.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	TAGGED_FROM(0.00)[bounces-268676-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.920];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-m68k.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: 30BC92ADC81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michael,

On Tue, 17 Mar 2026 at 10:45, Michael Dege <michael.dege@renesas.com> wrote:
> Add rules to forward packets from the Ethernet ports to the CPU port (GWCA)
> using L2 forwarding instead of port forwarding.
>
> Signed-off-by: Michael Dege <michael.dege@renesas.com>

Thanks for your patch!

> --- a/drivers/net/ethernet/renesas/rswitch_l2.c
> +++ b/drivers/net/ethernet/renesas/rswitch_l2.c
> @@ -93,10 +93,36 @@ static void rswitch_update_l2_hw_forwarding(struct rswitch_private *priv)
>         }
>  }
>
> +static void rswitch_update_l2_hw_forwarding_gwca(struct rswitch_private *priv)
> +{
> +       struct rswitch_device *rdev;
> +
> +       if (priv->offload_brdev) {
> +               rswitch_modify(priv->addr, FWPC0(AGENT_INDEX_GWCA),
> +                              0, FWPC0_MACSSA | FWPC0_MACDSA | FWPC0_MACRUDA);
> +
> +               rswitch_for_all_ports(priv, rdev) {
> +                       rswitch_modify(priv->addr, FWPC2(rdev->etha->index),
> +                                      FIELD_PREP(FWPC2_LTWFW, BIT(AGENT_INDEX_GWCA)),
> +                                      0);
> +               }
> +       } else {
> +               rswitch_modify(priv->addr, FWPC0(AGENT_INDEX_GWCA),
> +                              FWPC0_MACSSA | FWPC0_MACDSA | FWPC0_MACRUDA,
> +                              0);
> +               rswitch_for_all_ports(priv, rdev) {
> +                       rswitch_modify(priv->addr, FWPC2(rdev->etha->index),
> +                                      0,
> +                                      FIELD_PREP(FWPC2_LTWFW, BIT(AGENT_INDEX_GWCA)));
> +               }
> +       }
> +}

This looks a bit hard to read: are the bitfield values in the two
branches the same or not?

I came up with the following, which avoids duplication of the field values,
and of the control logic, but I am still not 100% happy with it:

    u32 fwpc0_clr, fwpc0_set, fwpc2_clr, fwpc2_set;

    fwpc0_clr = fwpc0_set = FWPC0_MACSSA | FWPC0_MACDSA | FWPC0_MACRUDA;
    fwpc2_clr = fwpc2_set = FIELD_PREP(FWPC2_LTWFW, BIT(AGENT_INDEX_GWCA);
    if (priv->offload_brdev) {
            fwpc0_clr = fwpc2_set = 0;
    } else {
            fwpc0_set = fwpc2_clr = 0;
    }

    rswitch_modify(priv->addr, FWPC0(AGENT_INDEX_GWCA), fwpc0_clr, fwpc0_set);

    rswitch_for_all_ports(priv, rdev) {
            rswitch_modify(priv->addr, FWPC2(rdev->etha->index), fwpc2_clr,
                           fwpc2_set);
    }

Can this be improved?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

