Return-Path: <netdev+bounces-59371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EB681AAD5
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 00:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6160C283796
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 23:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883BA4E1CF;
	Wed, 20 Dec 2023 23:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WB+bBQ/E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2584E619
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbd71f33cd3so201275276.3
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 15:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703113264; x=1703718064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kndbi6UPJxN6+T5jqZZQ14R7CnrzIl8QsQoFB2iMQDE=;
        b=WB+bBQ/E1emc3jJ25gQRbrK5viq2nrzeqpYOU21p3cSbhl2T9s+CqkJj4Q9X3gaUQG
         p/8Nqe9wlnOO+src/f2ndqzHlZz7Dkbq0o6S8g/sma70mnEYPF7dSGJg0NlQhwXPrYiA
         AbZ7CVQ+3hmp/iaQ6jYqjBFGlqczfAuNgdG2XkT6PCZscdQ4lmPqDSoP+UT8aq3Z9WaJ
         i5D+AdNRzaZRERkSlGWz8MuK2vGS2c1+NbvSuXsaYLHMKYkLu57UyVJxKVwnRG22qF1L
         qOVcavrZE1hCwIgxACoeIJH5h8KbviQ/do7+xkdVPPxhuAEwKIIQuBT/g4d55iszAA0/
         FrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703113264; x=1703718064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kndbi6UPJxN6+T5jqZZQ14R7CnrzIl8QsQoFB2iMQDE=;
        b=S0dIdMsb8bEIdHQD80DijeSabu+PGLYBVhsSJiefC0XbgVqFnlmzKB8/LX6wWsHR7O
         M/Td+/Or1hQZ9hDSGTNc2gzZETHvqg0dIzQmQqzI1TXPAn/iZ4zgVQEIQTT1mTGDOD4o
         w6O4mpaZACgWhREMq9QMRRYI9T0LbSzBx80JoZkVJS1EDKlnkc36hvAK1s2gbIb3o9fJ
         Q5lqllWiKffDzo5XwvRhTEANQVSHhu+adWd/OusaFESvgCx9/7c+UCbBboj9YnO+Wtx5
         vAKVpRXwx5FOwIJDi7O9LmkdYNL+UfSJQSRZoqEDhh+Td99rBUTEGk1oRYczXe9eGszJ
         mOxA==
X-Gm-Message-State: AOJu0YwWoEyl4Srp4nqa+XwFCTQQS8S9CogGy2+BHqPeWH3XOMDwoEQl
	b+NBomWpH4m0Kn0FiRFWkRjmvaSMlgc3eRvs8DD36A==
X-Google-Smtp-Source: AGHT+IEKvmNUg9bRCaiTBW2ffBMNHNVTN+PuEE8H2zvBjctHE6yEmrhyKhMQv1uFbhEhkvf1gN/e/9FOCU9KjjJHZtc=
X-Received: by 2002:a25:aab4:0:b0:dbd:739c:48ef with SMTP id
 t49-20020a25aab4000000b00dbd739c48efmr495214ybi.19.1703113263987; Wed, 20 Dec
 2023 15:01:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218162326.173127-1-romain.gantois@bootlin.com>
 <20231218162326.173127-2-romain.gantois@bootlin.com> <20231219122034.pg2djgrosa4irubh@skbuf>
 <20231219140754.7a7a8dbd@device-28.home> <CACRpkdaxy9u=1-rQ+f+1tb8xyV-GYOuq52xhb4_SRPk9-LpnUA@mail.gmail.com>
 <20231219172932.13f4b0c3@device-28.home> <20231219224616.pw32w5eq2dbuja5i@skbuf>
 <CACRpkdbo=Oem4PCOtSV6iWJoojRetTgZhx7J91uecTa-DQA8iQ@mail.gmail.com>
In-Reply-To: <CACRpkdbo=Oem4PCOtSV6iWJoojRetTgZhx7J91uecTa-DQA8iQ@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Dec 2023 00:00:52 +0100
Message-ID: <CACRpkdY2U-SmNZ=52qTFBcYtqe63MHdBY=FUFitfBfjb3aYeBQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: stmmac: Prevent DSA tags from breaking COE
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Romain Gantois <romain.gantois@bootlin.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Sylvain Girard <sylvain.girard@se.com>, Pascal EBERHARD <pascal.eberhard@se.com>, 
	Richard Tresidder <rtresidd@electromag.com.au>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 1:43=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:

> Then for *this* driver I need to check for the ethertype
> ETH_P_8021Q what is inside it, one level down, and that is a
> separate helper. And I named it skb_vlan_raw_inner_ethertype()
> It will retrieve the inner type no matter
>
> include/linux/if_vlan.h
>
> +/* This determines the inner ethertype incoded into the skb data without
> + * relying on skb->protocol which is not always identical.
> + */
> +static inline u16 skb_vlan_raw_inner_ethertype(const struct sk_buff *skb=
)
> +{
> +       struct vlan_ethhdr *vhdr;
> +
> +       if (!skb_pointer_if_linear(skb, 0, VLAN_ETH_HLEN))
> +               return 0x0000U;
> +
> +       vhdr =3D vlan_eth_hdr(skb);
> +       return ntohs(vhdr->h_vlan_encapsulated_proto);
> +}
>
> (We can bikeshed the name of the function. *_inner_protocol maybe.)
>
> It does not handle nested VLANs and I don't see why it should since
> the immediate siblings in if_vlan.h does not, i.e.
> vlan_eth_hdr(), skb_vlan_eth_hdr(). It's pretty clear these helpers
> all go just one level down. (We can add a *_descend_*()
> helper the day someone needs that.)

Forget this whole discussion because in <linux/if_vlan.h>
there is already vlan_get_protocol() and vlan_get_protocol_and_depth()
so this problem is already solved, just better.

Yours,
Linus Walleij

