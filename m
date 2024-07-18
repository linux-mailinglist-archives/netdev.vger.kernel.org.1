Return-Path: <netdev+bounces-112092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B4A934E75
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 15:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4109F1F22A11
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED63513C699;
	Thu, 18 Jul 2024 13:46:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A4F13C3D2
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721310366; cv=none; b=Q/jzmvlnZmVlLbTXQAQ2OVS0CIThqAPIJFCmwJr8Odqvv5+aMsD2n7Jk8k38m97jljOJ7jf9HjC3XYOYTIyMm5CqTjbGZBgyp4iQsBsIxRttTklAwKuOOov4BszLdTF/ebx+4Qzv5yST+hrU7dVI9haX+SpQGvXIp78EcvyTkqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721310366; c=relaxed/simple;
	bh=zU61HzKaLha5ui5qv1RruW5tjJNRwYsvf4eJ+U1kgkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qHtSoGror3J/ppA8niYotHjMV49sHZXb4b8qeX7hPyDVW/vg2x02UAMrd86odElSmtzZ2dWgvCm0Wd2gfEIr3/qmGlwgd2Blh1nppiyQY5Szt811rEhqZ3XMKzyH616dFe+4yiCYYQkPjbiotzx8INbBZQ0tum8+4WpOv5Fz1dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-5k7p9JraOBuuZ2V_Oa4LCw-1; Thu,
 18 Jul 2024 09:45:59 -0400
X-MC-Unique: 5k7p9JraOBuuZ2V_Oa4LCw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B4A61955D44;
	Thu, 18 Jul 2024 13:45:57 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B05F1955F40;
	Thu, 18 Jul 2024 13:45:54 +0000 (UTC)
Date: Thu, 18 Jul 2024 15:45:52 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v5 05/17] xfrm: netlink: add config (netlink)
 options
Message-ID: <ZpkckAyjSjC--i6M@hog>
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-6-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240714202246.1573817-6-chopps@chopps.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-07-14, 16:22:33 -0400, Christian Hopps wrote:
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index a552cfa623ea..d42805314a2a 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -297,6 +297,16 @@ static int verify_newsa_info(struct xfrm_usersa_info=
 *p,
>  =09=09=09NL_SET_ERR_MSG(extack, "TFC padding can only be used in tunnel =
mode");
>  =09=09=09goto out;
>  =09=09}
> +=09=09if ((attrs[XFRMA_IPTFS_DROP_TIME] ||
> +=09=09     attrs[XFRMA_IPTFS_REORDER_WINDOW] ||
> +=09=09     attrs[XFRMA_IPTFS_DONT_FRAG] ||
> +=09=09     attrs[XFRMA_IPTFS_INIT_DELAY] ||
> +=09=09     attrs[XFRMA_IPTFS_MAX_QSIZE] ||
> +=09=09     attrs[XFRMA_IPTFS_PKT_SIZE]) &&
> +=09=09    p->mode !=3D XFRM_MODE_IPTFS) {
> +=09=09=09NL_SET_ERR_MSG(extack, "IP-TFS options can only be used in IP-T=
FS mode");

AFAICT this only excludes the IPTFS options from ESP with a non-IPTFS
mode, but not from AH, IPcomp, etc.

> +=09=09=09goto out;
> +=09=09}
>  =09=09break;
> =20
>  =09case IPPROTO_COMP:
> @@ -417,6 +427,18 @@ static int verify_newsa_info(struct xfrm_usersa_info=
 *p,
>  =09=09=09goto out;
>  =09=09}
> =20
> +=09=09if (attrs[XFRMA_IPTFS_DROP_TIME]) {
> +=09=09=09NL_SET_ERR_MSG(extack, "Drop time should not be set for output =
SA");

Maybe add "IPTFS" to all those error messages, to help narrow down the
bogus attribute.

> +=09=09=09err =3D -EINVAL;
> +=09=09=09goto out;
> +=09=09}
> +
> +=09=09if (attrs[XFRMA_IPTFS_REORDER_WINDOW]) {
> +=09=09=09NL_SET_ERR_MSG(extack, "Reorder window should not be set for ou=
tput SA");
> +=09=09=09err =3D -EINVAL;
> +=09=09=09goto out;
> +=09=09}
> +
>  =09=09if (attrs[XFRMA_REPLAY_VAL]) {
>  =09=09=09struct xfrm_replay_state *replay;
> =20
> @@ -454,6 +476,30 @@ static int verify_newsa_info(struct xfrm_usersa_info=
 *p,
>  =09=09=09}
> =20
>  =09=09}
> +
> +=09=09if (attrs[XFRMA_IPTFS_DONT_FRAG]) {
> +=09=09=09NL_SET_ERR_MSG(extack, "Don't fragment should not be set for in=
put SA");
> +=09=09=09err =3D -EINVAL;
> +=09=09=09goto out;
> +=09=09}
> +
> +=09=09if (attrs[XFRMA_IPTFS_INIT_DELAY]) {
> +=09=09=09NL_SET_ERR_MSG(extack, "Initial delay should not be set for inp=
ut SA");
> +=09=09=09err =3D -EINVAL;
> +=09=09=09goto out;
> +=09=09}
> +
> +=09=09if (attrs[XFRMA_IPTFS_MAX_QSIZE]) {
> +=09=09=09NL_SET_ERR_MSG(extack, "Max queue size should not be set for in=
put SA");
> +=09=09=09err =3D -EINVAL;
> +=09=09=09goto out;
> +=09=09}
> +
> +=09=09if (attrs[XFRMA_IPTFS_PKT_SIZE]) {
> +=09=09=09NL_SET_ERR_MSG(extack, "Packet size should not be set for input=
 SA");
> +=09=09=09err =3D -EINVAL;
> +=09=09=09goto out;
> +=09=09}
>  =09}
> =20
>  out:
> @@ -3177,6 +3223,12 @@ const struct nla_policy xfrma_policy[XFRMA_MAX+1] =
=3D {
>  =09[XFRMA_MTIMER_THRESH]   =3D { .type =3D NLA_U32 },
>  =09[XFRMA_SA_DIR]          =3D NLA_POLICY_RANGE(NLA_U8, XFRM_SA_DIR_IN, =
XFRM_SA_DIR_OUT),
>  =09[XFRMA_NAT_KEEPALIVE_INTERVAL] =3D { .type =3D NLA_U32 },
> +=09[XFRMA_IPTFS_DROP_TIME]=09=09=3D { .type =3D NLA_U32 },
> +=09[XFRMA_IPTFS_REORDER_WINDOW]=09=3D { .type =3D NLA_U16 },

The corresponding sysctl is a u32, should this be NLA_U32?

> +=09[XFRMA_IPTFS_DONT_FRAG]=09=09=3D { .type =3D NLA_FLAG },
> +=09[XFRMA_IPTFS_INIT_DELAY]=09=3D { .type =3D NLA_U32 },
> +=09[XFRMA_IPTFS_MAX_QSIZE]=09=09=3D { .type =3D NLA_U32 },
> +=09[XFRMA_IPTFS_PKT_SIZE]=09=3D { .type =3D NLA_U32 },
>  };
>  EXPORT_SYMBOL_GPL(xfrma_policy);

--=20
Sabrina


