Return-Path: <netdev+bounces-258089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CUnHBco1i2nZRgAAu9opvQ
	(envelope-from <netdev+bounces-258089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:42:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B883D11B539
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 14:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A55A7303E75D
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27252329E6B;
	Tue, 10 Feb 2026 13:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="k+cwB4CK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5C31C84D7;
	Tue, 10 Feb 2026 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770730949; cv=none; b=PTCICswEAH9ce2io6OCJ+HE/WyjfGDGJd+8Q7A7YmGmfNWpOVqc3RQMidS0uHbpcan3qzI0dVvDBm26c2WpA9p6RWt0njpVGOG/b+0H76A6GmOBDVXZ1jD6HyuWmeB1ZYRl35Wzywqeuky+GWTKsdEMFgckCXHojjc0cQ8alFTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770730949; c=relaxed/simple;
	bh=qXMrBUkBfWd/NqNd7I4SAuxX2aP5ybSJaYos7gVHhZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLJVvIqQClxkxo4bF1tIgQt+LRf71nT26PVDCdSDpeHVvSrEwihxxjbk68px68baaCJHm+JxZaZTlqfA2gO3OPvep3Dwq+F46XxxFYTaofzb5yl3Xy7K718OjzcQcLQ9xAQS+JqwbvSKzahh13f+5+R+40KqiuQWpU4rTkryVco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=k+cwB4CK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ug6oixJQxlkYHz7+TydxYfOUASIiyhnn4ti27FklsD8=; b=k+
	cwB4CKlCrghR/CDo5Mle7zCl6CBvme+TjL+O52LegOcAEdlKBU/yiXzqs/UIfqsbb1GtAO6tHhfGF
	x/pf/sQjzPb0uO4k55657LiYlML0WE2pxaNY9ekikxUV3CXrzFPhzgQiCRT0G9e0fsteGgrc2k+ZI
	K6HxTf/ui1Tldec=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vpo0D-006pxR-VA; Tue, 10 Feb 2026 14:42:05 +0100
Date: Tue, 10 Feb 2026 14:42:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Illusion Wang <Illusion.Wang@nebula-matrix.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Sam <sam.chen@nebula-matrix.com>,
	"lukas.bulwahn" <lukas.bulwahn@redhat.com>,
	Dimon <dimon.zhao@nebula-matrix.com>,
	netdev <netdev@vger.kernel.org>,
	"vadim.fedorenko" <vadim.fedorenko@linux.dev>,
	open list <linux-kernel@vger.kernel.org>, corbet <corbet@lwn.net>,
	lorenzo <lorenzo@kernel.org>, Alvin <alvin.wang@nebula-matrix.com>,
	andrew+netdev <andrew+netdev@lunn.ch>,
	linux-doc <linux-doc@vger.kernel.org>, pabeni <pabeni@redhat.com>,
	edumazet <edumazet@google.com>, horms <horms@kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaW3Y0LG5ldC1uZXh0?= =?utf-8?B?LDExLzEx?=
 =?utf-8?Q?=5D?= net/nebula-matrix: add common dev start/stop operation
Message-ID: <62c4ce27-0786-4ef7-83f2-993365a8caf7@lunn.ch>
References: <20260206021608.85381-12-illusion.wang@nebula-matrix.com>
 <20260207022504.4018024-1-kuba@kernel.org>
 <8620f8c9-c7ff-427d-bad4-0ed860b998ea.Illusion.Wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8620f8c9-c7ff-427d-bad4-0ed860b998ea.Illusion.Wang@nebula-matrix.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-258089-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: B883D11B539
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 10:07:01AM +0800, Illusion Wang wrote:
> Thank you for your feedback
> But
> enum nbl_msix_serv_type {
> 	/* virtio_dev has a config vector_id, and the vector_id need is 0 */
> 	NBL_MSIX_VIRTIO_TYPE = 0,
> 	NBL_MSIX_NET_TYPE,
> 	NBL_MSIX_MAILBOX_TYPE,
> 	NBL_MSIX_TYPE_MAX
> };
> NBL_MSIX_NET_TYPE equals 1，so this function has no problem？

Please don't top post.

> --illusion.wang
> 
> > +static int nbl_dev_configure_msix_map(struct nbl_dev_mgt *dev_mgt)
> > +{
> > + struct nbl_dispatch_ops *disp_ops = dev_mgt->disp_ops_tbl->ops;
> > + struct nbl_dev_common *dev_common = dev_mgt->common_dev;
> > + struct nbl_msix_info *msix_info = &dev_common->msix_info;
> > + bool mask_en = msix_info->serv_info[NBL_MSIX_NET_TYPE].hw_self_mask_en;
> > + u16 msix_net_num = msix_info->serv_info[NBL_MSIX_NET_TYPE].num;
> > + u16 msix_not_net_num = 0;
> > + int err, i;
> > +
> > + for (i = NBL_MSIX_NET_TYPE; i < NBL_MSIX_TYPE_MAX; i++)
> > +  msix_info->serv_info[i].base_vector_id =
> > +   msix_info->serv_info[i - 1].base_vector_id +
> > +   msix_info->serv_info[i - 1].num;
>              ^^^^^^
> 
> Does this loop cause an array underflow? NBL_MSIX_NET_TYPE equals 0 (from
> the enum in nbl_dev.h), so on the first iteration i=0 and the code accesses
> serv_info[-1].

> The serv_info array is declared with NBL_MSIX_TYPE_MAX (2) elements in
> struct nbl_msix_info, giving valid indices [0,1]. Accessing index -1 reads
> uninitialized memory before the array start.

It is interesting it has the enum wrong. Given what you show,
NBL_MSIX_NET_TYPE is 1, NBL_MSIX_TYPE_MAX 3. But it seems to be
missing NBL_MSIX_VIRTIO_TYPE.

The tool does go backwards and forwards with the different
patches. Does nbl_msix_serv_type always have the values you show, or
does it start with less members and more are added in later patches?
That might of confused it, or you as you broke the driver up any less
big parts.

However, this code does look error prone. What would happen if a new
value was added between _VIRTIO_TYPE an _NET_TYPE?

Safer would be:

	 for (i = NBL_MSIX_NET_TYPE; i < NBL_MSIX_TYPE_MAX; i++)
		msix_info->serv_info[i].base_vector_id =
		msix_info->serv_info[i - NBL_MSIX_NET_TYPE].base_vector_id +
		msix_info->serv_info[i - NBL_MSIX_NET_TYPE].num;

But i also wounder why your design needs to do this shuffling? It
seems like a bad design.

	Andrew

