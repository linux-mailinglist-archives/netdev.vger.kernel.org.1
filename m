Return-Path: <netdev+bounces-285317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eG77GLuK/GleRAAAu9opvQ
	(envelope-from <netdev+bounces-285317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:51:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CF94E87CC
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BAC6B300D4C8
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D5B3C65F2;
	Thu,  7 May 2026 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=friendlyarm-com.20251104.gappssmtp.com header.i=@friendlyarm-com.20251104.gappssmtp.com header.b="iukFb2oD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9A83CAE76
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 12:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158156; cv=pass; b=pqDrXv69G/4auoCthKeXUv5p5ZtGMClqD+z8sH0meYmIkFpJkLG9jAdIu7Qjfcqr6MauwerzLkT8FwkM159StnpO+KozrSMJ8dndnVMzJXsa9wE+jOrIW9KRs1aPPUIBEyrDepEQWDvElG1STN6ONtf9iftXCJ2m1QtlSGo5/Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158156; c=relaxed/simple;
	bh=sz903DbfArP+QiHkxTXsqT3ZPy4O+2XviQY6sg+gQmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GfJpbBvL3FqWd2EMmrZ0EBsiz4+u/Xb3z9exrm1OX7GxQwUQHSq2J9m0v2wbkswcknMSHtzcTQHwSgbDvInF1BCr/FzuB6mw1dI44E3b5vOiBDXhgN6akCnrFGwWNzQfESonLIpG7IrtVQM78wdGH/ru0qy+klhmVOEYou0jSCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=friendlyarm.com; spf=none smtp.mailfrom=friendlyarm.com; dkim=pass (2048-bit key) header.d=friendlyarm-com.20251104.gappssmtp.com header.i=@friendlyarm-com.20251104.gappssmtp.com header.b=iukFb2oD; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=friendlyarm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=friendlyarm.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67e43a8996fso588475a12.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 05:49:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778158153; cv=none;
        d=google.com; s=arc-20240605;
        b=LARlDZK+Sr6ktbNSbuzqXAMfUheJU6GxEaI5x45EJxS/M9RsloLwclG+gM65cusVee
         eyfwyAfC8aiAYBLfh9EKOZXxKQq+P6IDnrPJqvHLNPstYDtdfMhMYd+G0yP8GfUZXmVe
         M/rGcLdwvvHbFb5Nrg+WsTM9lRLj9BzaFii6WC+sBYH5LeavTJS8jgfZyr2HgVHgioiz
         xGkD+4HcUKt61NEeJVWPm+wogeaDjhWI4VqmohdngdtirWgPSUXroh9ssJoI37498o/1
         jpR9YDMArHaIAtOEf6hKalvdu5TLVgQ4rePI/jC99Owwt3IXIUYiGCEUmNNQkjlBjlJL
         uHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T5GvoPtWelUk7+7MNNsj2fIFZyWFICYszMdYegWkkxI=;
        fh=sB7nu4XOPzOMy2NyE0y/MPXFGvFzzBsZTPerQZjfQmk=;
        b=Ahe00LCAsvCbNl/Rs9lSXv6YQEeeKuqWhXOlnZu9o1zxKfde0nKyWJQbtVwqdTuqSz
         meGw1BFEbrvvTkey8HvylPkb82DSu2nJnZ3rZ9gs6/1+HQOV32GGKd7sg3zUd5C1awal
         2oyL3bervO36SCuq03E6J4+deyjjbhQPXTR25lZz2YCYaIMJ6tkFkchlxEf8hy0HhF4A
         NgkMumPzhakQA6Y0sjasgxQMXUIKQnWIlNMUK86hkBIkrRlpQbZeNcMgV7cVsTDPa5lR
         eMPAlovX1E4HVGc38a2u4K4QbDy/dMgTeXuyiPF9hDBZzI5MiohYxCK4VvSh1IYB/FYc
         7B6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=friendlyarm-com.20251104.gappssmtp.com; s=20251104; t=1778158153; x=1778762953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5GvoPtWelUk7+7MNNsj2fIFZyWFICYszMdYegWkkxI=;
        b=iukFb2oDP+zLkOTwwgBmLvn4C+RPxnpEJ9vixQRPCgcejlfhk9GGne6y69PxIDbgxc
         tR2IjIeTkrtstmN4O7soIkECm0DdrCYfNwBHg0zy1BkonUCQrZ7T9uZCvALEAOllygcR
         ZM7efWjelnACSM8IkmGMdudI8wGbO+E21N6u2vmvjlkc5eME4UTXClZxFr3en6ae205R
         DVvGdO110S+zKoo1czxZVJIw7J1ZuMtOwtSQG01F4+jMvwOGP+LDCWsiQewBsk8vdiSi
         Yh4gnE/NeBoc/N/3WN1YF9/+AkoGo4XpuyDUbjxToUEMkeZc5ugggT3ORK8YVSYMQPyc
         /uXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158153; x=1778762953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T5GvoPtWelUk7+7MNNsj2fIFZyWFICYszMdYegWkkxI=;
        b=s3jAuNKelix/PQ/fAtO03t8w6/gqe6WXK2iYRaoRertAJLCRauVEPkKc8a1Jesxoir
         RPGhuYImbzD0Fu6AbjkpBo13Dom7XvyIb8ugT/j3X1OA9qwT3ZKA1dZCh2pinZyObOZ0
         EsuqFtvTEaJK6JOHCmm9XB1WtzATta/OsydL8luSO0ldmaWgLKx9/KeSI6oenJDjdMML
         32bACZM8/NdpYyQKHcBXFael96f8lkYyK2JZkuGPMAOtxosWICSlRloSveNyCphGJvgq
         mv9P8Pqj9lqUYWHC387MiyxJyXXkYsROvDVVB8S5T911CyQkByRtrkGEqiuQ1Nvv9OIT
         mqlw==
X-Forwarded-Encrypted: i=1; AFNElJ+/BwUewdo2lXZg91zQ0JlrYX+SJCBD6JGB0paCLvTYZpd3yS1COwtknIp0oJcbhmjOA68Zj0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtVPYX5LXs8QCHfMOGG1bUM4dHNRCv3YXGpoGWS9BMq5T0RO38
	mMn41eWRGEFmmwQVjC/7cAS84XNOpgtwC4Yc/8989BTauqSdZ7w8rk2Ss6n/rWW0DjbdeJwWzhd
	gif2tR5CtG6JXa1dqaAAmgcVwuu9Q0aIuEr2Qh7QWvA==
X-Gm-Gg: AeBDievdCJHaok/bibbNpigmssUA62uVOFPXIkliGtZg7RCl0BqDnGtmqedhptISr8F
	Rmq6jSluXcSf0+tNteA6C3sOxHxCnv3N3UioACY8REEvDGDlBUinUJol4lfU5DP/Sq9zDr/Qng5
	cYtXjCkC9pNkKTRLpex9Mwr8WuLeuhO41NAS/LAHEqy7MHqSubXHMV3RGchYu+iyxD6c5z0UktC
	pnmuMRfMGmFPh9BL9n0tg7T3LEwCqiuc3r5j+SGV+5bhBVgH0mSu3a77WeBNlqCiglAgh/pz0Jm
	qIwPO+Jg8GUGd8n9zSefKF73Sgcjr+eqxRe4Xxvy
X-Received: by 2002:aa7:d9cc:0:b0:678:f81a:76a1 with SMTP id
 4fb4d7f45d1cf-67d63d8f13fmr2850093a12.10.1778158152619; Thu, 07 May 2026
 05:49:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMpZ1qEwNOqR-KQD4kEqd93aB-TpHnG6WdQc2tXUF0aXMmw_SA@mail.gmail.com>
 <198e2ce4-07e1-46c0-818d-1eb18645aca0@leemhuis.info>
In-Reply-To: <198e2ce4-07e1-46c0-818d-1eb18645aca0@leemhuis.info>
From: Jensen Huang <jensenhuang@friendlyarm.com>
Date: Thu, 7 May 2026 20:49:01 +0800
X-Gm-Features: AVHnY4JIhFDYsewcoPMz6YubfqI0BrloS9P8SD1uRPJjDpD8UVEZ2b6XKnlXN4w
Message-ID: <CAMpZ1qGEOiPj7cApnWJnojSyEpDmXfco=No5n1VfyTCoNyCyFQ@mail.gmail.com>
Subject: Re: [REGRESSION] stmmac: Random DMA reset failure on RK3399 since v6.18
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Russell King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, regressions@lists.linux.dev, netdev@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 54CF94E87CC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[friendlyarm-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285317-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[friendlyarm.com];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,lunn.ch,lists.linux.dev,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[friendlyarm-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensenhuang@friendlyarm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, May 5, 2026 at 4:26=E2=80=AFPM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> [Jumping in here, as there are no replies yet]
>
> BTW, Russel, just in case you missed this: looks like this regressions
> caused by a change of yours.
>
> On 4/29/26 14:53, Jensen Huang wrote:
> >
> > I'm reporting a regression on RK3399 (stmmac) observed in v6.18.24.
> > When a network cable is connected during boot, the DMA reset
> > occasionally fails with the error message: "Failed to reset the dma".
> >
> > This appears to be a timing issue related to the EEE RX clock-stop
> > logic. Based on my investigation with the RTL8211E PHY, I monitored
> > the PHY register PS1R (MMD device 3, address 0x01) and observed a
> > value of 0x0f40. This indicates that the PHY is in LPI mode and the RX
> > clock may have already stopped.
> >
> > While commit dd557266cf5f ("net: stmmac: block PHY RXC clock-stop")
>
> Just wondering: have you tried if mainline (e.g. 7.1-rc1) is still
> affected? This is something that is always a good advisable (some people
> would call it required). In this case even more, as it since a while
> contains a fix for the change you mentioned, that wasn't backported:
> c171e679ee66d7 ("net: stmmac: Disable EEE RX clock stop when VLAN is
> enabled"). But this is not my area of expertise (and in different area
> of the code), so that fix might be unrelated to your issue.

Thanks for the pointer.
As you suggested, I have tested the mainline and confirmed that the
issue is not present in v7.1-rc2, nor as early as v6.19-rc1. However,
I verified that the issue persists in the latest stable v6.18.26.
I performed a git bisect and the result pointed exactly to the commit
you mentioned: c171e679ee66d7 ("net: stmmac: Disable EEE RX clock stop
when VLAN is enabled").
Additionally, I tested the case where CONFIG_VLAN_8021Q is not set,
and the DMA reset issue occurs again.


Best regards,
Jensen Huang

>
> Ciao, Thorsten
>
> > ensures the clock is running before the DMA reset, my tests suggest
> > that the phylink_rx_clk_stop_block() call might not provide a
> > sufficiently stable RX clock in time for the immediate DMA reset that
> > follows.
> >
> > Since stmmac already sets mac_requires_rxc =3D true, I modified
> > phylink_bringup_phy() to honor this flag. This avoids toggling the
> > PHY's clk_stop_enable during the initialization sequence, ensuring the
> > RX clock remains active and stable throughout.
> > With the change below, I achieved 200/200 successful reboots with the
> > cable connected (previously ~50% failure rate).
> >
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -2171,7 +2171,7 @@ static int phylink_bringup_phy(struct phylink
> > *pl, struct phy_device *phy,
> >      /* Allow the MAC to stop its clock if the PHY has the capability *=
/
> >      pl->mac_tx_clk_stop =3D phy_eee_tx_clock_stop_capable(phy) > 0;
> >
> > -    if (pl->mac_supports_eee_ops) {
> > +    if (pl->mac_supports_eee_ops && !pl->config->mac_requires_rxc) {
> >          /* Explicitly configure whether the PHY is allowed to stop it'=
s
> >           * receive clock.
> >           */
> >
> > Any feedback/testing on this would be appreciated.
> >
> > Best regards,
> > Jensen Huang
> >
>

