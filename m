Return-Path: <netdev+bounces-56013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224D480D3C4
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0431C215F3
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6099F4E1D2;
	Mon, 11 Dec 2023 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGDkk/BB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6EF9B
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:29:21 -0800 (PST)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-58e256505f7so2517045eaf.3
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 09:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702315761; x=1702920561; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svc5T2kog4G+U2gPm2+6rxscXzga3wrCaF6A3lGPmBU=;
        b=KGDkk/BBhJHGdXzWCFWS3QxZNBap/IW45JH5kMLtiPLQOAg3Bc/6X1euUHXSEubZGx
         +c8WvcmE3Rq59ah6Rw+Xfxu308zCiKTSWrNhe4LFpCQ4toW1laRYccpiaNpn1nspkI/e
         gYq46yL8rQR9FC0Vpk3xSc3o5VKLmjzlTb0pyQbb93fCgmRbUzJEAr9HmAEAOmU9JDDv
         Lp2Lb3RGJ3JKEKsVb19cfC6KalPsaBNmjQZnLsoTfcja1DyvAHOr7AlI8opf2XbprvaG
         8i2VpCfNYXjkvkePXyrLSQ5rqDOAewcRgA/SZXFL2hxMI3wiI7fXl/ecvAOHh5ANtp8v
         RYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702315761; x=1702920561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=svc5T2kog4G+U2gPm2+6rxscXzga3wrCaF6A3lGPmBU=;
        b=kuKZlnA6XRQMRMtD24za5Mt1lVTv7rbMXL7C2n5xl6OLCSHAbkxE1+oKKl/e8dBDNt
         OAQuao2yeI9dluRSkzDISFr8Qg5cNUNGVf+yGwJMXfR7IygKmNT30fB29Ex1UicF56Ke
         fV5w3CsYfbRc8uFej7vX55xiroFd3UUAJMo2CatMfcGxZNwjhs7SaVhwuRVmyRExVQhk
         7CGsqCPr5EicA6ONPj8/sUa1dKWI/+CfgAEgPEjKaZfsl8djNPwFFH0mZoYb68om6KNr
         o1mC+U0rXnjIYt9H94ddpaP/Q0RwcVOyGsGSLQuVRgEsjGPYTi7LHho0bqTkr421Sl6d
         XpKQ==
X-Gm-Message-State: AOJu0YzqPA8d7i6X2dtW56jUZW2y5ctxMI6A1J803KOCiTIr32peCDjF
	TZ3391o75A26mrJ/gePFx38=
X-Google-Smtp-Source: AGHT+IE7SoIS6YsznK/r4gZTciElm6yLRswqDbtB3lHh4vJLDjCShXqQTAApVGXDwLeJcPueRj3bkA==
X-Received: by 2002:a05:6359:628c:b0:170:5888:c92a with SMTP id se12-20020a056359628c00b001705888c92amr2244849rwb.60.1702315761076;
        Mon, 11 Dec 2023 09:29:21 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p1-20020a0cfd81000000b0067ec518b86esm1940172qvr.49.2023.12.11.09.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 09:29:20 -0800 (PST)
Message-ID: <c6f67ee3-cc88-41f2-8080-153d11e7d3cf@gmail.com>
Date: Mon, 11 Dec 2023 09:29:17 -0800
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
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 =?UTF-8?B?QWx2aW4g4pS8w6FpcHJhZ2E=?= <alsi@bang-olufsen.dk>,
 Madhuri Sripada <madhuri.sripada@microchip.com>,
 Marcin Wojtas <mw@semihalf.com>, Linus Walleij <linus.walleij@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Jonathan Corbet <corbet@lwn.net>
References: <20231208193518.2018114-1-vladimir.oltean@nxp.com>
 <20231208193518.2018114-5-vladimir.oltean@nxp.com>
 <2b4f6a45-2af2-482b-b8f5-f2bece824912@gmail.com>
 <20231209015805.zilrf5wrtlccixyw@skbuf>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231209015805.zilrf5wrtlccixyw@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/23 17:58, Vladimir Oltean wrote:
> On Fri, Dec 08, 2023 at 03:03:35PM -0800, Florian Fainelli wrote:
>>> +Probing through ``platform_data`` remains limited in functionality. The
>>> +``ds->dev->of_node`` and ``dp->dn`` pointers are NULL, and the OF API calls
>>> +made by drivers for discovering more complex setups fall back to the implicit
>>> +handling. There is no way to describe multi-chip trees, or switches with
>>> +multiple CPU ports. It is always assumed that shared ports are configured by
>>> +the driver to the maximum supported link speed (they do not use phylink).
>>> +User ports cannot connect to arbitrary PHYs, but are limited to
>>> +``ds->user_mii_bus``.
>>
>> Maybe a mention here that this implies built-in/internal PHY devices only,
>> just as a way to re-iterate the limitation and to echo to the previous
>> patch?
> 
> I am not fully convinced that saying "user_mii_bus can only access internal PHYs"
> only would be correct. This paragraph also exists in the user MDIO bus section:
> 
> For Ethernet switches which have both external and internal MDIO buses, the
> user MII bus can be utilized to mux/demux MDIO reads and writes towards either
> internal or external MDIO devices this switch might be connected to: internal
> PHYs, external PHYs, or even external switches.

OK, so what you have put is good enough, no need to add more that would 
only be a repeat of the user_mii_bus description (with the risk of the 
two being out of sync eventually).

> 
>>> +
>>> +Many switch drivers introduced since after DSA's second OF binding were not
>>> +designed to support probing through ``platform_data``. Most notably,
>>> +``device_get_match_data()`` and ``of_device_get_match_data()`` return NULL with
>>> +``platform_data``, so generally, drivers which do not have alternative
>>> +mechanisms for this do not support ``platform_data``.
>>> +
>>> +Extending the ``platform_data`` support implies adding more separate code.
>>> +An alternative worth exploring is growing DSA towards the ``fwnode`` API.
>>> +However, not the entire OF binding should be generalized to ``fwnode``.
>>> +The current bindings must be examined with a critical eye, and the properties
>>> +which are no longer considered good practice (like ``label``, because ``udev``
>>> +offers this functionality) should first be deprecated in OF, and not migrated
>>> +to ``fwnode``.
>>> +
>>> +With ``fwnode`` support in the DSA framework, the ``fwnode_create_software_node()``
>>> +API could be used as an alternative to ``platform_data``, to allow describing
>>> +and probing switches on non-OF.
>>
>> Might suggest to move the 3 paragraphs towards the end because otherwise it
>> might be a distraction for the reader who might think: ah that's it? no more
>> technical details!? Looks like Linus made the same suggestion in his review.
> 
> I think it needs even more rethinking than that. I now remembered that
> we also have a "Design limitations" section where the future work can go.
> 
> It's hard to navigate through what is now a 1400 line document and not
> get lost.

Agreed.

> 
> I'm hoping I could move the documentation of variables and methods that
> now sits in "Driver development" into kdoc comments inline with the code,
> to reduce the clutter a bit.
> 
> But I don't know how to tackle this. Should documentation changes go to
> "net" or to "net-next"? I targeted this for "net" as a documentation-only
> change set. But if I start adding kdocs, it won't be so clear-cut anymore...

Personal preference is that documentation changes should always target 
'net' (unless they document a 'net-next' change obviously) because 
accurate documentation is most important than anything.

> 
>>> +Simplifying the device tree bindings to require a single ``link`` phandle
>>> +cannot be done without rethinking the distributed probing scheme. One idea is
>>> +to reinstate the switch tree as a platform device, but this time created
>>> +dynamically by ``dsa_register_switch()`` if the switch's tree ID is not already
>>> +present in the system. The switch tree driver walks the device tree hop by hop,
>>> +following the ``link`` references, to discover all the other switches, and to
>>> +construct the full routing table. It then uses the component API to register
>>> +itself as an aggregate driver, with each of the discovered switches as a
>>> +component. When ``dsa_register_switch()`` completes for all component switches,
>>> +the tree probing continues and calls ``dsa_tree_setup()``.
>>
>> An interesting paragraph, but I am not sure this is such a big pain point
>> that we should be spending much description of it, especially since it
>> sounds like this is solved, but could be improved, but in the grand scheme
>> of things, should we really be spending any time on it?
>>
>> Same-vendor cascade configurations are Marvell specific, and different
>> vendor cascades require distinct switch trees, therefore do not really fall
>> into the cross-chip design anymore. In a nutshell, cross-chip is very very
>> niche and limited.
> 
> Well, I've been contacted by somebody to help with a custom board with 3
> daisy chained SJA1105 switches. He is doing the testing for me, and I'm
> waiting for the results to come back. I'm currently waiting for an uprev
> to an NXP BSP on top of 5.15 to be finalized, so that patches developed
> over net-next are at least barely testable...
> 
> If you remember, the SJA1105 has these one-shot management routes which
> must be installed over SPI, and they decide where the next transmitted
> link-local packet goes.

Yes, it's coming back now.

> 
> Well, the driver only supports single-chip trees, as you say, because it
> only programs the management route in the targeted switch. With daisy
> chained switches, one needs to figure out the actual packet route from
> the CPU to the leaf user port, and install a management route for every
> switch along that route. Otherwise, intermediary switches won't know
> what to do with the packets, and drop them.
> 
> The specific request was: "help, PTP doesn't work!"
> 
> I did solve the problem, and the documentation paragraphs above are
> basically my development notes while examining the existing support
> and the way in which it isn't giving me the tools I need.
> 
> I do need to send a dt-bindings patch on this topic as well. The fact
> that we put all cascade links in the device tree means we don't know
> which one represents the direct connection to the neighbor cascade port,
> and which one is an indirect connection. We need to bake in an
> assumption, like for example "the first element of the 'link' phandle
> array is the direct connection". I hope retroactively doing that won't
> bother the device tree maintainers too much. If it does, the problem is
> intractable.

Yes I believe this is exactly how we had intended for the "link" 
property to be used. We should have indeed encoded that more precisely 
into the property.

> 
> But I agree, requirements for cross-chip support are rare, and with
> SJA1105 I don't even own a board where I can directly test it. I
> specifically bought the Turris MOX for that.
> 
>>> +To untangle this situation and improve the reliability of the cross-chip
>>> +management layer, it is necessary to split the DSA operations into ones which
>>> +can fail, and ones which cannot fail. For example, ``port_fdb_add()`` can fail,
>>> +whereas ``port_fdb_del()`` cannot. Then, cross-chip operations can take a
>>> +fallible function to make forward progress, and an infallible function for
>>> +rollback. However, it is unclear what to do in the case of ``change_mtu()``.
>>> +It is hard to classify this operation as either fallible or infallible. It is
>>> +also unclear how to deal with I/O access errors on the switch's management bus.
>>
>> How about something like this:
>>
>> I/O access errors occurring during the switch configuration should always be
>> logged for debugging but are very unlikely to be recoverable and therefore
>> require an investigation into the failure mechanism and root cause or
>> possible work around.
> 
> Yeah, I suppose.
> 
> What do you think, has something like phy_error() been a useful mechanism
> for anything? Or just a pain in the rear? Would it be useful to shut
> everything down on a bus I/O error, phylib style?

phy_error() has been somewhat helpful in knowing whether we have a hard 
to debug, possibly silent MDIO error lurking around. Because the PHY 
library polls or reacts to interrupts updating the link status has a 
very high probability of hitting a MDIO transaction error. This is 
similar to what we see with some of our fielded reports where most 
text/data corruptions occur in scheduler code paths... because the 
scheduler is very often executed. So you know you have an error, but you 
don't know yet why.

For a switch there can be a lot of different transactions, but being 
able to know where it fails precisely could be a lead as to where the 
failure is.
-- 
Floria


