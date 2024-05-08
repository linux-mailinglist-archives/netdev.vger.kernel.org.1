Return-Path: <netdev+bounces-94630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224A58C004B
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1EC528A3DB
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5EE8626D;
	Wed,  8 May 2024 14:42:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1879E8625D
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 14:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179364; cv=none; b=PUeihEzriU8+wKrmAh+Wm3nErvVji8+WlruRaI0eHzsPrTXq7nonlLZ8h9w58k+chxZNpRmSC42JpV4qNAMjEMguwTfis1Q1aSCjpjeCjDUTFkbYuVyi1G6Zmk1idgJoIytXeMISFUF1OjUOu90ifG07SlVBqPVyOSTFSgY/Few=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179364; c=relaxed/simple;
	bh=OoJYbM2Uj2GkgKSp1xarMHfv2ydmCi2N8zPAmY5+Klw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IsIbem9GeQBSwVfCQuP4fGX0EGu2HctTNdoFMJxVDe9+8KGjZd9DmhNGSHRGBzr7hTvdhJm4S+/gtNZ+cV6RMv09d3opOrJDv6hRZZczrt/vp11Pg+FLDOpRVvDypciL/YJIgVzdd9VD+SMi/UdviHrc9/DA5mNFmGC8u/gZukg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-cABd-jbpPa2we2U8bN8OrA-1; Wed, 08 May 2024 10:42:39 -0400
X-MC-Unique: cABd-jbpPa2we2U8bN8OrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56528800994;
	Wed,  8 May 2024 14:42:38 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 279EC1C060AE;
	Wed,  8 May 2024 14:42:36 +0000 (UTC)
Date: Wed, 8 May 2024 16:42:35 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
Subject: Re: [PATCH net-next v3 03/24] ovpn: add basic netlink support
Message-ID: <ZjuPWwPIByGFkxHJ@hog>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-4-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506011637.27272-4-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-06, 03:16:16 +0200, Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
> new file mode 100644
> index 000000000000..c0a9f58e0e87
> --- /dev/null
> +++ b/drivers/net/ovpn/netlink.c
> +int ovpn_nl_new_iface_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +=09return -ENOTSUPP;

nit: All thhese should probably be EOPNOTSUPP if those return values
can be passed back to userspace, but since you're removing all of them
as you implement the functions, it doesn't really matter.

[...]
> +/**
> + * ovpn_nl_init - perform any ovpn specific netlink initialization
> + * @ovpn: the openvpn instance object
> + */
> +int ovpn_nl_init(struct ovpn_struct *ovpn)
> +{
> +=09return 0;
> +}

Is this also part of the auto-generated code? Or maybe a leftover from
previous iterations? This function doesn't do anything even after all
other patches are applied.

--=20
Sabrina


