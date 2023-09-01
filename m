Return-Path: <netdev+bounces-31720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6866178FBC7
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 12:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989831C20C26
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 10:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540869479;
	Fri,  1 Sep 2023 10:32:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4720F8489
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 10:32:33 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68DAE77;
	Fri,  1 Sep 2023 03:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZZNI5SzDjMh+n3YnZIoystrFj1gwCWGIlQs4OUIewrM=; b=yyMeIRUokVZVffJiqFH2xxha/5
	eKLpaZqIvtwBAOi9z116/fAqqaNn34BDwytAcy7qG4ziEkBkEdn+W+qka0JU0YXk9Cg9w0pm7BGqY
	ACVBxj7KgzHKMxYq08tjWjZClRqaD+cFlo8oajlN0f8tpVjERMZlS4RhjYttH8uyfTjhYmE8BDyHs
	tvt/7RPkUyPNCf3MhZuJd+spvv1/XuURlNrBfKBEasGCOs950mLMJkCrlet7Y4lJFWibX9rFZmKv4
	dlww0dspNqzbT7HQbgPMWubiouOgLWN2ow2GKiu6AMuWOdSaXf75gRK2SzHCKo8WeNAYk7y5Ryf87
	KvIDOT8A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50336)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qc1Rt-0003xC-18;
	Fri, 01 Sep 2023 11:32:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qc1Rr-0007kZ-VU; Fri, 01 Sep 2023 11:32:19 +0100
Date: Fri, 1 Sep 2023 11:32:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Radu Pirea <radu-nicolae.pirea@nxp.com>,
	"atenart@kernel.org" <atenart@kernel.org>,
	"Radu-nicolae Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Sebastian Tobuschat <sebastian.tobuschat@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [RFC net-next v2 5/5] net: phy: nxp-c45-tja11xx: implement
 mdo_insert_tx_tag
Message-ID: <ZPG9s1LDbphnBHUE@shell.armlinux.org.uk>
References: <20230824091615.191379-1-radu-nicolae.pirea@oss.nxp.com>
 <20230824091615.191379-6-radu-nicolae.pirea@oss.nxp.com>
 <ZOx0L722xg5-J_he@hog>
 <5d42d6c9-2f0c-8913-49ec-50a25860c49f@oss.nxp.com>
 <ZO8pbtnlOVauabjC@hog>
 <518c11e9000f895fddb5b3dc4d5b2bf445cf320f.camel@nxp.com>
 <ZPG35HfRseiv80Pb@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPG35HfRseiv80Pb@hog>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 01, 2023 at 12:07:32PM +0200, Sabrina Dubroca wrote:
> 2023-09-01, 09:09:06 +0000, Radu Pirea wrote:
> > On Wed, 2023-08-30 at 13:35 +0200, Sabrina Dubroca wrote:
> > ...
> > 
> > > And it's not restored when the link goes back up? That's inconvenient
> > > :/
> > > Do we end up with inconsistent state? ie driver and core believe
> > > everything is still offloaded, but HW lost all state? do we leak
> > > some resources allocated by the driver?
> > 
> > Yes. We end up with inconsistent state. The HW will lost all state when
> > the phy is reseted. No resource is leaked, everything is there, but the
> > configuration needs to be reapplied.
> > 
> > > 
> > > We could add a flush/restore in macsec_notify when the lower device
> > > goes down/up, maybe limited to devices that request this (I don't
> > > know
> > > if all devices would need it, or maybe all devices offloading to the
> > > PHY but not to the MAC).
> > 
> > Agreed.
> > We can do a flush very simple, but to restore the configuration maybe
> > we should to save the key in the macsec_key structure. I am not sure if
> > the key can be extracted from crypto_aead structure.
> 
> Either that or in the driver. I have a small preference for driver,
> because then cases that don't need this restore won't have to keep the
> key in memory, reducing the likelihood of accidentally sharing it.
> OTOH, if we centralize that code, it's easier to make sure everything
> is cleared from kernel memory when we delete the SA.

Maybe consider about doing it as a library function, so drivers that
need this don't have to reimplement the functionality in randomly
buggy ways?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

