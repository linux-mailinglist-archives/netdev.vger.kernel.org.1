Return-Path: <netdev+bounces-285215-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLShLLdh/GkZPgAAu9opvQ
	(envelope-from <netdev+bounces-285215-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:56:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B634E6521
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 11:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57A423036385
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 09:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F123AA4F3;
	Thu,  7 May 2026 09:52:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A2D3164A1
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147544; cv=none; b=ipg5eZ5QvIAzxLfgC4HDJNlD1UtvARDCptysW7KDrg37GJXJNMakC9THiF9UuoxYYK+IhYDC7OUIWdQb2Bv17gwZ7S+5/dxDj5ppYgDR8FpMj7M9Sm7SH9jnChWWd3bpxBaZHIH0nLqx3M4lHSRw6blRk9vaHs1miv5/lpszs9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147544; c=relaxed/simple;
	bh=eJ/srp9zrosiZKPztLc0t3HXPykDKM0ecqir8ctUaFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/Yg5993wWSHm5obuwRtStJjWHJXI4xdteNWbtcIhYRYICTV1V5cueuJYvPRQHxikNDp6eLJIsi4kjL7/gycxbWKNWAH/2vxi79MiP2CO5dRtGRo8eFhrATyoPlwcvStFsp9cHXudm1tCljvZqwtK8yQJIcM/Y5OtlOAQPCORaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56a8e0ea02aso631949e0c.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 02:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778147542; x=1778752342;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bhar/UK+XkT5Dhu83HpcF1mBIkuaB73W2rNiIRK9TU=;
        b=qAMoZ9GtPerTEaiwTFUL0DSVPJVBP+uKmKZu74FP/TzyptmqVojulA0yswRvNb6VHt
         kzsFrResUUxWvrxQHnF7+h+FuzQ6l7OfbimYSCWuu3jcu8UnU2b/TsCpayaO+uGeIGDb
         KV2xsox+3Ce1Ci72QppJbNnYGYhr+IrkMuDOxYHpM1jPw+SZc0De2aKHBXda3buZ/t5o
         JYWll7YDJ/coQCSLRP46In9027qTVDspOM2+Ye51Os7r9EGImgh5d+Zg+gjsrcb2TQNf
         PHCS/UaSff6XI8Q+1DXUjAzvKZ8N1fqkyy/4XdX6A8dSVX5KKJO6FNxfZdELOgfL7uSW
         gU/w==
X-Forwarded-Encrypted: i=1; AFNElJ/i5bDRio746VP8XKxaH2/AIeW8JX6mYjRP/Q3KAthGNJ2Ck/xralkkkiKAZcMPN/GtfDWGW4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM94ARYq1HBI4Y6/FQv2t67LRJKs/i7R7tzuTQiQm49kX/1OiO
	s3BqEkNI92PD9SjaCfzolkDMckpfyUjqRmvXKENL9NbjYP6lnccfqU3X/+b8Re7X76g=
X-Gm-Gg: AeBDieuFDcrXk+hBMJnu174gXkBds0iVDp0zVuHtKxyUGzF41GtquQ4Ly6gtjplTJjS
	mTt7R/au3SW1qLlSME/n8UgxNsyvy5fFeFdVpGaQ5zJz0aZDpKIW7ViZBez9bVhDXk43wIeoIUU
	x3eNcsv9wE1AFCbNR8YZhlXD1n1z49Md7EdmQOD27lchF8uzl+MwqZx97I1RYoKXKMs2u+RCNMx
	W9QkdBBVpCWWT0F3oUIAVc4thbTRwZKU7GScNXMO/qXFab54qNif2SrhhU9x8S0EQFXGPFwr9sh
	BD3aeN/rahtqA6k9y1VfU6TYO3h4ynLcjf0qckARCCyHjqJfHwEsMmwDOZ50ciJ61YYos75drvc
	EP00rCQl8qoC65EywCFpl5ylX/DAr00ayB+BbslKbVfh4nFh8a4Xf7soT4io9IGLj0J3G8CKEeM
	APrexQOvGR0Q+nRY65rQWKItkOtn/1gJi3Q4CoBQB097hG72luYPNDEIPXkRs18rSrE00m4jymE
	/onhhbf7g==
X-Received: by 2002:a05:6122:6087:b0:575:178f:62d2 with SMTP id 71dfb90a1353d-575596a768cmr4172916e0c.14.1778147541754;
        Thu, 07 May 2026 02:52:21 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-575585f72c1sm3635332e0c.12.2026.05.07.02.52.21
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 02:52:21 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-62dd2fa4a16so380669137.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 02:52:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ85P7//9aeOhuvo6R50NsTStOBohk6tQtfHUaEceiQsy1xMp5RUASiWtAPcTFMrjO83C7G4SEE=@vger.kernel.org
X-Received: by 2002:a05:6102:374c:b0:612:164e:ab02 with SMTP id
 ada2fe7eead31-630f8e75bc6mr3667660137.5.1778147540890; Thu, 07 May 2026
 02:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326111953.31024-1-biju.das.jz@bp.renesas.com> <20260326111953.31024-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260326111953.31024-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 May 2026 11:52:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU8S6pOxodK-LRWfU9NJhD5is5T-=cxA-K-cohqAyefAQ@mail.gmail.com>
X-Gm-Features: AVHnY4KKrk-p0LtIDnyA7jlpV5cLB8liuCJjfvbTpNoJ0gGv-_9HWUuGQzK5SBg
Message-ID: <CAMuHMdU8S6pOxodK-LRWfU9NJhD5is5T-=cxA-K-cohqAyefAQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: renesas: r9a08g046: Add GBETH nodes
To: Biju <biju.das.au@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 17B634E6521
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285215-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,bp.renesas.com,vger.kernel.org];
	DMARC_NA(0.00)[linux-m68k.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,linux-m68k.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,glider.be:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, 26 Mar 2026 at 12:19, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Renesas RZ/G3L SoC is equipped with 2x Synopsys DesignWare Ethernet
> (10/100/1000 BASE) with TSN, IP block version 5.30. Add GBETH nodes
> to R9A08G046 RZ/G3L SoC DTSI.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v2->v3:
>  * Rebased to boot series.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v7.2.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

