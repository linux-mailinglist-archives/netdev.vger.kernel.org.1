Return-Path: <netdev+bounces-18548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 685CC757957
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 12:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7E61C20CAE
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3D95662;
	Tue, 18 Jul 2023 10:34:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C34253C8
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:34:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220241B6
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689676494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XmJ5er1AV6LuYMRqG6UG7ANRyTQybKdF3pT2kD/7TDM=;
	b=JzL52eDSw8YJNshJrpCPyjd5ey2Je///pOJpVfppkHwYOQcVgmNH5EdvlIFrM4Vof1sK0L
	UjtE2nEZ82VF7XXqzRxC/DUQIkxUlqtCoKlktKEszDOiruLFBheD8x+rWlhyU9/YvcWctb
	fIyLHtTKzaeW2xCG0+ZzKL3OnSo6+Ns=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-KLjTRdNcMb2u30V4pLkE1A-1; Tue, 18 Jul 2023 06:34:53 -0400
X-MC-Unique: KLjTRdNcMb2u30V4pLkE1A-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7672918d8a4so129723385a.0
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689676492; x=1692268492;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XmJ5er1AV6LuYMRqG6UG7ANRyTQybKdF3pT2kD/7TDM=;
        b=SPodyRrOrwUaxRVN0rOqppY7N+LmzHrqiy9VS5cP9ZDjZzyzBCaax0DXWiwNOJN/NH
         ey3s/CC5AY5jS1B15tfyWtBBt/jppFuAR4xgGU0PCzV7xO6MNuPLuKhubWzEv3XNhgz6
         eWe6piFs5L3Np2b6wVIroAPRb2Ax29izI0jB9BkT1zO4JvSfwIcV5zMUMKQBgKRp71P2
         xkQqGz2epGmEt6Ji5chxkt2XgSvDjh+fybL5HcW0wm31zDLPn59dwk+0Eaq1c/L/7xME
         xzEs6I5bdyb+50/ILRhX1LfS16NwM4DbRzPH1G/nGjWHkQFnjlRvmxBBV+gbpkSlB/nN
         oa+w==
X-Gm-Message-State: ABy/qLaVu4RhCIHocJMjosJZQL9CD0HTI6tRS6lKZkDnXb2FvBxnymyS
	298jBdYmPkBE2Wl/LQhgnZfJb4Qh5tOUlePs8isOhkKWR4Pbqpa+op0P/lMwUtrqi0HY6/1r5+M
	SxX4jiYd4CGVQBvkF
X-Received: by 2002:a05:620a:4545:b0:766:3190:8052 with SMTP id u5-20020a05620a454500b0076631908052mr11364159qkp.0.1689676492695;
        Tue, 18 Jul 2023 03:34:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHYrO0ABUIgMBDYx5gO9Jkfww39fKwJPig8csSo20B2W+m6BY5xe8lsA4ooxsL5552qLzpvyg==
X-Received: by 2002:a05:620a:4545:b0:766:3190:8052 with SMTP id u5-20020a05620a454500b0076631908052mr11364150qkp.0.1689676492422;
        Tue, 18 Jul 2023 03:34:52 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id g16-20020a05620a13d000b007620b03ee65sm497256qkl.37.2023.07.18.03.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 03:34:51 -0700 (PDT)
Message-ID: <e7def8ab99c2a27176e0861117efbe4797c908eb.camel@redhat.com>
Subject: Re: [PATCH v1 net 1/4] llc: Check netns in llc_dgram_match().
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
	 <razor@blackwall.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Harry Coin
	 <hcoin@quietfountain.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	netdev@vger.kernel.org
Date: Tue, 18 Jul 2023 12:34:47 +0200
In-Reply-To: <20230715021338.34747-2-kuniyu@amazon.com>
References: <20230715021338.34747-1-kuniyu@amazon.com>
	 <20230715021338.34747-2-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

the series LGTM, I have only a couple of (very) minor nit, see below...

On Fri, 2023-07-14 at 19:13 -0700, Kuniyuki Iwashima wrote:
> We will remove this restriction in llc_rcv() in the following patch,

s/following patch/soon/, as the following patch will not do that ;)

> which means that the protocol handler must be aware of netns.
>=20
> 	if (!net_eq(dev_net(dev), &init_net))
> 		goto drop;
>=20
> llc_rcv() fetches llc_type_handlers[llc_pdu_type(skb) - 1] and calls it
> if not NULL.
>=20
> If the PDU type is LLC_DEST_SAP, llc_sap_handler() is called to pass skb
> to corresponding sockets.  Then, we must look up a proper socket in the
> same netns with skb->dev.
>=20
> If the destination is a multicast address, llc_sap_handler() calls
> llc_sap_mcast().  It calculates a hash based on DSAP and skb->dev->ifinde=
x,
> iterates on a socket list, and calls llc_mcast_match() to check if the
> socket is the correct destination.  Then, llc_mcast_match() checks if
> skb->dev matches with llc_sk(sk)->dev.  So, we need not check netns here.
>=20
> OTOH, if the destination is a unicast address, llc_sap_handler() calls
> llc_lookup_dgram() to look up a socket, but it does not check the netns.
>=20
> Therefore, we need to add netns check in llc_lookup_dgram().
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/llc/llc_sap.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/net/llc/llc_sap.c b/net/llc/llc_sap.c
> index 6805ce43a055..5c83fca3acd5 100644
> --- a/net/llc/llc_sap.c
> +++ b/net/llc/llc_sap.c
> @@ -294,13 +294,15 @@ static void llc_sap_rcv(struct llc_sap *sap, struct=
 sk_buff *skb,
> =20
>  static inline bool llc_dgram_match(const struct llc_sap *sap,
>  				   const struct llc_addr *laddr,
> -				   const struct sock *sk)
> +				   const struct sock *sk,
> +				   const struct net *net)
>  {
>       struct llc_sock *llc =3D llc_sk(sk);
> =20
>       return sk->sk_type =3D=3D SOCK_DGRAM &&
> -	  llc->laddr.lsap =3D=3D laddr->lsap &&
> -	  ether_addr_equal(llc->laddr.mac, laddr->mac);
> +	     net_eq(sock_net(sk), net) &&
> +	     llc->laddr.lsap =3D=3D laddr->lsap &&
> +	     ether_addr_equal(llc->laddr.mac, laddr->mac);
>  }
> =20
>  /**
> @@ -312,7 +314,8 @@ static inline bool llc_dgram_match(const struct llc_s=
ap *sap,
>   *	mac, and local sap. Returns pointer for socket found, %NULL otherwise=
.
>   */

As this function has doxygen documentation, you should additionally
document the 'net' argument.

Thanks,

Paolo


