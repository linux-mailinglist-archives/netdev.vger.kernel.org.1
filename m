Return-Path: <netdev+bounces-259306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD5/F7+tlWl1TgIAu9opvQ
	(envelope-from <netdev+bounces-259306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 13:17:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B438C15648F
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 13:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 399DE300BC96
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 12:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1314D30F934;
	Wed, 18 Feb 2026 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP/7Yct5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B6A307AF4
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771417020; cv=pass; b=d/e8HkngGrLw3QQ7J0ArltUO7Zc6h9K/7FPD0nWn6PTqXGltOjXGa8Db1KXGv1HWk++Clk11PiczqmGx+ex0//6c6a0RVCLmGdvy/qo6ADscKSQyPQK238caIDPdYe5XC2tYayzT+JD0a5YJvPXidIQHGd3lOls3RqOgxm2uBTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771417020; c=relaxed/simple;
	bh=SArX1+E5cSCm0gQ5hso7eAU0Toteb0ofYbqtpx4nQNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GjmKp88lBnjF7Txx7BrsBFESItQOuEmBa07NyPSQyOQtOAbNpFqyETmmXI/1nn9ESpWonbnZkLNI2Furi8I+bPnfywoYfg6A5H6c2/LN8nywNhyMhUZPmX/WLzKEglEFhXCwFfXoG8nK+cIQcoGE8Z8vM2qC99PcSwF72iIWI4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VP/7Yct5; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5fae01e8893so3209435137.3
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 04:16:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771417018; cv=none;
        d=google.com; s=arc-20240605;
        b=lyNGFq/LLOKF87KdPgMJTUdl4y8G+YZbUHelh2p1DBAm7ELcMfRP7FKMIlhaT+XWkR
         l0ZkfxayGWRAhbHbo2l6vRvSSdSxhZd80DdT5CJYXg6xYoIgwnjEd1fUXwmtcYVWTACv
         zACVsrwCPkzg+IEq7Zx/QFJF0cbrYeIDpFqhbvGCmaLmoeaBRwB8ASmYZAna9SisETgU
         tjMnyGVtZjyHWd3D6CUGtUcDu4Ws0deV1zElhXZ5UDOUpKTVDZiO14+x6tbIialqeSw0
         /2ICm4XmLOk3A5yxaHVc6k/RNEvvmcgPFpPE1/KCTy9vd7lZwHwo0XTRs0VTRVd+TSp4
         4Rhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SArX1+E5cSCm0gQ5hso7eAU0Toteb0ofYbqtpx4nQNk=;
        fh=/uxP/MkxgkHAqr8YWF14kBP7AOsQPFpd/TBOHtPx9uQ=;
        b=jqAUGfH2fiteWWf14aC9xqge/eirDi6SuDNVJpHvDF3ACTWSjnrilUYmOgRXpnGE2e
         qbKa2UVfU5U2IPyOrnt1L/g2PLAkMhtE5NFTfLbTNctvty24wwDdCbkVHIluae2X7Cmt
         Rm3NNQ3NHn7KLU0GGGlgR9h/ZjymvuvuOyBs8M051MXZn9Yw91Fw/Z0KnuYvY/r3lzGe
         ANFEUI7a4rYHGi15g69VbZCZXkekfl5upV36Z+ilFaaq8rOL3f1m8XVBOuUKORc8qzrt
         1j8PAXsgy/9cTj1mXMuWlLP1m7FhoNpBAUw615jgZva1v5qIGDKm8vUQ3r7Wz2GeW23Z
         MmpA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771417018; x=1772021818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SArX1+E5cSCm0gQ5hso7eAU0Toteb0ofYbqtpx4nQNk=;
        b=VP/7Yct53Z7PyTX9syVeQ90qFV2j4sIC/TRg6tKvnPDPX324avqH75XQA6PEodMeVy
         GI3KzpdL5xYjcDfhkI/I/NxlgZ3pmGZPECwK4zo0XbW/ZNl1Y7jElGpP43FIK3LZnx/d
         X3Di+cxKq57R0godEp+ZOcjkL3+eiyNxwGLjL/RyZ6RP5gieRhmOD7zdY3U/UlXKRmuc
         qVd7+QRb6rz+QPFhBpIwg0Fw4H0FaDIaFwszQnUn3Gh9Di54BpCS74KcEwLSwrPRbpwB
         yTf6xQw8RECTJC2gvMgxUEWyOpGM4WFBd9n4qrCxhCbpQhgALY1rFmrIypmwVdRq3Udt
         HFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771417018; x=1772021818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SArX1+E5cSCm0gQ5hso7eAU0Toteb0ofYbqtpx4nQNk=;
        b=EsjD0Io2JnjUVu/dkkG4so66u8jRZFKJzZY7LNDKX7QSvMLFtlcQY6iqttjtm6aPiO
         BJFmv58w0FWXhlkizK0btIJSf6r1qYfiXJ770ZgX1AQev1YjyPG+zXfCpTzy7vU2u1Dx
         2HPEtMkmAUWUvvYamAYYj0oOC8b0dfbHuQgxl4zhYlU18A/HmUVBZi3oPih95+G2ncV4
         ikFiupPSszjPrkTnOWmncNCDiNsopaWXDHO649xest4iEArwrocuxoVqXx9hm/K97fIt
         ZxS9KZyn8ZB9k+DEA024M7SFTPak4A4yV2R6Lq2FmIV6Y2F/Zik9WJWE1s9swINYawoj
         EaLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKMEDpzB1trjKCNK5DkpU61FvY0VGMPwjlWENNHBR/ZJ/UbqcgKN1ynmqMdSZCaudMViLfTEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQega85l9PlBklpOaEeq7QvL1C/qTmGFi16IqqA0wOfic/hfQ5
	hysJT7XiGRae1/Mi2DoGgtfJulP0PmDu0FiutbaIF/L3eEREYIpR3zNKr1EmTGo5fo5yMXIYN+Z
	a/BpH/pBTkCyMqv1XlkUDCp3vq4qASJE=
X-Gm-Gg: AZuq6aLz9ttqiWqjJ70BhBda6TNOEDyt8mGNedqCDCws9J1+X7x7g4sq3AoEFu/2tvW
	qUzpdrlDgZYFl6PWoQSrPhwTv6YD2oEoTjlddYAVC5byQGucTnowPgKmJqimHinitYQvApz1hPK
	pRBH9u7fwqUFrWg39YVRA9LfJlUrzMhm2rmVsnnlFepJs11FOY9z+K43rIwy1sG633x7JW50ZoZ
	xED8nxoX5CUQ7YrMclj2+DrRdMGhGvi2T+K4V/5H+i6+0UkKMa84kBxWyTt0T7OZ8XNfTMe8qBf
	P1RMFA==
X-Received: by 2002:a05:6102:c48:b0:5fd:a537:a778 with SMTP id
 ada2fe7eead31-5fe7fb9df43mr708244137.10.1771417017377; Wed, 18 Feb 2026
 04:16:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260216174950.455244-1-seanwascoding@gmail.com>
 <20260216174950.455244-3-seanwascoding@gmail.com> <f71cdfa7-25f8-487d-b727-39ae962401a4@lunn.ch>
 <CAAb=EJWNSvTHuUX862vLmA2s1uKO0vy_x9OSZ6VXqY9X-+JNsg@mail.gmail.com>
 <00ebdd77-d6ef-48f2-a25d-8d8b3c7dc7a8@lunn.ch> <CAAb=EJXQjraL=VEod0N8Pm5tuQ5UE9UbrdxdZQ+ArKVhDUT83w@mail.gmail.com>
 <a7c960af-ad60-4aef-93ef-f79657dbe4e5@lunn.ch>
In-Reply-To: <a7c960af-ad60-4aef-93ef-f79657dbe4e5@lunn.ch>
From: Sean Chang <seanwascoding@gmail.com>
Date: Wed, 18 Feb 2026 20:16:45 +0800
X-Gm-Features: AaiRm53ZMcBrHzDJddjETwail8piAZSuVmKqHIMqT5f7GzG0oLNBR4qZAVt0IcQ
Message-ID: <CAAb=EJUSEwrYrUWGcxwn+kQXAzzFO9_VHaVxAq738PtOYEraYw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: macb: fix format-truncation warning
To: Andrew Lunn <andrew@lunn.ch>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev, 
	trond.myklebust@hammerspace.com, anna@kernel.org, netdev@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259306-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lunn.ch:email]
X-Rspamd-Queue-Id: B438C15648F
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 4:33=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > Given the other patches in there series, i have to wounder, is the
> > > diagnostic analysis correct? Or is the RISC-V toolchain buggy?
> > >
> >
> > I retry the different methods, I found that when I directly compile
> > the macb_main.c, it can trigger the same error, and I already prove
> > the different compiler will reach the same result, so it is not a bug
> > of the compiler.
> >
> > I also found that the x86_64 defconfig does not enable CONFIG_MACB
> > because it requires CONFIG_COMMON_CLK (which is also disabled by
> > default on x86), whereas the RISC-V defconfig has both enabled.
>
> arm and arm64 are much more similar to risc-v than x86. You should
> test with those compilers. However, make allmodconfig will get you the
> common clk code on x86. Most build testing is done with this
> configuration, including the netdev CI.
>

Thanks for your suggestion to use the "allmodconfig" before the build.
I running the command: "make ARCH=3Darm64 CROSS_COMPILE=3Daarch64-
linux-gnu- KCFLAGS=3D"-Wno-error" W=3D1 C=3D1 modules -j$(nproc) 2>&1
| tee build.log" and "make ARCH=3Darm CROSS_COMPILE=3Darm-linux-
gnueabihf- KCFLAGS=3D"-Wno-error" W=3D1 C=3D1 modules -j$(nproc) 2>&1
| tee build.log", it throws the same warning -> [-Wformat-truncation=3D], s=
o
It proves that even if I switch to a different platform, like arm, arm32,
x86_64, riscv64, it still shows the same warning.

Best regards,
Sean

