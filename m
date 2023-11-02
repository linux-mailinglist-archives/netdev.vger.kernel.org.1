Return-Path: <netdev+bounces-45628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0201C7DEBA1
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96CC92814A0
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 04:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC55185E;
	Thu,  2 Nov 2023 04:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dx82ettY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C241F1851
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 04:09:19 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E21CA6
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 21:09:15 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-58706a0309dso245899eaf.1
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 21:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698898154; x=1699502954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rr6SmtrmbKJrv5g031SDkczTsS2PRWKcho0/ABEmfL8=;
        b=dx82ettY2jTd/tLiWrynp1vdEGjuZkebXfoIy9ipob7II+nJgqSn6aeF1DWz/Ugws+
         ybnYHjhEASdNOibzyup5T2GI2uAEpaFhwHRC/AzGrAd+9msPECtII/pVVYbwflQzn7cF
         weechfPBUVNsPXxkw433O0oJMrqRCP3MsY98T7wPTHS8E5NGSgcy8cBkMImPmQ17KRTb
         pLgjtJ5C/hj4fsjKjrszmWml682WHUL1RbzGS3qY6M3//cBcv03xUaSsmFybsi6YCTm7
         CsWIBUpT19009qISTfJkbTg+JU/cJZer1s4OHgkJgB9+ThWIQbG+CO6z1k6pyhGPRbSv
         oHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698898154; x=1699502954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rr6SmtrmbKJrv5g031SDkczTsS2PRWKcho0/ABEmfL8=;
        b=URiLvCS4126YD7ZeglT98HaTG2HpNrufGQicP7AMf0WWcrKLzMGQsiTvGGhMSI2cEM
         bhvGi/h/GGczkM/Vyc6zd4yQs95JO9xvMcjGazxnEP5zlmxEvkVRBaJRSsKX3B4QMkWO
         0y9ScYcxydlPUjibLVTvTZ94zKaH2CN6YxwI7y+Uo48ANzxUy4GRg70vPHVfAmsmW5rF
         1PxixaJ6uKnjJMSuLhR9u4kYnWr7HxxUJW2NGk9Ksth/f7lJgCt/Nzg7YzVAT7yD/dnZ
         4O0U49sWa0D4eW/xb6wfFSfoC0OhQ+D5U52L/MhxjpcxkIjSdN10HdJyv+QaJua+JmaJ
         SOlA==
X-Gm-Message-State: AOJu0Yx+uswo9t3aSGUvfwqX1tOYy3WLiYhi35ZBM8Rna0gfD96Q7wkJ
	n8FJ7DP/46XUStr2loHMRWQ=
X-Google-Smtp-Source: AGHT+IHPhyhooXPfmMNDvz8Af9h2HlD1GNht1OYBPzFUGFGZuJC/q7AiQQJ2T6a4aCZsf94CaYW9pQ==
X-Received: by 2002:a05:6358:5924:b0:168:e743:23b4 with SMTP id g36-20020a056358592400b00168e74323b4mr17219701rwf.2.1698898154426;
        Wed, 01 Nov 2023 21:09:14 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w22-20020a637b16000000b005b929dc2d25sm549459pgc.10.2023.11.01.21.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 21:09:13 -0700 (PDT)
Date: Thu, 2 Nov 2023 12:09:09 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: Re: [RFC Draft PATCHv2 net-next] Doc: update bridge doc
Message-ID: <ZUMg5ZVfZne3uycU@Laptop-X1>
References: <20231027071842.2705262-1-liuhangbin@gmail.com>
 <68045f82-4306-165b-c4b2-96432cc8c422@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68045f82-4306-165b-c4b2-96432cc8c422@blackwall.org>

Hi Nikolay,

On Wed, Nov 01, 2023 at 01:29:34PM +0200, Nikolay Aleksandrov wrote:
> Hi,
> I have written some initial comments, there will definitely be more.
> One general thing - please split this in 2 patches at least. 1 for the
> documentation, and 1 for the netlink uAPI changes. You can even split it

Sure, I will.
> further into logical parts if you'd like, it will make it easier to
> review and people can focus on different parts better. Please CC DSA
> folks as well.
> 
> > diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
> > index c859f3c1636e..b36bd737c05e 100644
> > --- a/Documentation/networking/bridge.rst
> > +++ b/Documentation/networking/bridge.rst
> > -The bridge-utilities are maintained at:
> > -   git://git.kernel.org/pub/scm/linux/kernel/git/shemminger/bridge-utils.git
> > +Bridge internals
> > +================
> > -Additionally, the iproute2 utilities can be used to configure
> > -bridge devices.
> > +Here are the core structs of bridge code.
> 
> the core structs? These are outdated structures used in ioctl.

Ah, I just notice this. In next patch I will use `struct net_bridge_vlan`
as example.

> > +Bridge sysfs
> > +------------
> > +
> > +All the sysfs parameters are also exported via the bridge netlink API.
> > +Here you can find the explanation based on the correspond netlink attributes.
> 
> I don't get this one?

Some users/admins may still config bridge via sysfs. So I added this part
to let users know what's the meaning/usage of each sysfs field.

Do you want to remove this part for the doc?

> Also please mention the sysfs interface is deprecated and should not be
> extended if new options are added.

OK, I will add this note if we will keep this part.
> > +
> > +Switchdev
> > +=========
> > +
> > +Linux Bridge Switchdev is a feature in the Linux kernel that extends the
> > +capabilities of the traditional Linux bridge to work more efficiently with
> > +hardware switches that support switchdev. This technology is particularly
> > +useful in data center and networking environments where high-performance
> > +and low-latency packet forwarding is essential.
> 
> The last sentence is misleading, switchdev is used for many different types
> of devices.
> > +
> > +With Linux Bridge Switchdev, certain networking functions like forwarding,
> > +filtering, and learning of Ethernet frames can be offloaded to the hardware
> 
> "to a hardware switch"
> 
> > +switch. This offloading reduces the burden on the Linux kernel and CPU,
> > +leading to improved network performance and lower latency.
> > +
> > +To use Linux Bridge Switchdev, you need hardware switches that support the
> > +switchdev interface. This means that the switch hardware needs to have the
> > +necessary drivers and functionality to work in conjunction with the Linux
> > +kernel.
> 
> I'd add DSA maintainers to the CC list, and also ask switchdev driver
> maintainers to add more here. Switchdev can be explained much better.

Yes, you are right. I will add them in next version.
> > +
> > +Is it protocol independent?
> 
> Unclear, what layer?

How about "Is it L3/L4 protocol independent?"

> > +---------------------------
> > +
> > +Yes. The bridge knows nothing about protocols, it only sees Ethernet frames.
> 
> It sees all frames, it *uses* only L2 headers/information.
> 
> > diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
> > index f95326fce6bb..63e39de1055b 100644
> > --- a/include/uapi/linux/if_bridge.h
> > +++ b/include/uapi/linux/if_bridge.h
> > + *
> > + * @IFLA_BR_MCAST_STARTUP_QUERY_CNT
> > + *   Set the number of IGMP queries to send during startup phase.
> 
> What is a startup phase?

https://datatracker.ietf.org/doc/html/rfc2236#section-8.7

I think it means when the bridge/switch up.
> 
> > + *
> > + *   The default value is 1.
> 
> What is 1?

1 second.

> 
> > + *
> > + * @IFLA_BR_MCAST_MEMBERSHIP_INTVL
> > + *   The interval after which the bridge will leave a group, if no membership
> > + *   reports for this group are received.
> > + *
> > + *   The default value is 260.
> 
> What is 260? Please be more specific.

OK, I will.

Thanks
Hangbin

