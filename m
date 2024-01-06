Return-Path: <netdev+bounces-62148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4E9825E2E
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 05:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0161F240C6
	for <lists+netdev@lfdr.de>; Sat,  6 Jan 2024 04:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF1E15CE;
	Sat,  6 Jan 2024 04:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeXz7F0N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC7117CB
	for <netdev@vger.kernel.org>; Sat,  6 Jan 2024 04:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4b74a9a9d4cso75210e0c.1
        for <netdev@vger.kernel.org>; Fri, 05 Jan 2024 20:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704514526; x=1705119326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niR+ENQYYO/xfLAGwHDq1aRyGA75R5+9RceCgIFLuQI=;
        b=HeXz7F0Nk+FsnrQLGLYwyGrJ1j/bGoFacMV7bEV1l+yYF4X6OBfr1AGi/E8AW0Tmf6
         FkFNFd8mjlukhT0DmachkHDNDOpgU4ve171V5+NGWNwO06Imf2mjyfg24BQCynxw9xxP
         ad/hjN2m2iAKcDJQeMOWpvB291aAM0ZSd8hPfJwQDdzYi4MIY6yLaCQyLvS+LsSb4gBO
         nSIeCkSKuoYFcgucrP9BeDXGBZ3A+vw4CSPI3e3bZmikCixuoonAUStR3hB/7bIo+9YN
         m4taDvV7hqgCSMDrVQrqfGNSyXIr5bVFo40zU7PBRuO4iuhZNH5/3Z4KjUa6uZXCVeBm
         xQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704514526; x=1705119326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niR+ENQYYO/xfLAGwHDq1aRyGA75R5+9RceCgIFLuQI=;
        b=MKeqtnYZiHoCfhkxyKjTHR6cZzYyvW5tAPmOnBKVvQt5dTqbX37lPcz2klb1a4DdQB
         JZUeDB/61mI7GETQorEwIvQx+amZJD2pSbvtvWRey9uizdfWcohCsCsMlL+u94o0LVYW
         9XMxvYZJRBjUTD7Zz8PC1zoiXANOdK18dPoyRxLs3I0J2Ll+6BMco9CBeRM4HmyJTIIQ
         n3fkTdY1ziPHtqZ/iHsdgwJtEq3OLNqEdNi/0gwj1PscQlcwH1zQeaAx3wEn3NpQIJt/
         Ds+bLhf8YrW6G5w4sOaF0WtCuFFwmMyB2U7GEIuS4P7gQxbi2iHfyopERJXWb1QmZe45
         m8Qw==
X-Gm-Message-State: AOJu0Yw+ANIrPrp4fDrHNZC9D+RjQP5Ia59w8s5Z2zolKVE0mMjjD+iW
	KHjFYRNKagOfMSJuBI/vDRuGv7IbBecEW42/S+U3xSgPJx0=
X-Google-Smtp-Source: AGHT+IG1GJIH/AF+uNw8LnoqugY4e+onUOR8bvPNPDdGcwmmL/UfDGC5sObxNfm5jktXnqB3tFEX8/zTutUV2cfvFgQ=
X-Received: by 2002:a05:6102:3a14:b0:467:2ffb:fe3a with SMTP id
 b20-20020a0561023a1400b004672ffbfe3amr242754vsu.17.1704514525611; Fri, 05 Jan
 2024 20:15:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226182531.34717-1-stephen@networkplumber.org>
 <CAM0EoMmH-5Afhe1DvhSJzMhsyx=y7AW+FnhR8p3YbveP3UigXA@mail.gmail.com>
 <20240104072552.1de9338f@kernel.org> <CAM0EoMkP18tbOuFyWgr=BaCODcRTJR=rU6hitcQSY_HD9gD87g@mail.gmail.com>
 <CAHsH6Gsz7ANvWo0DcfE7DYZwVzkmXSGSKwKhJMtA=MtOi=QqqA@mail.gmail.com>
 <CAM0EoMnSVQHyQy37OoznsF15+M84o7L2c6UwtKL1Fcuwev4rHA@mail.gmail.com> <20240105060946.221ca96f@kernel.org>
In-Reply-To: <20240105060946.221ca96f@kernel.org>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Fri, 5 Jan 2024 20:15:14 -0800
Message-ID: <CAHsH6GtbFvWKVy-u0-DvfHz_gs-sDrhfVnJj5mucqMo8jxCs+w@mail.gmail.com>
Subject: Re: [PATCH iproute2-next v2] remove support for iptables action
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, 
	Florian Westphal <fw@strlen.de>, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 6:09=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 5 Jan 2024 06:20:10 -0500 Jamal Hadi Salim wrote:
> > > I tested and it looks like the patch doesn't affect em_ipt, as expect=
ed.
>
> Thank you!
>
> > > I did however run into a related issue while testing - seems that
> > > using the old "ingress" qdisc - that em_ipt iproute2 code still uses =
-
> > > isn't working, i.e:
> > >
> > > $ tc qdisc add dev ipsec1 ingress
> > > Error: Egress block dev insert failed.
> > >
> > > This seems to originate from recent commit 913b47d3424e
> > > ("net/sched: Introduce tc block netdev tracking infra").
> > >
> > > When I disabled that code in my build I was able to use em_ipt
> > > as expected.
> >
> > Resolved in: https://lore.kernel.org/netdev/20240104125844.1522062-1-ji=
ri@resnulli.us/
> > Eyal, if you have cycles please give it a try. Jakub, can we get that a=
pplied?
>
> FTR it was applied by Dave soon after you asked.

Verified. With current net-next the problem doesn't happen anymore.

Thanks!
Eyal.

