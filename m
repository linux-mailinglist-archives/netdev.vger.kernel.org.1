Return-Path: <netdev+bounces-19449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEA575AB3C
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 11:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E42711C2125E
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623AC171AF;
	Thu, 20 Jul 2023 09:46:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5705E174E6
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 09:46:13 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECE0359C
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:46:11 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8ad9eede0so4306905ad.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 02:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689846371; x=1690451171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lTpTUj4MIpRS5cPzJ99oTNdMpvOMufBZFY9ZQRIcs0=;
        b=Dld81Sdj4I1CRSyX3eCz++uulLYW0zEQezNgstsilrJMcHKdtroXzmx6mc6xugp+ed
         xdmByCmcqSc/sfqIQmKyNZKDepKxJ7kL0t/8Lk+G7vFmm80aWoRpcw6sLpEYXApuLB4T
         zm0NgQ+bPRx/MLLoHxZm41n5vFmYS+nVCV1FI+GbFYBW8Vcm3DHL7c+MMDlN8QzzIDPV
         XFWZtcu77e/CpKjRGp7/xXVvPSESVkERFYtF0aPRHmKCek4ItOxGPnf5ZLygeXZmwfje
         xDVZ0nCNg+FEzRCi+FNo5mw53VqPF6bh/dtdcUylYFyXO6XEg8Yilhir2rRyyViq0zKp
         hs3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689846371; x=1690451171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lTpTUj4MIpRS5cPzJ99oTNdMpvOMufBZFY9ZQRIcs0=;
        b=Z5JxxWU4aLVJF/i7tZAZj1IsAEUbE3AitGvpyLrYciR5dkRjp49A5GOIcpEGwOFcX+
         Ijl13edtkioE0pq3eVVkIcp8k5QUTfmE/bDW7N042ptAYtPgSWLOO5B3D/GKg8PN42jN
         TGekta7JXDGGo04LWknj3DLDcyukXTbwDCXq1TM9von9h9F26eputZvJA1DWkTRzR0OY
         X52TQK7cFn3d+HCsQV/pKi48gVO97iFKgPGrlzGsNorxXVVqVLwPjzKOixJXWE/cyVth
         XnEm6QD+YHqGkXamH3kMf+rEV1tQMhM2/0lyCw91PVV6CzzQ42mC6TpwECjfGhu3n+Ft
         w9hg==
X-Gm-Message-State: ABy/qLZFUJ5jNWLGndDg8ZDYMZrmm1QxWTE0/5cZ8SRjc+1fVA84i0M1
	VdCYymW8M57MDwECAew4W6c=
X-Google-Smtp-Source: APBJJlEbhBF5fvtz+KgqC4jXgNLU2mz/4n734mmH2ng2DqFdMXfzDRo14/p36mVcRm/RwMLbhMibYw==
X-Received: by 2002:a17:903:110c:b0:1b8:4f93:b210 with SMTP id n12-20020a170903110c00b001b84f93b210mr5682420plh.45.1689846370710;
        Thu, 20 Jul 2023 02:46:10 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902a5c600b001b9c5e0393csm841189plq.225.2023.07.20.02.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 02:46:09 -0700 (PDT)
Date: Thu, 20 Jul 2023 17:46:04 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Liang Li <liali@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCHv3 net 2/2] team: reset team's flags when down link is P2P
 device
Message-ID: <ZLkCXLsf+K6GLS/6@Laptop-X1>
References: <20230718101741.2751799-1-liuhangbin@gmail.com>
 <20230718101741.2751799-3-liuhangbin@gmail.com>
 <ca0a159b39c4e1d192d225e96367c2ff7ffae25e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca0a159b39c4e1d192d225e96367c2ff7ffae25e.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 10:29:19AM +0200, Paolo Abeni wrote:
> > +static void team_ether_setup(struct net_device *dev)
> > +{
> > +	unsigned int flags = dev->flags & IFF_UP;
> > +
> > +	ether_setup(dev);
> > +	dev->flags |= flags;
> > +	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
> 
> I think we can't do the above. e.g. ether_setup() sets dev->mtu to
> ethernet default, while prior to this patch dev inherited mtu from the
> slaved device. The change may affect the user-space in bad ways.

Hi Paolo,

I don't see the reason why we should inherited a none ethernet dev's mtu
to an ethernet dev (i.e. add a none ethernet dev to team, then delete it and
re-add a ethernet dev to team). I think the dev type has changed, so the
mtu should also be updated.

BTW, after adding the port, team will also set port's mtu to team's mtu.

> 
> I think we just need an 'else' branch in the point2point check above,
> restoring the bcast/mcast flags as needed.

Reset the flags is not enough. All the dev header_ops, type, etc are
all need to be reset back, that's why we need to call ether_setup().

Thanks
Hangbin

