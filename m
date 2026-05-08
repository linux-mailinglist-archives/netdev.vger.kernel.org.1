Return-Path: <netdev+bounces-285718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAssDLic/WmwgQAAu9opvQ
	(envelope-from <netdev+bounces-285718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 10:20:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3244F39D5
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 10:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B1003008A4C
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 08:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369C83750DC;
	Fri,  8 May 2026 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=friendlyarm-com.20251104.gappssmtp.com header.i=@friendlyarm-com.20251104.gappssmtp.com header.b="LdiVjH4c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7EC3815EC
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778228378; cv=pass; b=bj2h7SxEGOOLEhFDANsuPgck8pFJJsh5chd1waEyTvddBX24/vAHmGqF1mrU2tpujQLJvsSe6Qg1r0DuSD0kFIWTXBDllMLXrRhN5TOtKONRHjMJHzBN8dHZYDAFgQAJlkYb6GGKBo23FPiV7TRZp8JfeXtrtoh3cRJvl8n6Jw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778228378; c=relaxed/simple;
	bh=TMyLLMSJpHwje7SvPMIjeLCmiLHP9pMOUENT799WEWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDJA3+sAb7VPmKTwMq5pssChqHI0gYL9M8jtoYX1rqgNrp9yZRRvOWciJj9c0NobeFVeyFQJXoG4QsObvYZu9I08nU+P3Ek6V23J5KkdXsxEiD2JMHxlt0ho0sRdZfoH7Xu1BtC+z3yn+1IVJf2V0aCBzCIBo2OvWQlgJ7xyvLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=friendlyarm.com; spf=none smtp.mailfrom=friendlyarm.com; dkim=pass (2048-bit key) header.d=friendlyarm-com.20251104.gappssmtp.com header.i=@friendlyarm-com.20251104.gappssmtp.com header.b=LdiVjH4c; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=friendlyarm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=friendlyarm.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8f97c626aaso298629266b.2
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 01:19:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778228375; cv=none;
        d=google.com; s=arc-20240605;
        b=EssHeaLKn24CzK7VRItoocAs1FVnejUjfX35MDNlBgwxj2CtaOvV0tL1EN2mApDvW9
         8pjbZB/MyZvR1/DYx2P9BCkEjB/QIESDM05jn2+ymbM8puhVEZUmWTzIUf5RFXszvtku
         HZqpOk7j/lelONj31plwuNJ8MGsLjS/3Wp69WyilC8gyH031YUCdZUMRxk4kY6SovPCB
         3wVlMs8f47ahI1yP/DTaxx8ppwxr8BamLz8K+PGZIeDBTnPkPtgP1cNd9bJDr5kVpXsG
         ATsCrrjtBLgZC9PB37gyexI+E9MxNP/PI9UhIYO8yTvAy6UICB3Zm5/0bJRG+nc5uUw1
         sZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jqbJb94JbpdOU+W9kBH8hlf6WXt6l3kJ1d1NQghHanw=;
        fh=xkZ558DDzVlTYDoZ1RGrsHbzj+W4jO0MRCACSCZdEjY=;
        b=KJD8UZo5cpopQmL4foGpxvvfwzIPmeBVrn7naznVnGJnvHo4KYwBPuZu7bVMfVApqq
         LC2uLs0INg1WjtO3Ynbs1///Hw3H4xt3B3LLMfSGvmHGdOmIz+M/PMuPerjZjzRTNiEB
         QQsQ0uwfZ/rFGwNJJ259rlX7MIb2+7EQY8WN0noOqaPaumnjVdz1Y589w36Ob0ZVSFbT
         XRwPWFYv/0MnCsw8MNYct2ThzQmJTUtmkzWdWF6PtZiubI7WduVS9ADYW6XZT1rlPD02
         JICzos1AwNYes+C0LteiiRYv3kwscRBW3bXcqTq5loGWioGxIsoSxXTwbF9chc7xmfxy
         fpOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=friendlyarm-com.20251104.gappssmtp.com; s=20251104; t=1778228375; x=1778833175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqbJb94JbpdOU+W9kBH8hlf6WXt6l3kJ1d1NQghHanw=;
        b=LdiVjH4cOPx8J5beEplBDqofg4GuiJxXUaVzkPE0AqxLUFfptYIXPHSiSIhekWulXw
         xUfPSPWHtY/V+tJiFvxqFmCuPTT8LNq+gW187cgvppWpk4nphIexW9LI6EQ4bJf8sKkg
         LROKG4temaapqBIyjOvc3GkqpLTpQmOmdhIvy63ziqW30xUxtIzpkmZQZVaRbCkkVKnJ
         7iK+1/9aYok/rHskBL3TinvP4rW5eSF47tcTqJjcTSKyQBJL/A5kP9ZZE/FS7REpsgGA
         ZTIV/lO0xVzu+OGG5QDSJ7xs33Z6PQVu7VDBkf2GaeRvS9FCkDTbOQLM/1Bgl/2hWyKx
         4Vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778228375; x=1778833175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jqbJb94JbpdOU+W9kBH8hlf6WXt6l3kJ1d1NQghHanw=;
        b=dh/hiS/EohoKKw7ogdf6iPwkiki3nfZSaCFuoglIuF60PVZqa+ER6d9ebkBjwpLgS2
         DFgLj0cLjgVjYWk3P34JIVwLGkU6Sy0/yNxNBAtW+fMSG3PzcxnNiow+c5GWQspXro6a
         5vIg5P/qqFoHD2FJ+FotPQ05K34UdlpfB6f/2SyhRTTLHnedMRHGSZFBUL44/u9EarJS
         m9R+7tvGEkdRQOsJlGurLCnoTbVd0ToQ2rkkhMf/3ARtxoI79/nHTViVLjHCxqVxsr8j
         LR3PBBzvJL/5+xu8ORMvyIh9vkL3T/YJ49S0LB6+ucBKfc/EDQcY4JTsYLNcgGXsDHtC
         W7Sw==
X-Forwarded-Encrypted: i=1; AFNElJ/MNiHY8LpD6XLY7e0zx4Ibh8AOjK0c8BZBUGTOzmM7nlJJZVuCqN3kO4AeMBpUEHqZa2DD2H8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2XUNU5RNPi0oDdnee9G+0yb0+BOQB2HToorbBWIy7/UKNoIke
	TkHkMTn+58EeweSnCmvZuj9fwR0pn22Zy9AgDnt+ctAOUhgHaPvRbxGNhWXxt8gjqhAMvtjHs6d
	2zuA4L4z6tGrqVVIMx1PE3DDSvcq/7ICCZvsuG8Nmkw==
X-Gm-Gg: AeBDiesh9oWsGQZauov7k17ad0MXzED7GGPuW8E7hv6PZYLljQhXExsHGx4G2883Yc+
	euMFx/QOGgqSDOdbj4EkgQuqgT0F2bL5gGALagx9dD0IFW+pnXtX6mLJMMG6xgcWmMEAlzgCZY6
	pg1T3mUuOzzsDj90mlxIsztJfEPSma+KV3jbG+vGxHp+3/tXoMv9ssU2yH8yuth70PDfqIsOBme
	5NJ5ewp5Ug/t6MsXtBZ0/VwVRURqqSxjw+y2upeo7DSMvtLMFuBDA1QjqNPq0LbGPbe2pcgtNRE
	KLqOQCQ9LjnQNv8lycz7y1dcjYeYwilzBl6hyK9Q
X-Received: by 2002:a17:906:478e:b0:bc9:e1b1:8edf with SMTP id
 a640c23a62f3a-bcaaa54ce58mr98170766b.12.1778228374421; Fri, 08 May 2026
 01:19:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMpZ1qEwNOqR-KQD4kEqd93aB-TpHnG6WdQc2tXUF0aXMmw_SA@mail.gmail.com>
 <198e2ce4-07e1-46c0-818d-1eb18645aca0@leemhuis.info> <CAMpZ1qGEOiPj7cApnWJnojSyEpDmXfco=No5n1VfyTCoNyCyFQ@mail.gmail.com>
 <5308c658-7d4c-4292-b091-a51546ea4d23@leemhuis.info>
In-Reply-To: <5308c658-7d4c-4292-b091-a51546ea4d23@leemhuis.info>
From: Jensen Huang <jensenhuang@friendlyarm.com>
Date: Fri, 8 May 2026 16:19:23 +0800
X-Gm-Features: AVHnY4KNZNxr-RE9SnsIFaocCfihs_7XxPsWOfb_l4qp4jbHCbttfEVHiDYgXSM
Message-ID: <CAMpZ1qEwCjFQ5HkV5pBxHYpKJO14FM3M16XtSJFzjpjigDdX6A@mail.gmail.com>
Subject: Re: [REGRESSION] stmmac: Random DMA reset failure on RK3399 since v6.18
To: Thorsten Leemhuis <regressions@leemhuis.info>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Russell King <linux@armlinux.org.uk>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>, regressions@lists.linux.dev, 
	netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2C3244F39D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[friendlyarm-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285718-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[friendlyarm.com];
	FREEMAIL_CC(0.00)[renesas.com,armlinux.org.uk,gmail.com,lunn.ch,lists.linux.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[friendlyarm-com.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensenhuang@friendlyarm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,leemhuis.info:email,bootlin.com:email]
X-Rspamd-Action: no action

Hi Thorsten, Maxime,

On Thu, May 7, 2026 at 9:45=E2=80=AFPM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> [+Ovidiu Panait]
>
> On 5/7/26 14:49, Jensen Huang wrote:
> > On Tue, May 5, 2026 at 4:26=E2=80=AFPM Thorsten Leemhuis
> > <regressions@leemhuis.info> wrote:
> >> On 4/29/26 14:53, Jensen Huang wrote:
> >
> >>> I'm reporting a regression on RK3399 (stmmac) observed in v6.18.24.
> >>> When a network cable is connected during boot, the DMA reset
> >>> occasionally fails with the error message: "Failed to reset the dma".
> >>>
> >>> This appears to be a timing issue related to the EEE RX clock-stop
> >>> logic. Based on my investigation with the RTL8211E PHY, I monitored
> >>> the PHY register PS1R (MMD device 3, address 0x01) and observed a
> >>> value of 0x0f40. This indicates that the PHY is in LPI mode and the R=
X
> >>> clock may have already stopped.
> >>>
> >>> While commit dd557266cf5f ("net: stmmac: block PHY RXC clock-stop")
> >>
> >> Just wondering: have you tried if mainline (e.g. 7.1-rc1) is still
> >> affected? This is something that is always a good advisable (some peop=
le
> >> would call it required). In this case even more, as it since a while
> >> contains a fix for the change you mentioned, that wasn't backported:
> >> c171e679ee66d7 ("net: stmmac: Disable EEE RX clock stop when VLAN is
> >> enabled"). But this is not my area of expertise (and in different area
> >> of the code), so that fix might be unrelated to your issue.
> >
> > Thanks for the pointer.
> > As you suggested, I have tested the mainline and confirmed that the
> > issue is not present in v7.1-rc2, nor as early as v6.19-rc1. However,
> > I verified that the issue persists in the latest stable v6.18.26.
> > I performed a git bisect and the result pointed exactly to the commit
> > you mentioned: c171e679ee66d7 ("net: stmmac: Disable EEE RX clock stop
> > when VLAN is enabled").
>
> Great! Could you please cherry-pick c171e679ee66d7 to 6.18.y and see if
> that fixes things? It sounds like it should.
>
> @Ovidiu Panait: c171e679ee66d7 is a commit of yours. If Jensen confirms
> that cherry-picking fixed the problem, I'd say we ask Greg to pick it up
> for 6.18.y -- unless you see any reasons why that might be a bad idea.
>
> > Additionally, I tested the case where CONFIG_VLAN_8021Q is not set,
> > and the DMA reset issue occurs again.
>
> I'd say that is likely best discussed in a new thread you might want to
> start. Also wondering if it was like that earlier. Or iow: if that is a
> regression or not.

I have tested v6.18.26 and here are the results:
1. running "ip link add link eth0 name eth0.5 type vlan id 5" over 10
times and did not encounter timeout issues. This might be because the
RK3399 GMAC does not support EEE.
2. cherry-picking c171e679ee66d7 to v6.18.26 avoids the DMA reset failure.

Additionally, I am considering proposing a new DT property (e.g.,
snps,no-eee-rx-clk-stop) to explicitly control eee_rx_clk_stop_enable.
This would provide a more robust solution for hardware combinations
that require a continuous RX clock for stability, regardless of VLAN
configurations. However, this would be better discussed in new thread
too.


On Thu, May 7, 2026 at 9:16=E2=80=AFPM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hi,
>
> On 07/05/2026 14:49, Jensen Huang wrote:
> > On Tue, May 5, 2026 at 4:26=E2=80=AFPM Thorsten Leemhuis
> > <regressions@leemhuis.info> wrote:
> >>
> >> [Jumping in here, as there are no replies yet]
> >>
> >> BTW, Russel, just in case you missed this: looks like this regressions
> >> caused by a change of yours.
>
> I think Russell is dealing with unpleasant personal stuff, let's see if w=
e
> can figure this out while he's away.
>
> >>
> >> On 4/29/26 14:53, Jensen Huang wrote:
> >>>
> >>> I'm reporting a regression on RK3399 (stmmac) observed in v6.18.24.
> >>> When a network cable is connected during boot, the DMA reset
> >>> occasionally fails with the error message: "Failed to reset the dma".
> >>>
> >>> This appears to be a timing issue related to the EEE RX clock-stop
> >>> logic. Based on my investigation with the RTL8211E PHY, I monitored
> >>> the PHY register PS1R (MMD device 3, address 0x01) and observed a
> >>> value of 0x0f40. This indicates that the PHY is in LPI mode and the R=
X
> >>> clock may have already stopped.
>
> From what I get, your current hypthesis is that it takes a while for that
> clock to stabilize and therefore we're accessing the DMA registers too so=
on ?
>
> Can you confirm that with the addition of a small delay ?

Adding msleep(100) between phylink_rx_clk_stop_block() and
stmmac_init_dma_engine(), and it did not help.

> Do you mean that c171e679ee66d7 ("net: stmmac: Disable EEE RX clock stop
> when VLAN is enabled") introduces the bug on 6.18.26 ?
>
> do you have the possibility of bisecting to verify when exactly the issue
> was solved between v6.18 and v6.19 ?

Sorry for the confusion. Commit c171e679ee66d7 is actually the fix. My
git bisect pointed to this commit as the one that avoided the issue
between v6.18 and v6.19-rc1.


Best regards,
Jensen Huang

>
> Ciao, Thorsten
>
> >>> ensures the clock is running before the DMA reset, my tests suggest
> >>> that the phylink_rx_clk_stop_block() call might not provide a
> >>> sufficiently stable RX clock in time for the immediate DMA reset that
> >>> follows.
> >>>
> >>> Since stmmac already sets mac_requires_rxc =3D true, I modified
> >>> phylink_bringup_phy() to honor this flag. This avoids toggling the
> >>> PHY's clk_stop_enable during the initialization sequence, ensuring th=
e
> >>> RX clock remains active and stable throughout.
> >>> With the change below, I achieved 200/200 successful reboots with the
> >>> cable connected (previously ~50% failure rate).
> >>>
> >>> --- a/drivers/net/phy/phylink.c
> >>> +++ b/drivers/net/phy/phylink.c
> >>> @@ -2171,7 +2171,7 @@ static int phylink_bringup_phy(struct phylink
> >>> *pl, struct phy_device *phy,
> >>>      /* Allow the MAC to stop its clock if the PHY has the capability=
 */
> >>>      pl->mac_tx_clk_stop =3D phy_eee_tx_clock_stop_capable(phy) > 0;
> >>>
> >>> -    if (pl->mac_supports_eee_ops) {
> >>> +    if (pl->mac_supports_eee_ops && !pl->config->mac_requires_rxc) {
> >>>          /* Explicitly configure whether the PHY is allowed to stop i=
t's
> >>>           * receive clock.
> >>>           */
> >>>
> >>> Any feedback/testing on this would be appreciated.
> >>>
> >>> Best regards,
> >>> Jensen Huang
> >>>
> >>
>

