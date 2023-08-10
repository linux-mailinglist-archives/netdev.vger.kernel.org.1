Return-Path: <netdev+bounces-26534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ABB77803E
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2B11C20D69
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECA621D5C;
	Thu, 10 Aug 2023 18:28:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB0621D35
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 18:28:00 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13152684
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:27:59 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9e6cc93d8so19930421fa.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 11:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691692078; x=1692296878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wfP/OzxPHG9qRJzw+vf9dn9u2oTTQETEgpP7lnLy9BA=;
        b=AR9y9wVxouts8evph3YfMioeVRoanzDCL45z8NGFd4Z1dMK99RdcdHnSiCbNI+L3KD
         7NRn9zbfse66hqRy1aTIU/x3gLktjXaYtgoIk/WAYhhcREZrurvt8pZo6W3zEtIYPMMa
         k6edXzNfONXU7ijxT6/IBEBPiDHBrUajAP817YWoMoUhUY0r9Modzx3FhQoZh4qKn+GV
         NAaLD+B9mJ94jqwnGyslUFUTbeqMH90nuQi6s+pt1CyK7SKQ4sjRNnqBfgMjlYz8/JET
         9WYEsjSgecmAdbBY05Jdo5zqJeJuJPEbZ7mZjbQAW24k5hNZDKS+6eIAeK1Mo3LzbG97
         MlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691692078; x=1692296878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfP/OzxPHG9qRJzw+vf9dn9u2oTTQETEgpP7lnLy9BA=;
        b=NPcKF/URLvlBpw6GFa8zwMtmV98LBvdG2WZqsUr2jpKAXhjyrDnD2JPW4qOWFYLEYi
         bag8yXxEYYOGiGN5K9XuacvlEQg1cRevHH2RpJTuWjV0A+F2xCRb8WqocBm2oRKlscUT
         G73JV1IflRss6koSyj9Lv8Er0WQxYphO3MF1fEEhojyO7AOQ2PlVlv9+pMKN3Wkb53sR
         D5owU50IuTACkbiYELhOqcmvhK+Eb7hVmYkYV3BbbCw8SgqbiELOhfd6UD8xMifnn6Ne
         u1ut2Im4ulCviSw70qDA0WmtOHN1BCgHRjaTdPiEkPaAvarper3ya4uE1NyWz7kOWAmb
         99Rw==
X-Gm-Message-State: AOJu0YzUp5Nj+rkvSljbZaU9memSWtdTZ3yYfWRV3wMpBv6YVLPpr5bt
	LFlU7zoFa3ID0lv/UK3CZIg97HxLKXu7lw==
X-Google-Smtp-Source: AGHT+IEJfTnBZN3Ha4dya5YslYiLAsPH9vqD5EGgp7ffWC16FDn4B2Mh4U0aiawNtvz5mOCjYrG32g==
X-Received: by 2002:a2e:9355:0:b0:2b9:f13b:6135 with SMTP id m21-20020a2e9355000000b002b9f13b6135mr2727030ljh.18.1691692077635;
        Thu, 10 Aug 2023 11:27:57 -0700 (PDT)
Received: from skbuf ([188.27.184.201])
        by smtp.gmail.com with ESMTPSA id g11-20020a17090613cb00b00992d0de8762sm1239673ejc.216.2023.08.10.11.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 11:27:57 -0700 (PDT)
Date: Thu, 10 Aug 2023 21:27:55 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Sergei Antonov <saproj@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: mv88e6060: add phylink_get_caps
 implementation
Message-ID: <20230810182755.upr4cziv43lzrxby@skbuf>
References: <E1qTkRn-003NBG-FH@rmk-PC.armlinux.org.uk>
 <E1qTkRn-003NBG-FH@rmk-PC.armlinux.org.uk>
 <20230810164441.udjyn7avp3afcwgo@skbuf>
 <ZNUV2VzY01TWVSgk@shell.armlinux.org.uk>
 <20230810171100.dvnsjgjo67hax4ld@skbuf>
 <ZNUglYF2Xy63l4aZ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNUglYF2Xy63l4aZ@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 06:38:29PM +0100, Russell King (Oracle) wrote:
> What I meant is that there are no in-tree users of the Marvell 88E6060
> DSA driver. It looks like it was contributed in 2008. Whether it had
> users between the date that it was contributed and today I don't know.
> 
> All that I can see is that the only users of it are out-of-tree users,
> which means we have the maintenance burden from the driver but no
> apparent platforms that make use of it, and no way to test it (other
> than if one of those out-of-tree users pops up, such as like last
> month.)
> 
> I know that Arnd tends to strip out code that a platform uses when the
> platform is removed, was there a reason that this got left behind,
> assuming that it was used by a board?

I also have reasons to believe that this driver is seeing very little use,
based on the number of reports relative to the severity and age of the
bugs/performance limitations found.

But, since it hasn't really bothered the general DSA maintenance all that
much up until now, we just kept it, not knowing what state it is in.

If you're saying that's starting to change, I suppose we can start
issuing ultimatums, and make a list of what's being blocked because of
the lack of activity. But as long as Sergei is responding, maybe the
mv88e6060 can live another day.

> > Maybe if we don't want to introduce PHY_INTERFACE_MODE_SNI for fear of a
> > lack of real users, we could at least detect PortMode=0, and not
> > populate supported_interfaces, leading to an intentional validation
> > failure and a comment above that check, stating that phy-mode = "sni" is
> > not yet implemented?
> 
> It would probably be better for mv88e6060_phylink_get_caps() to detect
> it and print the warning, leaving supported_interfaces empty - which
> will then cause phylink_create() to fail. Maybe that's what you meant,
> but I interpreted it as modifying the check in phylink_create().

Yes, this is what I meant. I didn't say anything about phylink_create().

diff --git a/drivers/net/dsa/mv88e6060.c b/drivers/net/dsa/mv88e6060.c
index 0e776be5e941..23cc6b01a1c4 100644
--- a/drivers/net/dsa/mv88e6060.c
+++ b/drivers/net/dsa/mv88e6060.c
@@ -263,15 +263,12 @@ static void mv88e6060_phylink_get_caps(struct dsa_switch *ds, int port,
 		return;
 	}

-	if (!(ret & PORT_STATUS_PORTMODE)) {
-		/* Port configured in SNI mode (acts as a 10Mbps PHY) */
-		config->mac_capabilities = MAC_10 | MAC_SYM_PAUSE;
-		/* I don't think SNI is SMII - SMII has a sync signal, and
-		 * SNI doesn't.
-		 */
-		__set_bit(PHY_INTERFACE_MODE_SMII, interfaces);
+	/* If the port is configured in SNI mode (acts as a 10Mbps PHY),
+	 * it should have phy-mode = "sni", but that doesn't yet exist, so
+	 * forcibly fail validation until the need arises to introduce it.
+	 */
+	if (!(ret & PORT_STATUS_PORTMODE))
 		return;
-	}

 	config->mac_capabilities = MAC_100 | MAC_10 | MAC_SYM_PAUSE;
 

