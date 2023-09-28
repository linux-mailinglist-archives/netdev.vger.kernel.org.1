Return-Path: <netdev+bounces-36767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719387B1A9C
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 13:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 7C3471C208F0
	for <lists+netdev@lfdr.de>; Thu, 28 Sep 2023 11:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8C5374E8;
	Thu, 28 Sep 2023 11:20:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D901862D
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 11:19:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B9B1BC6
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 04:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695899993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LZyalP8efyhZ47CffuwWrgdt3siIzI6BNgFohr02Yz0=;
	b=CSxjo5s+bvb60Bop3xCfRfTM+6V7AAGegETYcF8eMiP8FaujR6mUTqMI2Vy66FcaF5vKYd
	Io/G11W72/gbEkMSrSd/3s0xh/dZ9IBzp9J8226g+PgECactu3M4lU2ohWLU5xMYLklr6J
	XsCRWmvY+Z9EMyhTCBQDSPdrUnD60ig=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-J57mhjKaPFmXT4CVpTGw1g-1; Thu, 28 Sep 2023 07:19:52 -0400
X-MC-Unique: J57mhjKaPFmXT4CVpTGw1g-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7742bd869e4so345315885a.1
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 04:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695899992; x=1696504792;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZyalP8efyhZ47CffuwWrgdt3siIzI6BNgFohr02Yz0=;
        b=Nfs8ZICCwvxtAbuj/71YzYv2DBV5rrg86FydQQpEkXfHMDqWwt1ppWwFOvZr1NlU6L
         KFMgwcV6wqhp7FRVDDAc0MzMpE1ImW0sE/eg3tno3ai2lokACtisnKqiqh+btGkn0ErK
         qKPAWG24mnBdTUWsTAGRrPpqguq2m8PQ2AeiBF7+esM0Hrm+q5AWi8e5zbazA6O9HIET
         wCEoLl6JV41rSBRlsjASaiTzcRcPTZPAxIdwLOpLs1TaZoR0rADlwoNegUp3JoDuYmeT
         1iSKCpyYeUb+vVCm+M8DosYX/wAePiJdiRVLjEbSOBQG93iOMrFobqtKPBubd7mDTJXi
         uAfA==
X-Gm-Message-State: AOJu0YwukSOhtF+CVKp61h+Hu3Iibqyj/GMdFu+dTNKNNFGSD1C1UPMW
	6rjcK/yQvysuZlVMwZCIxaRJ/xjInwdEKyNrCPEw6RYucrHKRAo3Ifznr+9rimFe0moZczbdt5k
	/rEL6f622+TO9mbiciCQ+a0tzKqY=
X-Received: by 2002:a05:620a:191d:b0:76d:9234:1db4 with SMTP id bj29-20020a05620a191d00b0076d92341db4mr710482qkb.7.1695899991975;
        Thu, 28 Sep 2023 04:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXGg2l+kUTlqdZkTybEkjvDiy3mSBP/ZuJA6V2Jk28zzDe35JkGva/iDXQ9h2kKZu9fe14rQ==
X-Received: by 2002:a05:620a:191d:b0:76d:9234:1db4 with SMTP id bj29-20020a05620a191d00b0076d92341db4mr710471qkb.7.1695899991608;
        Thu, 28 Sep 2023 04:19:51 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-233-183.dyn.eolo.it. [146.241.233.183])
        by smtp.gmail.com with ESMTPSA id u4-20020ae9c004000000b00774350813ccsm2877307qkk.118.2023.09.28.04.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 04:19:51 -0700 (PDT)
Message-ID: <1f55345f58987dbcfd566e1f61aee55d2c78f788.camel@redhat.com>
Subject: Re: [net-next PATCH v3 06/10] netdev-genl: Add netlink framework
 functions for napi
From: Paolo Abeni <pabeni@redhat.com>
To: Amritha Nambiar <amritha.nambiar@intel.com>, netdev@vger.kernel.org, 
	kuba@kernel.org
Cc: sridhar.samudrala@intel.com
Date: Thu, 28 Sep 2023 13:19:48 +0200
In-Reply-To: <169516246697.7377.18105000910116179893.stgit@anambiarhost.jf.intel.com>
References: 
	<169516206704.7377.12938469824609831999.stgit@anambiarhost.jf.intel.com>
	 <169516246697.7377.18105000910116179893.stgit@anambiarhost.jf.intel.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-09-19 at 15:27 -0700, Amritha Nambiar wrote:
> Implement the netdev netlink framework functions for
> napi support. The netdev structure tracks all the napi
> instances and napi fields. The napi instances and associated
> parameters can be retrieved this way.
>=20
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  include/linux/netdevice.h |    2 +
>  net/core/dev.c            |    4 +-
>  net/core/netdev-genl.c    |  117 +++++++++++++++++++++++++++++++++++++++=
+++++-
>  3 files changed, 119 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 69e363918e4b..e7321178dc1a 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -536,6 +536,8 @@ static inline bool napi_complete(struct napi_struct *=
n)
>  	return napi_complete_done(n, 0);
>  }
> =20
> +struct napi_struct *napi_by_id(unsigned int napi_id);
> +
>  int dev_set_threaded(struct net_device *dev, bool threaded);
> =20
>  /**
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 508b1d799681..ea6b3115ee8b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -165,7 +165,6 @@ static int netif_rx_internal(struct sk_buff *skb);
>  static int call_netdevice_notifiers_extack(unsigned long val,
>  					   struct net_device *dev,
>  					   struct netlink_ext_ack *extack);
> -static struct napi_struct *napi_by_id(unsigned int napi_id);
> =20
>  /*
>   * The @dev_base_head list is protected by @dev_base_lock and the rtnl
> @@ -6133,7 +6132,7 @@ bool napi_complete_done(struct napi_struct *n, int =
work_done)
>  EXPORT_SYMBOL(napi_complete_done);
> =20
>  /* must be called under rcu_read_lock(), as we dont take a reference */
> -static struct napi_struct *napi_by_id(unsigned int napi_id)
> +struct napi_struct *napi_by_id(unsigned int napi_id)
>  {
>  	unsigned int hash =3D napi_id % HASH_SIZE(napi_hash);
>  	struct napi_struct *napi;
> @@ -6144,6 +6143,7 @@ static struct napi_struct *napi_by_id(unsigned int =
napi_id)
> =20
>  	return NULL;
>  }
> +EXPORT_SYMBOL(napi_by_id);
> =20
>  #if defined(CONFIG_NET_RX_BUSY_POLL)
> =20
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 8609884fefe4..6f4ed21ebd15 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -7,6 +7,7 @@
>  #include <net/sock.h>
>  #include <net/xdp.h>
>  #include <net/netdev_rx_queue.h>
> +#include <net/busy_poll.h>
> =20
>  #include "netdev-genl-gen.h"
> =20
> @@ -14,6 +15,7 @@ struct netdev_nl_dump_ctx {
>  	unsigned long	ifindex;
>  	unsigned int	rxq_idx;
>  	unsigned int	txq_idx;
> +	unsigned int	napi_id;

Why you need to add napi_id to the context? don't you need just such
field to do the traversing? e.g. use directly single cb[0]

[...]
> +static int
> +netdev_nl_napi_dump_one(struct net_device *netdev, struct sk_buff *rsp,
> +			const struct genl_info *info, unsigned int *start)
> +{
> +	struct napi_struct *napi;
> +	int err =3D 0;
> +
> +	list_for_each_entry_rcu(napi, &netdev->napi_list, dev_list) {

I'm sorry for the conflicting feedback here, but I think you don't need
any special variant, just 'list_for_each_entry'. This is under rtnl
lock, the list can't change under the hood. Also I think you should get
a RCU splat here when building with CONFIG_PROVE_RCU_LIST.


Cheers,

Paolo


