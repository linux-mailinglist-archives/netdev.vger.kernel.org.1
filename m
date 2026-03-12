Return-Path: <netdev+bounces-267080-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFeIG57HsmmvPAAAu9opvQ
	(envelope-from <netdev+bounces-267080-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:03:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E04072730A4
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 15:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BFC9300F5A9
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 14:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA97A330B0B;
	Thu, 12 Mar 2026 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq66R2ty"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38E526C39F
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773324179; cv=pass; b=jwlTkQTojNSxecP7w2yWPJQs48FSuw2PUTYMH7g9EPQyne1Rqwy0p1svDwdYub3+C20alLuFWkAYxg/000tYj2VyaDEkzzKj5BoGAgTqak92JvwGpVO0KiiYllnyRJx4qBKGWVdzD5mJUfaBxCPXpxYV3uOTg50LPudS6DzcBQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773324179; c=relaxed/simple;
	bh=1cNkInBcHMDQN0rq2ebxd/Nn2LAPM9SYtoNSORESutA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgGkZYNflGLxwYUVBLi/Fd1EuI0IbQMwdU2xS+tkX7x6QcT6f8AEp/KWidMjeL1bibZUQPNp0aXpLc/bdnm/btpp4/d7maR2DyEy/OxSo0IskYUUb45eyRY8v5J6jhfkEs9cgoFTS3XBasrH7cv8079ugSB4IbwxosghG0sO/zU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yq66R2ty; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64c9a6d68e5so916470d50.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 07:02:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773324177; cv=none;
        d=google.com; s=arc-20240605;
        b=X4NE2187h2GWCm56HwNaI6zrRozwOoAifDxiq97Khg8fQyOqNcdGRxPXZEYrCAPVUe
         sVUqQuUOlI0JIsasP5RCQvBYnd5ehAaqDOgZm9ySrLOiWFX3DgueWP8xHUxAxV74VBWm
         igJ6KOAXFYrki1/cSqbWc3Zu8aXTstUHMjKG80qVuY7mVjZgfQlXGsKXyX1sGHBQmmNr
         kKqNiDIb5Ty/ql6w4S31z7Hk3mgKWploMwk4RRNHsSxBLRGjQUkdVJ2DooNrJl4WR39Z
         HrjZvwm+7BCaV3JJwxzT67XJpJelTDjroV1rYQJr8GLHSPMCZvXVLaaJHa9WQiDfeyi1
         Movg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1cNkInBcHMDQN0rq2ebxd/Nn2LAPM9SYtoNSORESutA=;
        fh=u24o62hDtPR/kUn1zn3MY6radxHziw5codugFeKd0ys=;
        b=IgfOo+3RLJ/EwUeVhtvkWv+yt/xc9HXc6aFBigMHNZNRPEWgemygM57nWaFVmnh7AJ
         W/AAR601MnotALFf1rxo1cfgPN+J2DxNaPJLRYzSKH+SlB4HwZJs0lIGXCELrm9zWEsD
         OLeRu2IMY4a5ZmxdzB7KagDyk+FTDOhkAAA9lX+q8XSGK3TFshkHee6tKurBTjDKKNej
         1JXkTeYTYrgzEbpg4omt8FNmgvXAZsHFHqPWZhSSkRw4oq9qJ99tBBfkgIvDzNWnObwP
         8sM6LLT0eyHU+IqnO6+aKfnfe6kYavH3pn8HvoWnN5BDy6brKgQj7PPgf3yflnShRilM
         xheg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773324177; x=1773928977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cNkInBcHMDQN0rq2ebxd/Nn2LAPM9SYtoNSORESutA=;
        b=Yq66R2tyhZvPsa/UF9BYsr7bWhsGdZrvUpROKVbQC1IewU0OdFZAWagRA8FsyO7vJX
         b2/tMNBWjubYK+yAZZKiRPTXVNsbybKd56DXjgUZacUVLm9f0NWd2WsfZorly40AKhGp
         caoglAXmOnB4RNfAcNHPTOMn1utWnzoIRisnxiixLJ5UNUgsRsu4aUKccIHP4uOr/t8k
         JSIYCol66mydcOFIkh3+5yFw9rAoFT1De1S70D1fgTqfnibvaFWG65/uAx7dSXUXgnbF
         YfK2tWuku1eWtmE2+VgQHAHzJnm21gFwETjq8Zd79bmjZ0IXH1FuUTg8tmmMqzM6O6Y/
         ANBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773324177; x=1773928977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1cNkInBcHMDQN0rq2ebxd/Nn2LAPM9SYtoNSORESutA=;
        b=ReU/BEzrAgbY/+tiWuKD4oVrT9rbVjum1L26h50W2EKJEwDSi6hEQ8rE1FJyRivN0A
         vkz40WDMgZJofuXO4eObaRNkiXW/2wi9K5c4Trmrit7T4xv3+NHSewV5Vl8i8XipGYt7
         ETpcJq7AN5KTiqDH0XUQNss8OotEKGJEXYE40xOhfA3e0PomH1/rk4XoL8q/OIEekXp+
         6PO7KY8HTaOmjaAc9taQrMtdN5DyCMcXtVd43zMyvDjCR6oxoUuY1eroFKZv2wl89/Hg
         w+AzeCx1luvSUrxmjZkR7sa8pYg5QNQzfwNXGcbqFr+aCCqvMN/IJPVobwNhnmAOY4PB
         SADw==
X-Forwarded-Encrypted: i=1; AJvYcCWyFogtBD+SCwB5XOSsxceHgb6P93enxWuBZssc90ENpuLl1thHtwny+aoKI7Aq651TS29mioc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU69n12QGWx65Nkl6Y2xRXRtuYRfApgrSYeYPcLxtleNLiExPr
	7vvMEnoOk+mv20ck650An21YMtdGjC7dwYRq5N9Gcp8Lp962qxUPjkfwhOYfr0a82kvMxhETTX9
	mmHjIkpSTSKfHo9goHxUDuq4CGeTyOfE3dGuu
X-Gm-Gg: ATEYQzzQdUtCgEmNrDRwv2/mRaF1Tr0a6xH90kpGCcNM0EkXHZ1ZGpkUsIt3s1QFLEJ
	ht3gSFV+Du53FPj3KoKlBqrK7VKKL/QejbmEACVUJkFk3Ox9ob7VcXwqDb7qvapTYHYgqj+RxZK
	ztS9427J2+FGgQOuMqmzpSKHyELhuL+eAMGe0aGxpwY9i7FoLkVBJQbpXgkcK/oPTciuTF9TJpY
	Z/cQrmnNwARXl232SHMOw0zw/6ytTMdrmEY64llsRtXw46mEAPnBtOL/hXPA6i+60hFhh9J0a7g
	881BbA5sVwf4X3X5zfU=
X-Received: by 2002:a53:e948:0:b0:64a:d1ac:4528 with SMTP id
 956f58d0204a3-64d65714ba6mr4408584d50.39.1773324176574; Thu, 12 Mar 2026
 07:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP6Zq1i31Z0kfDST1Xcoftxja-TFaxgSjKH6jX5eY0AGdASpTw@mail.gmail.com>
 <b2868f3d-ef84-4ec0-ac37-e41029a1d385@lunn.ch> <abHV7rDryld4A-S_@shell.armlinux.org.uk>
In-Reply-To: <abHV7rDryld4A-S_@shell.armlinux.org.uk>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Thu, 12 Mar 2026 16:02:45 +0200
X-Gm-Features: AaiRm50tCEv4zsqzufzlSYmZV4JCkNJs1xlOYw5sE4BkoO-egg2hdHvLH3gyKtA
Message-ID: <CAP6Zq1hKd19aLjWBnx3pkfeGyqrudqSHd0PTxUJhn7r9BG0oSA@mail.gmail.com>
Subject: Re: stmmac: TX stalls with head OWN=1; requiring manual DMA kick (6.12.63)
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267080-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tmaimon77@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,armlinux.org.uk:email,armlinux.org.uk:url]
X-Rspamd-Queue-Id: E04072730A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew and Russell,

On Wed, 11 Mar 2026 at 22:52, Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Mar 11, 2026 at 08:46:04PM +0100, Andrew Lunn wrote:
> > On Wed, Mar 11, 2026 at 08:34:36PM +0200, Tomer Maimon wrote:
> > > Hi Giuseppe,
> > >
> > > On kernel 6.12.63 (GMAC, normal 16=E2=80=91byte TX descriptors), we o=
bserve
> > > brief TX stalls when sending small packets.
> >
> > You might want to look at Russell Kings patches from this week to
> > rework the descriptor handling.
Could you point me to Russell Kings patches?
> >
> > Also, please don't report problems on dead kernels. 6.12.76 is the
> > current version for the 6.12 LTS. There is a small chance your problem
> > has already been fixed, and you are wasting everybody's time.
Sorry, I mean 6.12 LTS.
>
> Yep.
>
> Not sure they'll materially affect any problem, because I try to avoid
> functional changes in stuff like those.
>
> What's missing from the original report is a description of the
> hardware. stmmac drives multiple different versions of the Synopsys
> IP which have significant changes between them. Which platform glue
> is being used, which core driver is being used (dwmac1000? dwmac4?
> etc.)
stmmac IP version is 3.73a
The platform is glue is "snps,dwmac" and the core driver is "dwmac1000"
>
> Also what isn't mentioned is whether this is a regression, or whether
> it's something that has never worked. If it's a regression, which
> kernel version previously worked?
We ran the test with kernel 5.10 LTS, and it didn't work.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

Thanks,

Tomer

