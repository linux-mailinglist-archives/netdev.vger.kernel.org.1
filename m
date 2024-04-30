Return-Path: <netdev+bounces-92398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A61E8B6E68
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 11:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112B11F26A93
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 09:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E895127E31;
	Tue, 30 Apr 2024 09:33:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5EB22618
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469631; cv=none; b=P38eE525V5hXR3uB2HbN5Ad2uKf/1neElNAaEw6v2sAcE+YTYPKiBNQm4GkNLgWhdmG+zx++HFwWYV+G9MrmA+Lf5JqmapUiO+9Vs7106eKaLEDOix0XNhmZ0eaE8yZMnGvNS2HKRhdKRF9ie+7f7/dKB/4Zj5aPC7DGPdENhKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469631; c=relaxed/simple;
	bh=g58ZFJZxCRIIPX25vcNWUJoCTdmke4j0yQd3NCifP1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sjN295bL3qhLugt5SfubNp6MWqndcoZNyltU68c9exrjg8JPy9lxbgFxSqBMKWxThMgDQnL1cqfIDdzBrhN6d7dZGyYPJSDM2oH0QjLVtiNetNF1nVmzeP7LOClPs04kNTI8AvSvCnRR9uevpWKbRwhrkcxNVBoOxATYIzuRsOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-88mza38tOn2iBm2D2w-f2g-1; Tue,
 30 Apr 2024 05:33:42 -0400
X-MC-Unique: 88mza38tOn2iBm2D2w-f2g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77AD43C0CEEA;
	Tue, 30 Apr 2024 09:33:41 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 500B520169C4;
	Tue, 30 Apr 2024 09:33:38 +0000 (UTC)
Date: Tue, 30 Apr 2024 11:33:38 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Leon Romanovsky <leon@kernel.org>,
	Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH ipsec-next v14 0/4] xfrm: Introduce direction attribute
 for SA
Message-ID: <ZjC68onD2DvsX6Qy@hog>
References: <cover.1714460330.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <cover.1714460330.git.antony.antony@secunet.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-04-30, 09:08:06 +0200, Antony Antony wrote:
> Hi,
>=20
> Inspired by the upcoming IP-TFS patch set, and confusions experienced in
> the past due to lack of direction attribute on SAs, add a new direction
> "dir" attribute. It aims to streamline the SA configuration process and
> enhance the clarity of existing SA attributes.
>=20
> This patch set introduces the 'dir' attribute to SA, aka xfrm_state,
> ('in' for input or 'out' for output). Alsp add validations of existing
> direction-specific SA attributes during configuration and in the data
> path lookup.
>=20
> This change would not affect any existing use case or way of configuring
> SA. You will notice improvements when the new 'dir' attribute is set.
>=20
> v14: add more SA flag checks.
> v13: has one fix, minor documenation updates, and function renaming.
>=20
> Antony Antony (4):
>   xfrm: Add Direction to the SA in or out
>   xfrm: Add dir validation to "out" data path lookup
>   xfrm: Add dir validation to "in" data path lookup
>   xfrm: Restrict SA direction attribute to specific netlink message
>     types

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks Antony.

Patches 2 and 3 are identical to v13 so you could have kept Nicolas's
Reviewed-by tags. Steffen, I guess you can copy them in case Nicolas
doesn't look at v14 by the time you apply it?

--=20
Sabrina


