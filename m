Return-Path: <netdev+bounces-55484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A2980B05C
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 00:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D6E1C20951
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 23:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2AB5AB87;
	Fri,  8 Dec 2023 23:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+pxOT9f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD5610D2
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 15:03:41 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67a9cba087aso14797686d6.3
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 15:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702076620; x=1702681420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9Y+I5m1U6Q4Ez0Gj9SX3PCX7tYFJu3rDLPvDjpsI0w=;
        b=C+pxOT9fAOd3txHUX8lNWHbCCTB2vcOrfMUmu/bFQZrOqCI0kwWJwXPwPX8MmZo8qw
         XfvIgHiBaYIsQzueDftqP4GJtHHhjvLv7TddKyCBR5nlhUlNqELppkEB4uxLQ+VmAy5P
         1D/anAD0JScwOZMo4kRGR7Jitercec2bWzy9PhehPUZp+zgQcSRRzGSgpxnsqGmGOsdt
         1/iCsk7CanEXZJa2Z7Og/I7N8ZhnduowpfaCulPSvBNkfLDEKoqia4Iw5NMouel8swy0
         dN9O6f77lgvm6OSrql7bh1TF9/yUj28cNQc/qBxSIBBjlz/uiEE05N97x7xgkY8Epw/y
         CqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702076620; x=1702681420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9Y+I5m1U6Q4Ez0Gj9SX3PCX7tYFJu3rDLPvDjpsI0w=;
        b=gLBvVjg61GfFS2nFs410gc5qvlgn4lEayL9GdEsEshCOOCvUvWf6uSkDibB0Tv22i2
         Gio3dkiw2JsrVo6oBbcq0PhBGPhVy+1i+zbF3Og/23ezahONtiS1ikw7EsUmLK1xWYcm
         NH/3gGNprKDMtkHaPTMFD12II8vqMs7WU9gajpiOf/IYyOhnpqWy7fqb0WcKKQKPb/es
         S6lx0VMNR0aKV1TzU/xiepAb7+7QRHyZAkohRcOAQ6MIsliTK2vnrbtTq7ewbE7oF8+3
         0SFJZDw8gNz8JsjX7sujjaAnlG6Gz+cYDyFlWCKUadx7+RCUpzBok2meRZVCHTjOn/EB
         OKWg==
X-Gm-Message-State: AOJu0Yw3H5WpusU4fQdnZQB/rn4+2ijiJ9zbgZNMpMybdpHYJSX9TGjR
	S6fI5l09T5KZUsikIZc2zpCDgPTOx3U=
X-Google-Smtp-Source: AGHT+IHxhfKNjs51AsUpZE8nfKydKWOQuVBaSiYCOkb4YFVSajtfbRok6fEW/WtqsRD/XUrxS+ic7w==
X-Received: by 2002:a0c:e5c2:0:b0:67a:a58f:e364 with SMTP id u2-20020a0ce5c2000000b0067aa58fe364mr744035qvm.31.1702076620373;
        Fri, 08 Dec 2023 15:03:40 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g11-20020a05620a218b00b0077f5759e060sm486647qka.113.2023.12.08.15.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 15:03:39 -0800 (PST)
Message-ID: <2b4f6a45-2af2-482b-b8f5-f2bece824912@gmail.com>
Date: Fri, 8 Dec 2023 15:03:35 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 4/4] docs: net: dsa: replace TODO section with info
 about history and devel ideas
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Madhuri Sripada <madhuri.sripada@microchip.com>,
 Marcin Wojtas <mw@semihalf.com>, Linus Walleij <linus.walleij@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Jonathan Corbet <corbet@lwn.net>
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
 <20231208193518.2018114-5-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231208193518.2018114-5-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/23 11:35, Vladimir Oltean wrote:
> It was a bit unclear to me what the TODO is about and what is even
> actionable about it. I had a discussion with Florian about it at NetConf
> 2023, and it seems that it's about the amount of boilerplate code that
> exists in switchdev drivers, and how that could be maybe made common
> with DSA, through something like another library.
> 
> I think we are seeing a lot of people who are looking at DSA now,
> and there is a lot of misunderstanding about why things are the way
> they are, and which are the changes that would benefit the subsystem,
> compared to the changes that go against DSA's past development trend.
> 
> I think what is missing is the context, which is admittedly a bit
> hard to grasp considering there are 15 years of development.
> Based on the git log and on the discussions where I participated,
> I tried to cobble up a section about DSA's history. Here and there,
> I've mentioned the limitations that I am aware of, and some possible
> ways forward.
> 
> I'm also personally surprised by the amount of change in DSA over the
> years, and I hope that putting things into perspective will also
> encourage others to not think that it's set in stone the way it is now.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

This is really great, and thanks for having put that together, it 
represents an useful timeline of changes introduces.

> ---

[snip]

> +Probing through ``platform_data`` remains limited in functionality. The
> +``ds->dev->of_node`` and ``dp->dn`` pointers are NULL, and the OF API calls
> +made by drivers for discovering more complex setups fall back to the implicit
> +handling. There is no way to describe multi-chip trees, or switches with
> +multiple CPU ports. It is always assumed that shared ports are configured by
> +the driver to the maximum supported link speed (they do not use phylink).
> +User ports cannot connect to arbitrary PHYs, but are limited to
> +``ds->user_mii_bus``.

Maybe a mention here that this implies built-in/internal PHY devices 
only, just as a way to re-iterate the limitation and to echo to the 
previous patch?

> +
> +Many switch drivers introduced since after DSA's second OF binding were not
> +designed to support probing through ``platform_data``. Most notably,
> +``device_get_match_data()`` and ``of_device_get_match_data()`` return NULL with
> +``platform_data``, so generally, drivers which do not have alternative
> +mechanisms for this do not support ``platform_data``.
> +
> +Extending the ``platform_data`` support implies adding more separate code.
> +An alternative worth exploring is growing DSA towards the ``fwnode`` API.
> +However, not the entire OF binding should be generalized to ``fwnode``.
> +The current bindings must be examined with a critical eye, and the properties
> +which are no longer considered good practice (like ``label``, because ``udev``
> +offers this functionality) should first be deprecated in OF, and not migrated
> +to ``fwnode``.
> +
> +With ``fwnode`` support in the DSA framework, the ``fwnode_create_software_node()``
> +API could be used as an alternative to ``platform_data``, to allow describing
> +and probing switches on non-OF.

Might suggest to move the 3 paragraphs towards the end because otherwise 
it might be a distraction for the reader who might think: ah that's it? 
no more technical details!? Looks like Linus made the same suggestion in 
his review.

> +
> +DSA is used to control very complex switching chips. Some devices have a
> +microprocessor, and in some cases, this microprocessor can run a variant of the
> +Linux kernel. Sometimes, the switch packet I/O procedure of the internal
> +microprocessor is different from the packet I/O procedure for an external host.
> +The internal processor may have access to switch queues, while the external
> +processor may require DSA tags. Other times, the microprocessor may also be
> +connected to the switch in a DSA fashion (using an internal MAC to MAC
> +connection).
> +
> +Since DSA is only concerned with switches where the packet I/O is handled
> +by an intermediate conduit driver, this leads to the situation where it is
> +recommended to have two drivers for the same switch hardware. 

the same switch hardware, one for each of the use cases described above.

When the queues
> +are accessed directly, a separate non-DSA driver should be used, with its own
> +skeleton which is integrated with ``switchdev`` on its own.
> +
> +In 2019, a DSA driver was added for the ``ocelot`` switch, which is a thin
> +front-end over a hardware library that is also common with a ``switchdev``
> +driver. While this design is encouraged for other similar cases, code
> +duplication among multiple front-ends is a concern, so it may be desirable to
> +extract some of DSA's core functionality into a reusable library for Ethernet
> +switches. This could offer a driver-facing API similar to ``dsa_switch_ops``,
> +but the aspects relating to cross-chip management, to DSA tags and to the
> +conduit interface would remain DSA-specific.

Yes! That was exactly the idea indeed.

> +
> +Traditionally, DSA switch drivers for discrete chips own the entire
> +``spi_device``, ``i2c_client``, ``mdio_device`` etc. When the chip is complex
> +and has multiple embedded peripherals (IRQ controller, GPIO controller, MDIO
> +controller, LED controller, sensors), the handling of these peripherals is
> +currently monolithic within the same device driver that also calls
> +``dsa_register_switch()``.
> +
> +But an internal microprocessor may have a very different view of the switch
> +address space, and may have discrete Linux drivers for each peripheral.
> +In 2023, the ``ocelot_ext`` driver was added, which deviated from the
> +traditional DSA driver architecture. Rather than probing on the entire
> +``spi_device``, it created a multi-function device (MFD) top-level driver for
> +it (associated with the SoC at large), and the switching IP is only one of the
> +children of the MFD (it is a platform device with regmaps provided by its
> +parent). The drivers for each peripheral in this switch SoC are the same when
> +controlled over SPI and when controlled by the internal processor.
> +
> +Authors of new switch drivers that use DSA are encouraged to have a wider view
> +of the peripherals on the chip that they are controlling, and to use the MFD
> +model to separate the components whenever possible. The general direction for
> +the DSA core is to shrink in size and to focus only on the Ethernet switching
> +IP and its ports. ``CONFIG_NET_DSA_HWMON`` was removed in 2017. Adding new
> +methods to ``struct dsa_switch_ops`` which are outside of DSA's core focus on
> +Ethernet is strongly discouraged.

Agreed and good idea to put that on (virtual) paper.

> +
> +DSA's support for multi-chip trees also has limitations. After converting from
> +the first to the second OF binding, the switch tree stopped being a platform
> +device, and its probing became implicit, and distributed among its constituent
> +switch devices. There is currently a synchronization point in
> +``dsa_tree_setup_routing_table()``, through which the tree setup is performed
> +only once, when there is more than one switch in the tree. The first N-1
> +switches will end their probing early, and the last switch will configure the
> +entire tree, and thus all the other switches, in its ``dsa_register_switch()``
> +calling context.
> +
> +Furthermore, the synchronization point works because each switch is able to
> +determine, in a distributed manner, that the routing table is not complete, aka
> +that there is at least one switch which has not probed. This is only possible
> +because the ``link`` properties in the device tree describe the connections to
> +all other cascade ports in the tree, not just to the directly connected cascade
> +port. If only the latter were described, it could happen that a switch waits
> +for its direct neighbors to probe before setting up the tree, but not
> +necessarily for all switches in the tree (therefore, it sets up the tree too
> +early).
> +
> +With more than 3 switches in a tree, it becomes a difficult task to write
> +correct device trees which are not missing any link to the other cascade ports
> +in the tree. The routing table, based on which ``dsa_routing_port()`` works, is
> +directly taken from the device tree, although it could be computed through BFS
> +instead. This means that the device tree writer needs to specify more than just
> +the hardware description (represented by the direct cascade port connections).
> +
> +Simplifying the device tree bindings to require a single ``link`` phandle
> +cannot be done without rethinking the distributed probing scheme. One idea is
> +to reinstate the switch tree as a platform device, but this time created
> +dynamically by ``dsa_register_switch()`` if the switch's tree ID is not already
> +present in the system. The switch tree driver walks the device tree hop by hop,
> +following the ``link`` references, to discover all the other switches, and to
> +construct the full routing table. It then uses the component API to register
> +itself as an aggregate driver, with each of the discovered switches as a
> +component. When ``dsa_register_switch()`` completes for all component switches,
> +the tree probing continues and calls ``dsa_tree_setup()``.

An interesting paragraph, but I am not sure this is such a big pain 
point that we should be spending much description of it, especially 
since it sounds like this is solved, but could be improved, but in the 
grand scheme of things, should we really be spending any time on it?

Same-vendor cascade configurations are Marvell specific, and different 
vendor cascades require distinct switch trees, therefore do not really 
fall into the cross-chip design anymore. In a nutshell, cross-chip is 
very very niche and limited.

> +
> +The cross-chip management layer (``net/dsa/switch.c``) can also be improved.
> +Currently ``struct dsa_switch_tree`` holds a list of ports rather than a list
> +of switches, and thus, calling one function for each switch in a tree is hard.
> +DSA currently uses one notifier chain per tree as a workaround for that, with
> +each switch registered as a listener (``dsa_switch_event()``).
> +
> +It is considered bad practice to use notifiers when the emitter and the
> +listener are known to each other, instead of a plain function call. Also, error
> +handling with notifiers is not robust. When one switch fails mid-operation,
> +there is no rollback to the previous state for switches which already completed
> +the operation successfully.
> +
> +To untangle this situation and improve the reliability of the cross-chip
> +management layer, it is necessary to split the DSA operations into ones which
> +can fail, and ones which cannot fail. For example, ``port_fdb_add()`` can fail,
> +whereas ``port_fdb_del()`` cannot. Then, cross-chip operations can take a
> +fallible function to make forward progress, and an infallible function for
> +rollback. However, it is unclear what to do in the case of ``change_mtu()``.
> +It is hard to classify this operation as either fallible or infallible. It is
> +also unclear how to deal with I/O access errors on the switch's management bus.

How about something like this:

I/O access errors occurring during the switch configuration should 
always be logged for debugging but are very unlikely to be recoverable 
and therefore require an investigation into the failure mechanism and 
root cause or possible work around.
-- 
Florian


