Return-Path: <netdev+bounces-263614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LVBMcjap2kRkQAAu9opvQ
	(envelope-from <netdev+bounces-263614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:10:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DD51FB63B
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 08:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A933303800A
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 07:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D36364058;
	Wed,  4 Mar 2026 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0oSHNIw5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30A529B8D9
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608197; cv=pass; b=WR6PrFj1ehU6WucMj5xExd4m1UJKXGea2LzwST65PuAfPXft5lvy/T4RDhyTeCacDlxM+hHjx0Ow3MZ7PQ89P9BSsPMQ7zymF9LzaI4Tf7FXgB5VyzrJksX3XUXWY4sfQFiHOLeMonzdDBNT98QYFmoi6Lwc1pa65NIavMYMQas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608197; c=relaxed/simple;
	bh=9aL2/kk6wveGrje2Y9SInbnNrVBZ6jo1thOAGAk4kTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVDS89cE2bfTcYBWoFT+io5v8ioFG2mLimbAd+InJ3gr/MMP6TGsW1ZttDnPQy9KmuAcHiPkioxDsENWA/ghFO06kt+BIzuQ997Ak6C1OCQ4wWcbKnuz1NNdbnbVFeIQq0OEMrUkue2vEKIxSEK/thYgc1pX66l3WJnJpgqwDCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0oSHNIw5; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7986c7b8076so68764937b3.2
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 23:09:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772608196; cv=none;
        d=google.com; s=arc-20240605;
        b=hG1gpYLdOjQReLcFTUfwbKRP8gD6mGQf2WmzYGPLoeVbtb/FeuvNcGSuXxYxZpKxMZ
         YgEKj0zn6crLKJDXuN8zq2q5X2cAfmqMLbNPJM9x3/qGfyoNDA2f9Vd+VpqQxED11/Tg
         WbLWFhZUILKJRiOqM6fGx4027ybuyZaoAM2HNiJ72K+PpkOfGV7sS4Z+rxViFAZG3gZu
         X3kfBu4IcriwkA1vDmfXO8yxGcR/rkbzjbm6ZOH3dvViTSdvSRksygV320p5hVRnxFKJ
         26lq96qebDEFk4okFnbSD9XRJSBeH+og7d82qthhQS1HUUMHLS1GvA9+qWcQnSwYlWhR
         EPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PciYHB3qUUdIdKkdnd19arugmU6OZcy+BX6Eqw3xeHA=;
        fh=tMZm3QNUwI0++aXGmrnkBRO0vx96rc76hB6OKqZrD90=;
        b=C10Ua9B1UJn8FIRfBMODZTSHa++2i2ZZZIWH6QpCNnUQW5+UcciXtGaqfYBwvKkqB5
         FVoEmgT3fehPWz5NDQSZ/rKJRDru71d473OfG1jAHRL2aC26tGiyzvEd6wD+wP8wByPq
         3nGXNwtlqNV8Iwa6EAht0vYNmW+IE2AF5kHcm4fUWWItpiQWDjZxwKz1UWpFpdy4rKvr
         xLz+Ls8gmEPbqtNzxElgGY66yJEwYeb6NtGHpZCUTRRE5VObmzXxhp5DJroNg6j/c3Cs
         rIW8iKswRVwL/E7Dj3lW6UC4DLF84foGnGi4e38LlS/5xI7zdlRNvayHAbg58x32RDhk
         1hDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772608196; x=1773212996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PciYHB3qUUdIdKkdnd19arugmU6OZcy+BX6Eqw3xeHA=;
        b=0oSHNIw5mDdczBTiIIcp/IUe+XL8CuwUzGR2Ge1OoyeEm5HSVoNaf92JzSTT+cuXN6
         3w5kH5/U/xAQPJUIpBMUmgC7TqB2CRojSfr9F1TjVaElgXYrSDoJ908v7fMF5ZCPqatc
         5FJh3mrz0VxmhHulg3L4smyhYxPsRVrOSPAO4zI0zevjLr6yokbpFI+5ijC1txEEOQGD
         sfqD3T3Zm1V8nSg2ZdGThAInBl1/qS5Uv1azH8cGSgSyrLD6dy88pWlC4TSL5Izyx0qi
         /pNiC3x9JXbymdQ1yCut8qpszkE1YX4JE8/EFnoYFP1CGQisCqO4C5J7ELIQRSWRCi7V
         RLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608196; x=1773212996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PciYHB3qUUdIdKkdnd19arugmU6OZcy+BX6Eqw3xeHA=;
        b=ZpNJjlfku4vDDcbddSDXepkHzkLQ0bg77SrB/1X14ax9BFfaIbhfDR0Hz3Nr/Lqm5p
         8F95HrPoRrzXy+FrNjlt5k0XQn4zoIKRUNxdXPU8mzcE9q456NAVbeM5Pb08s0wIdeOs
         kQ2SUAfFebZi6sk1BU+cWKX69GMM1tVuJkp26iECHKPFAub1ineKapE2GDODXAXeKTSU
         Jk47a/jrPvXoUCEdiGUomUecjEzG0c662OnjsmBueSDdjgo9KD20HbSpud3/0E66OBIO
         bjpEi7AO3ooQR6G3Iq/3n2zqgJwtnNcZ2cADuPr69AzdyvrU7qZd80ezzIhci1bWcB6W
         GVCA==
X-Gm-Message-State: AOJu0Yx6UnGOjd6gUDiqznbQ/0SY85SIALH9Oyw0/WyvbgFscrUjup6t
	4S5/4Z6zn/tFIA/EKGXtpTLCWkjfscxNROXX5YVr8rsvHmYWDY1QIw12gPNJD3+wD0xFIsVNWSj
	1aFRvLFoPsx0G5bU7m7h6CTXt3O2au/gdXRj5sXYc/hAOeEYHwRZEksQh
X-Gm-Gg: ATEYQzxYizm2IE9pxv8r4MAvoYsIg8sSRfmvdVlRWraXLI6Du0wIAjiudY12c1QT6PQ
	TMmFP2w2jkMEmPVfzhLEMWKheyWtMPC3MApSNNeGz+MMW2AkUE4MeXAM4JwcisxR3wLHl4uGR8C
	bL12wD9Cw6yzfARajrfobgwg6526ez+fVS2sgqHaOJ0wOqBktd/eHQiyxWxHwdCP25LnfnGLbdG
	4kRrMSVG/BO4Nobct1pi203l4iM2frGdknFPzGiJWeCqALSvixbR7WJ+0oswRCFNrum+6bcOEUo
	fXz7vcll
X-Received: by 2002:a05:690c:18:b0:798:6401:fd1f with SMTP id
 00721157ae682-798c6baaa32mr7573867b3.14.1772608195266; Tue, 03 Mar 2026
 23:09:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228095854.391093-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260228095854.391093-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Mar 2026 08:09:44 +0100
X-Gm-Features: AaiRm53cm5a2oWE04ntfhNYdjGErRh51mlKSPD1r7UW1sHQxNNpSVVyXD2DoNyk
Message-ID: <CANn89iJ1vK4gcN5k_BcBL=NQLAQ-z+B15x3pdhTuep-SfK_19Q@mail.gmail.com>
Subject: Re: [PATCH net v1] bonding: fix type confusion in bond_setup_by_slave()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pravin B Shelar <pshelar@nicira.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 56DD51FB63B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263614-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email,shopee.com:email]
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 10:59=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.d=
ev> wrote:
>
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
>
>
> When a device (e.g. GRE tunnel) is enslaved to a bond,
> bond_setup_by_slave() directly copies the slave's header_ops to the
> bond device:
>
>     bond_dev->header_ops =3D slave_dev->header_ops;
>
> This causes a type confusion when dev_hard_header() is later called
> on the bond device. Functions like ipgre_header(), ip6gre_header(),
> vlan_dev_hard_header(), and macvlan_hard_header() all use
> netdev_priv(dev) to access their device-specific private data. When
> called with the bond device, netdev_priv() returns the bond's private
> data (struct bonding) instead of the expected type (e.g. struct
> ip_tunnel), leading to garbage values being read and kernel crashes.
>
> Fix this by introducing bond_header_ops with wrapper functions that
> delegate to the active slave's header_ops using the slave's own
> device. This ensures netdev_priv() in the slave's header functions
> always receives the correct device.
>
> The fix is placed in the bonding driver rather than individual device
> drivers, as the root cause is bond blindly inheriting header_ops from
> the slave without considering that these callbacks expect a specific
> netdev_priv() layout.
>
> The type confusion can be observed by adding a printk in
> ipgre_header() and running the following commands:
>
>     ip link add dummy0 type dummy
>     ip addr add 10.0.0.1/24 dev dummy0
>     ip link set dummy0 up
>     ip link add gre1 type gre local 10.0.0.1
>     ip link add bond1 type bond mode active-backup
>     ip link set gre1 master bond1
>     ip link set gre1 up
>     ip link set bond1 up
>     ip addr add fe80::1/64 dev bond1
>
> Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

