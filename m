Return-Path: <netdev+bounces-162861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC72A28350
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 05:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 410891887565
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 04:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929D82139D7;
	Wed,  5 Feb 2025 04:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=montleon.com header.i=@montleon.com header.b="GzfIYBeD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-10627.protonmail.ch (mail-10627.protonmail.ch [79.135.106.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075520C00C
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 04:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738729214; cv=none; b=FtcZrfbJC18YES4UNV3shHZU3cVyU8iIObWPNdW+f99wrCn0TcP9Hz6Ez9PViqwdZpPV47yA98l5aLZBlYW6EvBgj29HyoYmUK96oG2+znCnREvQvd4Milt9wTlw5BYLBnDiNrMhiAyCTgdka6cyNQUBBqtViLyMnEKJZSSMjiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738729214; c=relaxed/simple;
	bh=diuf4Q6Qz1Ac77ejlgBsdm102NX+oVHubnbGNjCevZc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNnGXuIkA1o4reDY8hG3MFXggTZdAekcNd7YFQswoWlo6f6MGFRBYqaQFsebKvYBi1EgMrveipX+Xnj3qw1WYrKmhnlUw2kebyEtfKW/fLE9uFHpIpiMvdUkn37SypmIvnjKJJBvVYi+BesF8GM1mwv8ltXfBU2J7Jv7y5EyXYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=montleon.com; spf=pass smtp.mailfrom=montleon.com; dkim=pass (2048-bit key) header.d=montleon.com header.i=@montleon.com header.b=GzfIYBeD; arc=none smtp.client-ip=79.135.106.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=montleon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=montleon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=montleon.com;
	s=protonmail2; t=1738729202; x=1738988402;
	bh=diuf4Q6Qz1Ac77ejlgBsdm102NX+oVHubnbGNjCevZc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=GzfIYBeDbxiwtT9P9AhqKrOEQWPqebRn1RC+8DgxW3bNL98oBUItDP2SMI8zPmJOs
	 lttBADT9wC8D/updemPL6obJ2ZwiEDb5UVRFowGoNMJ/Bkg43kTnr/aGj9pM/JX6iH
	 jYR50NQOUrNTPPPIYwhj0DpIjVsxG1DAhnQdqMAW33L1s+YTobyctWGSlR5fKljGcC
	 Q11EfD/woNXYOu0WR/QFg5bcKxUsoPvgxi5Bp38RU00jgAvsrJoHNKIN2hp46yJ3kt
	 HSOHosxW+99aePWoiS9c2GKXvueQwivAkfsvL4SWM54G4xIbPuf0R65Wu2pmHIXY4E
	 BBQ/hCRveLeNg==
Date: Wed, 05 Feb 2025 04:19:58 +0000
To: Domenico Andreoli <domenico.andreoli@linux.com>
From: Jason Montleon <jason@montleon.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "hayashi.kunihiko@socionext.com" <hayashi.kunihiko@socionext.com>, "si.yanteng@linux.dev" <si.yanteng@linux.dev>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [REGRESSION,6.14.0-rc1]: rk_gmac-dwmac: no ethernet device shows up (NanoPi M4)
Message-ID: <INKEBRCGF47MsjO5WHpLcf1OTcQHw2KG6_Ez-K9QiTwAnb4MRVErnxoUT1euX_o9oRrxUILDRDvlOZ7ezguCU4maUyvkk-UqU52l6xLsF8U=@montleon.com>
In-Reply-To: <Z6CfoZtq7CBgc393@localhost>
References: <Z6CfoZtq7CBgc393@localhost>
Feedback-ID: 31263673:user:proton
X-Pm-Message-ID: 91cf9ed08671796c68fcff7b4943b9d063c50cc0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, February 3rd, 2025 at 5:51 AM, Domenico Andreoli <domenico.andre=
oli@linux.com> wrote:

>
>
> Hi,
>
> This morning I tried 6.14.0-rc1 on my NanoPi M4, the ethernet does not
> show up.

I am experiencing similar behavior on the Lichee Pi 4A with thead-dwmac. It=
 works fine on 6.12.12 and 6.13.1, but with 6.14-rc1 I don't see these last=
 several lines of output as in your case. I did also see the same new error=
:
+stmmaceth ffe7070000.ethernet: Can't specify Rx FIFO size

It looks like this message was introduced in the following commit and if I =
build with it reverted my ethernet interfaces work again.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/net/ethernet/stmicro?h=3Dv6.14-rc1&id=3D8865d22656b442b8d0fb019e6acb=
2292b99a9c3c

Thanks,
Jason

> This is the diff of the output of `dmesg | grep rk_gmac-dwmac` on 6.13.0
> and 6.14.0-rc1:
>
> --- m4.ok.log 2025-02-03 11:37:03.991757775 +0100
> +++ m4.nok.log 2025-02-03 11:37:17.249455484 +0100
> @@ -15,4 +15,13 @@
> rk_gmac-dwmac fe300000.ethernet: COE Type 2
> rk_gmac-dwmac fe300000.ethernet: TX Checksum insertion supported
> rk_gmac-dwmac fe300000.ethernet: Wake-Up On Lan supported
> -rk_gmac-dwmac fe300000.ethernet: Normal descriptors
> -rk_gmac-dwmac fe300000.ethernet: Ring mode enabled
> -rk_gmac-dwmac fe300000.ethernet: Enable RX Mitigation via HW Watchdog Ti=
mer
> -rk_gmac-dwmac fe300000.ethernet end0: renamed from eth0
> -rk_gmac-dwmac fe300000.ethernet end0: Register MEM_TYPE_PAGE_POOL RxQ-0
> -rk_gmac-dwmac fe300000.ethernet end0: PHY [stmmac-0:01] driver [Generic =
PHY] (irq=3DPOLL)
> -rk_gmac-dwmac fe300000.ethernet end0: No Safety Features support found
> -rk_gmac-dwmac fe300000.ethernet end0: PTP not supported by HW
> -rk_gmac-dwmac fe300000.ethernet end0: configuring for phy/rgmii link mod=
e
> -rk_gmac-dwmac fe300000.ethernet end0: Link is Up - 1Gbps/Full - flow con=
trol rx/tx
> +rk_gmac-dwmac fe300000.ethernet: Can't specify Rx FIFO size
>
> The configration was updated with `make olddefconfig`, as usual. I
> could not find any new option that I might need to enable, if that is
> what went wrong.
>
> Is there anything I can do to help diagnose this?
>
> Thanks,
> Dom


