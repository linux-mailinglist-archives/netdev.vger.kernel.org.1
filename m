Return-Path: <netdev+bounces-100310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C968D87C3
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 19:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1202841F0
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6271612FF7B;
	Mon,  3 Jun 2024 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="E3bPIh/q"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7331366
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434925; cv=none; b=mDL2VuYmEWHUr/gDVFXdKjDUuHV4EEC3eBuV9vadhJVCoCDjW2Tj7WNPbx9QJ4PhpwU+ZSEyX/e1GZhaluNbdN992KudFLTleMORvTIzHErgaSoypl0/g2g+I3ZSWdG7VG1WTVeUgxooX0Lin9fZzg6N+fmc8AYpDzVQfVcluiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434925; c=relaxed/simple;
	bh=jualHWXuUASYnsWO1QgKt3IyZasjChH1RDyWHFLtirs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGVEX9t2TbvmHN1Fy89k4YvfnUzH5sGot6JMnF3KZATucz5lprobM6AeRnVHFZIHuAqPtOk19fokdmAM5aWBGJTx9qJEZ2A/oS5oDMVWlMjd77oSxtp0fhZw4/9SJ1bUzw+fW7wwo1Zszp/8Ii+MgNd2Z2MJ6JS9tva2s5FtiaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=E3bPIh/q; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: b1b4b60d-21cc-11ef-836c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b1b4b60d-21cc-11ef-836c-005056aba152;
	Mon, 03 Jun 2024 19:14:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=j3QrCxYvD6uA4Eof+u5ENabS6yKeQMnm0DDQR8Jahm0=;
	b=E3bPIh/qQ2QoBuG3rxyqPH+7Zrwah3A3v1+28kYCdqUwq20CH4vRj8p/sh5ywTunGJgDeJi/Yf7hI
	 3eoCRyF0ke6J6qIYp7yiczi+7cfjs4C9BRclfgw8MqZCicqPKqCI7IAgvmo//piAfNEBVtL36ILxtf
	 o/fw4WLtqJJzEZNo=
X-KPN-MID: 33|AcNecvlg+7YIHxhCbRG6JrZ5v/ZHqGlzUFtgk666mVj3EUYADwSTnm27srBE15s
 /lCKLkmrYCk1Oin+x4qaAuYtFWg1G9AwBZYzYS0JMBpM=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|elBrGdnqcXIYSs+fhLq3ci5kAGCu/bxKMcEdvkq0w3xJCudx2QdDSfX1TOIzFJn
 PxOGOhRrUcUAU7LfASHyBSQ==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id b181ebab-21cc-11ef-8132-005056ab1411;
	Mon, 03 Jun 2024 19:14:11 +0200 (CEST)
Date: Mon, 3 Jun 2024 19:14:10 +0200
From: Antony Antony <antony@phenome.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v2 08/17] xfrm: iptfs: add new
 iptfs xfrm mode impl
Message-ID: <Zl354nSbE5mOMC2h@Antony2201.local>
References: <20240520214255.2590923-1-chopps@chopps.org>
 <20240520214255.2590923-9-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520214255.2590923-9-chopps@chopps.org>

Hi Chris,

On Mon, May 20, 2024 at 05:42:46PM -0400, Christian Hopps via Devel wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Add a new xfrm mode implementing AggFrag/IP-TFS from RFC9347.
> 
> This utilizes the new xfrm_mode_cbs to implement demand-driven IP-TFS
> functionality. This functionality can be used to increase bandwidth
> utilization through small packet aggregation, as well as help solve PMTU
> issues through it's efficient use of fragmentation.
> 
>   Link: https://www.rfc-editor.org/rfc/rfc9347.txt
> 
> Multiple commits follow to build the functionality into xfrm_iptfs.c
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  net/xfrm/Makefile     |   1 +
>  net/xfrm/xfrm_iptfs.c | 225 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 226 insertions(+)
>  create mode 100644 net/xfrm/xfrm_iptfs.c
> 
> diff --git a/net/xfrm/Makefile b/net/xfrm/Makefile
> index 547cec77ba03..cd6520d4d777 100644
> --- a/net/xfrm/Makefile
> +++ b/net/xfrm/Makefile
> @@ -20,5 +20,6 @@ obj-$(CONFIG_XFRM_USER) += xfrm_user.o
>  obj-$(CONFIG_XFRM_USER_COMPAT) += xfrm_compat.o
>  obj-$(CONFIG_XFRM_IPCOMP) += xfrm_ipcomp.o
>  obj-$(CONFIG_XFRM_INTERFACE) += xfrm_interface.o
> +obj-$(CONFIG_XFRM_IPTFS) += xfrm_iptfs.o
>  obj-$(CONFIG_XFRM_ESPINTCP) += espintcp.o
>  obj-$(CONFIG_DEBUG_INFO_BTF) += xfrm_state_bpf.o
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> new file mode 100644
> index 000000000000..e7b5546e1f6a
> --- /dev/null
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* xfrm_iptfs: IPTFS encapsulation support
> + *
> + * April 21 2022, Christian Hopps <chopps@labn.net>
> + *
> + * Copyright (c) 2022, LabN Consulting, L.L.C.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/icmpv6.h>
> +#include <net/gro.h>
> +#include <net/icmp.h>
> +#include <net/ip6_route.h>
> +#include <net/inet_ecn.h>
> +#include <net/xfrm.h>
> +
> +#include <crypto/aead.h>
> +
> +#include "xfrm_inout.h"
> +
> +struct xfrm_iptfs_config {
> +	u32 pkt_size;	    /* outer_packet_size or 0 */
> +};
> +
> +struct xfrm_iptfs_data {
> +	struct xfrm_iptfs_config cfg;
> +
> +	/* Ingress User Input */
> +	struct xfrm_state *x;	    /* owning state */
> +	u32 payload_mtu;	    /* max payload size */
> +};
> +
> +/* ========================== */
> +/* State Management Functions */
> +/* ========================== */
> +
> +/**
> + * iptfs_get_inner_mtu() - return inner MTU with no fragmentation.
> + * @x: xfrm state.
> + * @outer_mtu: the outer mtu
> + */
> +static u32 iptfs_get_inner_mtu(struct xfrm_state *x, int outer_mtu)
> +{
> +	struct crypto_aead *aead;
> +	u32 blksize;
> +
> +	aead = x->data;
> +	blksize = ALIGN(crypto_aead_blocksize(aead), 4);
> +	return ((outer_mtu - x->props.header_len - crypto_aead_authsize(aead)) &
> +		~(blksize - 1)) - 2;
> +}
> +
> +/**
> + * iptfs_user_init() - initialize the SA with IPTFS options from netlink.
> + * @net: the net data
> + * @x: xfrm state
> + * @attrs: netlink attributes
> + * @extack: extack return data
> + */
> +static int iptfs_user_init(struct net *net, struct xfrm_state *x,
> +			   struct nlattr **attrs,
> +			   struct netlink_ext_ack *extack)
> +{
> +	struct xfrm_iptfs_data *xtfs = x->mode_data;
> +	struct xfrm_iptfs_config *xc;
> +
> +	xc = &xtfs->cfg;
> +
> +	if (attrs[XFRMA_IPTFS_PKT_SIZE]) {
> +		xc->pkt_size = nla_get_u32(attrs[XFRMA_IPTFS_PKT_SIZE]);
> +		if (!xc->pkt_size) {
> +			xtfs->payload_mtu = 0;
> +		} else if (xc->pkt_size > x->props.header_len) {
> +			xtfs->payload_mtu = xc->pkt_size - x->props.header_len;
> +		} else {
> +			NL_SET_ERR_MSG(extack,
> +				       "Packet size must be 0 or greater than IPTFS/ESP header length");
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static unsigned int iptfs_sa_len(const struct xfrm_state *x)
> +{
> +	struct xfrm_iptfs_data *xtfs = x->mode_data;
> +	struct xfrm_iptfs_config *xc = &xtfs->cfg;
> +	unsigned int l = 0;
> +
> +	l += nla_total_size(0);
> +	l += nla_total_size(sizeof(u16));
> +	l += nla_total_size(sizeof(xc->pkt_size));
> +	l += nla_total_size(sizeof(u32));
> +	l += nla_total_size(sizeof(u32)); /* drop time usec */
> +	l += nla_total_size(sizeof(u32)); /* init delay usec */
> +
> +	return l;
> +}
> +
> +static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
> +{
> +	struct xfrm_iptfs_data *xtfs = x->mode_data;
> +	struct xfrm_iptfs_config *xc = &xtfs->cfg;
> +	int ret;
> +
> +	ret = nla_put_flag(skb, XFRMA_IPTFS_DONT_FRAG);
> +	if (ret)
> +		return ret;
> +	ret = nla_put_u16(skb, XFRMA_IPTFS_REORDER_WINDOW, 0);
> +	if (ret)
> +		return ret;
> +	ret = nla_put_u32(skb, XFRMA_IPTFS_PKT_SIZE, xc->pkt_size);
> +	if (ret)
> +		return ret;
> +	ret = nla_put_u32(skb, XFRMA_IPTFS_MAX_QSIZE, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_u32(skb, XFRMA_IPTFS_DROP_TIME, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = nla_put_u32(skb, XFRMA_IPTFS_INIT_DELAY, 0);

Why copy all attributes? Only copy the ones relevant to the SA direction.
Also adjust in  iptfs_sa_len().

> +
> +	return ret;
> +}
> +
> +static int __iptfs_init_state(struct xfrm_state *x,
> +			      struct xfrm_iptfs_data *xtfs)
> +{
> +	/* Modify type (esp) adjustment values */
> +
> +	if (x->props.family == AF_INET)
> +		x->props.header_len += sizeof(struct iphdr) + sizeof(struct ip_iptfs_hdr);
> +	else if (x->props.family == AF_INET6)
> +		x->props.header_len += sizeof(struct ipv6hdr) + sizeof(struct ip_iptfs_hdr);
> +	x->props.enc_hdr_len = sizeof(struct ip_iptfs_hdr);
> +
> +	/* Always have a module reference if x->mode_data is set */
> +	if (!try_module_get(x->mode_cbs->owner))
> +		return -EINVAL;
> +
> +	x->mode_data = xtfs;
> +	xtfs->x = x;
> +
> +	return 0;
> +}
> +
> +static int iptfs_clone(struct xfrm_state *x, struct xfrm_state *orig)
> +{
> +	struct xfrm_iptfs_data *xtfs;
> +	int err;
> +
> +	xtfs = kmemdup(orig->mode_data, sizeof(*xtfs), GFP_KERNEL);
> +	if (!xtfs)
> +		return -ENOMEM;
> +
> +	err = __iptfs_init_state(x, xtfs);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int iptfs_create_state(struct xfrm_state *x)
> +{
> +	struct xfrm_iptfs_data *xtfs;
> +	int err;
> +
> +	xtfs = kzalloc(sizeof(*xtfs), GFP_KERNEL);
> +	if (!xtfs)
> +		return -ENOMEM;
> +
> +	err = __iptfs_init_state(x, xtfs);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static void iptfs_delete_state(struct xfrm_state *x)
> +{
> +	struct xfrm_iptfs_data *xtfs = x->mode_data;
> +
> +	if (!xtfs)
> +		return;
> +
> +	kfree_sensitive(xtfs);
> +
> +	module_put(x->mode_cbs->owner);
> +}
> +
> +static const struct xfrm_mode_cbs iptfs_mode_cbs = {
> +	.owner = THIS_MODULE,
> +	.create_state = iptfs_create_state,
> +	.delete_state = iptfs_delete_state,
> +	.user_init = iptfs_user_init,
> +	.copy_to_user = iptfs_copy_to_user,
> +	.sa_len = iptfs_sa_len,
> +	.clone = iptfs_clone,
> +	.get_inner_mtu = iptfs_get_inner_mtu,
> +};
> +
> +static int __init xfrm_iptfs_init(void)
> +{
> +	int err;
> +
> +	pr_info("xfrm_iptfs: IPsec IP-TFS tunnel mode module\n");
> +
> +	err = xfrm_register_mode_cbs(XFRM_MODE_IPTFS, &iptfs_mode_cbs);
> +	if (err < 0)
> +		pr_info("%s: can't register IP-TFS\n", __func__);
> +
> +	return err;
> +}
> +
> +static void __exit xfrm_iptfs_fini(void)
> +{
> +	xfrm_unregister_mode_cbs(XFRM_MODE_IPTFS);
> +}
> +
> +module_init(xfrm_iptfs_init);
> +module_exit(xfrm_iptfs_fini);
> +MODULE_LICENSE("GPL");
> -- 
> 2.45.1
> 
> -- 
> Devel mailing list
> Devel@linux-ipsec.org
> https://linux-ipsec.org/mailman/listinfo/devel

