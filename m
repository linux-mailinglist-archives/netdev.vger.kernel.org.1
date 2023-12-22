Return-Path: <netdev+bounces-59917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2698F81CA9F
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 14:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880F61F215E1
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA96A18B00;
	Fri, 22 Dec 2023 13:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIrzMt4B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A88B200A5
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e587fb62fso2676768e87.2
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 05:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703251352; x=1703856152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCg4NGFhBfmCLnD5+0zz/s65Er4SqV6IwYzGmR8Vu14=;
        b=DIrzMt4Bnp4BK4VzMkff3D0ucGFWr7sVUX2o++J4S9ibsbU2Qulm4SpVL+ox9UYvAL
         LptZsXrz9UFPxV2A/+jD1FuMlH8yNWvADAuaiSx6f1C/eSwUkRbZxGycS/cVqg9cAGCi
         O3AiuyQZH36AyHIMKMj6PiMZuMeaC4p9mSJGt553zYld90cVb0N6RBvJ6pMTzJcGH/kH
         F6x5lKFlfS9c22gvTwVGkBhOGGtQ4/ThzlBtsOOSZkxJXzWVXDOP2lY9Dml69ZcMegVu
         NZHjj8ATEwWOs75ZKO71SapfU0WZWfisvRrg97K9bAyD4qAr8tkb3unA/JDJXmxXn3yu
         MEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703251352; x=1703856152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCg4NGFhBfmCLnD5+0zz/s65Er4SqV6IwYzGmR8Vu14=;
        b=IMTVj8vOlndDYhIfTks4/haVXAGk1XTD7R8xxtfpXB1A/g1r+E8D9e3Q6kONa23Ix0
         EzpDuJ0GBhEhSUYMCfiEeucz/QJHkM+a2m/NLkO8J+7ycO4z5rp7Au8VisjUCQodL/mq
         DUMWLbS3eEaSQAtAYf6smAfdyRllEYkZ6c3ButSBedAmAaSph4iT0eyUmtBGXno+E3ke
         OhFH8aZxbq9zP9SYqR9HI+6tiPhh0TFkdmXHEU6O5BMJkuRknEiJ4F6dXW/XaTY3EO32
         yda4sJWq9CqacadTbWBViZijZaeeWX80ZxqTgDxMb91+l7cTbq6GMEN+Uk8X6rGr/OyV
         2Wpg==
X-Gm-Message-State: AOJu0YyyS6aV8xAPFvu0c/S3cNno3Rf4vWI9bx/SBo/HiGy2uSdlEHBt
	aOlBPzH2tbV8SlPNcOxisk9ZpWzCJqsFOjlT2N49DwtXxM8Mtg==
X-Google-Smtp-Source: AGHT+IEm2K9H4BRA+l/wrsKkcMi1cxDqAKEX9W7cDmtxAKS7BiLw5eyeiIHC45GgDw1CYe0oxjDL24n7vB4o8r07TJA=
X-Received: by 2002:a19:5504:0:b0:50e:3107:29cd with SMTP id
 n4-20020a195504000000b0050e310729cdmr666976lfe.34.1703251351603; Fri, 22 Dec
 2023 05:22:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
 <0351C5C2-FEE2-4AED-84C8-9DCACCE4ED0A@aol.com> <20231222123023.voxoxfcckxsz2vce@skbuf>
In-Reply-To: <20231222123023.voxoxfcckxsz2vce@skbuf>
From: Lucas Pereira <lucasvp@gmail.com>
Date: Fri, 22 Dec 2023 10:22:21 -0300
Message-ID: <CAG7fG-bDdtTxWkv8690+LHE5DVMKUn_+pQGsFVHxjXYPrLnN_w@mail.gmail.com>
Subject: RE: [PATCH net 0/1] Prevent DSA tags from breaking COE
To: Vladimir Oltean <olteanv@gmail.com>, Household Cang <canghousehold@aol.com>
Cc: Romain Gantois <romain.gantois@bootlin.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Sylvain Girard <sylvain.girard@se.com>, 
	Pascal EBERHARD <pascal.eberhard@se.com>, Richard Tresidder <rtresidd@electromag.com.au>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear community collaborators,

First of all, I would like to thank you for the prompt response and
the suggestions provided.

We conducted the tests as indicated, but unfortunately, the problem
persists. It seems to me that if it were a Checksum-related issue, the
behavior would be different, as the VPN and communication work
normally for several days before failing suddenly.

We have observed that the only effective ways to reestablish
communication, so far, are through a system reboot or by changing the
authentication cipher, such as switching from MD5 to SHA1.
Interestingly, when switching back to the MD5 cipher, the
communication fails to function again.

I am immensely grateful for the help received so far and would greatly
appreciate any further suggestions or recommendations that you might
offer to resolve this challenge.

Sincerely,
Lucas

________________________________
De: Vladimir Oltean <olteanv@gmail.com>
Enviado: sexta-feira, 22 de dezembro de 2023 09:30
Para: Household Cang <canghousehold@aol.com>
Cc: Romain Gantois <romain.gantois@bootlin.com>; Alexandre Torgue
<alexandre.torgue@foss.st.com>; Jose Abreu <joabreu@synopsys.com>;
David S. Miller <davem@davemloft.net>; Eric Dumazet
<edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
<pabeni@redhat.com>; Maxime Coquelin <mcoquelin.stm32@gmail.com>;
Miquel Raynal <miquel.raynal@bootlin.com>; Maxime Chevallier
<maxime.chevallier@bootlin.com>; Sylvain Girard
<sylvain.girard@se.com>; Pascal EBERHARD <pascal.eberhard@se.com>;
Richard Tresidder <rtresidd@electromag.com.au>; netdev@vger.kernel.org
<netdev@vger.kernel.org>; linux-stm32@st-md-mailman.stormreply.com
<linux-stm32@st-md-mailman.stormreply.com>;
linux-arm-kernel@lists.infradead.org
<linux-arm-kernel@lists.infradead.org>
Assunto: Re: [PATCH net 0/1] Prevent DSA tags from breaking COE

Hi Lucas,

On Thu, Dec 21, 2023 at 02:40:34AM -0500, Household Cang wrote:
> > On Dec 18, 2023, at 11:23 AM, Romain Gantois <romain.gantois@bootlin.co=
m> wrote:
> >
> > This is a bugfix for an issue that was recently brought up in two
> > reports:
> >
> > https://lore.kernel.org/netdev/c57283ed-6b9b-b0e6-ee12-5655c1c54495@boo=
tlin.com/
> > https://lore.kernel.org/netdev/e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@ele=
ctromag.com.au/
> >
> Add me in to be the 3rd report...
> RK3568 GMAC0 (eth1) to MT7531BE (CPU port)
> Current workaround for me is ethtool -K eth1 rx off tx off

Is "rx off" actually required, or just "tx off"?

> https://lore.kernel.org/netdev/m3clft2k7umjtny546ot3ayebattksibty3yyttpff=
vdixl65p@7dpqsr5nisbk/T/#t
>
> Question on the patch to be built: how would I know if my setup could
> take advantage of the HW checksum offload? RK3658=E2=80=99s eth0 on stmma=
c is
> doing fine, and eth0 is not on a DSA switch. Does this mean eth1
> should be able to do hw checksum offload once the stmmac driver is
> fixed?

The MT7531BE switch requires transmitted packets to have an additional
header which indicates what switch port is targeted. So the packet
structure is not the same as what eth0 transmits.

Your GMAC datasheet should explain what packets it is able to offload
L4 checksumming for, quite plainly. Probably MAC + IP + TCP yes, but
MAC + MTK DSA + IP + TCP no.

The bug is that the network stack thinks that the GMAC is able to
offload TX checksums for these MTK DSA tagged packets, so it does not
calculate the checksum in software, leaving the task up to the hardware.
My guess is that the hardware doesn't recognize the packets as something
that is offloadable, so it doesn't calculate the checksum either, and
that's the story of how you end up with packets with bad checksums.

The patch to be built should analyze the packet before passing it to a
hardware offload engine which will do nothing. The driver still declares
the NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM features because it is able to
offload checksumming for _some_ packets, but it falls back to the
software checksum helper for the rest. This includes your MTK DSA tagged
packets. They can be checksummed in software even with the DSA tag added,
because that uses the more generic mechanism with skb->csum_start and
skb->csum_offset, which DSA is compatible with, just fine. The GMAC
driver, most likely because of the lack of hardware support, does not
look at skb->csum_start and skb->csum_offset (aka it does not declare
the NETIF_F_HW_CSUM feature), so it cannot offload checksumming for your
switch traffic unless that was specifically baked into the RTL.

More details in the "Switch tagging protocols" section of
Documentation/networking/dsa/dsa.rst.

