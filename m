Return-Path: <netdev+bounces-109042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA13926A33
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 23:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76787B20C5B
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 21:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9CD190694;
	Wed,  3 Jul 2024 21:27:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52842BB13
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 21:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042043; cv=none; b=uBIK/5yEjGq7D5YsxqfpKk91U54EzLGlvN3OrtIzVIH/mb12TFl9s/Nea3ZtlmxxFEkfFxnEWjtlczUXHZUN+rmPNVGBmdYT1zYprwnUSOU2GYJbcYEsp/y6+PE5rYDfUVdaDO7WgmFXKXR5NFR7Kyu0Fg2n4Obke3YhV8G/3bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042043; c=relaxed/simple;
	bh=F57X17PaGFqQvYFFyHS3uYdPAEnXp90pwRMysXkc73k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mVcWpQ+GwSKtkR8cT+CJF1moI65pdd6cp7/vSXX97Tl89CdO/108qV2ErWl93YBWguF5bQb6e6D8hKx6iFuVLuaDcvnrz2k30pJSdheTncZdcDkk+Kmr6tuVamnjky2WXE9YT1LaM60PLCpMpxEMtW6arBvD/zS4dNCVp8qY+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-8O0IGIuYMD2YHGsBWhDxvg-1; Wed,
 03 Jul 2024 17:27:12 -0400
X-MC-Unique: 8O0IGIuYMD2YHGsBWhDxvg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC3FB19560B4;
	Wed,  3 Jul 2024 21:27:10 +0000 (UTC)
Received: from hog (unknown [10.39.192.70])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 55F7C195607C;
	Wed,  3 Jul 2024 21:27:06 +0000 (UTC)
Date: Wed, 3 Jul 2024 23:27:04 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 06/25] ovpn: implement interface
 creation/destruction via netlink
Message-ID: <ZoXCKPlwfhB2iPBC@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-7-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627130843.21042-7-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-06-27, 15:08:24 +0200, Antonio Quartulli wrote:
>  int ovpn_nl_new_iface_doit(struct sk_buff *skb, struct genl_info *info)
>  {
[...]
> +=09msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +=09if (!msg)
> +=09=09return -ENOMEM;
> +
> +=09hdr =3D genlmsg_iput(msg, info);
> +=09if (!hdr) {
> +=09=09nlmsg_free(msg);
> +=09=09return -ENOBUFS;
> +=09}
> +
> +=09if (nla_put_string(msg, OVPN_A_IFNAME, dev->name)) {
> +=09=09genlmsg_cancel(msg, hdr);
> +=09=09nlmsg_free(msg);
> +=09=09return -EMSGSIZE;
> +=09}

Maybe the ifindex as well? The notifications in later patches use that
rather than the name, but I don't know how the client handles this reply.

> +=09genlmsg_end(msg, hdr);
> +
> +=09return genlmsg_reply(msg, info);
>  }

--=20
Sabrina


