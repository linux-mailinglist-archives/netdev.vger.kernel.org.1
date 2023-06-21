Return-Path: <netdev+bounces-12525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E83737F21
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 11:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9971281552
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 09:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F83D53C;
	Wed, 21 Jun 2023 09:47:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E73C8E2
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 09:47:41 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29F0197
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:47:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-311099fac92so6643014f8f.0
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 02:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687340856; x=1689932856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W7vaP4COJw7cr7JoMrHnRrsTiKTA9ch4qqT7H54n5KE=;
        b=G30UblbIXu9IjjMqmFif9BgmLt3Q/wQTHEsMPkfLQ2oBmWTm5RII/sOqRztvRcsWzJ
         Ah1nQh48mmP5CCrE8aTcUVUSRu13vhQVf2MVFOCvM47xAA/Hiu+J9dk2gnQwl4QC7hes
         HAP+lqoeyWWN5jjl1ayxKa2WnWgnkphJfGXVAvPgzlV6KAYCB72zEOCUC1Fkgw2LG2RL
         qFScXp+08lWQ9ZxXHT9Qcij9NKqAiIrz+h+nz7blAAb2hEcKUuX4T5C8U7kkITRkk9FZ
         XqqvTK/GSalt63Du1qQniW+Vrm4MpysfSqjvspyrrmkcgIBSjkIMw+kflK9hW0VEDDaJ
         SBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687340856; x=1689932856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7vaP4COJw7cr7JoMrHnRrsTiKTA9ch4qqT7H54n5KE=;
        b=c/++QrbDL8UT+8ZnPyWdeCga16UwWUhFB0DFRVzRB3fBOtpzCGY1hF2AA4pIlJ2cA5
         Wi3IaGeO7xM0priLs82D3jAvq7QL+9dX6k6sRg05jUGvx0Yt24H/KfhvIswQZO1E+PNc
         RiSag3JRvop1kHkCG5qIAdCUPLiOzIZu8S1NAUi4ginH/nIfLl7bmgiXzYWp/mE+iNXH
         trb+p0rWXl3YgFtkfXF/DrJnc3WH9TmLAiBN+scYJfECY/ktuD6hhPWWSAW39qyZghsg
         LzsWALGnS8FdEzBIRGhryHBmU0X7Gkyo5j1c5ec1MMiZe5DbfAImKdnTvXzJuP4ePfVw
         xiEQ==
X-Gm-Message-State: AC+VfDzx32OVxh/esBxS+S5Y0P4Ve3MqC2RfJ9r4CMgPhV96FHnA44i7
	lVgRFSCE+7bhAlvyNGBRUypQRw==
X-Google-Smtp-Source: ACHHUZ6ePCYgaia+iVpDq0611OUDvjZTLmyLBYbezvwjToiHn9G9AScJHP32anCsooi+7JwtVK2+aw==
X-Received: by 2002:adf:f00f:0:b0:30f:c679:793a with SMTP id j15-20020adff00f000000b0030fc679793amr12494668wro.3.1687340856153;
        Wed, 21 Jun 2023 02:47:36 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w18-20020a5d6812000000b0030ae69920c9sm3991595wru.53.2023.06.21.02.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 02:47:34 -0700 (PDT)
Date: Wed, 21 Jun 2023 12:47:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Joel Granados <j.granados@samsung.com>
Cc: mcgrof@kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Joerg Reuter <jreuter@yaina.de>, Ralf Baechle <ralf@linux-mips.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <martineau@kernel.org>,
	Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>,
	Remi Denis-Courmont <courmisch@gmail.com>,
	Santosh Shilimkar <santosh.shilimkar@oracle.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>, Martin Schiller <ms@dev.tdt.de>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-hams@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	bridge@lists.linux-foundation.org, dccp@vger.kernel.org,
	linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
	lvs-devel@vger.kernel.org, rds-devel@oss.oracle.com,
	linux-afs@lists.infradead.org, linux-sctp@vger.kernel.org,
	linux-s390@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
	linux-x25@vger.kernel.org
Subject: Re: [PATCH 06/11] sysctl: Add size to register_net_sysctl function
Message-ID: <dab06c20-f8b0-4e34-b885-f3537e442d54@kadam.mountain>
References: <20230621091000.424843-1-j.granados@samsung.com>
 <CGME20230621091022eucas1p1c097da50842b23e902e1a674e117e1aa@eucas1p1.samsung.com>
 <20230621091000.424843-7-j.granados@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621091000.424843-7-j.granados@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The patchset doesn't include the actual interesting changes, just a
bunch of mechanical prep work.

On Wed, Jun 21, 2023 at 11:09:55AM +0200, Joel Granados wrote:
> diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
> index a91283d1e5bf..7b717434368c 100644
> --- a/net/ieee802154/6lowpan/reassembly.c
> +++ b/net/ieee802154/6lowpan/reassembly.c
> @@ -379,7 +379,8 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
>  	table[1].extra2	= &ieee802154_lowpan->fqdir->high_thresh;
>  	table[2].data	= &ieee802154_lowpan->fqdir->timeout;
>  
> -	hdr = register_net_sysctl(net, "net/ieee802154/6lowpan", table);
> +	hdr = register_net_sysctl(net, "net/ieee802154/6lowpan", table,
> +				  ARRAY_SIZE(lowpan_frags_ns_ctl_table));

For example, in lowpan_frags_ns_sysctl_register() the sentinel is
sometimes element zero if the user doesn't have enough permissions.  I
would want to ensure that was handled correctly, but that's going to be
done later in a completely different patchset.  I'm definitely not going
to remember to check.

> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index dc5165d3eec4..6f96aae76537 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -1395,6 +1395,40 @@ static const struct ctl_table mpls_dev_table[] = {
>  	{ }
>  };
>  
> +static int mpls_platform_labels(struct ctl_table *table, int write,
> +				void *buffer, size_t *lenp, loff_t *ppos);
> +#define MPLS_NS_SYSCTL_OFFSET(field)		\
> +	(&((struct net *)0)->field)
> +
> +static const struct ctl_table mpls_table[] = {
> +	{
> +		.procname	= "platform_labels",
> +		.data		= NULL,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= mpls_platform_labels,
> +	},
> +	{
> +		.procname	= "ip_ttl_propagate",
> +		.data		= MPLS_NS_SYSCTL_OFFSET(mpls.ip_ttl_propagate),
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
> +	{
> +		.procname	= "default_ttl",
> +		.data		= MPLS_NS_SYSCTL_OFFSET(mpls.default_ttl),
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= &ttl_max,
> +	},
> +	{ }
> +};
> +
>  static int mpls_dev_sysctl_register(struct net_device *dev,
>  				    struct mpls_dev *mdev)
>  {
> @@ -1410,7 +1444,7 @@ static int mpls_dev_sysctl_register(struct net_device *dev,
>  	/* Table data contains only offsets relative to the base of
>  	 * the mdev at this point, so make them absolute.
>  	 */
> -	for (i = 0; i < ARRAY_SIZE(mpls_dev_table); i++) {
> +	for (i = 0; i < ARRAY_SIZE(mpls_dev_table) - 1; i++) {

Adding the " - 1" is just a gratuitous change.  It's not required.
It makes that patch more confusing to review.  And you're just going
to have to change it back to how it was if you remove the sentinel.

>  		table[i].data = (char *)mdev + (uintptr_t)table[i].data;
>  		table[i].extra1 = mdev;
>  		table[i].extra2 = net;
> @@ -1418,7 +1452,8 @@ static int mpls_dev_sysctl_register(struct net_device *dev,
>  
>  	snprintf(path, sizeof(path), "net/mpls/conf/%s", dev->name);
>  
> -	mdev->sysctl = register_net_sysctl(net, path, table);
> +	mdev->sysctl = register_net_sysctl(net, path, table,
> +					   ARRAY_SIZE(mpls_dev_table));
>  	if (!mdev->sysctl)
>  		goto free;
>  
> @@ -1432,6 +1467,7 @@ static int mpls_dev_sysctl_register(struct net_device *dev,
>  	return -ENOBUFS;
>  }
>  
> +

Double blank line.

>  static void mpls_dev_sysctl_unregister(struct net_device *dev,
>  				       struct mpls_dev *mdev)
>  {

regards,
dan carpenter

