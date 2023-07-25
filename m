Return-Path: <netdev+bounces-20721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FC9760C40
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 09:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3F51C20DF0
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 07:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D175411CB0;
	Tue, 25 Jul 2023 07:45:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56F0111A7
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 07:45:30 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AD997
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:45:29 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a36b309524so3936082b6e.3
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 00:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690271129; x=1690875929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ho31wz8ZD4iWlPaxb5elWbPWIFXMo0wok4X5a2KWREs=;
        b=HSnT27CdeNsSv2isiLYAc7f1EWUXCCkmnKCX9zHJDPPRuH1Xvzyns8zRmpkYlAAkHR
         szHQL2jJ1NEnTdyW1uY+5uMdIeqeEZQ6dHg1FHxrujAHnVLXBSTSFtzM1b0GdLyeI+lV
         IpSWxzLMXQhXyqOoP5Af3EV6QXQdvgpmxpJshmAlnnoPl9s088EewZP2Fb9i5ucBM0kp
         +uBl5NTIAlaZbAJ9TrE/EiJD97fCkb98HUmQq/8Scv8ERE7Yu+bDRc+n/OeODSOQqQe3
         +aqZDUE/U9BIikglPC5oX22Mq0FM5tvSPmG0ESctYfi1eT9qSc8yLZfq0Ph0tfP2pPKJ
         Uf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690271129; x=1690875929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ho31wz8ZD4iWlPaxb5elWbPWIFXMo0wok4X5a2KWREs=;
        b=FVOqeqz5oaVQHdsz5bAK4luYeJpImOcXhZAeLeIEqqNWhwzRIQBc1hY5qMjq5DpjLg
         /y+YhnHQCMge8tr0zUQmJX4f1qzN1Ig6GS0GgU/JBiUetW1DGsF6lKIQUysnCJTaRW96
         SY26JIEkDXawisB5Kt4Yb2GYNcxP16hEySB/F6q/Xbc/YS1qy0P5RVmLZEaaz8vhlqFS
         97rS8kK2wbyhTztUnu0faq1CYv5NFfW990Z0Tc4qGOyi0IQXLu19cO+d3iRXRyW3hsoz
         N+x5He0jTKdSDh7tcBRhahp3RtSquxtTj5n6iCgOluCLks8WqX3/j3FyKHJpgttekDnx
         e2UA==
X-Gm-Message-State: ABy/qLamQcXcHJeANH6VgNDCwquokljIqRliewvtZxEJco5N/0eUZerA
	kVdGhq0Y7pTkHiBohfAaK4I5VQOolMRaK2yY
X-Google-Smtp-Source: APBJJlGHwkMtCNB5lN+OTz1WKRiaspLkxIMLn4a0F5//Y6kg4f7iTW8BotVJtWzBtfumTxIuiKHd5g==
X-Received: by 2002:a05:6808:2023:b0:3a1:df16:2eed with SMTP id q35-20020a056808202300b003a1df162eedmr15213095oiw.30.1690271128742;
        Tue, 25 Jul 2023 00:45:28 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d15-20020a17090a02cf00b00262d662c9adsm9920268pjd.53.2023.07.25.00.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 00:45:28 -0700 (PDT)
Date: Tue, 25 Jul 2023 15:45:24 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Beniamino Galvani <bgalvani@redhat.com>
Subject: Re: [PATCHv3 net-next] IPv6: add extack info for IPv6 address
 add/delete
Message-ID: <ZL99lOAlwAsvsJU1@Laptop-X1>
References: <20230724075051.20081-1-liuhangbin@gmail.com>
 <1c9f75cc-b9c0-0f5d-9b92-b37f639ce25b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c9f75cc-b9c0-0f5d-9b92-b37f639ce25b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 09:02:42AM -0600, David Ahern wrote:
> On 7/24/23 1:50 AM, Hangbin Liu wrote:
> > Add extack info for IPv6 address add/delete, which would be useful for
> > users to understand the problem without having to read kernel code.
> > 
> > Suggested-by: Beniamino Galvani <bgalvani@redhat.com>
> > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> > ---
> > v3: * Update extack message. Pass extack to addrconf_f6i_alloc().
> >     * Return "IPv6 is disabled" for addrconf_add_dev(), as the same
> >       with ndisc_allow_add() does.
> >     * Set dup addr extack message in inet6_rtm_newaddr() instead of
> >       ipv6_add_addr_hash().
> > v2: Update extack msg for dead dev. Remove msg for NOBUFS error.
> >     Add extack for ipv6_add_addr_hash()
> > ---
> >  include/net/ip6_route.h |  2 +-
> >  net/ipv6/addrconf.c     | 63 +++++++++++++++++++++++++++++------------
> >  net/ipv6/anycast.c      |  2 +-
> >  net/ipv6/route.c        |  5 ++--
> >  4 files changed, 50 insertions(+), 22 deletions(-)
> > 
> 
> This patch is getting long enough, so:
> Reviewed-by: David Ahern <dsahern@kernel.org>
> 

Thanks a lot for your review.

> Followup requests below. Thanks,

> 
> > diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> > index 19eb4b3d26ea..53dea18a4a07 100644
> > --- a/net/ipv6/addrconf.c
> > +++ b/net/ipv6/addrconf.c
> > @@ -1068,15 +1068,19 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
> >  	     !(cfg->ifa_flags & IFA_F_MCAUTOJOIN)) ||
> >  	    (!(idev->dev->flags & IFF_LOOPBACK) &&
> >  	     !netif_is_l3_master(idev->dev) &&
> > -	     addr_type & IPV6_ADDR_LOOPBACK))
> > +	     addr_type & IPV6_ADDR_LOOPBACK)) {
> > +		NL_SET_ERR_MSG(extack, "Cannot assign requested address");
> >  		return ERR_PTR(-EADDRNOTAVAIL);
> > +	}
> 
> It would be good to split the above checks into separate ones with more
> specific messages.

How about this.

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 53dea18a4a07..e6c3fe413441 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1063,13 +1063,17 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
        struct fib6_info *f6i = NULL;
        int err = 0;

-       if (addr_type == IPV6_ADDR_ANY ||
-           (addr_type & IPV6_ADDR_MULTICAST &&
-            !(cfg->ifa_flags & IFA_F_MCAUTOJOIN)) ||
-           (!(idev->dev->flags & IFF_LOOPBACK) &&
-            !netif_is_l3_master(idev->dev) &&
-            addr_type & IPV6_ADDR_LOOPBACK)) {
-               NL_SET_ERR_MSG(extack, "Cannot assign requested address");
+       if (addr_type == IPV6_ADDR_ANY) {
+               NL_SET_ERR_MSG(extack, "IPv6: Cannot assign unspecified address");
+               return ERR_PTR(-EADDRNOTAVAIL);
+       } else if (addr_type & IPV6_ADDR_MULTICAST &&
+                  !(cfg->ifa_flags & IFA_F_MCAUTOJOIN)) {
+               NL_SET_ERR_MSG(extack, "IPv6: Cannot assign multicast address without \"IFA_F_MCAUTOJOIN\" flag");
+               return ERR_PTR(-EADDRNOTAVAIL);
+       } else if (!(idev->dev->flags & IFF_LOOPBACK) &&
+                  !netif_is_l3_master(idev->dev) &&
+                  addr_type & IPV6_ADDR_LOOPBACK) {
+               NL_SET_ERR_MSG(extack, "IPv6: Cannot assign loopback address on this device");
                return ERR_PTR(-EADDRNOTAVAIL);
        }

> ...
> 
> >  
> >  	if (cfg->ifa_flags & IFA_F_MCAUTOJOIN) {
> >  		int ret = ipv6_mc_config(net->ipv6.mc_autojoin_sk,
> >  					 true, cfg->pfx, ifindex);
> 
> and pass extack to this one for better message as well.

This one looks a little deep. We need pass extack to
- ipv6_mc_config
  - ipv6_sock_mc_join
    - __ipv6_sock_mc_join
      - __ipv6_dev_mc_inc	maybe also this one??

to get more detailed message. And all these are "Join multicast group failed".
Do you still want to do this?

Thanks
Hangbin

> 
> >  
> > -		if (ret < 0)
> > +		if (ret < 0) {
> > +			NL_SET_ERR_MSG(extack, "Multicast auto join failed");
> >  			return ret;
> > +		}
> >  	}
> >  
> >  	cfg->scope = ipv6_addr_scope(cfg->pfx);
> 
> 

