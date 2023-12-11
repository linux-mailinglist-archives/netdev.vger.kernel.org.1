Return-Path: <netdev+bounces-55794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A53180C580
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 11:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7DB1F2102D
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298472208C;
	Mon, 11 Dec 2023 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WuCSBzfs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D439DBD
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 02:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702289014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FBY56C7pG8mBzo3mVC/Zv2Peov9lg+Ssv7EHttFe0bM=;
	b=WuCSBzfsUUjBPzHFdZTA8XRoDqKECtqr8FXS1OOkATWWEbinxwzylu3mStaksFa7m9ubcW
	sEixOVMOqjWbzcNz3DDdgzQC9sb5Fu1Xm02H95TaaHWweO8741pPM3fdTPhidK3DjSIySm
	KsE8oGoc08+RpMmzA6tm8TlL0WVlVBg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-gq8mYUtHNoy7-u7M7fqzfA-1; Mon, 11 Dec 2023 05:03:31 -0500
X-MC-Unique: gq8mYUtHNoy7-u7M7fqzfA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3190A88FA25;
	Mon, 11 Dec 2023 10:03:31 +0000 (UTC)
Received: from calimero.vinschen.de (unknown [10.39.192.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EEE3492BE6;
	Mon, 11 Dec 2023 10:03:30 +0000 (UTC)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 276BBA807CF; Mon, 11 Dec 2023 11:03:29 +0100 (CET)
Date: Mon, 11 Dec 2023 11:03:29 +0100
From: Corinna Vinschen <vinschen@redhat.com>
To: Richard Tresidder <rtresidd@electromag.com.au>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: STMMAC Ethernet Driver support
Message-ID: <ZXbecbaUnTwiX3l1@calimero.vinschen.de>
Mail-Followup-To: Richard Tresidder <rtresidd@electromag.com.au>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au>
 <20231208101216.3fca85b1@kernel.org>
 <8a0850d8-a2e4-4eb0-81e1-d067f18c2263@electromag.com.au>
 <41903b8b-d145-4fdf-a942-79d7f88f9068@electromag.com.au>
 <f47b0230-1513-4a81-9d78-3f092b979c48@electromag.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f47b0230-1513-4a81-9d78-3f092b979c48@electromag.com.au>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Dec 11 17:23, Richard Tresidder wrote:
> 
> > Richard Tresidder
> > 
> > 
> > On 9/12/2023 3:06 pm, Richard Tresidder wrote:
> > > On 9/12/2023 2:12 am, Jakub Kicinski wrote:
> > > > On Fri, 8 Dec 2023 14:03:25 +0800 Richard Tresidder wrote:
> > > > > I've looked through the diffset 6.3.3 >>> 6.6.3 on the driver
> > > > > drivers\net\ethernet\stmicro\stmmac
> > > > > But nothing is jumping out at me.
> > > > > 
> > > > > I could use a pointer as to where to look to start tracing this.
> > > > Bisection is good way to zero in on the bad change if you don't
> > > > have much hard to rebase code in your tree.
> > > > 
> > > > Otherwise you can dump the relevant registers and the descriptors
> > > > (descriptors_status file in debugfs) and see if driver is doing
> > > > anything differently on the newer kernel?
> > > > 
> > > Thanks Jakub
> > >   Yep I think I'll have to start bisecting things on Monday.
> > > Luckily to work through this I shouldn't have to merge very much.
> > > Have a great weekend
> > > 
> > > Cheers
> > >   Richard Tresidder
> > > 
> > Hi Jakub
> >    Ok the bad commit is the following:
> > ************************************
> > 6b2c6e4a938fece9b539c8085f21d17c5e6eb9de is the first bad commit
> > commit 6b2c6e4a938fece9b539c8085f21d17c5e6eb9de
> > Author: Corinna Vinschen <vinschen@redhat.com>
> > Date:   Mon Apr 17 21:28:45 2023 +0200
> > 
> >     net: stmmac: propagate feature flags to vlan
> > 
> >     stmmac_dev_probe doesn't propagate feature flags to VLANs.  So
> > features
> >     like offloading don't correspond with the general features and it's
> > not
> >     possible to manipulate features via ethtool -K to affect VLANs.
> > 
> >     Propagate feature flags to vlan features.  Drop TSO feature because
> >     it does not work on VLANs yet.
> > 
> >     Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
> >     Link:
> > https://lore.kernel.org/r/20230417192845.590034-1-vinschen@redhat.com
> >     Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > 
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > ****************************************
> > From back in the work for 6.4-rc1
> > 
> > Theres a single line addition  approx line 7506
> > drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > 
> > ndev->vlan_features |= ndev->features;

This is missing the 2nd line

    ndev->vlan_features &= ~NETIF_F_TSO;

I assume that another flag or two have to be dropped from being
propagated as well.  That may depend on the platform, just like the
feature flags depend on STMMAC_VLAN_TAG_USED, for instance.

I'm sorry, but I'm not working on stmmac anymore.  Can you perhaps test
removing flags from vlan_features and see what actual flag is breaking
your scenario?

Other than that, maybe reverting the patch is the better option and the
vlan_feature flags should be set explicitely in the various
platform-specific code.


Corinna


