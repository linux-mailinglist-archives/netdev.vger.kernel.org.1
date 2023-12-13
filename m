Return-Path: <netdev+bounces-56715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F94481092B
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 05:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BD58B20D7A
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 04:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8EDC129;
	Wed, 13 Dec 2023 04:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHQRDPRo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703CFBE
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 20:37:40 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2ca03103155so82244811fa.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 20:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702442259; x=1703047059; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F9Hvj1CI87bSyTtY3Nn5BEEq2OjlpbUtSmA5JvSAHcw=;
        b=fHQRDPRoXzr9m01qSAYKWIrFhAF+qYNjSWlNBspb/071PCwhOX2DopgLarTmXH5UXT
         W6DQztjh9VsLPRebj0Q7ZGGFTP9+0DvRJIhAtR5VprnFB0chdHh3FoNsGaDqBZQpKeWn
         vIEbH2Gul3KEJzZLHQx+s0wOP+IVci1A3NBGwg+TEGiUDsuFSsWU19n0vq2phRwXWdue
         VKapHe38c7Ageurv1sKApkV3SamI0uo0u2rC9/zXv8nCuijrZDa/ie6ytt7ABc9nFkBA
         Ixy5/xJmflRb+75mwSsv59AnTV+4eUlD61A4m5PxTtQfn3DSwHG8z4xZu+9MzshfevdF
         q2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702442259; x=1703047059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9Hvj1CI87bSyTtY3Nn5BEEq2OjlpbUtSmA5JvSAHcw=;
        b=nUhLMLIK3WDXgyc0paGap7dYbW4keBVhNakDXTKekT837epAsqnTezwt4+upvr7rs+
         6hANYddUiNKsovjTHWovJ+4q3CD8zlDVzXCKRC1dP+Rjtig5/cDP0s2z2xPX9T66j+V/
         NyZP2hNVm/MCotmHXQIEFBTfOzmas8eHNTn06/kzu7DWBPCCWfUlTjj3iCuWjOoGkxAY
         E5QAfD8hHpW8frNqQfz6/OmVg/5sBlZaSxMyjYZKIC3rquRFr4NXc/927j9vmNsfbwyu
         WpwDmBJYX0K8tPUnug1kwDFL46WPKfq4nmMcib9iHWZXxb+U/Z7VGXz4xirzEUiee4QC
         9hUA==
X-Gm-Message-State: AOJu0Yx3IJ+R3A0K8VBLxx1CluJTBhOMTopCARJzbuLtll37JPY26JEC
	XNNe7Z8gyYC84dZ4kfT10gnqDJKJGnoJY93YMTI=
X-Google-Smtp-Source: AGHT+IFmn6KlKQWSgLKn7Ex6s+CB/nf30BdVTvYJkxSf1jd3JerxKZug26YsaKIYjBzpbFdJ0H3eOXkGtBJWq+a2a4E=
X-Received: by 2002:a19:655a:0:b0:50b:fe63:ef9 with SMTP id
 c26-20020a19655a000000b0050bfe630ef9mr2246825lfj.73.1702442258314; Tue, 12
 Dec 2023 20:37:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208045054.27966-1-luizluca@gmail.com> <20231208045054.27966-3-luizluca@gmail.com>
 <CAJq09z7yykDsh2--ZahDX=Pto9SF+EQUo5hBnrLiWNALeVY_Bw@mail.gmail.com>
 <i3qp6sjkgqw2mgkbkrpgwxlbcdblwfp6vpohpfnb7tnq77mrpc@hrr3iv2flvqh>
 <CAJq09z45WQv-F9dw-y13E_6DXAfmpxH20JnRoO10za3cuS2kZw@mail.gmail.com>
 <20231211171143.yrvtw7l6wihkbeur@skbuf> <CAJq09z6G+yyQ9NLmfTLYRKnNzoP_=AUC5TibQCNPysb6GsBjqA@mail.gmail.com>
 <20231212215801.ey74tgywufywa3ip@skbuf>
In-Reply-To: <20231212215801.ey74tgywufywa3ip@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 13 Dec 2023 01:37:27 -0300
Message-ID: <CAJq09z6veGUNymR6hxabBPercR6+7gFC-FhwiVM+wScm5xDREA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/7] net: dsa: realtek: put of node after MDIO registration
To: Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> > The unregistration happens only in mdiobus_unregister(), where, I
> > guess, it should avoid OF-specific code. Even if we put OF code there,
> > we would need to know during mdiobus_unregister() if the
> > bus->dev.of_node was gotten by of_mdio or someone else.
> >
> > I believe it is not nice to externally assign dev.of_node directly to
> > mdiobus but realtek switch driver is doing just that and others might
> > be doing the same thing.
>
> Well, make up your mind: earlier you said the user_mii_bus->dev.of_node
> assignment from the Realtek DSA driver is redundant, because
> devm_of_mdiobus_register() -> ... -> __of_mdiobus_register() does it
> anyway. So if it's redundant, you can remove it and nothing changes.
> What's so "not nice" about it that's worth complaining?
>
> Are you trying to say that you're concerned that some drivers might be
> populating the mii_bus->dev.of_node manually, and then proceeding to
> call the _non-OF_ mdiobus_register() variant?

Yes. Just like that. :)

> Some drivers like bcm_sf2.c? :)

Yeah.

> That will be a problem, yes. If a clean result is the goal, I guess some
> consolidation needs to be done before any new rule could be added.
> Otherwise, yeah, we can just snap on one more lazy layer of complexity,
> no problem. My 2 cents.
>
> > The delegation of of_node_get/put to the caller seems to be just an
> > easy workaround the fact that there is no good place to put a node
> > that of_mdio would get. For devm functions, we could include the
> > get/put call creating a new devm_of_mdiobus_unregister() but I believe
> > devm and non-devm needs to be equivalent (except for the resource
> > deallocation).
>
> How did we get here, who suggested to get and put the references to the
> OF node outside of the OF MDIO API?

It is not a suggestion. If it was a suggestion (like in a comment), it
would be a little bit better. Some got it right and some didn't.

The OF API will only return you a node with the refcount incremented.
You need to put it in somewhere after that. That will happen no matter
how you use the node and that's OK. The problem is when I pass that
reference to another function, I need to somehow know if it keeps a
reference to that node and not increments the refconf. If it does not
keep the reference, it is OK. If it keeps the reference and gets it,
it is also OK.

The answer "just read (all the multiple level and different) code
(paths)" is fated to fail. The put after registration in DSA core code
is just an example of how it did not work.

> > > If you want, you could make the OF MDIO API get() and put() the reference,
> > > instead of using something it doesn't fully own. But currently the code
> > > doesn't do that. Try to acknowledge what exists, first.
> >
> > What I saw in other drivers outside drivers/net is that one that
> > allocates the dev will get the node before assigning dev.of_node and
> > put it before freeing the device. The mdiobus case seems to be
> > different. I believe it would make the code more robust if we could
> > fix that inside OF MDIO API and not just document its behavior. It
> > will also not break existing uses as extra get/put's are OK.
> >
> > I believe we could add an unregister callback to mii_bus. It wouldn't
> > be too complex:
> >
> > From b5b059ea4491e9f745872220fb94d8105e2d7d43 Mon Sep 17 00:00:00 2001
> > From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > Date: Tue, 12 Dec 2023 00:26:06 -0300
> > Subject: [PATCH] net: mdio: get/put device node during (un)registration
> >
> > __of_mdiobus_register() was storing the device node in dev.of_node
> > without increasing its refcount. It was implicitly delegating to the
> > caller to maintain the node allocated until mdiobus was unregistered.
> >
> > Now, the __of_mdiobus_register() will get the node before assigning it,
> > and of_mdiobus_unregister_callback() will be called at the end of
> > mdio_unregister().
> >
> > Drivers can now put the node just after the MDIO registration.
> >
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > ---
> > drivers/net/mdio/of_mdio.c | 12 +++++++++++-
> > drivers/net/phy/mdio_bus.c |  3 +++
> > include/linux/phy.h        |  3 +++
> > 3 files changed, 17 insertions(+), 1 deletion(-)
>
> I don't mean to be rude, but I don't have the time to dig into this any
> further, sorry. If you are truly committed to better the phylib API,
> please bring it up with the phylib people instead. I literally only
> care about the thing that Alvin pointed out, which is that you made
> unjustified changes to a DSA driver.

Sure, phylib is still for netdev, right?

I'll redo this patch to avoid putting the node before unregistration.

> > If we don't fix that in OF MDIO API, we would need to fix
> > fe7324b932222 as well, moving the put to the dsa_switch_teardown().
>
> Oh, couldn't we straight-up revert that instead? :) The user_mii_bus
> is created by DSA for compatibility with non-OF. I cannot understand
> why you insist to attach an OF node to it.

Please, not before this patch series gets merged or you'll break
MDIO-connected Realtek DSA switches, at least the IRQ handling.
I'll send the revert myself afterwards.

> But otherwise, yes, it is the same situation: of_node_put(), called
> before unregistering an MDIO bus registered with of_mdiobus_register(),
> means that the full OF API on this MDIO bus may not work correctly.
> I don't know the exact conditions though. It might be marginal or even
> a bug that's impossible to trigger. I haven't tested anything.

OK. I'll not try to fix that but revert it as soon as possible without
breaking existing code. You need too much conditions to make it
trigger a bug:
1) use dynamic OF
2) no other code also keep a reference to that node
3) a call that actually reads the of_node from user_mii.dev

But, as you pointed out, OF and user_mii should not work together.

> In any case, while I encourage you to make OF node refcounting work in
> the way that you think is intuitive, I want to be clear about one thing,
> and that is that I'm not onboard with modifying phylib to make a non
> use-case in DSA work, aka OF-aware user_mii_bus (an oxymoron).

The change to MDIO code would not be a requirement for this patch
series. I'll deal with each front independently.

> I understand why a driver may want a ds->user_mii_bus. And I understand
> why a driver may want an MDIO bus with an of_node. What I don't understand
> is who might want both at the same time, and why.

That one I might be novice enough to answer :).

When you start to write a new driver, you read the docs to get a
general idea. However, as code moves faster than docs, you mainly rely
on code. So, you just choose a driver (or a couple of them) to inspire
you. You normally prefer a small driver because it is less code to
read and it might be just enough to get started. As long as it is
mainline, nothing indicates it should not be used as a reference.

I wasn't the one that wrote most of the Realtek DSA driver but I see
the same OF + user_mii_bus pattern in more than one driver. If you
want to stop spreading, as rewriting all affected drivers might not be
an option, a nice /* TODO: convert to user YXZ */ comment might do the
trick. An updated doc suggesting a driver to be used as an example
would also be nice.

The doc update you sent about the "user MDIO bus documentation"
telling us we should not use user_mii_bus when we describe the
internal MDIO in the device-tree made me more confused. But I'll
comment on that thread.

Regards,

Luiz

