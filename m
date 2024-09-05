Return-Path: <netdev+bounces-125483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE20296D4C0
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E86B281021
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC08198856;
	Thu,  5 Sep 2024 09:55:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416BE156225
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530146; cv=none; b=MxpkEwoI+9PVXDWKWQRH6Mew/GmL2VNZjjcF4rKmlx4pjOOVzsN8DMDFcLWy66FMBL6AeQ26bV1hXj5/l7WyPUYkfa5nuN1osOqr/5jphY5uMd0XssP0mBWoz4dywoABeRPM5GcQ9E7Lfej/kuQam9vSVnNQ6/P/0mkvjDn/eEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530146; c=relaxed/simple;
	bh=nnIkHrsuCUDMtfo0bBvtiEWlJQEN56Wq3V5reSJXzdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=m7DtF4Hm7HeKsXXXacRvyVOSxNx+NHYeUutaPyHh22eYw2Agtj+i/Lyp/pXH24AeRxia5GJhrSQFjKPqUAypF3+qfFAmuRIsV/WA+g4uByqdEIVcHMxn8QWUp5ju7Z1u+rt360waDcan9+/Nu+fKEnhMg7TAMbkIyf2Jr32ByhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-2WOAPix_N76moWNzCZjUzg-1; Thu,
 05 Sep 2024 05:55:40 -0400
X-MC-Unique: 2WOAPix_N76moWNzCZjUzg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC4031953953;
	Thu,  5 Sep 2024 09:55:38 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C93073001D1D;
	Thu,  5 Sep 2024 09:55:35 +0000 (UTC)
Date: Thu, 5 Sep 2024 11:55:33 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v6 19/25] ovpn: add support for peer floating
Message-ID: <ZtmAFX2ryse1p5jr@hog>
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-20-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240827120805.13681-20-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-08-27, 14:07:59 +0200, Antonio Quartulli wrote:
> +void ovpn_peer_float(struct ovpn_peer *peer, struct sk_buff *skb)
> +{
[...]
> +
> +=09netdev_dbg(peer->ovpn->dev, "%s: peer %d floated to %pIScp", __func__=
,
> +=09=09   peer->id, &ss);
> +=09ovpn_peer_reset_sockaddr(peer, (struct sockaddr_storage *)&ss,
> +=09=09=09=09 local_ip);
> +
> +=09spin_lock_bh(&peer->ovpn->peers->lock_by_transp_addr);

ovpn->peers in only set in MP mode, is there something preventing us
getting here in P2P mode? I think we need a mode=3D=3DMP check around the
rehash.  (I just took a look at other uses of ovpn->peers and there
are obvious mode =3D=3D MP checks before all of them except this one)

I guess this would only happen in P2P mode if the server changes IP,
so it doesn't really occur in practice?

--=20
Sabrina


