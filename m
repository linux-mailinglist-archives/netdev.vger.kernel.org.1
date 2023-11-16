Return-Path: <netdev+bounces-48358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE89E7EE252
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD76280F69
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A712C857;
	Thu, 16 Nov 2023 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F60812F;
	Thu, 16 Nov 2023 06:06:23 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5bf58204b7aso8754877b3.3;
        Thu, 16 Nov 2023 06:06:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700143582; x=1700748382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEPUom4+S9HspVdedIGhs90OWgXiSLz4bkpRQsQLtVY=;
        b=wDh2W52UAmJq+OUeg+wgykBKBLCJ6TFf8qd9xkhwdZY9z/mQwWuDJ2x6ZHVlYNDnNs
         eT/b0Hr2M5G88EHfFu90hhnexRQFATpv6yfoTJB4L7jqe4oR4bGR8vAKmtXCO6rMzEUL
         r3bVXjJUTaGr1Qgc/tr0443X4PAV+la4P0rLM47VWgaFBse8c4rGM7Resyh2rGmTDVBd
         G+b9Ihjxv4v0fx1YNihjtSfm46bb/ZQe23bFnNShYdkEFzqsysLwM5NFzBD3apqfd+Rg
         Dd3o8ZxhMn3HxLLLO5GX9FVDgAb43jtfSxCO3S1qPDYY5Ga2jHBAJQ1/yIyfFqXLrq74
         C+Hw==
X-Gm-Message-State: AOJu0Yw6B5ZYgRZOxo58U13j+7nIGM1JilOaiS0kQkWSoq+rO22drzds
	hE6WxjqP45Akz8YaGxxCiN7a3AlQhl+BCg==
X-Google-Smtp-Source: AGHT+IF8wudKwS97Tv3Klxmzo1yEYk5N+m59Gv7vf8mWO/WQc/WreLLot09iHG/ZwbggQDA2Ut6K6A==
X-Received: by 2002:a05:690c:368f:b0:5a7:a817:be43 with SMTP id fu15-20020a05690c368f00b005a7a817be43mr4875432ywb.6.1700143581817;
        Thu, 16 Nov 2023 06:06:21 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id i12-20020a81d50c000000b005af5bb5e840sm1005405ywj.34.2023.11.16.06.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 06:06:21 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5c516f92759so8768687b3.2;
        Thu, 16 Nov 2023 06:06:21 -0800 (PST)
X-Received: by 2002:a81:6c41:0:b0:5af:a73f:53d3 with SMTP id
 h62-20020a816c41000000b005afa73f53d3mr16703732ywc.13.1700143581293; Thu, 16
 Nov 2023 06:06:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115210448.31575-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231115210448.31575-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Nov 2023 15:06:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXRyvQ+z7O7wZ5U5y+1OcPWwzL0f1EYu1vuC67p=mBwWg@mail.gmail.com>
Message-ID: <CAMuHMdXRyvQ+z7O7wZ5U5y+1OcPWwzL0f1EYu1vuC67p=mBwWg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: net: renesas,etheravb: Document RZ/Five SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Sergei Shtylyov <sergei.shtylyov@gmail.com>, 
	Magnus Damm <magnus.damm@gmail.com>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 10:05=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The Gigabit Ethernet IP block on the RZ/Five SoC is identical to one
> found on the RZ/G2UL SoC. "renesas,r9a07g043-gbeth" compatible string
> will be used on the RZ/Five SoC so to make this clear and to keep this
> file consistent, update the comment to include RZ/Five SoC.
>
> No driver changes are required as generic compatible string
> "renesas,rzg2l-gbeth" will be used as a fallback on RZ/Five SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

