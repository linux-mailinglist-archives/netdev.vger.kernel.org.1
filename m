Return-Path: <netdev+bounces-111459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E99F1931277
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 12:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC971F21281
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 10:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8D018733F;
	Mon, 15 Jul 2024 10:40:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD5A18629E
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040047; cv=none; b=TazOjIyGfek8yP/00NBxog88bH+PHN3l3uynFH4xNrnAR7L9b49Sh2+SvE6mbBwsirWmig2xfyG/dXlmo3YQHDR0909ZZm1NFCpJ2I42Bcy7uPTJ9dDcpno7U+Rj1xpohfKfxivL6HLckOz0h6ljEXVKcKrSCWzFTjhkRLqXpNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040047; c=relaxed/simple;
	bh=WjUObaiwRKoLTb5MXCDcIhQKKkReHbmHQAWZNIh2/E0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iOf9aC1o072clZwWib8kBVcf4voQuIHY8TuffBW5dv/Icwk6Wa6Z6DhHcp/3dyLZDFQSHuBEVUCFt/PjpR0BBubw+qRbfu60WZty9RMwq7ocayr6dKQCCQ8lisaIl2bbDXimlo02PEtrebGbVEWsd/KAK6ffSKoB9K5WtRa+2Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-qWxJ6_DlN9aWJPGqS5Bg-g-1; Mon,
 15 Jul 2024 06:40:32 -0400
X-MC-Unique: qWxJ6_DlN9aWJPGqS5Bg-g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 903FA1955D59;
	Mon, 15 Jul 2024 10:40:31 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AEBF1955D42;
	Mon, 15 Jul 2024 10:40:27 +0000 (UTC)
Date: Mon, 15 Jul 2024 12:40:25 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 15/25] ovpn: implement multi-peer support
Message-ID: <ZpT8mQsZiPBxnaf_@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-16-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627130843.21042-16-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-06-27, 15:08:33 +0200, Antonio Quartulli wrote:
> @@ -46,6 +46,17 @@ static int ovpn_struct_init(struct net_device *dev, en=
um ovpn_mode mode)
>  =09ovpn->mode =3D mode;
>  =09spin_lock_init(&ovpn->lock);
> =20
> +=09if (mode =3D=3D OVPN_MODE_MP) {
> +=09=09/* the peer container is fairly large, therefore we dynamically
> +=09=09 * allocate it only when needed
> +=09=09 */
> +=09=09ovpn->peers =3D kzalloc(sizeof(*ovpn->peers), GFP_KERNEL);
> +=09=09if (!ovpn->peers)
> +=09=09=09return -ENOMEM;

As we discussed in v3 (it was about the workqueue), I don't think this
will get freed correctly in some of the failure cases. This should go
in ovpn_net_init.

> +
> +=09=09spin_lock_init(&ovpn->peers->lock);
> +=09}
> +
>  =09return 0;
>  }

--=20
Sabrina


