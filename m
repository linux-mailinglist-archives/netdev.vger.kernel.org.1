Return-Path: <netdev+bounces-107849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BB391C8F7
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 00:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7908B2314D
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 22:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583AE80BF2;
	Fri, 28 Jun 2024 22:12:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911C6823A3
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 22:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719612775; cv=none; b=IoBwvZ10PsOkCf04SnNX9EJ9cO9T7gOkDdYCH8GAvwIvR0IRK/tic3SiOSo8FD2KxZ+5ykPEpxZXwATr1d/aY5Geh7n3qxP+6oEO17MJnqrt7IQwfnvo2H0/7sMk9ODYf6QWszhnaADKzGlKvx4el7fis7KzBe+SCjaK89lRIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719612775; c=relaxed/simple;
	bh=2H9CeSjeG9YmpcmTRotcIEksrMJoNY10B5ug+lv7awI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=td5HugiT+1IfTL5to86G6+R5qwfUXOmdKQ+odPGg7bTTI7Fv73Zo00kybPX/Vy5ElaW6KbrVmwe2toZmnvGGlQWhQRt9X2nJQSFHP+/rkHm6v7/pu+aAewDkRxvBj6yOEBh/7plrsaoWiSYar5tnQjoA9blutkU3Mbrfq56dxCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-TSrKeiM8PrCmN37YSjO4bQ-1; Fri,
 28 Jun 2024 18:11:39 -0400
X-MC-Unique: TSrKeiM8PrCmN37YSjO4bQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F22C119560BE;
	Fri, 28 Jun 2024 22:11:37 +0000 (UTC)
Received: from hog (unknown [10.39.192.70])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E280819560AA;
	Fri, 28 Jun 2024 22:11:34 +0000 (UTC)
Date: Sat, 29 Jun 2024 00:11:32 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 05/25] ovpn: add basic interface
 creation/destruction/management routines
Message-ID: <Zn81FBrUNUMC6VvM@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-6-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627130843.21042-6-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-06-27, 15:08:23 +0200, Antonio Quartulli wrote:
> +static void ovpn_setup(struct net_device *dev)
> +{
> +=09/* compute the overhead considering AEAD encryption */
> +=09const int overhead =3D sizeof(u32) + NONCE_WIRE_SIZE + 16 +

Is that 16 equal to OVPN_MAX_PADDING? Or some other constant that
would help figure out the details of that overhead?

> +=09=09=09     sizeof(struct udphdr) +
> +=09=09=09     max(sizeof(struct ipv6hdr), sizeof(struct iphdr));
> +
> +=09netdev_features_t feat =3D NETIF_F_SG | NETIF_F_LLTX |
[...]
> +=09dev->features |=3D feat;
> +=09dev->hw_features |=3D feat;

I'm not sure we want NETIF_F_LLTX to be part of hw_features, I think
it's more of a property of the device than something we want to let
users toggle. AFAICT no other virtual driver does that.

--=20
Sabrina


