Return-Path: <netdev+bounces-56084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C9780DC8A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9452282533
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 21:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD72254BDB;
	Mon, 11 Dec 2023 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUwHRtyv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D24C8
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 13:08:10 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bf32c0140so5636117e87.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 13:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702328888; x=1702933688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OmJIZ0olQXMR6bPgI94+JMayaJsWSV5kcghFDyz/lX4=;
        b=JUwHRtyvriRWXjY71hbj+KPqccugt6c8C0KurIGZeroLhb74y3fmDm0g2jDsL5mT1H
         nSiszHX5Ujvw+LIaYHE9tQLngzUwti1HfJ4Yjc8C2//0KbhXp5wrjJpuRwkqyP+O60k8
         wcsoNP3ERoOY6LTF+ycwEnc0DrECmxbNEb20LCGJaqWIetueLcEjVkAt0mDn9ne71gHp
         21BR9uEaKIuNqOoTzeQMzLjOAeNZnw/tFf/MXm+XMIiVbEfn4izRHHD0uj81a/Be8DIR
         ofx2fm9OQnyn8V503+Hh5bdqHFzTgapUw9zfQCQKDvGSFjrJ7uMIRaJ2VaHFucsjol2T
         pIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702328888; x=1702933688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmJIZ0olQXMR6bPgI94+JMayaJsWSV5kcghFDyz/lX4=;
        b=XSB/LBBpRfucVOK6aag0MqRZK+VpKQ2ctmaJ3avpr+4ur/A0jbref2d+i87s9DHi0Q
         T9ST7kXtRqpCIIP81rb0x2c6lIINSNVhAg1SoVsyNrr2tO4Q1a86HeFjGBoIPZWgbm5l
         SD07kXo7YgnF3LLiUlJWg4pHPXpmE6UjS9klMxRYB3Map6Nzpg/MQsG+VL5Zv0aECXvh
         BXZHsZiX5dmQxR3PtmI7MQUoHvZ7UJc979Cqql7/Qhg7DfYM34jcIG3nmshiTPRKeYzn
         00j3FeowrtBZxLtQW+6j2pcztJLHDksff2vFOUCC1Txr1IAmu7Oo6M0XKMHQbqsxhq+g
         Y1xQ==
X-Gm-Message-State: AOJu0YxFunjYwua3q6/7EEWjCmK5dx6Z3DhvNjxesURR5FWGrBRMOvbu
	TlPdRpP/rE2JNc2CmTayBxiIOzrbNVRGOk/MOEc=
X-Google-Smtp-Source: AGHT+IGtGQUoLZTw11446u0S2aA8lLQK8yotmayw/fuYK+1cRdjq3Q5lulOAV4jMIMFcCCMdSc0B1eXDLxXMToYqwJU=
X-Received: by 2002:a05:6512:3da2:b0:50d:12fe:4881 with SMTP id
 k34-20020a0565123da200b0050d12fe4881mr3529888lfv.4.1702328888166; Mon, 11 Dec
 2023 13:08:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org>
 <20231209-rtl8366rb-mtu-fix-v1-2-df863e2b2b2a@linaro.org> <CAJq09z4fJmc9=CwdVSS_+LfOS9ax+voWrkPMwDmiBtrCwzc20A@mail.gmail.com>
 <20231211153054.vpgbx7oufazujtzf@skbuf>
In-Reply-To: <20231211153054.vpgbx7oufazujtzf@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 11 Dec 2023 18:07:56 -0300
Message-ID: <CAJq09z7dTa3wB48aE0CkskvcE0vx5nM6VNzBtZzBGqTFxaV0CA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: realtek: Rewrite RTL8366RB MTU handling
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> > I'm not sure you need this old code. Whenever you change the MTU in a
> > user port, it will also call rtl8366rb_change_mtu() for the CPU port
> > if the max MTU changes. A call to change both the port and the CPU
> > port makes sense when you need to update something inside the switch
> > to set the MTU per port. However, these realtek switches only have a
> > global MTU size for all ports. What I did in rtl8365mb is to ignore
> > any MTU change except it is related to the CPU port. I hope this is a
> > "core feature" that you can rely on.
>
> Ha, "core feature" :-/
>
> It is a valid way to simplify the programming of a register that is
> global to the switch, when the DSA methods are per port. The largest_mtu
> is programmed via DSA_NOTIFIER_MTU to all cascade and CPU ports. So it
> makes sense to want to use it. But with a single CPU port, the driver
> would program the largest_mtu to hardware once. With 2 CPU ports (not
> the case here), twice (although it would still be the same value).

I don't see it as a problem. The DSA API is saying to the driver: this
port must now accept this MTU. And it will send it multiple times, at
least for the user port and one or more CPU ports. The driver must
handle that "message" the best it can. I believe we just need to
describe this behavior to make it "official". I discovered that
behavior empirically and then I read the code. Something like this
would be nice:

/*
* MTU change functionality. Switches can also adjust their MRU through
* this method. By MTU, one understands the SDU (L2 payload) length.
* If the switch needs to account for the DSA tag on the CPU port, this
-* method needs to do so privately.
+* method needs to do so privately. An MTU change will also be
+* propagated to every CPU port when the largest MTU in the switch
+* changes, either up or down. Switches with only a global MTU setting
+* can adjust the MTU based only on these calls targeting CPU ports.
*/
int (*port_change_mtu)(struct dsa_switch *ds, int port,
   int new_mtu);

> To do as you recommend would still not make it a "core feature".
> That would be if DSA were to call a new ds->ops->set_global_mtu() with a
> clear contract and expectation about being called once (not once per CPU
> port), and with the maximum value only.

Do we really need to expand the API? A new ds_ops.set_global_mtu() is
just giving the same but less specific info as
ds_ops.port_change_mtu(). I prefer to work in an API with fewer
functions than more optional functions for each specific HW design. It
just makes writing a new driver more complex. The code in the DSA side
will also be more complex with more code paths when only
set_global_mtu is defined.

If setting the MTU multiple times is a problem for a switch, the
driver must keep track of the current global MTU value and do nothing
when not needed. In the case of rtl8366rb, the MTU works in specific
ranges. In many cases, changing the MTU inside a range would not have
an effect on the switch (although the code is still writing the
register with the same value).

> Searching through the code to see how widespread the pattern is, I
> noticed mv88e6xxx_change_mtu() and I think I found a bug.
>
> static int mv88e6xxx_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
> {
>         struct mv88e6xxx_chip *chip = ds->priv;
>         int ret = 0;
>
>         /* For families where we don't know how to alter the MTU,
>          * just accept any value up to ETH_DATA_LEN
>          */
>         if (!chip->info->ops->port_set_jumbo_size &&
>             !chip->info->ops->set_max_frame_size) {
>                 if (new_mtu > ETH_DATA_LEN)
>                         return -EINVAL;
>
>                 return 0;
>         }
>
>         if (dsa_is_dsa_port(ds, port) || dsa_is_cpu_port(ds, port))
>                 new_mtu += EDSA_HLEN;
>
>         mv88e6xxx_reg_lock(chip);
>         if (chip->info->ops->port_set_jumbo_size)
>                 ret = chip->info->ops->port_set_jumbo_size(chip, port, new_mtu);
>         else if (chip->info->ops->set_max_frame_size)
>                 ret = chip->info->ops->set_max_frame_size(chip, new_mtu);
>         mv88e6xxx_reg_unlock(chip);
>
>         return ret;
> }
>
> If the chip uses set_max_frame_size() - which is not per port - then it
> will accept any latest value, and not look just at the largest_mtu.

It might just work as the latest value will be the CPU port that is
guaranteed to be the largest one. However, it might temporarily lower
the global MTU between the user and the CPU MTU change. In order to
fix that, it just needs to ignore user port changes.

> b53_change_mtu() also looks like it suffers from a similar problem, it
> always programs the latest per-port value to a global register.

Latest will, in the end, just work because it is a CPU port and the
MTU the largest one. Maybe the sequence could change in a
multithreaded system but I didn't investigate that further. Anyway,
focusing on the CPU port would just work.

> So I guess there is ample opportunity to get this wrong, and maybe
> making the global MTU "core functionality" is worth considering.
> As "net-next" material - I think the bugs are sufficiently artificial,
> and workarounds exist, to not bother the stable kernels with fixes over
> the existing API.
>
> Would you volunteer to do that?

I don't believe we should expand the API but I will volunteer to
update the port_change_mtu comment if accepted. I can also suggest
changes to other drivers when needed but I prefer to not do that
without a proper HW to test it.

Regards,

Luiz

