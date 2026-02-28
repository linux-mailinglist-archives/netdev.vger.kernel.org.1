Return-Path: <netdev+bounces-262123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PDytDQruomny8AQAu9opvQ
	(envelope-from <netdev+bounces-262123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:30:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B6D1C33C1
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08407303A8DD
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 13:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975D51EE033;
	Sat, 28 Feb 2026 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huUMpM+x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B011487F6
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772285447; cv=pass; b=mk3EGuUaSgt9oSSIon+Ojxw8CEftJm9UfwaIR9UeVBpuAOw2UxMQg9nzTzHBYDaS0sL8FzCxQe/hLhAfMjm+Q5qgBvGQ8yvujPMUhSVZxOVvVj9/J/K/uzqYdyEnBxLyLrfM3uAvsdt5RxskzTcGrKv8CUbf5qU39OkzMJcH18E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772285447; c=relaxed/simple;
	bh=80jwD2gHI64J1JGG4o86aD1JoyB7X9z+PTWBAKv56SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtuNybZBGPyZdFmQLwZu5Zgdj9i0jsYrQRX1Q72U3FgM8siplW379PiWfpVUDG3kHpcwbY6rkPbL4TCGg0ZP4owXctZdixMKVnce+TKrwFMbJ3XyB4LkEqE92Yxz5BNPVTBGeFsmjl+IHmY40/yZ+cl81YBwuXm/V4/8sX3/x9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huUMpM+x; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64aea64bf15so2577412d50.2
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 05:30:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772285445; cv=none;
        d=google.com; s=arc-20240605;
        b=VmAgOHpn7eyPUpTbR875ecMVfPGnYYVPbE8LjF+otW+yDXq2rx7p+MRvUDYaTxS+Ue
         GPxNrwxl9+td3WsTkz606wB8qzrPOWNSGN8fsaeYDwCS9lqdUfmvbYIVosUPLbWGt86j
         8xkDO8fRzUicfaXrcPuVSC3lhMK0jzhlSJANF0QjPo5W1PZXU2IbZO7mI1tb2rUprX33
         r5CszzVUgk7luADfCOPd5gsgPot7VeMvzQD4WI59oS7MLJ45seDbh9+Y3h052pP3rC0B
         LWhgZM/4plf1nzjK/QYfTORVdKLbREtI1OoB9zjwjKozgWI1HSq/iXClxJ2kotSqSCKs
         0FrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=80jwD2gHI64J1JGG4o86aD1JoyB7X9z+PTWBAKv56SQ=;
        fh=blZ0jvUq9qyU2Kr4RXf1cuMIc2Yf5jghjuGMYjzLMuM=;
        b=VoJ5KTH5MvLD39qY8EvS5hblt7OI8y27+V5ZgFbgMQxg69CGncT++JVok5s8AfMviT
         JIzJx04vVwpdgAzaTCH1yJCSNGEUafCG6SFaonTfpKiGFWXp1qntjgBPuqvfQiz42z2n
         CQrBxQfW8VhY++I1OerpW1hR9AbnoOw4oLHKEyrVvJTawhfOuvC1vC9Xf0G6DOtad2O6
         5sqB3RF1lHsfx/YsNLERaWiSBGSEpGxbs125BNg9ejsiGbC3UpcIC4y9YJBebR9oJFBg
         TH2pKkbYfcebp0TDCpZ6/wXMEPPoxRcxtMsRRJKQpzna0fBupXJJHpXrn/h64WWnRRAR
         E5tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772285445; x=1772890245; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80jwD2gHI64J1JGG4o86aD1JoyB7X9z+PTWBAKv56SQ=;
        b=huUMpM+xSbdhhbo+rkqPXBQYdsiCQ56OQXVadbvqGj9xbajdilZVy95JOlxGbEMkAl
         rSZPKlcEmX/y4p5y8MvfxxVvgfcG+3GsAvPylTKFqJwqpoZxGyhYFwYP+HKjirpnEHUg
         wH34q/ylpjD6PkjrjmPWrE6dlc76kfZrGAbUTIBl7OCwAWP6gGz58+Je2lYFyXdKavWp
         AUzRl7xYZl2K1ACkeraoeIeuDjBlTAhZN1E+VrgSgDG/p5nYFPHC/BAiKaAQ69AsNaij
         SOjl1/OK9d/V3VJ0z6RcJfwyuRfSPb4YXhXjLuWYQ56izVApF6VJjYkJHIPk+KPB1bSQ
         tEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772285445; x=1772890245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=80jwD2gHI64J1JGG4o86aD1JoyB7X9z+PTWBAKv56SQ=;
        b=ltciWVKrysxiVI1xeNGXDtVxEYqfeWwsziIUQ6vY1BJJmlzHSv6vkK5YN+BgVDwa9o
         7mJ4cpSPZizfpGuE6475RdzICTKYB/A7t1hA62CvAp7rJBXhYiYRfCn8Gu5++uO4RmcR
         X6fIeXnst5o8+MbwQlyqisxgTVP8RIlHcpfnenRVk1DYXTEMb31NQsuJsTG48a5787pO
         Dk5nquyEa2mcvnB8PphzChXjNiQ1xE9IfJDz+7zKzce9bJC+ly/rldVnl5zC9rfrhaRj
         L88Py08KmhPbIaofMTCW50mTPIlkUPXBE7abj5srkrP4ldfBdQV6cBQOVQlG5xnLvZO7
         CWKA==
X-Forwarded-Encrypted: i=1; AJvYcCV+vUDS81nQWfnqSFF78psUJSjQMYpeY1PrGfCcI+gvHcxk/bsOHyRxorFfoz5Kl2r0R2TWKCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfgTHO2wMMC6P8MysmPODsNzZpT8Pa5M0aqSuh+nt7Zfnb3U2+
	KPQQHyhNwf53huxWWMmgwLV6M0Zzs/WyknLPavP/cja/tICUfg9JzQJxNLT12yMj8eK680hshHm
	FFep+HJelULjIAjkRHd/krf4MjoKXTPs=
X-Gm-Gg: ATEYQzwx+umDUlFR3jn66BaFUCcdFQtpOis5n+86kLBZkBjRx8uCDL5B0hDLR5agL/R
	hPs709YMe+KgmlkhYUzqF4GOtYBEuLLpK2//K4JrWJgPqiL5ZZVgBlcFKzYRKqymvfg5FL+xoYA
	kOVB++g+s+Rte49po8aOBy4b87sz0AZoLMSEvURl4xOQPNmkU2juzYLFQ20Cwm4fNXv5URlA3nK
	bIcD/QOGcnYRk9URLWSlC3WRCV2PPSWRUJZKGr5umK2eKFjuvVSUzuA8izsCDT+KrU3BNqyCaSJ
	voxvsuEa
X-Received: by 2002:a53:b642:0:b0:64a:d74f:257b with SMTP id
 956f58d0204a3-64cc2080be0mr3732882d50.7.1772285445069; Sat, 28 Feb 2026
 05:30:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508091424.26870-1-jonas.gorski@gmail.com>
 <ce4d9b7b-aaf6-4796-94fb-8c3d6a1dcd4d@gmail.com> <d7f9775e-0af6-4294-837b-47e31e0d30d7@broadcom.com>
 <CACna6rw1kF-r40dr-nxouV9E0AigmeVj9fxQm_Px34Z_n2up9g@mail.gmail.com>
 <CACna6ry9B9LiPbWdXzi7FCcaU1YC+HPkor53AiSEaRSNUMcLwQ@mail.gmail.com>
 <eccf1d40-e4f2-4ea1-a8e2-328606fc0860@gmail.com> <CACna6rzi3_pnduEphRBY3NDKrNqhK2i5TdVTNeEGb4nHm+vOMg@mail.gmail.com>
In-Reply-To: <CACna6rzi3_pnduEphRBY3NDKrNqhK2i5TdVTNeEGb4nHm+vOMg@mail.gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sat, 28 Feb 2026 14:30:34 +0100
X-Gm-Features: AaiRm53elsgk7jk696p2Zj0G5jSypB-BM7g_7_ulmzSDXWuOw76Aoel8UWvKo7A
Message-ID: <CAOiHx=m9JQkm3pMj_mEMoVwCApB=Ef4J7FBzOf9_8o9eiYbCjg@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: prevent standalone from trying to
 forward to other ports
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262123-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonasgorski@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,hauke-m.de];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:email]
X-Rspamd-Queue-Id: 84B6D1C33C1
X-Rspamd-Action: no action

Hi,

sorry for being late to the party; currently on vacation (be back
early next week).

On Fri, Feb 27, 2026 at 7:13=E2=80=AFPM Rafa=C5=82 Mi=C5=82ecki <zajec5@gma=
il.com> wrote:
>
> pt., 27 lut 2026 o 18:58 Florian Fainelli <f.fainelli@gmail.com> napisa=
=C5=82(a):
> > On 2/27/26 05:32, Rafa=C5=82 Mi=C5=82ecki wrote:
> > > pt., 27 lut 2026 o 13:23 Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> n=
apisa=C5=82(a):
> > >> czw., 26 lut 2026 o 22:26 Florian Fainelli
> > >> <florian.fainelli@broadcom.com> napisa=C5=82(a):
> > >>> Could you try to program GMNGCFG (page 0x02, offset 0) bits 7:6 to =
have
> > >>> the value 0b11 which is dual IMP port (IMPO is port 8 and IMP1 is p=
ort
> > >>> 5) and see if that helps?
> > >>
> > >> On my Luxul XWR-3150 (it uses gmac0 and port 5) the value of
> > >> B53_MGMT_PAGE (0x02) / B53_GLOBAL_CONFIG (0x00) is 0xc2. Nothing to
> > >> set there I suppose?
> > >
> > > I tried other possible values:
> > > 0x02
> > > 0x82
> > > 0x42
> > >
> > > None affected my switch / wan / lan ports.
> > >
> >
> > Thanks for giving it a try, how about the BRCM_HDR_CTRL register
> > programming (page 0x02, offset 0x03)? Can you see whether it is set to
> > 0x3 or 0x1?
>
> It's 0x02 which seems to match BRCM_HDR_P5_EN. It makes sense as
> XWR-3150 uses gmac0 + port 5.

Does this affect all ports, or only the wan port?

Have you tried to check the hardware counters if they get sent out a
different (cpu) port? AFAIK they should be available as ethtool
counters via gmacs, though I'm not 100% sure.

Can you check the contents of the EAP Port config registers? Maybe
some extra mode is set there by default.

I don't have NS(+) device, so I can only guess. Though I always
wondered if the setup which CPU port (5/8/both) to use is just a
software thing or actually a hardware thing ... .

Best regards,
Jonas

