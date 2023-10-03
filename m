Return-Path: <netdev+bounces-37640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014F97B66AD
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 12:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7E8C928163D
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 10:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A70D199B2;
	Tue,  3 Oct 2023 10:45:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992107ED
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 10:45:57 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC6BAC
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 03:45:55 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so7243305e9.1
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 03:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696329954; x=1696934754; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1UgqEmhUjTwTGxWl+jR6q7RapF9/nPP9ub69wgkPL5k=;
        b=g3z6hW8OBeTI24rvJZDNRYr+V5dHubHtaI6om5ReuqVWDh636QS0CZ3CB+G7iVcVuV
         gFNam9Q4VewbgmdX9614V9HWku+uXJHA4T7rqydasF6szu91l1yBd51bzui01uG78MN4
         YYCA0TNx0u7sf5ioJClIq49O1vbppK1K9NQ+M8o/YTG882AIzOmukaozJPVhlE4X24dV
         QZYBw1CwbSrRd1L3P7qsCe1Go0SOLC2yFs2aDRUj0c7IL6BFTJrgyfr0+/Hq67y4sd+o
         +sfPZ+mqoKgnve579V2gWiihKCVkkfr52ROtYvq0k4ACPTSmY+jbSx4LGvaS8cT58hp0
         PlcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696329954; x=1696934754;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1UgqEmhUjTwTGxWl+jR6q7RapF9/nPP9ub69wgkPL5k=;
        b=caBWFXsfUbsfJ9fN+UqJGVm1FK011353VlNrdT7AU+wcMMQ0hE/tXU+KdTV/bie3eO
         uaMsOr7Yxxw1zYQ1OoWIy1EgCv67VwU50SbivyFAfFawzUnFly/EjcS6qnSmvctEzqJL
         ADCbTI9kJClm5wrog1EPkhYP2ndrR8t6+/9G74QkSbmLT8jmILwZp1s9UEPV2gxsXGms
         4K4KhnAEIatyWzumZ5KWX9jg2GmKcqBDg8fs5884iddxRo2FTU3W8nAQv4jsF97uQyzE
         UqSFCezyv/1vtHcuYGYMhovTF6MsOKjyRW3AkNu9AGnI6oo86RP8nA7G3691K3waVMEI
         S6/Q==
X-Gm-Message-State: AOJu0YxkefP0WuA6AclWKg6nfuKrlzQtTbXCXl8SFQuN8640yG3OAgPC
	Uy/HO7hlxrxcuMJM23W0Rqw=
X-Google-Smtp-Source: AGHT+IEnapkb8FOdcWrBnsjoTDzJpb1Z0rroX6ONC3+JAIJFzQWYyc6wzA0P6n2vDH/TdsK8qbGI7A==
X-Received: by 2002:a1c:7c0b:0:b0:405:3885:490a with SMTP id x11-20020a1c7c0b000000b004053885490amr12514829wmc.0.1696329953545;
        Tue, 03 Oct 2023 03:45:53 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id f17-20020a7bc8d1000000b004064cd71aa8sm974766wml.34.2023.10.03.03.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 03:45:53 -0700 (PDT)
Message-ID: <651bf0e1.7b0a0220.45d05.3ab6@mx.google.com>
X-Google-Original-Message-ID: <ZRvw4DCuzH/saC8D@Ansuel-xps.>
Date: Tue, 3 Oct 2023 12:45:52 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: dsa: qca8k: fix potential MDIO bus conflict
 when accessing internal PHYs via management frames
References: <20231002104612.21898-1-kabel@kernel.org>
 <20231002104612.21898-3-kabel@kernel.org>
 <651ab382.df0a0220.e74df.fc51@mx.google.com>
 <20231003120510.6abd08af@dellmb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231003120510.6abd08af@dellmb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 12:05:10PM +0200, Marek Behún wrote:
> On Mon, 2 Oct 2023 14:11:43 +0200
> Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > On Mon, Oct 02, 2023 at 12:46:12PM +0200, Marek Behún wrote:
> > > Besides the QCA8337 switch the Turris 1.x device has on it's MDIO bus
> > > also Micron ethernet PHY (dedicated to the WAN port).
> > > 
> > > We've been experiencing a strange behavior of the WAN ethernet
> > > interface, wherein the WAN PHY started timing out the MDIO accesses, for
> > > example when the interface was brought down and then back up.
> > > 
> > > Bisecting led to commit 2cd548566384 ("net: dsa: qca8k: add support for
> > > phy read/write with mgmt Ethernet"), which added support to access the
> > > QCA8337 switch's internal PHYs via management ethernet frames.
> > > 
> > > Connecting the MDIO bus pins onto an oscilloscope, I was able to see
> > > that the MDIO bus was active whenever a request to read/write an
> > > internal PHY register was done via an management ethernet frame.
> > > 
> > > My theory is that when the switch core always communicates with the
> > > internal PHYs via the MDIO bus, even when externally we request the
> > > access via ethernet. This MDIO bus is the same one via which the switch
> > > and internal PHYs are accessible to the board, and the board may have
> > > other devices connected on this bus. An ASCII illustration may give more
> > > insight:
> > > 
> > >            +---------+
> > >       +----|         |
> > >       |    | WAN PHY |
> > >       | +--|         |
> > >       | |  +---------+
> > >       | |
> > >       | |  +----------------------------------+
> > >       | |  | QCA8337                          |
> > > MDC   | |  |                        +-------+ |
> > > ------o-+--|--------o------------o--|       | |
> > > MDIO    |  |        |            |  | PHY 1 |-|--to RJ45
> > > --------o--|---o----+---------o--+--|       | |
> > >            |   |    |         |  |  +-------+ |
> > > 	   | +-------------+  |  o--|       | |
> > > 	   | | MDIO MDC    |  |  |  | PHY 2 |-|--to RJ45
> > > eth1	   | |             |  o--+--|       | |
> > > -----------|-|port0        |  |  |  +-------+ |
> > >            | |             |  |  o--|       | |
> > > 	   | | switch core |  |  |  | PHY 3 |-|--to RJ45
> > >            | +-------------+  o--+--|       | |
> > > 	   |                  |  |  +-------+ |
> > > 	   |                  |  o--|  ...  | |
> > > 	   +----------------------------------+
> > > 
> > > When we send a request to read an internal PHY register via an ethernet
> > > management frame via eth1, the switch core receives the ethernet frame
> > > on port 0 and then communicates with the internal PHY via MDIO. At this
> > > time, other potential devices, such as the WAN PHY on Turris 1.x, cannot
> > > use the MDIO bus, since it may cause a bus conflict.
> > > 
> > > Fix this issue by locking the MDIO bus even when we are accessing the
> > > PHY registers via ethernet management frames.
> > > 
> > > Fixes: 2cd548566384 ("net: dsa: qca8k: add support for phy read/write with mgmt Ethernet")
> > > Signed-off-by: Marek Behún <kabel@kernel.org>  
> > 
> > Just some comments (micro-optimization) and one question.
> > 
> > Wonder if the extra lock would result in a bit of overhead for simple
> > implementation where the switch is the only thing connected to the MDIO.
> > 
> > It's just an idea and probably not even something to consider (since
> > probably the overhead is so little that it's not worth it)
> > 
> > But we might consider to add some logic in the MDIO setup function to
> > check if the MDIO have other PHY connected and enable this lock (and
> > make this optional with an if and a bool like require_mdio_locking)
> > 
> > If we don't account for this, yes the lock should have been there from
> > the start and this is correct. (we can make it optional only in the case
> > where only the switch is connected as it would be the only user and
> > everything is already locked by the eth_mgmt lock)
> 
> I don't think we should do that. It is possible that a PHY may be
> registered during the time that the mutex is locked, even if the PHY is
> not defined in device-tree. A driver may be probed that calls
> mdiobus_scan, which will cause transactions on the MDIO bus. Currently
> there are no such drivers in kernel, but they may be in the future.
>

Yep was just an idea, happy it was trashed with correct explaination. It
would have added extra logic and more bloat to the code, totally not
worth for lots of reason. Also yep not doable with the problem of PHY
not declared in DT.

> Anyway, this is a regression fix, it should be merged. If you want to
> optimize it, I think it should be done afterwards in net-next.
> 

Nha, was just to discuss chance to improve this patch directly without
adding additional commit later.

> > > ---
> > >  drivers/net/dsa/qca/qca8k-8xxx.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
> > > index d2df30640269..4ce68e655a63 100644
> > > --- a/drivers/net/dsa/qca/qca8k-8xxx.c
> > > +++ b/drivers/net/dsa/qca/qca8k-8xxx.c
> > > @@ -666,6 +666,15 @@ qca8k_phy_eth_command(struct qca8k_priv *priv, bool read, int phy,
> > >  		goto err_read_skb;
> > >  	}
> > >  
> > > +	/* It seems that accessing the switch's internal PHYs via management
> > > +	 * packets still uses the MDIO bus within the switch internally, and
> > > +	 * these accesses can conflict with external MDIO accesses to other
> > > +	 * devices on the MDIO bus.
> > > +	 * We therefore need to lock the MDIO bus onto which the switch is
> > > +	 * connected.
> > > +	 */
> > > +	mutex_lock(&priv->bus->mdio_lock);
> > > +  
> > 
> > Please move this down before the first dev_queue_xmit. (we can save a
> > few cycle where locking is not needed)
> 
> I put it before the mgmt lock for the following reason: if I first lock
> the mgmt_eth_data and only then the MDIO bus mutex, and a MDIO
> transaction is being done on another device, the mgmt_eth_data mutex is
> unnecessarily locked for a longer time (since MDIO is slow). I thought
> that the whole point of register writes via ethernet frames was to make
> it faster. If another part of the driver wants to read/write a
> switch register, it should not be unnecessarily slowed down because a
> MDIO transaction to a unrelated device.
> 
> Illustration when MDIO mutex is locked before first skb queue, as you
> suggested:
> 
>   WAN PHY driver	qca8k PHY read		qca8k reg read
> 
>   mdio mutex locked
>   reading		eth mutex locked
>   reading		mdio mutex lock
>   reading		waiting			eth mutex lock
>   reading		waiting			waiting
>   reading		waiting			waiting
>   mdio mutex unlocked	waiting			waiting
> 			mdio mutex locked	waiting
> 			reading			waiting
> 			mdio mutex unlocked	waiting
> 			eth mutex unlocked	waiting
> 						eth mutex locked
> 						reading
> 						eth mutex unlocked
> 
> Illustration when MDIO mutex is locked before eth mutex:
> 
>   WAN PHY driver	qca8k PHY read		qca8k reg read
> 
>   mdio mutex locked
>   reading		mdio mutex lock
>   reading		waiting			eth mutex locked
>   reading		waiting			reading
>   reading		waiting			eth mutex unlocked
>   reading		waiting
>   mdio mutex unlocked   waiting
> 			mdio mutex locked
> 			eth mutex locked
> 			reading
> 			eth mutex unlocked
> 			mdio mutex unlocked
> 
> Notice how in the second illustration the qca8k register read is not
> slowed by the mdio mutex.
> 

Thanks for the nice table. I didn't think that mgmt eth is much faster
and moving the lock down would result is worse perf.

> > Also should we use mutex_lock_nested?
> 
> That would allow some MDIO bus reads, for example if someone called
> mdiobus_read() on the bus. We specifically want to completely avoid 
> this. We are not doing any nested reads on the MDIO bus here, so no,
> we should not be using mutex_lock_nested().
> 

Reviewed-by: Christian Marangi <ansuelsmth@gmail.com>

-- 
	Ansuel

