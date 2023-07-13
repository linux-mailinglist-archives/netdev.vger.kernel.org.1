Return-Path: <netdev+bounces-17622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CBA75262D
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 17:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909DF281E1F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D3B1DDFD;
	Thu, 13 Jul 2023 15:08:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E4918B12
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 15:08:48 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33DCE4F
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WvRFQ3c2mk+SjihMtflvsDGyPEV0YBIh+PdCnSkr7FY=; b=KQN2N0d69xhm7d0od43QYEQTzg
	3peqojD98Xrim7fqgPzg+9rq8mlKpr4kS0arRN+6j49mAYnwMXnHtfZB4jw6M6dzlmY10JM0/k/1n
	FNRejt5vllxr5cxqprynMPNkGh9zYyJXv0bHng7tzDXNZYKIQuP1pUylrITLAed9LHb+NBvX+spya
	ZKvUWWI1IMWnrDLQUc2ZqDicKXBEUKw4amYpAuIWk4clMGOGMXyjGxD+6nJGvyZtUYNaufyKs/hp7
	l1vzPaZTKuR7FQoMj9VgcHnxsDIgpoAhBoxaBPFxCoR/QWAYs2ozNJbG9LNLZ7chlZDDZORj+dCrR
	YPJc62OQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53838)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qJxvj-0007aV-1o;
	Thu, 13 Jul 2023 16:08:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qJxvj-0006FI-4E; Thu, 13 Jul 2023 16:08:31 +0100
Date: Thu, 13 Jul 2023 16:08:31 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Sergei Antonov <saproj@gmail.com>, netdev@vger.kernel.org
Subject: Re: Regression: supported_interfaces filling enforcement
Message-ID: <ZLATb/obklRDT3KW@shell.armlinux.org.uk>
References: <CABikg9wM0f5cjYY0EV_i3cMT2JcUT1bSe_kkiYk0wFwMrTo8=w@mail.gmail.com>
 <20230710123556.gufuowtkre652fdp@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710123556.gufuowtkre652fdp@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 03:35:56PM +0300, Vladimir Oltean wrote:
> On Tue, Jul 04, 2023 at 05:28:47PM +0300, Sergei Antonov wrote:
> > Hello!
> > This commit seems to break the mv88e6060 dsa driver:
> > de5c9bf40c4582729f64f66d9cf4920d50beb897    "net: phylink: require
> > supported_interfaces to be filled"
> > 
> > The driver does not fill 'supported_interfaces'. What is the proper
> > way to fix it? I managed to fix it by the following quick code.
> > Comments? Recommendations?
> 
> Ok, it seems that commit de5c9bf40c45 ("net: phylink: require
> supported_interfaces to be filled") was based on a miscalculation.

Yes, it seems so. I'm not great with dealing with legacy stuff - which
is something I've stated time and time again when drivers fall behind
with phylink development. There's only so much that I can hold in my
head, and I can't runtime test the legacy stuff.

I suspect two other DSA drivers are also broken by this:

drivers/net/dsa/dsa_loop.c
drivers/net/dsa/realtek/rtl8366rb.c

based upon:

$ grep -lr dsa_switch_ops drivers/net/dsa | xargs grep -L '\.phylink_get_caps.*=' | xargs grep -L '\.adjust_link'

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

