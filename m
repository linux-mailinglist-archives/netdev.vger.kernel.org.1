Return-Path: <netdev+bounces-253821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOBNObafeGn4rQEAu9opvQ
	(envelope-from <netdev+bounces-253821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:21:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2896D93886
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3910C300E5CB
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87076346A08;
	Tue, 27 Jan 2026 11:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZS54qkn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB30345CA6
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 11:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769512824; cv=pass; b=KKfYMgULYNNIpv+PSMOZZbYdF3pNNiMUyEILtFwULla/3IiOxYLAsPhUl4UMNUh1E+Dhq9TS6mxhgdCNGTp2WvSlvVFAmjst0aDnl4MP9rd3EmjDKLnSPkZLr2lXPTF+D7Vg+qB5mKQ0xE0UoADtyAKi2g9ejxlgrr13gr5aEpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769512824; c=relaxed/simple;
	bh=zBNT28+4+CnkaDGfblx6EkvQYJq2NjdkCYxFII6AVWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqUs4Xb0pblxYDoRRMDhL6FXTZJ2bH00FPbHAca9ti4TypVL1pz+PRWfpGY1+SZIcCIxI+AJno5msG/T/v271wAs07bJhmZ/RX9FK4Q+DurY/+X5pfbcwEIzYKdtgwttyIltw/+JS1Tfy24OolgaOSpLUdjgIqb/CZ3N5g0NWyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZS54qkn; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59b8466b4a8so4762499e87.1
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 03:20:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769512821; cv=none;
        d=google.com; s=arc-20240605;
        b=fsmj0K1bKRh1d0fH2eLcEXHZhdL2YHihR2x71G4e8Ho/ZDkh2CZeu4rIlfEK2Tn6xn
         4kn5DWB5+7cwRh+cp0S13Sr16FFXlYxmdMcgvGHYlCrbTL5Uxk2n29E68r+HD0Bdhj5i
         5FxyX4e8gMrB+aXo1II9wSNlGcOeBuO4Wx63m8ujLYdpcA4XBWPx82wg5HjdH7FZv9zs
         D8KzUY50zSWSlJwLL5AyYnsOE3TwIRBENmD6irtqoNv2y2iomicZJGtaBtg3S14vhnBH
         mnuZ0nBa8oDSJGCpgrixNvWy9p4CgkIMLmFZY2Iaxnz0vrVNIScYoaHj7sHx04VvAcp2
         mqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6wxWMezJ9jKdszgHjUeHRsmwzkli6JK/A21xled7GWU=;
        fh=/ZWHVFZnyn7Ct9WcIfg14xgE29sKjMQj0Vrw1whU8Mo=;
        b=MPp/veUToRddTHQYAVi+5UF5tdK3fOTTVeeZqVJE6RyLUR1RVI26tgIYSOa8onIYgC
         aERKCDk3vts1CP/ma1pMfjpp6EdG5/rfYS26r6+nGyOmpnJvisizoyjIF+JspsGQrDzD
         LaoLv3WcSx2QESMuNdxV3qds70ITSK5GMe2jg0jvr9NM6+6QeWI02Pc2HAzbG08i2HOu
         6MiFWC7gjd7HPIFpadTqoPXpN1uGl2MG1IvA11rI56hdMk2GjLsWplY6eU2PZuvYR4Vo
         81Aj6MSpDjBOIg3nnzpBtTPeabOozyHT5BcbiLBoE/n9iu3pGGoF5ZScM050hOt2nb2L
         xnng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769512821; x=1770117621; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6wxWMezJ9jKdszgHjUeHRsmwzkli6JK/A21xled7GWU=;
        b=FZS54qknz8Vk8upsTnF260EVTsOoEPhlUGSEqdBpw0mYeIwzAMXKCaq4QREjPeDoPg
         UeUQ5Gpxa+8dI+uElqJk8t4s9kn3Bzo0uSFe+7zd6GvYZBL17VXBzRJoioLKBUbR4nqI
         V33Jt/z7rQV1DtUCA4jCSQrMj9r34RKaxQotEMVmJVDgorEU8n/xxcCD7x+s02gwDyBl
         3ujV22HuYG6Spo61FkTy7MGbjsX/i6SWTihFaJMrstIJujUv9s+LcsfYNLUkqPYN1EYI
         UH1Ly2z2EQvqodkUvEweaknKTVhD5jNBfYtNFh8WyoPKn0ysLxDDDeGcXpB10+JmvGmw
         xG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769512821; x=1770117621;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wxWMezJ9jKdszgHjUeHRsmwzkli6JK/A21xled7GWU=;
        b=sjewZfGT2JFdxyJWyZZM/JAwPNebKxROCZje0SH0R4j1Y/IqBXbera/xenIREgINx0
         3x0UQrKUcUQ4rXv3ojkjAy0Ho/9AVrESrnWBDtgZIqBBLnx/MaAIf16jWzN62lRgkPt9
         liz2kG6W/VReWsY7p7QWV2P2tYMv8JJ58wY39C67bSocJMhN71Nvu+0kAZQs8RHskhkj
         nqquOMzd4Hn8qi+fz/8oVubC+drTCU6Hjw2YdteUMUSDJWeFVN9L+1W+OUpPBsZ+3Yc5
         d2qyJ/V9y/5Y9wP/f4C8cc3+8qPK3lBmgruTCZ/0i5ArOsdFIwAKNJZKl7mK37kBWx1i
         4aeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjcKfQsduSqAQGGM4XtM5o+/GznMzmIL/HRfP/SLrkpeXjcemXOAJcwQyQlVm3EXHUuC6lAlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy75A+t3kHv43oS/M0Dd+c3sUe6ubiaBC7LL6X3DVnIYsOsy8N8
	xVQEy7XB0u2xjy5RmCV9ZW+kOKdc1vDSrFXTVPLEXNyNLtPMJ+ZjEK/eBiUZY8fuUxiPEp9G0tn
	g+f83SqsYbSXbNPsxzsQVsk4rQrN/lj4=
X-Gm-Gg: AZuq6aK09f/I2odsSzcHxBa5YMulDZ4ePJN8JA9gYUz47JH5nc6aJhSpQSi9eoDS2B6
	iiJ7F3s1MFMGj03AMGk23qlV0WORgv+NIRN4IPJxSE3fdnDiylnVkp0V7X7i3ptzNna3ttcOq+v
	m6qG8y4YDIPqCuUDdiribm39o3deoWKKO/o3PQzsFFeetFsLSWwmTcLr0RcUVJA1LY8pedm4iOA
	J8DTRdjETwAGrOtJ1c1APrfffTAqzLFPVQYckS86cBO3CCjdDDf81KbpDyMBJXFiiKZBGCLZfMA
	9Z9TOX2zD7c0Uut+v9yw69uzqyOPfk4ZTKsP
X-Received: by 2002:a05:6512:638c:10b0:59d:f669:c92d with SMTP id
 2adb3069b0e04-59e040241ddmr451049e87.28.1769512820779; Tue, 27 Jan 2026
 03:20:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121184621.198537-1-one-d-wide@protonmail.com> <20260121184621.198537-3-one-d-wide@protonmail.com>
In-Reply-To: <20260121184621.198537-3-one-d-wide@protonmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 27 Jan 2026 11:20:09 +0000
X-Gm-Features: AZwV_QhQ2pk9JgBKx3M3vUShc5oQiyuV6V9zGNusr8w_3L7o4lXRWgxnXx-z-o8
Message-ID: <CAD4GDZwAuX+W5e36R0sSySf9jdCw20YwiO==3CB59d4fpFdRYA@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] doc/netlink: nftables: Add definitions
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253821-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonmail.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2896D93886
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 at 18:47, Remy D. Farley <one-d-wide@protonmail.com> wrote:
>
> New enums/flags:
> - payload-base
> - range-ops
> - registers
> - numgen-types
> - log-level
> - log-flags
>
> Added missing enumerations:
> - bitwise-ops
>
> Annotated doc comment or associated enum:
> - bitwise-ops
>
> Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>
> ---
>  Documentation/netlink/specs/nftables.yaml | 157 +++++++++++++++++++++-
>  1 file changed, 154 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/netlink/specs/nftables.yaml
> index 17ad707fa..87cd4d201 100644
> --- a/Documentation/netlink/specs/nftables.yaml
> +++ b/Documentation/netlink/specs/nftables.yaml
> @@ -66,9 +66,17 @@ definitions:
>      name: bitwise-ops
>      type: enum
>      entries:
> -      - bool
> -      - lshift
> -      - rshift
> +      -
> +        name: mask-xor  # aka bool (old name)
> +        doc: >-
> +          mask-and-xor operation used to implement NOT, AND, OR and XOR boolean
> +          operations
> +      # Spinx docutils display warning when interleaving attrsets with strings

No need for the comment here. Better to explain the refactor in the
patch description

> +      - name: lshift
> +      - name: rshift
> +      - name: and
> +      - name: or
> +      - name: xor

I'd prefer to see the list marker and attribute on separate lines, we
only use the compact format for pure lists of names.

>    -
>      name: cmp-ops
>      type: enum
> @@ -132,6 +140,12 @@ definitions:
>        - object
>        - concat
>        - expr
> +  -
> +    name: set-elem-flags
> +    type: flags
> +    entries:
> +      - interval-end
> +      - catchall
>    -
>      name: lookup-flags
>      type: flags
> @@ -225,6 +239,127 @@ definitions:
>        - icmp-unreach
>        - tcp-rst
>        - icmpx-unreach
> +  -
> +    name: reject-inet-code
> +    doc: These codes are mapped to real ICMP and ICMPv6 codes.
> +    type: enum
> +    entries:
> +      - icmpx-no-route
> +      - icmpx-port-unreach
> +      - icmpx-host-unreach
> +      - icmpx-admin-prohibited
> +  -
> +    name: payload-base
> +    type: enum
> +    entries:
> +      - link-layer-header
> +      - network-header
> +      - transport-header
> +      - inner-header
> +      - tun-header
> +  -
> +    name: range-ops
> +    doc: Range operator
> +    type: enum
> +    entries:
> +      - eq
> +      - neq
> +  -
> +    name: registers
> +    doc: |
> +      nf_tables registers.
> +      nf_tables used to have five registers: a verdict register and four data
> +      registers of size 16. The data registers have been changed to 16 registers
> +      of size 4. For compatibility reasons, the NFT_REG_[1-4] registers still
> +      map to areas of size 16, the 4 byte registers are addressed using
> +      NFT_REG32_00 - NFT_REG32_15.
> +    type: enum
> +    entries:
> +      # Spinx docutils display warning when interleaving attrsets and strings

Same here, please remove sphinx comment and use the preferred list formatting.

> +      - name: reg-verdict
> +      - name: reg-1
> +      - name: reg-2
> +      - name: reg-3
> +      - name: reg-4
> +      - name: reg32-00
> +        value: 8
> +      - name: reg32-01
> +      - name: reg32-02
> +      - name: reg32-03
> +      - name: reg32-04
> +      - name: reg32-05
> +      - name: reg32-06
> +      - name: reg32-07
> +      - name: reg32-08
> +      - name: reg32-09
> +      - name: reg32-10
> +      - name: reg32-11
> +      - name: reg32-12
> +      - name: reg32-13
> +      - name: reg32-14
> +      - name: reg32-15

