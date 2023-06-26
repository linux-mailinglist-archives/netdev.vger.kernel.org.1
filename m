Return-Path: <netdev+bounces-14117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1EA73EEBC
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 00:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8DD1C2084E
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 22:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6C71870;
	Mon, 26 Jun 2023 22:42:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0006111E
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 22:42:50 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEB9BD;
	Mon, 26 Jun 2023 15:42:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98e25fa6f5bso359022666b.3;
        Mon, 26 Jun 2023 15:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687819366; x=1690411366;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XEFAA2gDkBPNK5+f6P7/QUuUIhTBpSxnJII7HREQcf4=;
        b=YLrQte4c8sCVsgfT+rkj3HZoftvrYZKLN/SZ6yN9wgOuBxe+zMEt4WwOwbqmAjztzL
         HBFOCy1Pkg/8XEcPMbRnQPZ2NF3GerJ3CNYuJACzUxFjHAhSB7gqmkHoQ3/0+tqfnXG/
         P0vWBJ/86T6KXAa6vO2pMGmjjpssAiY8h5xD4wCz3tOhfCu/4kCi/W/h7LmyNSP30xLF
         GJrz/W6jX/mzMAIjrECcLKoKwTVZSJtcxiQaCMzWNFAhCxJcv+3nV+dzCVuBpLtsnJhE
         0kxlly/Ni182qSGQZ6RbR2navv0B4bUZtPzBI9tp2xUO0NP1ldUc4QO+EAFO3Hc39Knj
         KVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687819366; x=1690411366;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEFAA2gDkBPNK5+f6P7/QUuUIhTBpSxnJII7HREQcf4=;
        b=ExWIix47ESYnUleyfvr14+lD4ReWnGw/8jjot0oiFj7AeDU09xNKErqNCj3cft32fQ
         OOfxQITiIiqVU1LGTbhN3U/KeLVWF1ECYKSKlewOWxd4Ng/YnBdXu4JAQKLYHdrL1w/V
         FEZcZYczNGio8EALfdulFHzhvo7SEA+A75A0RPIZcfvQars3uNR+WOjSKI3c0+hTBJWv
         Z4yMNRQONv/J+bq0SGag1/7ug2mNvKGgD4Nly84/MbR7ToqW8m3yw0BMPMgj4285uzz7
         33kisriXjaW5Hwg5h0qbhgpJSqguBEScP7p8TZ1h+AKzUmTsp7mfJf3y439w5LA1peOw
         LJOA==
X-Gm-Message-State: AC+VfDwbhMk4RlYjVCpXhEghsBoW4cx7yT4a49niuq5RgwYi4/BrWcTI
	W9/hgq4qj02nHVdnEY+0mn4=
X-Google-Smtp-Source: ACHHUZ4NF6wL71lj6OSAtImbZz2ZXBouok992OJFHQNzEIdK8d/p0s+eFBurHUtzVKqyYcBku5XBYw==
X-Received: by 2002:a17:907:806:b0:974:5e14:29c0 with SMTP id wv6-20020a170907080600b009745e1429c0mr28660350ejb.21.1687819365605;
        Mon, 26 Jun 2023 15:42:45 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id pv18-20020a170907209200b00987cd2db33fsm3737147ejb.131.2023.06.26.15.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 15:42:45 -0700 (PDT)
Date: Tue, 27 Jun 2023 01:42:42 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Jerry Ray <jerry.ray@microchip.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] net: dsa: microchip: phy reg access 0x10-0x1f
Message-ID: <20230626224242.bqzqyfep5hvdkboh@skbuf>
References: <20230626182032.2079497-1-jerry.ray@microchip.com>
 <20230626192643.4zi2qyrjfllkxlmw@soft-dev3-1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230626192643.4zi2qyrjfllkxlmw@soft-dev3-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Horațiu,

On Mon, Jun 26, 2023 at 09:26:43PM +0200, Horatiu Vultur wrote:
> The 06/26/2023 11:20, Jerry Ray wrote:
> 
> Hi Jerry,
> 
> This seems like a patch for net-next which seems to be closed now.
> Please hold back this patch until the window opens again in like 2 weeks.
> 
> Also you need to add in the subject which tree are you targeting.
> In your case is net-next then it should be something like:
> [PATCH net-next] net: dsa: microchip: phy reg access 0x10-0x1f
> 
> > With the recent patch to promote phy register accesses to 32-bits for the
> > range >=0x10, it is also necessary to expand the allowed register address
> > table for the affected devices.  These three register sets use
> > ksz9477_dev_ops and are therefore affected by the change. The address
> > ranges 0xN120-0xN13f map to the phy register address 0x10-0x1f. There is
> > no reason to exclude any register accesses within this space.
> > 
> > on June 20, 2023
> > commit 5c844d57aa78    ("net: dsa: microchip: fix writes to phy registers >= 0x10")
> 
> This is just a small thing but as you need to send a new version, you can
> write something like this:
> ---
> With the recent patch [0] to promote ...
> 
> [0] 5c844d57aa78 ("net: dsa: microchip: fix writes to phy registers >= 0x10")
> ---
> 
> Or:
> 
> ---
> With the commit 5c844d57aa78 ("net: dsa: microchip: fix writes to phy
> registers >= 0x10") which promotes phy ...
> ---
> 
> Just to make it a little bit more clear that the commit that you posted
> at the end refers to the patch that you mention to at the beginning of
> the commit message.

I think these signs intend to denote a Fixes: tag. For that, we have a
fairly standard way of generating them:

$ cat ~/.gitconfig
...
[core]
        abbrev = 12
[pretty]
        fixes = Fixes: %h (\"%s\")

$ git show 5c844d57aa78 --pretty=fixes
Fixes: 5c844d57aa78 ("net: dsa: microchip: fix writes to phy registers >= 0x10")

That line should be pasted in the commit message next to (no empty lines
in between) the other tags like reviews and sign offs.

If Jerry can prove a problem with the existing code structure from
net-next (any PHY writes to registers >= 0x10), then the patch does not
need to wait until net-next reopens. It needs to wait until the net-next
pull request is sent to Linus, then this can be resent towards 'net.git'.
That problem needs to be described in the commit message.

If there's no problem that could potentially have a user-visible impact
in the existing code and PHY driver (those PHY writes are unreachable),
then I agree with you, the change can wait and should be resent when
net-next reopens.

