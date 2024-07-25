Return-Path: <netdev+bounces-113007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B5A93C318
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 15:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1942728247B
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 13:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D79319AD73;
	Thu, 25 Jul 2024 13:33:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAA3C8DF
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721914434; cv=none; b=WppXc8kMghdcaQRretMdZ5VrK3OvT+dT1v9XO5M+nemq29JUfJFJaViqPSH2w/9TPlR+8mjF/Is4kW8jFfk5p7/Y2ZOvXb7s7k3dCBX1T2qx7exv+7AXI8qRvjfmiAM4L2zHQDlklpvUn+ZK3L8xz5TrTDHcDDLGqL2rGUCfJfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721914434; c=relaxed/simple;
	bh=i+y62vTZk1PO4zViyEPNtQqAhwonNsS+hXxRE7gi3eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=eMK6nXUgt8XYJETwHlYWyyol/YXee1w0TjwAHD3ay5qbJfKTI9NxEv9W7DSW72VsoTpFf5vcpWSD+3b0cfXLoLUtnGebRkDCjWU24A+0GVwGZRgjaf3XQTZbY2xGrWLADT6gOfehP8khSli0pF19X5+6WosR1X0UAgGT+MV+bmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-R2Kny4dkMOeDBT4g5lqk7Q-1; Thu,
 25 Jul 2024 09:33:44 -0400
X-MC-Unique: R2Kny4dkMOeDBT4g5lqk7Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA7761955BED;
	Thu, 25 Jul 2024 13:33:41 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4735819560AE;
	Thu, 25 Jul 2024 13:33:39 +0000 (UTC)
Date: Thu, 25 Jul 2024 15:33:36 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v5 08/17] xfrm: iptfs: add new iptfs xfrm mode
 impl
Message-ID: <ZqJUMLVOTR812ACs@hog>
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-9-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240714202246.1573817-9-chopps@chopps.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-07-14, 16:22:36 -0400, Christian Hopps wrote:
> +struct xfrm_iptfs_config {
> +=09u32 pkt_size;=09    /* outer_packet_size or 0 */

Please convert this to kdoc.

> +};
> +
> +struct xfrm_iptfs_data {
> +=09struct xfrm_iptfs_config cfg;
> +
> +=09/* Ingress User Input */
> +=09struct xfrm_state *x;=09    /* owning state */

And this too.

> +=09u32 payload_mtu;=09    /* max payload size */
> +};


> +static int iptfs_create_state(struct xfrm_state *x)
> +{
> +=09struct xfrm_iptfs_data *xtfs;
> +=09int err;
> +
> +=09xtfs =3D kzalloc(sizeof(*xtfs), GFP_KERNEL);
> +=09if (!xtfs)
> +=09=09return -ENOMEM;
> +
> +=09err =3D __iptfs_init_state(x, xtfs);
> +=09if (err)
> +=09=09return err;

BTW, I wrote that this was leaking xtfs in my previous review, back in
March :/

--=20
Sabrina


