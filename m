Return-Path: <netdev+bounces-45540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F259C7DE0DE
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 13:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFBF1C20CD2
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 12:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18995240;
	Wed,  1 Nov 2023 12:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+WsgAmb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135311FC4
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 12:35:47 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2324D102;
	Wed,  1 Nov 2023 05:35:44 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507d1cc0538so9079926e87.2;
        Wed, 01 Nov 2023 05:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698842142; x=1699446942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qI0/sXLeEnR7YBjCt3Bkt8R3r4WtKotBNkJPydXC1m0=;
        b=m+WsgAmbJMVnRI/t3a4ihUcdGkkUqcljAgKF+bhwo98Wn3yjHnKHyL7gwIjHe4iydl
         w1d133cmXK2GcNUyaHpxbYDTsKHCBSN/F1IvfkqdkuKh1MXDJ6hz4wN5H72bxvhlheRG
         6bveBDRaojrJFRt6ULDDr50EoeHN6Y7MNroLwBTMNPsdsA1HWAtJ3kcsSBxU3w+g1Vqg
         ELuU7tbCXfZmubg0OIDJvmzsObEGY7Txlh3haBqjhFELQ/7BTVUhaj7+RC9MICQ2flsU
         IAl4cG963W6e3EogohGm/cpt/kyMUstXq4nazYUejkBuxyIXYqjF34o6bqTDJ7BTh18n
         pKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698842142; x=1699446942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qI0/sXLeEnR7YBjCt3Bkt8R3r4WtKotBNkJPydXC1m0=;
        b=xGHLlAPBCVTmkftqFrgaQKH9EnsvqOYb8Y50O0XpSWzXNDWxiperBekVYtVeP4zgto
         e1wC87y3WJrfnzVr50zrsGtb9GFtPlm+IexH3v1MfVMXSvkBorQcAPyyN2qgn5/JqCY+
         xwwVwW7ZqoATxE9guxsuFsn4R3jmmklL4mXGVbXHerTm51Xb82zr2mdJ+q14cA0dffmN
         VjCBHaeMHJR+jTfAbR40rmleSWSI/DkszY7WlfZEaUDNE6D4gNyGeaZ1rsmeWM4SSMMi
         RB3Z7EW2x0JxrW9pfGIKP80hSLy67mWMdLQXw3mTPBwI7jzBAuLfbuKwUXIvcThTydv+
         nBag==
X-Gm-Message-State: AOJu0YzC77iVyKtED9KniJImqyF/J/mzo+bDEqUE6GccCWvgx7cxG0Qf
	3RuqYiBR6YN7KNVk951sjpy1Hn11lkFQnAD55ts=
X-Google-Smtp-Source: AGHT+IGJLEW6Sqf73Te7JxYzCXZNSkjnnz6rQhClCjqiGWfTZk7vGQxKsb5qidHtzP4UROk+PRBbVHCYyODqZr13R1Y=
X-Received: by 2002:ac2:4ac1:0:b0:507:a58f:79b0 with SMTP id
 m1-20020ac24ac1000000b00507a58f79b0mr10522069lfp.9.1698842141921; Wed, 01 Nov
 2023 05:35:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf> <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf> <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
 <CAJq09z4+3g7-h5asYPs_3g4e9NbPnxZQK+NxggYXGGxO+oHU1g@mail.gmail.com> <CACRpkdZ-M5mSUeVNhdahQRpm+oA1zfFkq6kZEbpp=3sKjdV9jA@mail.gmail.com>
In-Reply-To: <CACRpkdZ-M5mSUeVNhdahQRpm+oA1zfFkq6kZEbpp=3sKjdV9jA@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 1 Nov 2023 09:35:30 -0300
Message-ID: <CAJq09z6QwLNEc5rEGvE3jujZ-vb+vtUQLS-fkOnrdnYqk5KvxA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em ter., 31 de out. de 2023 =C3=A0s 16:27, Linus Walleij
<linus.walleij@linaro.org> escreveu:
>
> On Tue, Oct 31, 2023 at 8:18=E2=80=AFPM Luiz Angelo Daros de Luca
> <luizluca@gmail.com> wrote:
>
> > > I don't have any other RTL8366RB systems than the D-Link DIR-685.
> > >
> > > I however have several systems with the same backing ethernet control=
ler
> > > connected directly to a PHY and they all work fine.
> >
> > Hi Linus,
> >
> > I ported TL-WR1043nd to DSA using RTL8366RB on OpenWrt main. Do you
> > need some help testing the switch?
>
> Yes!
>
> > I just need to test ping with different sizes?
>
> Yes try to ping the host from the router:
>
> ping -s 1472 192.168.1.1 or so to send a 1500 byte ping packet,
> which will be padded up to a 1518 byte ethernet frame and
> 1522 bytes from the conduit interface.
>
> Then if it doesn't work, see if this patch solves the issue!

Hi Linus,

Sorry but I noticed no issues:

From the router:

No. Time Source Destination Protocol Length Info
1 0.000000000 192.168.1.1 192.168.1.2 ICMP 1514 Echo (ping) request
id=3D0x0789, seq=3D23/5888, ttl=3D64 (reply in 2)
2 0.000040094 192.168.1.2 192.168.1.1 ICMP 1514 Echo (ping) reply
id=3D0x0789, seq=3D23/5888, ttl=3D64 (request in 1)
5 1.000361559 192.168.1.1 192.168.1.2 ICMP 1514 Echo (ping) request
id=3D0x0789, seq=3D24/6144, ttl=3D64 (reply in 6)
6 1.000439668 192.168.1.2 192.168.1.1 ICMP 1514 Echo (ping) reply
id=3D0x0789, seq=3D24/6144, ttl=3D64 (request in 5)

From the host:

No. Time Source Destination Protocol Length Info
1 0.000000000 192.168.1.2 192.168.1.1 ICMP 1514 Echo (ping) request
id=3D0x0002, seq=3D8/2048, ttl=3D64 (reply in 2)
2 0.000391800 192.168.1.1 192.168.1.2 ICMP 1514 Echo (ping) reply
id=3D0x0002, seq=3D8/2048, ttl=3D64 (request in 1)
3 1.024825212 192.168.1.2 192.168.1.1 ICMP 1514 Echo (ping) request
id=3D0x0002, seq=3D9/2304, ttl=3D64 (reply in 4)
4 1.026865170 192.168.1.1 192.168.1.2 ICMP 1514 Echo (ping) reply
id=3D0x0002, seq=3D9/2304, ttl=3D64 (request in 3)

If I go over that limit, it fragments the packet as expected.

My device is using
https://github.com/luizluca/openwrt/tree/ath79_dsa_prep%2Bdevices . In
summary, kernel 6.1 with openwrt generic patches and the
reset-controller patch I sent net-next recently.

[    3.888540] realtek-smi switch: found an RTL8366RB switch
[    3.952366] realtek-smi switch: RTL5937 ver 3 chip found
[    3.967086] realtek-smi switch: set MAC: 42:E4:F5:XX:XX:XX
[    3.976779] realtek-smi switch: missing child interrupt-controller node
[    3.983455] realtek-smi switch: no interrupt support
[    4.158891] realtek-smi switch: no LED for port 5
[    4.164130] realtek-smi switch: configuring for fixed/rgmii link mode
[    4.171178] realtek-smi switch wan (uninitialized): PHY [SMI-0:00]
driver [RTL8366RB Gigabit Ethernet] (irq=3DPOLL)
[    4.183849] realtek-smi switch lan1 (uninitialized): PHY [SMI-0:01]
driver [RTL8366RB Gigabit Ethernet] (irq=3DPOLL)
[    4.196439] realtek-smi switch lan2 (uninitialized): PHY [SMI-0:02]
driver [RTL8366RB Gigabit Ethernet] (irq=3DPOLL)
[    4.209258] realtek-smi switch lan3 (uninitialized): PHY [SMI-0:03]
driver [RTL8366RB Gigabit Ethernet] (irq=3DPOLL)
[    4.221815] realtek-smi switch lan4 (uninitialized): PHY [SMI-0:04]
driver [RTL8366RB Gigabit Ethernet] (irq=3DPOLL)
[    4.243071] realtek-smi switch: Link is Up - 1Gbps/Full - flow control o=
ff
[    9.707171] realtek-smi switch lan1: configuring for phy/gmii link mode
[    9.727707] realtek-smi switch lan1: Link is Up - 1Gbps/Full - flow
control rx/tx
[   12.289349] realtek-smi switch lan1: Link is Down
[   55.761797] realtek-smi switch lan1: configuring for phy/gmii link mode
[   57.460421] realtek-smi switch lan2: configuring for phy/gmii link mode
[   57.505039] realtek-smi switch lan3: configuring for phy/gmii link mode
[   57.823528] realtek-smi switch lan4: configuring for phy/gmii link mode
[   58.000712] realtek-smi switch lan1: Link is Up - 1Gbps/Full - flow
control rx/tx
[   58.181047] realtek-smi switch wan: configuring for phy/gmii link mode

Maybe the ag71xx driver is doing something differently.

Let me know if you need to test anything else. I didn't test the
device with your patch applied.

Regards,

Luiz

