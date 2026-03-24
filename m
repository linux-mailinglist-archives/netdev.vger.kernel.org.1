Return-Path: <netdev+bounces-271247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eB60LWnfwmmMnAQAu9opvQ
	(envelope-from <netdev+bounces-271247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:00:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1556B31B27A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CC53302206B
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FBD3659E7;
	Tue, 24 Mar 2026 18:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7eJVCTj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136F7313E2C
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 18:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774378484; cv=pass; b=X6t0/wsWD290DDXRlAowLdWg77+qtdo6ipbQNWyYRH4BX1T4WKja8CE0dcw/Jo/9uTV/e4bVKAa+rFUBwhieDSdS+eU1J903+8Jata5qjbaL5PZQhCr9eZZv9XPZiup+RKDr57QLPf460J0bMPVjAujcmrsfbJD/u/ac0M29p34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774378484; c=relaxed/simple;
	bh=lY+ctn4301wTT+oS6OVkxfxz0cNnCZRODojeVpEpqqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ju4CugzwDm0fAaS1voMNAXQzjxhRuFwBvOPkDbTd3fXi4HHRGRcuQvHqRaT/xNANgnJrSTYAkV+ZGWvU+CGeqI/2WaS4CxoFU+yGqG1HOCsuUlmbMjxRP0JUVn4r4Y2rDzQg4FldbdfvPW8GUCScJ8GD6jwMyjW/Wpms3fZgkkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7eJVCTj; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b98133bdc4bso713394666b.0
        for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 11:54:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774378481; cv=none;
        d=google.com; s=arc-20240605;
        b=i/86jqiuOz0YkSH1pW4Zel0jPY3/q0vc5Mf4ld/HU1cqrWiRUVZHMQaxkgSkZsuRgx
         xILfCcO2s9fGUY9oAlF0ao2GYPtHIuOJU4v9Lj/jQt66dFShitLeLyJFbdINA1h8peTc
         XcDH2QudU6TtYp3HfuWQXzdFZUHCUk+PiuJo1vFAG5SHktAiiRmB/kjvwg63DPuRM3xj
         6u319dw/VXVk9DP0d0UiC4dLkwfZVLonf2glqp7vpEUkY/n8Wk/nFMAZ/eS13qYmQ7JV
         ijqwjESyk3Q1h5inQuOEF5qS63zOB8b8bqm3BZS2AGpBPzSL100yKeJ++kbyJsWRVEfp
         QjGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bqDV/be7EroAJlJ120KrSa08JT+ay4tM2uCSX75Q5AU=;
        fh=8w1R61Imu3ap6ou05igOtSBT/ZZmZy7Q00hNLaHeUHo=;
        b=bBXdbwg+hjKHwa3GpXZO025A3HkiMNQ+tNYP2GFlhlszjaprWddj2otZDIrzdS+b9V
         L2ppL9F44XsLHWOwFffJXG1BeeFPRlKyfyjqWkWVbQZnR8UiZeUgyWLr6PpJPT5rUyBm
         DO8OYpji6TIkbcbonGK0VtgQExsp37wNkjYLK2oU4K9PrwqyWGoEU+wllc4lA8U2g3rp
         LLVrCryJPzHZ7JDT8n+7BkdaZ4mueHuxFa2BOW3HoX3oWz6j/Av2cFGWjbqD9yFAZua1
         EwkvVQXsRN8Qn0k5G+RicqH4WMQxNxHmHx7D5W0oZptXv4NscgMNjZ9TsS6GPlNwOw2K
         kL1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774378481; x=1774983281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bqDV/be7EroAJlJ120KrSa08JT+ay4tM2uCSX75Q5AU=;
        b=K7eJVCTjY4kNmyciFNSZLBnpikdU6hVHINCkWZrTlOluNfHNafWKTyJb+WiZX46BFQ
         YPeRKVJTDWzQcRMLEogEPe9tiDXl1LVCaDIf5mq0YbKe/SK5OBAsHMEo+svabn1SUo1i
         OxxhN35CBEtcKophZJHIXORbysqJoIy5+xJGlpA/BybAsw3gQWECcR0VmpI3esXvWUvj
         qSPU9EhLCADEyomFl8MXXCx7ca5X/mImwbEcswEoMtiUL/5YoacvAyq9tPMvoeo4y+MX
         kvO5ZIdyHGZ9tV9zf1X7hVQja7NavloMkVPV3gkD8szoyiVqWf9gMbt77L5fVIARFzLO
         0ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774378481; x=1774983281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bqDV/be7EroAJlJ120KrSa08JT+ay4tM2uCSX75Q5AU=;
        b=FgaU8gC0mCzrg3e3J1b5h82ORjfQVGUVKDC780vSmOxZ3sLoXc4gEJQCwM0+pxQcct
         qQVRXlPT09hSdhbEzSiKA9CTQlaM47VmWUu4bI8MsgspO5OkMC29U/z0jmiaIdixzad7
         icODwS7xSK5+SA0NqT6TmND0MuYeioQaKL8mvCfWcA2eEt4Fq/xNiFleJ6T6aFcCL1nf
         yxCZw5JnjTz9PVh/eGJQuYVgu8fGeSpU9YWER/M0MpbALOHBmOoQzkwDo7bgmKpWVMu7
         vsBbuHdLwd6rVl/RtjVA8pFjq1GjLmg31RHPFCbdo7k5nC9nK7HDTz2FjC/d9lycuOa/
         nfaA==
X-Gm-Message-State: AOJu0YyzZxxk7D7QTkLbX73EgOXHadt846sVPpLeOF8eAmu/ZlXAFgyX
	SGjVI0gXLSO3qCwX2XoTpORI0X/G0FYLOiWLivsHqpuRdazJ5QuxgOhg5ej4Bv5ggFqcbM4cXJe
	wa81pIhLhA+lWYH0aZLX/P5NRs6RF6II=
X-Gm-Gg: ATEYQzwgGkYtZIZ0I9wvrCjyQ4WKa8yZ7ro3LBqu2bbk6Gqg9Dz/JLBr+9mg0lH9287
	h1FkRWDcqe8IU410J6dhv/VAcoVg4OYux8OHuCBbK8zPbZZBvWF2QItwz2KZ0DWjfigj1MAdNxt
	WBXoYHJagFxLYL/dAHOdGIkleFReVojCFCOiiq9yzEo6sY0U2kZqEJKTmRVVeH9LYA2rUIhR+R/
	UZR5/+XFFVW8MlwBejBbzDdKLm5FMiBDQsdlbI53ZF2stBoJPSU3aKBROH718vV/KLv2hZ3jYxp
	oRs=
X-Received: by 2002:a17:907:7b84:b0:b98:4f24:a6d with SMTP id
 a640c23a62f3a-b9a3f15234amr46560366b.11.1774378481032; Tue, 24 Mar 2026
 11:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324152503.1522071-2-wagner.daniel.t@gmail.com> <acKypS845fm_GB0o@shell.armlinux.org.uk>
In-Reply-To: <acKypS845fm_GB0o@shell.armlinux.org.uk>
From: Daniel Wagner <wagner.daniel.t@gmail.com>
Date: Tue, 24 Mar 2026 18:54:29 +0000
X-Gm-Features: AQROBzAqKWOlFyGlIU0Iw6R65DeMUfxDZ3on858V4sCX8Ry0EhBgpUN-noV7BTY
Message-ID: <CAMsLQxFnhPT5TLmwQS14rrgD8xmgs6ymH8Q3ee1KcSqm1XEstw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: bcm84881: add BCM84891/BCM84892 support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271247-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,lunn.ch,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wagnerdanielt@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1556B31B27A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks both for the quick review.

On Tue, Mar 24, 2026 at 3:50=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
> > +     case PHY_INTERFACE_MODE_USXGMII:
>
> This also allows USXGMII for BCM84881, which it doesn't support. This is
> wrong. Does the bcm8489x support these other modes? If not, this is more
> wrong - it should be a separate function - bcm8489x_config_init().

Good point. v2 will have a separate bcm8489x_config_init() that only allows
USXGMII -- the only mode available on the hardware I have access to. I don'=
t
know whether these PHYs support other modes.

This means that since only bcm8489x_config_init() allows USXGMII, we can us=
e
the interface mode to discriminate in read_status, eliminating is_bcm8489x(=
).

> This function only gets called when the PHY is being started, resumed,
> or when the user changes the advertisement. If firmware switches to low
> power when e.g. the results of the media negotiation change, then this
> isn't the correct place to do this. When exactly does firmware set the
> PHY to low power mode?

I went back to characterize this more thoroughly and found my v1 claim abou=
t
SerDes reconfiguration was overly broad. I can substantiate:

- At boot: comes up in low power mode. Requires clearing for link.
- ifdown/ifup: does not reappear. Tested with the clear moved to
  config_init (so config_aneg no longer touches it)
- Cable unplug/replug: does not reappear.
- Link-partner advertisement changes: I used ethtool on the link partner to
  force renegotiation to different speeds. All links negotiated fine under
  config_init-only.

v2 moves the clear to bcm8489x_config_init().

> Is the PHY really using 10GBASE-R or is it using USXGMII. The two are
> different.
[...]
> Is there a code in the 0x4011 register which indicates if it uses
> USXGMII as opposed to 10GBASE-R ? Please clarify.

It's USXGMII with symbol replication. The MAC receives the negotiated coppe=
r
speed, not 10G -- phylink's mac_link_up() is called with the copper speed.
Link works at 100M/1G/2.5G with no rate_matching in the driver, which I thi=
nk
wouldn't be the case for 10GBASE-R with rate adaptation.

On 0x4011: it reads the same value (0x3107, mode=3D3) at 1G and at 2.5G cop=
per,
not tracking copper speed. There's no separate USXGMII encoding I can find =
--
mode=3D3 appears to mean "10G SerDes line rate" regardless of protocol, but
admittedly I don't have access to data sheets so this is inference.

> While the driver is called bcm84881, I'd prefer if we didn't name
> functions with the same prefix when they have nothing to do with the
> bcm84881 PHY. bcm8489x_link_change_notify() would be more suitable.
>
> ... however, this is not how we support LEDs. Please look at the PHY
> LEDs support using the generic LEDs support.

In that case let me drop LEDs from v2 for now. The hardware is a single
bicolor LED (green/amber) with speed-based color selection (vendor firmware
does 10G=3Dgreen, else amber). I don't immediately see an obvious way to ex=
press
that in the LED framework. If there's a good example to follow I'd apprecia=
te
a pointer; otherwise I'll figure it out as a follow-up.

> Why set the revision in .phy_id when you mask it off? Please use
> PHY_ID_MATCH_MODEL().

Done.

v2 follows.

Thanks,
Daniel

