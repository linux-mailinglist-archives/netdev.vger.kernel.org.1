Return-Path: <netdev+bounces-19713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BA475BCE1
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 05:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453E52820A6
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 03:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200C4659;
	Fri, 21 Jul 2023 03:43:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113407F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 03:43:46 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B66272C
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 20:43:45 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-553ad54d3c6so831247a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 20:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689911025; x=1690515825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6pjF0oH+2jtoyW480YDKi0koX7plpTpR0yT9jY1vLQ=;
        b=VOCACyD12VFQu1pHckrxr7b+fCAEVfV8jyCLHwcp8nJtzS/JRNKKUt1OmrqOo5Leya
         E0g+SYAhyUtpXWk1ix/ktxeqIkJATOuqj1U9vXdfjpCGpMVGsDbyvhRypuCpN48WiPz5
         MfWQViDuN6dbjcLLqc9u5uMy53Tdy7NZcT5eVlObo5nwHFYBjKELXNONUTvrcPdGuIXY
         AOk3wypoXd+0r0LnGx4nrxD2cnrz7RKiUYzqoT4cbHZV4z2TLKGjfB8dxsZn78E65sBx
         IBu20L1dF1CIGI8KpEWVxzIPjdu+vwrkg+FEtA5LfSN/CXrmRjo1nKdN2sA7rFTRVnWv
         mG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689911025; x=1690515825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6pjF0oH+2jtoyW480YDKi0koX7plpTpR0yT9jY1vLQ=;
        b=O84VH83dq1d8qtkHIAyONDVi5sy+KS5SJPwhJsb5e/2xIsxjMpPdabTqxdGfCennWY
         aZ18yPEPyH12phu3dbWmzUx1zVhV+pcE/noLoIeyMjXaEH0WeGl7QL5Peo1t9DtmFnaH
         X9mTL1QZ6yXhfAWvy6izsfUwljHxXHgkxUHM0iHyeDjlRfpx69ase/7xxTKViajG8/mx
         Zb2eS3G6RIoKbaMzqSKvO4qB7ltr/nsAoqiL5WAMLk6am2ENKuiDsJ5x7kBYxWtoR1Ng
         CYA33c6aF0MrccPjY+RtEv24yI4hVDocTfCGofVykSSbYlMOQUDXorls5hafvcBsanR6
         GZQg==
X-Gm-Message-State: ABy/qLbo+6PbEsg93U4vh/C+Rk5ktGehMluEuPbbc0SygjGsS4rbBzXR
	GhRDlHYtGrgCLcl+ISCcqL0=
X-Google-Smtp-Source: APBJJlFumPkYk2PvkbOsAj/c3JS0ime07iXyiw/puQyKUcBTcMvXq/FLtPRfJj+9YSyF6nDZqubz7Q==
X-Received: by 2002:a05:6a20:197:b0:101:1951:d491 with SMTP id 23-20020a056a20019700b001011951d491mr631985pzy.6.1689911025155;
        Thu, 20 Jul 2023 20:43:45 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902bd0400b001ab2b4105ddsm2215437pls.60.2023.07.20.20.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 20:43:44 -0700 (PDT)
Date: Fri, 21 Jul 2023 11:43:39 +0800
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
Message-ID: <ZLn+65hLufxEibUN@Laptop-X1>
References: <20230718101741.2751799-1-liuhangbin@gmail.com>
 <20230718101741.2751799-3-liuhangbin@gmail.com>
 <ca0a159b39c4e1d192d225e96367c2ff7ffae25e.camel@redhat.com>
 <ZLkCXLsf+K6GLS/6@Laptop-X1>
 <dcb23aaea64e5a890dd3c819dd6ba1ab2799dbfd.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcb23aaea64e5a890dd3c819dd6ba1ab2799dbfd.camel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 20, 2023 at 12:40:56PM +0200, Paolo Abeni wrote:
> > I don't see the reason why we should inherited a none ethernet dev's mtu
> > to an ethernet dev (i.e. add a none ethernet dev to team, then delete it and
> > re-add a ethernet dev to team). I think the dev type has changed, so the
> > mtu should also be updated.
> > 
> > BTW, after adding the port, team will also set port's mtu to team's mtu.
> 
> Let suppose the user has set the lower dev MTU to some N (< 1500) for
> whatever reason (e.g. lower is a vxlan tunnel). After this change, team
> will use mtu = 1500 breaking the connectivity in such scenario/

This looks like a team bug here. Team will not inherited port mtu if
they are some dev type. This would cause adding vxlan to team failed.

But if we change the team dev type and then adding vxlan. Team will
reset the mtu and add vxlan success.

With my patch, if we reset team to 1500, the later adding will failed.
So, as consistency, you suggestion is right.

> As far as I can see team_setup_by_port() takes care of that, inheriting
> such infor from the current slave. What I mean is something alike the
> following.
> 
> Cheers,
> 
> Paolo
> 
> ---
> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> index 555b0b1e9a78..17c8056adbe9 100644
> --- a/drivers/net/team/team.c
> +++ b/drivers/net/team/team.c
> @@ -2135,6 +2135,15 @@ static void team_setup_by_port(struct net_device *dev,
>  	dev->mtu = port_dev->mtu;
>  	memcpy(dev->broadcast, port_dev->broadcast, port_dev->addr_len);
>  	eth_hw_addr_inherit(dev, port_dev);
> +
> +	if (port_dev->flags & IFF_POINTOPOINT) {
> +		dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
> +		dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
> +	} else if ((port_dev->flags & (IFF_BROADCAST | IFF_MULTICAST)) ==
> +		   (IFF_BROADCAST | IFF_MULTICAST)) {
> +		dev->flags |= IFF_BROADCAST | IFF_MULTICAST;
> +		dev->flags &= ~(IFF_POINTOPOINT | IFF_NOARP)
> +	}
>  }

Thanks, this looks good to me. I will update the patch.

Hangbin

