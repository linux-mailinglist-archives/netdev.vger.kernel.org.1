Return-Path: <netdev+bounces-18519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9380757776
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 11:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2AD1C20C47
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 09:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D91C8FB;
	Tue, 18 Jul 2023 09:11:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D68C8D8
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 09:11:14 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E59B1982
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 02:11:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666e97fcc60so3499974b3a.3
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 02:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689671466; x=1692263466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t6eWN4hNWqlsaHOiHrE9PBcc+4mbn5FiIA5wt1QmZlo=;
        b=ibx4KR2LxW66W8Gg/YN+/lMTo0VUbY6hzE8NM1OXxjQiZGdxo8/o4SkRNQcVccZyHD
         3QUqqVX5F76j5Oma42+DoRm+QmNjhqw7c+3KFCE0Kv6eLOMlUgib3iOCKcrm7gs6M449
         oJM6pMQm/1wu+ZO7zr+HnbOjfzDdlYsY3Yrm3AQuCwxrwZrWdsZxBFDRFnGKz406dab8
         RmC03aJFkCr4Fn5lfyLgGWQZtjgveP+kfRmpuYjlrJqzPAdzaXWy9k1QebmRHuSZDuUo
         rt60ShTgrV/5rD5HvLZwW2E36SAXXm0uBxeKjmUXEAHOlbf6fZRzTjoxUtFRGyZ8itrE
         +nZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689671466; x=1692263466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6eWN4hNWqlsaHOiHrE9PBcc+4mbn5FiIA5wt1QmZlo=;
        b=SkLFgUAWcm6HG90w3PIZq8DqYsdgtpl5QBnUtnn6HrYJHtzKgwMAtWFDqJYHYT2Kuq
         VwyeACDub3gNsK2/O9rRbQlEpApD0k5dSheQHW0gi9pfvu0M3JUnfoaOcHAh1UMsN93y
         V/AQCMaGc5i6PYyMk2M5FXuL3VH2qrIgAwl5NaawaYLtTyzb8qZnXUbdD6vS4qRmjJcp
         7Qwwn4gxIaHK+t8unbQT4zTuBAeZpVg4vjpNawCLWONcUcl5XpSBVOp/dl4BTK/6Xf8G
         iOObazZZstakf2UHswQPDXFVkWSbWcuPiLrN5I4Oe203ln5xva4k9GAG2yKhDYpcnUnm
         e+DA==
X-Gm-Message-State: ABy/qLagMkxJA70IaqYWpIESPi9bRR53TSaz0aS5scfDNFGUIRqiwprU
	5x28WudIoaGkCBUy+FSBU61kUL9iMu+ewBRj
X-Google-Smtp-Source: APBJJlGEXj/SuIznsTtvig9Yg9Oohad9E5NQ4lVn7k61BjfIfAMcBumsQSX5YI1/YUd94CtFrImJlQ==
X-Received: by 2002:a05:6a20:8f27:b0:10b:b6cf:bbb0 with SMTP id b39-20020a056a208f2700b0010bb6cfbbb0mr14483875pzk.42.1689671466440;
        Tue, 18 Jul 2023 02:11:06 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bf6-20020a170902b90600b001b890b3bbb1sm1320143plb.211.2023.07.18.02.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 02:11:05 -0700 (PDT)
Date: Tue, 18 Jul 2023 17:10:56 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Liang Li <liali@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCHv2 net 2/2] team: reset team's flags when down link is P2P
 device
Message-ID: <ZLZXIMk9dCm5PgM4@Laptop-X1>
References: <20230714081340.2064472-1-liuhangbin@gmail.com>
 <20230714081340.2064472-3-liuhangbin@gmail.com>
 <33950173db97ff49475551cd53ae287be895a6be.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33950173db97ff49475551cd53ae287be895a6be.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 10:01:27AM +0200, Paolo Abeni wrote:
> > diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> > index 555b0b1e9a78..9104e373c8cb 100644
> > --- a/drivers/net/team/team.c
> > +++ b/drivers/net/team/team.c
> > @@ -2135,6 +2135,11 @@ static void team_setup_by_port(struct net_device *dev,
> >  	dev->mtu = port_dev->mtu;
> >  	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
> >  	eth_hw_addr_inherit(dev, port_dev);
> > +
> > +	if (port_dev->flags & IFF_POINTOPOINT) {
> > +		dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
> > +		dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
> > +	}
> 
> It's unclear to me what happens with the following sequence of events:
> 
> * p2p dev is enslaved to team (IFF_BROADCAST cleared)
> * p2p dev is removed from team
> * plain ether device is enslaved to team.
> 
> I don't see where/when IFF_BROADCAST is set again. Could you please
> point it out?

Hmm, you are right. Bonding will call bond_ether_setup(), ether_setup() to
reset the dev flags. But team didn't do that. I will fix it.

Thanks
Hangbin

