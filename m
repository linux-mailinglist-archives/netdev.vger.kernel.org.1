Return-Path: <netdev+bounces-61312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA1A8234C4
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 19:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4807B2316A
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2631C298;
	Wed,  3 Jan 2024 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbkzk1ts"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D461C6A5
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e8ca6c76dso5515611e87.3
        for <netdev@vger.kernel.org>; Wed, 03 Jan 2024 10:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704307503; x=1704912303; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L2J9xLq90/SXHf7CgG58udv6ZLtuy8QjdPZKLMi556k=;
        b=kbkzk1ts0ch4DF/tLu0x2/B4EXZtmJzdx9diT2XrKe2tKBHBixBcdOGu6xLsZhNdgl
         IeRQdhXQB2C8vs11r+WPdAUjVwkqXZwMtQ+qghaD+40rsTf0AtTrIxI6wQ/KM7HNYwKi
         kirQuuyG1+87Ww7XGTCbb+DcQhnwafVhdsImqrUwRTmQIccp756QeXSZaXTbqb+vSP/Z
         40yljR7orBVGgpCfPhJaTNEx/vAo+Yuc/RUrLhNQsh8ybm50Dr+u8tnKwbw9WckQptNG
         Rbyb0KqoR8/o9Ppegkn3aUNVBYjnftxk+oIkQwbKFthehuebHDnOjgMDQ+kil6S/ueq2
         PzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704307503; x=1704912303;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2J9xLq90/SXHf7CgG58udv6ZLtuy8QjdPZKLMi556k=;
        b=PdACkvlKxXfq2pFXHoRm2XqmajaSuw+rDWpSLOid4BzBzdjSmwepNV+fmJnpyss9va
         3/yu4JZpCtkzes8/T7OZHlsyjc+nooxKlMGRjdReczxXFtZ84sViEhTyrouVKH27+qAf
         SZURXHPxyDetK9LSmPtAgSFCiPzLfqjpbyTMMcA4Ijg1BTKGsQbzXeIkCXufHlfnoqDB
         0L7AiqvfkA6UWBAP+3rEBp0pgv73lAghDnE8890Ne0UZKERFa11y/ho005wIMhIaCESY
         wl/Zzl838bL5qyPHCxzvmj7/qrbaLi6ZOGsYE3enok5HQFZjE6wSFPj9mCvI4AH8RKCq
         2rhg==
X-Gm-Message-State: AOJu0YynqJEs+oZ9w/dVax9fDZQS43ZjWFPQNfQ5M331GAj365aJYXJz
	FyiFSgF1k9Po5+/2Kmt6gio=
X-Google-Smtp-Source: AGHT+IHqAqZwYLhnhuwkVuXJxE0YgYZolVqeE6ZVli9Cq0ZCtSujlLdANlQlcVGdUHi2h85htFiHdw==
X-Received: by 2002:a19:f814:0:b0:50e:76f7:a74c with SMTP id a20-20020a19f814000000b0050e76f7a74cmr6146324lff.67.1704307502612;
        Wed, 03 Jan 2024 10:45:02 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm17614415eda.44.2024.01.03.10.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 10:45:02 -0800 (PST)
Date: Wed, 3 Jan 2024 20:44:59 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/7] net: dsa: realtek: Migrate user_mii_bus
 setup to realtek-dsa
Message-ID: <20240103184459.dcbh57wdnlox6w7d@skbuf>
References: <20231220042632.26825-1-luizluca@gmail.com>
 <20231220042632.26825-6-luizluca@gmail.com>
 <CAJq09z4OP6Djuv=HkntCqyLM1332pXzhW0qBd4fc-pfrSt+r1A@mail.gmail.com>
 <20231221174746.hylsmr3f7g5byrsi@skbuf>
 <d74e47b6-ff02-41f4-9929-02109ce39e12@arinc9.com>
 <20231222104831.js4xiwdklazytgeu@skbuf>
 <461d86e8-21db-47fc-a878-7c532a592ac7@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <461d86e8-21db-47fc-a878-7c532a592ac7@arinc9.com>

On Fri, Dec 22, 2023 at 07:56:48PM +0300, Arınç ÜNAL wrote:
> We should also align all DSA subdrivers with this understanding. I will
> modify the MDIO bus patch I submitted for the MT7530 DSA subdriver
> accordingly.

I began working on this, and I do have some patches. But returns start
to diminish very quickly. Some drivers are just not worth it to change.
So I will also respin the documentation patch set to at least advise to
not continue the pattern to new drivers.

> I was wondering of moving the MDIO bus registration from DSA subdrivers to
> the DSA core driver but probably it's not generic enough across switch
> models with multiple MDIO buses and whatnot to manage this.

Actually this is the logic after which everything starts to unravel -
"multiple DSA switches have internal MDIO buses, so let's make DSA
assist with their registration".

If you can't do a good job at it, it's more honest to not even try -
and you gave the perfect example of handling multiple internal MDIO buses.

I just don't want to maintain stuff that I am really clueless about.
If registering an MDIO bus is so hard that DSA has to help with it,
make the MDIO API better.

Where things would be comfortable for me is if the optional ds->user_mii_bus
pointer could be always provided by individual subdrivers, and never allocated
by the framework. So that dsa_switch_ops :: phy_read() and :: phy_write()
would not exist at all.

