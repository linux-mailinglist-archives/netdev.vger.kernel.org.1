Return-Path: <netdev+bounces-120228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE869589EE
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 16:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C07811C21EDD
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 14:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBF11946C3;
	Tue, 20 Aug 2024 14:38:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561221940B7
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 14:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164718; cv=none; b=Ie7OwfPRWeVx80umA0hJMP2BNWrzAPcUzbYhtwgL4HhvhIJbO3XTlolCptJFYArMr1Hl4jSafRhIHhve5/HN2WzukeJQxn63jYAnIJB7+cZOWQ9JlhUXtfqvE0YxjkEtBlWtqdGTPgBr6gYzwYlh8EsV8A+7SPOPwDaYhJvpRCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164718; c=relaxed/simple;
	bh=WxotiNE0yNj1Dr5MFrPyVsllSmCNRWqBsnhOwq0Z1h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pY2RsIq7m8jutIRjajMhBGmAFctNV6FDKQ0THkAKFrb67TULbm6EqIq6eIPI1jvZp+Azg1j7nfzajUI/WfHQzTFVHgSJ5s03FIke9WEGuqzz0+5YnIx5u4xJrCM4zCP/E8TMZXydoCMeFGWypTIOZRZI08fLNJUFV9yNPtIoWIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-KofZUxcjMnS9UfmBkMPACA-1; Tue,
 20 Aug 2024 10:38:25 -0400
X-MC-Unique: KofZUxcjMnS9UfmBkMPACA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 475451955BF9;
	Tue, 20 Aug 2024 14:38:23 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3F531955F66;
	Tue, 20 Aug 2024 14:38:18 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:38:16 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCHv3 net-next 3/3] bonding: support xfrm state update
Message-ID: <ZsSqWO-zbgYSQIdY@hog>
References: <20240820004840.510412-1-liuhangbin@gmail.com>
 <20240820004840.510412-4-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240820004840.510412-4-liuhangbin@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hangbin,

2024-08-20, 08:48:40 +0800, Hangbin Liu wrote:
> The patch add xfrm statistics update for bonding IPsec offload.
>=20
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_main.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index 24747fceef66..4a4a1d9c8cca 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -675,11 +675,36 @@ static void bond_advance_esn_state(struct xfrm_stat=
e *xs)
>  =09rcu_read_unlock();
>  }
> =20
> +/**
> + * bond_xfrm_update_stats - Update xfrm state
> + * @xs: pointer to transformer state struct
> + **/
> +static void bond_xfrm_update_stats(struct xfrm_state *xs)
> +{
> +=09struct net_device *real_dev;
> +
> +=09rcu_read_lock();
> +=09real_dev =3D bond_ipsec_dev(xs);
> +=09if (!real_dev)
> +=09=09goto out;
> +
> +=09if (!real_dev->xfrmdev_ops ||
> +=09    !real_dev->xfrmdev_ops->xdo_dev_state_update_stats) {
> +=09=09pr_warn("%s: %s doesn't support xdo_dev_state_update_stats\n", __f=
unc__, real_dev->name);

I'm not convinced we should warn here. Most drivers don't implement
xdo_dev_state_update_stats, so if we're using one of those drivers
(for example netdevsim), we'll get one line in dmesg for every "ip
xfrm state" command run by the user. At most it should be ratelimited,
but since it's an optional callback, I think no warning would be fine.

--=20
Sabrina


