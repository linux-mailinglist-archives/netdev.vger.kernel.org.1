Return-Path: <netdev+bounces-56218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C405880E2F8
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 04:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501431F21DCE
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A119473;
	Tue, 12 Dec 2023 03:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPjl6spV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378DAD9
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 19:48:11 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bf26b677dso4964157e87.2
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 19:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702352889; x=1702957689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gHM7RLH512MW5VIJP4EUDkytCBtarcrMVa3cPG31NzM=;
        b=ZPjl6spVR/K+KrrzdwvlXEgNwcsHAZWf44GQwMs3keA9W2JbUPpBmiPPslAGPgkiT3
         IWwSueZVfX1kOsVlvCinGTq4zej5FV8hZDTRgnrB+lj0jcVX1er7IJoJAlJCeeMphakl
         tSRn80E6+MkW+eQniwg9VFqiXLHJZqWKgu03lvROwvexOJcU2yFytqpW2CO+oP8buLeu
         LGIqWWg2TFSbv8eJwEo+eXk6Z2HkXVBetCRy5W951tNcqVY4aegY3xFoPptzb5fmjxlx
         4QQ8TNH1fRKIi1ToX2NHvlLhVvswr4Rap6W7Gay/Y4C325BuKuhYZOV4l3jP8zpZ/3X2
         c5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702352889; x=1702957689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHM7RLH512MW5VIJP4EUDkytCBtarcrMVa3cPG31NzM=;
        b=skI6JvdXDEYYUH29wH2TAsKTRn+ayberfOYszFwUe+1wyrMMdCI0N2ys+4/yaozKeB
         dx6tTZQP2Kb9lJSJONhOPlouJS0vQFHaBFNI/h6aeEogvteBn/9gSves/XiClLSUBGfF
         vPro0VDqt6YYjo0rYqF+I37WEkm53ExZ5WR/KHBEmocUOA8Q6PUOSxyUbZiHZtGnc1G/
         VIg52cc/rm5tqoi2bg7/yU9aw3eDSRf2n3kbYHeXoONWlHthYV9Xzn/0dZIkyU1SG/6l
         Sg5IbQ7D1lOT+Fb9CPmGXnexZsZIQnXIYoevt9ehwHvTJb16wyVaB4WOAtr7FKV+i8Qh
         rRJA==
X-Gm-Message-State: AOJu0YxhBA4X5RfwutbL00TPBR3jmN79782wGe0tvScS57N+xUKIwE8a
	ayubXAx9cbNzkrgE86boNURh0icYONyVfAp3FnQ=
X-Google-Smtp-Source: AGHT+IEa5Q08YiVcpoIm8Hou4qnewVGN6jjHurHLcXsoUii0+lrpNib8d/Tfl+fvXUhf6jaWENu7BVr2TLBjfRi/1P0=
X-Received: by 2002:a05:6512:234a:b0:50c:a39:ee22 with SMTP id
 p10-20020a056512234a00b0050c0a39ee22mr2137814lfu.33.1702352889118; Mon, 11
 Dec 2023 19:48:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208045054.27966-1-luizluca@gmail.com> <20231208045054.27966-3-luizluca@gmail.com>
 <CAJq09z7yykDsh2--ZahDX=Pto9SF+EQUo5hBnrLiWNALeVY_Bw@mail.gmail.com>
 <i3qp6sjkgqw2mgkbkrpgwxlbcdblwfp6vpohpfnb7tnq77mrpc@hrr3iv2flvqh>
 <CAJq09z45WQv-F9dw-y13E_6DXAfmpxH20JnRoO10za3cuS2kZw@mail.gmail.com> <20231211171143.yrvtw7l6wihkbeur@skbuf>
In-Reply-To: <20231211171143.yrvtw7l6wihkbeur@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 12 Dec 2023 00:47:57 -0300
Message-ID: <CAJq09z6G+yyQ9NLmfTLYRKnNzoP_=AUC5TibQCNPysb6GsBjqA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/7] net: dsa: realtek: put of node after MDIO registration
To: Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <ALSI@bang-olufsen.dk>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>, "andrew@lunn.ch" <andrew@lunn.ch>, 
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Content-Type: text/plain; charset="UTF-8"

> > Reviewing the code again, I believe it was not just misplacing the
> > of_put_node() but probably calling it twice.
> >
> > devm_mdiobus_alloc() doesn't set the dev in mii_bus. So, dev is all
> > zeros. The dev.of_node normal place to be defined is:
> >
> > devm_of_mdiobus_register()
> >   __devm_of_mdiobus_register()
> >     __of_mdiobus_register()
> >       device_set_node()
> >
> > The only way for that value, set by the line I removed, to persist is
> > when the devm_of_mdiobus_register() fails before device_set_node().
>
> Did you consider that __of_mdiobus_register() -> device_set_node() is
> actually overwriting priv->user_mii_bus->dev.of_node with the same value?
> So the reference to mdio_np persists even if technically overwritten.
> The fact that the assignment looks redundant is another story.

Yes, I believe it is just redundant.

> > My guess is that it was set to be used by realtek_smi_remove() if it
> > is called when registration fails. However, in that case, both
> > realtek_smi_setup_mdio() and realtek_smi_setup_mdio() would put the
>
> You listed the same function name twice. You meant realtek_smi_remove()
> the second time?

yes

> > node. So, either the line is useless or it will effectively result in
> > calling of_node_put() twice.
>
> False logic, since realtek_smi_remove() is not called when probe() fails.
> ds->ops->setup() is called from probe() context. So no double of_node_put().
> That's a general rule with the kernel API. When a setup API function fails,
> it is responsible of cleaning up the temporary things it did. The
> teardown API function is only called when the setup was performed fully.

So, "the line is useless".

> (the only exception I'm aware of is the Qdisc API, but that's not
> exactly the best model to follow)
>
> > If I really needed to put that node in the realtek_smi_remove(), I
> > would use a dedicated field in realtek_priv instead of reusing a
> > reference for it inside another structure.
> >
> > I'll add some notes to the commit message about all these but moving
> > the of_node_put() to the same function that gets the node solved all
> > the issues.
>
> "Solved all the issues" - what are those issues, first of all?

1) the useless assignment
2) the (possible) double of_node_put(), which proved to be false.

> The simple fact is: of_get_compatible_child() returns an OF node with an
> elevated refcount. It passes it to of_mdiobus_register() which does not
> take ownership of it per se, but assigns it to bus->dev.of_node, which
> is accessible until device_del() from mdiobus_unregister().

Normally, when you have a refcount system, whenever you have a
reference to an object, you should increase the refcount. I thought
that every time you assign a kobject to a structure, you should get it
as well (and put it when you deallocate it). But that's just what I
would expect, not something I found in docs.

I see distinct behaviors with methods that assign the dev.of_node
using device_set_node() in OF MDIO API code and that's not good:

static int of_mdiobus_register_device(struct mii_bus *mdio,
                                     struct device_node *child, u32 addr)
{
       (...)
       fwnode_handle_get(fwnode);
       device_set_node(&mdiodev->dev, fwnode);
       (...)
}

int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
                                      struct phy_device *phy,
                                      struct fwnode_handle *child, u32 addr)
{
       (...)
       fwnode_handle_get(child);
       device_set_node(&phy->mdio.dev, child);
       (...)
}

int of_mdiobus_phy_device_register(struct mii_bus *mdio, struct phy_device *phy,
                                  struct device_node *child, u32 addr)
{
       return fwnode_mdiobus_phy_device_register(mdio, phy,
                                                 of_fwnode_handle(child),
}

int __of_mdiobus_register(struct mii_bus *mdio, struct device_node *np,
                         struct module *owner)
{
       (...)
       device_set_node(&mdio->dev, of_fwnode_handle(np));
       (...)
       for_each_available_child_of_node(np, child) {
                (...)
                if (of_mdiobus_child_is_phy(child))
                       rc = of_mdiobus_register_phy(mdio, child, addr);
               else
                       rc = of_mdiobus_register_device(mdio, child, addr);
       }
})

Each deals differently with the device_node it receives. Both
of_mdiobus_register_phy and of_mdiobus_register_device gets the child
before assigning it to the device but not __of_mdiobus_register. Why?

After some more study, I think it is just because, while an
of_node_get() just before device_set_node() fits nicely in
__of_mdiobus_register(), there is not a good place in of_mdio to put
it. We don't have an of_mdiobus_unregister(). The unregistration
happens only in mdiobus_unregister(), where, I guess, it should avoid
OF-specific code. Even if we put OF code there, we would need to know
during mdiobus_unregister() if the bus->dev.of_node was gotten by
of_mdio or someone else. I believe it is not nice to externally assign
dev.of_node directly to mdiobus but realtek switch driver is doing
just that and others might be doing the same thing.

The delegation of of_node_get/put to the caller seems to be just an
easy workaround the fact that there is no good place to put a node
that of_mdio would get. For devm functions, we could include the
get/put call creating a new devm_of_mdiobus_unregister() but I believe
devm and non-devm needs to be equivalent (except for the resource
deallocation).

> The PHY library does not make the ownership rules of the of_node very
> clear, but since it takes no reference on it, it will fail in subtle
> ways if you pull the carpet from under its feet.
>
> For example, I expect of_mdio_find_bus() to fail. That is used only
> rarely, like by the MDIO mux driver which I suppose you haven't tested.

No, I didn't test it. In fact, most embedded devices will not use
dynamic OF and all those of_node_get/put will be a noop.

> If you want, you could make the OF MDIO API get() and put() the reference,
> instead of using something it doesn't fully own. But currently the code
> doesn't do that. Try to acknowledge what exists, first.

What I saw in other drivers outside drivers/net is that one that
allocates the dev will get the node before assigning dev.of_node and
put it before freeing the device. The mdiobus case seems to be
different. I believe it would make the code more robust if we could
fix that inside OF MDIO API and not just document its behavior. It
will also not break existing uses as extra get/put's are OK.

I believe we could add an unregister callback to mii_bus. It wouldn't
be too complex:

From b5b059ea4491e9f745872220fb94d8105e2d7d43 Mon Sep 17 00:00:00 2001
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 12 Dec 2023 00:26:06 -0300
Subject: [PATCH] net: mdio: get/put device node during (un)registration

__of_mdiobus_register() was storing the device node in dev.of_node
without increasing its refcount. It was implicitly delegating to the
caller to maintain the node allocated until mdiobus was unregistered.

Now, the __of_mdiobus_register() will get the node before assigning it,
and of_mdiobus_unregister_callback() will be called at the end of
mdio_unregister().

Drivers can now put the node just after the MDIO registration.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
drivers/net/mdio/of_mdio.c | 12 +++++++++++-
drivers/net/phy/mdio_bus.c |  3 +++
include/linux/phy.h        |  3 +++
3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index 64ebcb6d235c..9b6cab6154e0 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -139,6 +139,11 @@ bool of_mdiobus_child_is_phy(struct device_node *child)
}
EXPORT_SYMBOL(of_mdiobus_child_is_phy);

+static void __of_mdiobus_unregister_callback(struct mii_bus *mdio)
+{
+       of_node_put(mdio->dev.of_node);
+}
+
/**
 * __of_mdiobus_register - Register mii_bus and create PHYs from the device tree
 * @mdio: pointer to mii_bus structure
@@ -166,6 +171,8 @@ int __of_mdiobus_register(struct mii_bus *mdio,
struct device_node *np,
        * the device tree are populated after the bus has been registered */
       mdio->phy_mask = ~0;

+       mdio->__unregister_callback = __of_mdiobus_unregister_callback;
+       of_node_get(np);
       device_set_node(&mdio->dev, of_fwnode_handle(np));

       /* Get bus level PHY reset GPIO details */
@@ -177,7 +184,7 @@ int __of_mdiobus_register(struct mii_bus *mdio,
struct device_node *np,
       /* Register the MDIO bus */
       rc = __mdiobus_register(mdio, owner);
       if (rc)
-               return rc;
+               goto put_node;

       /* Loop over the child nodes and register a phy_device for each phy */
       for_each_available_child_of_node(np, child) {
@@ -237,6 +244,9 @@ int __of_mdiobus_register(struct mii_bus *mdio,
struct device_node *np,
unregister:
       of_node_put(child);
       mdiobus_unregister(mdio);
+
+put_node:
+       of_node_put(np);
       return rc;
}
EXPORT_SYMBOL(__of_mdiobus_register);
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 25dcaa49ab8b..1229b8e4c53b 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -787,6 +787,9 @@ void mdiobus_unregister(struct mii_bus *bus)
               gpiod_set_value_cansleep(bus->reset_gpiod, 1);

       device_del(&bus->dev);
+
+       if (bus->__unregister_callback)
+               bus->__unregister_callback(bus);
}
EXPORT_SYMBOL(mdiobus_unregister);

diff --git a/include/linux/phy.h b/include/linux/phy.h
index e5f1f41e399c..2b383da4d825 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -433,6 +433,9 @@ struct mii_bus {

       /** @shared: shared state across different PHYs */
       struct phy_package_shared *shared[PHY_MAX_ADDR];
+
+       /** @__unregister_callback: called at the last step of unregistration */
+       void (*__unregister_callback)(struct mii_bus *bus);
};
#define to_mii_bus(d) container_of(d, struct mii_bus, dev)

--
2.43.0

If we don't fix that in OF MDIO API, we would need to fix
fe7324b932222 as well, moving the put to the dsa_switch_teardown().

Regards,

Luiz

