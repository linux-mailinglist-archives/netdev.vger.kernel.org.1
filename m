Return-Path: <netdev+bounces-111863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4854933B88
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 12:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3B928138B
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 10:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74BC17E8FD;
	Wed, 17 Jul 2024 10:54:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F41878
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721213659; cv=none; b=sTnUgQDytEGEkThZGilKhLNhfx/Muun2AJlCA9vrUo41btKpUAz+bK7L+X1Jtv+/kOVCBzGchyUhXAK1/eR4o8xlZsvqzVMPtUrW9K6QSNwC/pmrstoD/Cw9lx4DjUwIvnTFwBFp4sG9GrtkrA8x00ygwCifLL6I7pfwRwk/Juo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721213659; c=relaxed/simple;
	bh=B6cZUxx20EAsG9ULiEbt2zZUcSOuNesjPVTq376nSsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=pcKWa3MldY7ls6clEvSET3dHKQ4qHzHbD3+m+tx4qEO3uLvnXLmf3qnyN0V9RpCeaF6Z5oQxrBXwXbEeJyNlvTFJD3R8SCvjkF6BztGS/dcbOWq9AwxgxdiAmvtDAOCP3zZLMUhl1vXc4+IV5lX+84mFnONpNdQhzLMFbg2p/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-Sct2FaiTMz66uZYYHFD1og-1; Wed,
 17 Jul 2024 06:54:13 -0400
X-MC-Unique: Sct2FaiTMz66uZYYHFD1og-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2CCF1944B35;
	Wed, 17 Jul 2024 10:54:11 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 21FD11955D42;
	Wed, 17 Jul 2024 10:54:08 +0000 (UTC)
Date: Wed, 17 Jul 2024 12:54:06 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 23/25] ovpn: notify userspace when a peer is
 deleted
Message-ID: <Zpeizmu-FOHCsPy0@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-24-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627130843.21042-24-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-06-27, 15:08:41 +0200, Antonio Quartulli wrote:
> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
> index 2105bcc981fa..23418204fa8e 100644
> --- a/drivers/net/ovpn/peer.c
> +++ b/drivers/net/ovpn/peer.c
> @@ -273,6 +273,7 @@ void ovpn_peer_release_kref(struct kref *kref)
> =20
>  =09ovpn_peer_release(peer);
>  =09netdev_put(peer->ovpn->dev, NULL);

I don't think you can access peer->ovpn once you release that
reference, if this peer was holding the last reference the netdev (and
the ovpn struct) could be gone while we're accessing it in
ovpn_nl_notify_del_peer.

> +=09ovpn_nl_notify_del_peer(peer);
>  =09kfree_rcu(peer, rcu);
>  }
> =20
> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
> index 8d24a8fdd03e..971603a70090 100644
> --- a/drivers/net/ovpn/peer.h
> +++ b/drivers/net/ovpn/peer.h
> @@ -129,6 +129,7 @@ static inline bool ovpn_peer_hold(struct ovpn_peer *p=
eer)
> =20
>  void ovpn_peer_release(struct ovpn_peer *peer);
>  void ovpn_peer_release_kref(struct kref *kref);
> +void ovpn_peer_release(struct ovpn_peer *peer);

nit: dupe of 2 lines before

--=20
Sabrina


