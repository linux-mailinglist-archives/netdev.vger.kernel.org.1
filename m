Return-Path: <netdev+bounces-31175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A778478C230
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 12:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DB2281007
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 10:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477FF14F82;
	Tue, 29 Aug 2023 10:19:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386F263C0
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 10:19:01 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A886F198;
	Tue, 29 Aug 2023 03:18:56 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c0cb7285fso549773966b.0;
        Tue, 29 Aug 2023 03:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693304335; x=1693909135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHwX3HHNuhvSAHWZznp7DzQES+oVCF4P2xGpGQFfxH4=;
        b=gXbIdOMs5ECYfJQZOIrjuDoiwOonK+X7IeZ1YtHyOF/oHrZ/aL5pHxbmJ250eCSVlo
         +uuD4fW7NddQRbQDpCPVSNLwRwojPzWvzlFe7x7VqWO+6WHPFAcnd0v15FLgSSwLnIQ4
         pvyfUTQx98fMinzjLfVvSs8ilSAyx0U6z1z0TOyz/Eg8b4JF74U8CvVCw4bw7c6tX1Ti
         1i+5w808lJpf1H9Ik166zg0WN2xNLe1gD4MBJJJaZOZNf9Q8AL6FAyBzaVL4vSJuJvFh
         wQ4xcAyl0GK+ZrPK0OExC0A25/NOTXJUwYNCy4LNqdD+wRhF8Ps778Sg6KqBbQPPjITr
         MjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693304335; x=1693909135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHwX3HHNuhvSAHWZznp7DzQES+oVCF4P2xGpGQFfxH4=;
        b=Ls73VIz5sCx+OgZLEZIFCvaCgOVp4VAgF8d/3bj3q68aIPufieihj41nLIiQnRSe+D
         HnyI1aDEmD0Atf3dh1YttwxdnKFuPcBw/shb2NDhjlNV6wbS46koQtFGZk7YsUfAG6Aq
         VHxbAuoHV3Q+HIqtvqNygqcj2+E0nIJrTCVDVZtggcXfsB6i7byBraY4XlRg7PcEJ+qF
         txK7+f0gSwebqPWJxz0p/8tqVM+dMAY+Xj8/Q3NY0gTHKhfqXrVGoKokhYECOQ4NHThN
         UlzmUV7XTXDdaCOGcumgUQaXk5df7uouA9DsG+HV7NhhMFYmshUHb4UgPvskiU3wtn1v
         jIXg==
X-Gm-Message-State: AOJu0Yw56kMxa3CGeIAF6JZsymoel4VCSuw3xZhi+ws4nqJn+SuOUeSo
	ResCQ8OLSubDNrpl6EUqEgM=
X-Google-Smtp-Source: AGHT+IFEpGH9uGOjSF+h80DpIXF98NhFa20iPsT2Tjt4DSlb4Fa2hxxvVvHQ72eeUlT5xH0DluxYDg==
X-Received: by 2002:a17:906:51d0:b0:9a2:24f9:fabd with SMTP id v16-20020a17090651d000b009a224f9fabdmr9113469ejk.73.1693304334850;
        Tue, 29 Aug 2023 03:18:54 -0700 (PDT)
Received: from skbuf ([188.26.185.176])
        by smtp.gmail.com with ESMTPSA id f24-20020a170906495800b009829d2e892csm5909180ejt.15.2023.08.29.03.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 03:18:54 -0700 (PDT)
Date: Tue, 29 Aug 2023 13:18:51 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Lukasz Majewski <lukma@denx.de>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Tristram.Ha@microchip.com, f.fainelli@gmail.com, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	Woojung.Huh@microchip.com, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH 2/2] net: dsa: microchip: Provide Module 4 KSZ9477 errata
 (DS80000754C)
Message-ID: <20230829101851.435pxwwse2mo5fwi@skbuf>
References: <20230824154827.166274-1-lukma@denx.de>
 <20230824154827.166274-2-lukma@denx.de>
 <BYAPR11MB35583A648E4E44944A0172A0ECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230825103911.682b3d70@wsk>
 <862e5225-2d8e-8b8f-fc6d-c9b48ac74bfc@gmail.com>
 <BYAPR11MB3558A24A05D30BA93408851EECE3A@BYAPR11MB3558.namprd11.prod.outlook.com>
 <20230826104910.voaw3ndvs52yoy2v@skbuf>
 <20230829103533.7966f332@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829103533.7966f332@wsk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Lukasz,

On Tue, Aug 29, 2023 at 10:35:33AM +0200, Lukasz Majewski wrote:
> Hi Vladimir,
> 
> > On Fri, Aug 25, 2023 at 06:48:41PM +0000, Tristram.Ha@microchip.com
> > wrote:
> > > > > IMHO adding functions to MMD modification would facilitate
> > > > > further development (for example LED setup).  
> > > > 
> > > > We already have some KSZ9477 specific initialization done in the
> > > > Micrel PHY driver under drivers/net/phy/micrel.c, can we converge
> > > > on the PHY driver which has a reasonable amount of infrastructure
> > > > for dealing with workarounds, indirect or direct MMD accesses
> > > > etc.?  
> > > 
> > > Actually the internal PHY used in the KSZ9897/KSZ9477/KSZ9893
> > > switches are special and only used inside those switches.  Putting
> > > all the switch related code in Micrel PHY driver does not really
> > > help.  When the switch is reset all those PHY registers need to be
> > > set again, but the PHY driver only executes those code during PHY
> > > initialization.  I do not know if there is a good way to tell the
> > > PHY to re-initialize again.  
> > 
> > Suppose there was a method to tell the PHY driver to re-initialize
> > itself. What would be the key points in which the DSA switch driver
> > would need to trigger that method? Where is the switch reset at
> > runtime?
> 
> Tristam has explained why adding the internal switch PHY errata to
> generic PHY code is not optimal.

Yes, and I didn't understand that explanation, so I asked a
clarification question.

> If adding MMD generic code is a problem - then I'm fine with just
> clearing proper bits with just two indirect writes in the
> drivers/net/dsa/microchip/ksz9477.c
> 
> I would also prefer to keep the separate ksz9477_errata() function, so
> we could add other errata code there.
> 
> Just informative - without this patch the KSZ9477-EVB board's network
> is useless when the other peer has EEE enabled by default (like almost
> all non managed ETH switches).

No, adding direct PHY MMD access code to the ksz9477 switch driver is
not even the biggest problem - even though, IIUC, the "workaround" to
disable EEE advertisement could be moved to ksz9477_get_features() in
drivers/net/phy/micrel.c, where phydev->supported_eee could be cleared.

The biggest problem that I see is that Oleksij Rempel has "just" added
EEE support to the KSZ9477 earlier this year, with an ack from Arun
Ramadoss: 69d3b36ca045 ("net: dsa: microchip: enable EEE support").
I'm not understanding why the erratum wasn't a discussion topic then.

I am currently on vacation and won't be able to look very deeply into
the problem, but IIUC, your patch undoes that work, and so, it needs an
ACK from Oleksij.

