Return-Path: <netdev+bounces-268981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IqTKByKumnSXgIAu9opvQ
	(envelope-from <netdev+bounces-268981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:18:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9582BAB08
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 234B3325F4D8
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 11:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD4A39446D;
	Wed, 18 Mar 2026 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fm9ViXu7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8CA8479
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831925; cv=pass; b=FerHDyx1acCxqXts5lTQ6i8nzlBYKYUCrLS0V2wS6sx6Fif97LyhhTMjs/nO2kzYD0dp9RwzOxfeAMPaboPh1ylCXAcRaYWwtHoaKNnKkOr4uSjR8NlUp3Q/2y9quFfZA6ZwAE2hCZfN7BCixytk5qFpt0WqUQvlT930wqRh+Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831925; c=relaxed/simple;
	bh=9bLFN0CG/Yj3eRltICeUp7o159ganRlK/LDV39wkSVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pY7Nf8NT+74q946ZBEjgoevA0RBnZq2OWn9lPrs3eTEiCPHZfWFU3fBvqYajsOPEVWoq2JT6W/RZoGPBrNcvLRU6iyg/B+FnzJ48ZyerZ8f8F++tKgRvnpbaaquCGdYwhASXw/AyVWeiNUXAs5N4WIpW1HU3xhs8h31PhqpZkQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fm9ViXu7; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79a7109f568so9399847b3.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 04:05:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773831923; cv=none;
        d=google.com; s=arc-20240605;
        b=AnD+38fyzQ6JylYm2yWIelk+l8JcQ0jtIDxJ1KIRfJ0gOpbTSLqCY79/c5vPYwQlv+
         hrY9Ly/DVJpsZIfxWXZmHyz8OYvKxBgDEplebs9r2pbp4Egn/wfhYY9BF+lpFRqspvtz
         Pw/PTXVNYPnTHuFZ5fwd+2MyMXKJQ1NUlsxrl2UNjmecDePM7YgYUIgpeZxYLlXX+552
         o9JL0tVpe6bN+hWnSHiPjxrwdQ0bRZweSRTapowh2CdxqWS8yn0XmSo2yFtZa6Inq6qn
         DM3eDIqQzcYZKGjj8Pn0RFwXhvFJCdnf3ws/9JFQH3ZOmSGy2qTUG9M3s9T8tf3Goxkb
         XAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9bLFN0CG/Yj3eRltICeUp7o159ganRlK/LDV39wkSVg=;
        fh=gGDQVB/bTuYrgeyRVjApPl1TvUaWtHl31Lid+tFsHZk=;
        b=D7csxTdwIUb5J/KUKba4hKI4NM1Cu5sLW4Wdo+go9+DHbU5HYhZ0cRYj0g2v31DCs4
         f4YrwAeMMka35K4f+FEh2V2zPV3pfdLgN0NQEA3wHMM22CiYuecLwq/gViLz7YUL63+6
         bq21KC5JUDfB5d/Brgfi2L73vPjvTSMvQ79F90x9I4HRDaS6MhlepH60sQILWnLSQYT2
         E15dxTthu90Q4OrXnL0QILTX4+Ayrpm7EJWZE9qD2BJ0Q6u4+noATaMi4e8E+Jt6G0KH
         sR0gmhep9RvJLkkxyOU1r8+m7b1cOA8ADy6YHVsAEuaSiRgn5gWQzr9cPFrulQ6S0Wf8
         EF+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773831923; x=1774436723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bLFN0CG/Yj3eRltICeUp7o159ganRlK/LDV39wkSVg=;
        b=Fm9ViXu7BftrBypVTFQtbMf0eEdwDaTUfr/NStcgxMcRtCDYTAMcelj/9g/pVBlMQZ
         Z25ucqtdiPOugxSAiglddD7uw949ncc4jlj1Uhr9C6iACbvNFukov3litb6RlW5/hewN
         7fUR+p5BQFqOd2kjDd5osCdLnCIEI++wpfSMhVuixssPFJExhy/GvQIqqak0ulC8hsme
         UkiKK7I9ZSgwP0Mgp7XapnKSxiJ/JckFtKdXiSVXfVCO0cwKCl2up5grGijadOo84Y/x
         7qeAhHBugxswoWcbWLJABtSGqyjmPGxsfbJdIEYOwQKzd5Z2033AFXd9qhfY7kGnOnW8
         wm7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773831923; x=1774436723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9bLFN0CG/Yj3eRltICeUp7o159ganRlK/LDV39wkSVg=;
        b=YuFIGnoqPTk56d3aJnwwxQ+nmuaVcaHA04bTNYrqmkEXYrNyvTq2zMIIwF6M2fsIpU
         P+VULpUj8sC+gR/7x5hupwrTnTD8Z0eqsiSKeuU3qtRYISaH9VqwyXfnF17MAhq4QuEo
         cWLcfUo19eApxjYMGkTqpch9E0VG4NrUOOJg1JAJSmO0JzUifbPfqEDPbYkcvvnP8UuB
         Nwe70jWpz68pV5Ffjay8H/lbGFT+eZmXWKolRBCnrFz5HQrX3DEAixhxWIYnzUnNLK7r
         6YZ42zz6w38T6JQvFVGP6PMyhvAmaS4Yh4BOx7epjp1qDE8kauVr7W7EPji8A89ATwO8
         T/gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVW3lNYytCC40mHeRrdohchrJXMiHZmEIgLNxeT8ZQK8wpdn+pwzCRmrkoXMStBprwTxyEmzWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpJ07l6uiiIwFTVHPbM84DK8WL5oYwb6QTuDQat1GOa3w8W8+
	dzDLOwE/zrr47S69jk6Ba5MTUbOj8ctmWo4QywnzI0jBPuW9u0/HnJPC9YyV5LY6KEdSAZsWvoV
	s9K2PKMayNd3tR2NZ6ZFgwCvVF/FFj8M2jw==
X-Gm-Gg: ATEYQzyR+kPXKJv8pvZW+AB3LgDk36uI+Ft24MEHjps6lMI+PcYKu4foxGcs28WIx0e
	A9RnIb4br33JIzyELszeIC6zkyQXJ/HQRneDpfOujkgkKODVpxh1dYec7mG8fnZXhNMfq6HZtpZ
	gJpFui4y0rqL+G7KUhpjKdK6ZD65K4MI8fhPfXlgQ64zqzwYnBjy0MNtzCZVRFkd1JAFJZakiZt
	NnfQ2nHubFk85xi59rctDtQNtIIqvC0oDK90rNKYm6IVxGEkkB2FqIg5LZ3k77pVkWbRcWN8cOK
	AvVqlzm3
X-Received: by 2002:a05:690c:6e87:b0:79a:4fe4:ff60 with SMTP id
 00721157ae682-79a71be742fmr26442267b3.35.1773831923259; Wed, 18 Mar 2026
 04:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP6Zq1i31Z0kfDST1Xcoftxja-TFaxgSjKH6jX5eY0AGdASpTw@mail.gmail.com>
 <b2868f3d-ef84-4ec0-ac37-e41029a1d385@lunn.ch> <abHV7rDryld4A-S_@shell.armlinux.org.uk>
 <CAP6Zq1hKd19aLjWBnx3pkfeGyqrudqSHd0PTxUJhn7r9BG0oSA@mail.gmail.com>
In-Reply-To: <CAP6Zq1hKd19aLjWBnx3pkfeGyqrudqSHd0PTxUJhn7r9BG0oSA@mail.gmail.com>
From: Tomer Maimon <tmaimon77@gmail.com>
Date: Wed, 18 Mar 2026 13:05:12 +0200
X-Gm-Features: AaiRm53rFOYnBTL9Juw2OemD7spdB53j5IJQJDDzLpTJbbJvHkMWYHyylnysNDw
Message-ID: <CAP6Zq1goZnvYFGupAuyRZwE=vEvjkqn1TuJD1u0LsvCPs8By1g@mail.gmail.com>
Subject: Re: stmmac: TX stalls with head OWN=1; requiring manual DMA kick (6.12.63)
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268981-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email,armlinux.org.uk:url]
X-Rspamd-Queue-Id: 0A9582BAB08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi All,

Appreciate your comments on the reply that I sent a few days ago

Thanks,

Tomer

On Thu, 12 Mar 2026 at 16:02, Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> Hi Andrew and Russell,
>
> On Wed, 11 Mar 2026 at 22:52, Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Mar 11, 2026 at 08:46:04PM +0100, Andrew Lunn wrote:
> > > On Wed, Mar 11, 2026 at 08:34:36PM +0200, Tomer Maimon wrote:
> > > > Hi Giuseppe,
> > > >
> > > > On kernel 6.12.63 (GMAC, normal 16=E2=80=91byte TX descriptors), we=
 observe
> > > > brief TX stalls when sending small packets.
> > >
> > > You might want to look at Russell Kings patches from this week to
> > > rework the descriptor handling.
> Could you point me to Russell Kings patches?
> > >
> > > Also, please don't report problems on dead kernels. 6.12.76 is the
> > > current version for the 6.12 LTS. There is a small chance your proble=
m
> > > has already been fixed, and you are wasting everybody's time.
> Sorry, I mean 6.12 LTS.
> >
> > Yep.
> >
> > Not sure they'll materially affect any problem, because I try to avoid
> > functional changes in stuff like those.
> >
> > What's missing from the original report is a description of the
> > hardware. stmmac drives multiple different versions of the Synopsys
> > IP which have significant changes between them. Which platform glue
> > is being used, which core driver is being used (dwmac1000? dwmac4?
> > etc.)
> stmmac IP version is 3.73a
> The platform is glue is "snps,dwmac" and the core driver is "dwmac1000"
> >
> > Also what isn't mentioned is whether this is a regression, or whether
> > it's something that has never worked. If it's a regression, which
> > kernel version previously worked?
> We ran the test with kernel 5.10 LTS, and it didn't work.
> >
> > --
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>
> Thanks,
>
> Tomer

