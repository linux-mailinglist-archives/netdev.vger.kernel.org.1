Return-Path: <netdev+bounces-298568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jjqHIRDYK2reGAQAu9opvQ
	(envelope-from <netdev+bounces-298568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:57:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6656787F1
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:57:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298568-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298568-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CB43308A5CD
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD01339844;
	Fri, 12 Jun 2026 09:52:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0806C313E24
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:52:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257977; cv=none; b=Ay50PgB2Tbgw93VtR3IBlU4rnpMfGi0RHKal6ajIG3LK2WiMUVY7vZGbXGkKRZpjZCVzEQJR+RkGcL9TcedI/hUgo4Un25it29Vsep5EKCsZLHugB+nrRPT6Ss1VoUbpGY/Svg67Y3t25izDGm3GZlsQRfZa4NsZuCvw5Lwp5RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257977; c=relaxed/simple;
	bh=TsdwKdc9yokgTj1o1KWL7wDregVHwkh9wLKY74tlLjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLg3ommgH5UO0mypLDSsVzrS0jyUYtbemu26XGCLPr/BlfuSOg+aAxiAICtP5i8u1J9uEXER3OC/dL1hFUJgxJGg3D7+TLFqZm9CxyF+PAXxk9GG6Hyu3dmuHKIdn4gwMEMOgFEFHdxXHzdG3tYWvGxR3CiMm5rs0Wij7Gj7YuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-59d07df448bso489421e0c.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781257975; x=1781862775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ekw+Oevfx6i4xq0d1g4dLAXWaWK/4ZFI+zNuRgMbC8=;
        b=PTSUaKvKZGHkcx0F5qlN1mlrBkg5VFFdRbv9PLGvdeLYkjdbx2JT4DnXyWuNK9uvPm
         E95MK1S03cpSCgeWO80A0Ct9wp1dYjJFZF1D+NY3AZAbebjcu0g1RI6gBuvoulZ+9CMf
         9AkMU7OYh07XIk8FYrw7LfJxlJaIvDkPFwQSsnwBTsDy7l8upDr+Q4MD8VkSwo5Nj8q1
         WKAr0ZC6pND31gLJaha8FA7ZQQjw1uk+MryDzROMoAaUcIOi3Ckdj2zkGeatO3I/ttWA
         o2HT2pMGlTDOu2aO1sd6pxWMkQFrtpM/vGiK3kvB0JAAm/F6Uz77dQ0cnSAT/0n4suF6
         UChw==
X-Forwarded-Encrypted: i=1; AFNElJ8DIPluQq0SFw49T+KvX6NVsmG3dz/CaOG3XZUX07WSVLDXvOi8qmpak83nHBKyWL3hP18elbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQMCq/1gmRSteGmI3G6wf4Eq7gT8KA5/r2nNdqtqj7/20Gv4mE
	jpCxP43/HeWbpZjVaLjCjSJWnKB3Co/R8oGFaGLyfHyoFN7Z1/7Etv8FU+H+Jy+R
X-Gm-Gg: Acq92OFHooPKZHILZaGnSvvNtf7VEc/cGjgODjepZLhN4t1xVJYTq+AJkbZ6pG+zLpo
	8IUx4kihm8kXUsTYrkGStQIwrTR5HY+ajGO1KMW6wgF2BIkVY6jHCG2uzXwcLroH3QFR9PCNthX
	199GJ/a2c60gcgsuKn5ocMxD9gnAa5BZV5IR9aBKbBz7ZtuBiIJ7Lv9StPuYVttw9wtSfLC8bSC
	lYXVGYSWF3onNHBufTfhNJmfGal0wvpsga53FAj2yauH0VQLpVJLI3X6bx1VcoaMjF+WUJfrW3A
	vo73daOeCoWHmxNSXMOiFWeycfe6JcgRTqPLFNK+c611iDe+wBfXU7r+82BqGViOAJAImSJYpV+
	qMlO7QYaSpUs2sLPS1hoDltsI85nRgTzUUPdIE877uQ4RL449ekQ/ni4n/G1ayhaup6gtfG8hX+
	PPSTUBjMwsE0Yr2r6ReeY1l8iAP4V7OecKac89O7+d40HkBLKLlQyrJGXO8l27
X-Received: by 2002:a05:6122:d09:b0:5a3:da51:daa3 with SMTP id 71dfb90a1353d-5bb6bfe6582mr854693e0c.1.1781257974867;
        Fri, 12 Jun 2026 02:52:54 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb68fc4d73sm2001769e0c.4.2026.06.12.02.52.54
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 02:52:54 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-6cfb0a137c9so437681137.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:52:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+KflUpBaTsOfzd2jnv8z8Umx9y/qmA231E1FLooYo3fXU4TKIGwdH+A/rEbw34NjPlWgjBUb0=@vger.kernel.org
X-Received: by 2002:a05:6102:1527:b0:6ef:db57:d472 with SMTP id
 ada2fe7eead31-71e88fce218mr844922137.27.1781257480541; Fri, 12 Jun 2026
 02:44:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612092851.2141782-1-niklas.soderlund+renesas@ragnatech.se> <20260612092851.2141782-4-niklas.soderlund+renesas@ragnatech.se>
In-Reply-To: <20260612092851.2141782-4-niklas.soderlund+renesas@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Jun 2026 11:44:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXq59znV1uatwVyszTh5PjR96Ay3DTe=TzP9VxgKm5W_g@mail.gmail.com>
X-Gm-Features: AVVi8CeFKC4WGhTZS8WnXOfTTINM5eUjUYYQa4NqNv0sVR6at_JjsT2cJ1T43Ag
Message-ID: <CAMuHMdXq59znV1uatwVyszTh5PjR96Ay3DTe=TzP9VxgKm5W_g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] arm64: dts: renesas: r8a779g0: Add gPTP node
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "DavidS. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298568-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:niklas.soderlund+renesas@ragnatech.se,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:richardcochran@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-renesas-soc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:niklas.soderlund@ragnatech.se,m:krzk@kernel.org,m:conor@kernel.org,m:geert@glider.be,m:magnusdamm@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,glider.be,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux-m68k.org:from_mime,linux-m68k.org:email,ragnatech.se:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D6656787F1

Hi Niklas,

On Fri, 12 Jun 2026 at 11:29, Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> The gPTP module is shared between the RAVB and RTSN Ethernet devices on
> the SoC.
>
> Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.=
se>
> ---
> * Changes since v1
> - Rename node ptp.

Thanks for the update!

> --- a/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a779g0.dtsi
> @@ -603,6 +603,15 @@ tsn0: ethernet@e6460000 {
>                         status =3D "disabled";
>                 };
>
> +               gptp: ptp@e6449000 {

Please preserve sort order (by unit-address).

> +                       compatible =3D "renesas,r8a779g0-gptp", "renesas,=
rcar-gen4-gptp";
> +                       reg =3D <0 0xe6449000 0 0x500>;
> +                       clocks =3D <&cpg CPG_MOD 2723>;
> +                       power-domains =3D <&sysc R8A779G0_PD_ALWAYS_ON>;
> +                       resets =3D <&cpg 2723>;
> +                       status =3D "disabled";
> +               };
> +
>                 i2c0: i2c@e6500000 {
>                         compatible =3D "renesas,i2c-r8a779g0",
>                                      "renesas,rcar-gen4-i2c";

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

