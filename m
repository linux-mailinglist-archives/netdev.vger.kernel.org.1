Return-Path: <netdev+bounces-95359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF72A8C1F6A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 10:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BEAA1C2135E
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 08:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0FF15F330;
	Fri, 10 May 2024 08:05:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4578612AAE5
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 08:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715328344; cv=none; b=poE7uhmyeG3cF5hGGYAnxXVD/gP3t2ql+1ygQG/wBD6GKZqQo9mNG4odIuZRF500uTCyMKjAUgkyDbqk5r0cOaCoWe/VojHQob06gB2+iB7pHO/+sH1Xgghk6T8Pe5AlbdjW8Yxn7bUNvPLtRWTO1vKNTPwHQqL9xjqbjFfNPrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715328344; c=relaxed/simple;
	bh=JF7E4x+C8SgkhiA/TFFx4e66UBRqFT66HEYEcHW6Y5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GiVpjKnSerxt1/GP9vOM9euKSgKwg0QNyDi3+maZPb6Dv8OawtZDbxBv64NMhQTD63xq3MYriyG/AvfYIPh+mSPEJMARs/6PeHWzUi02/mh1/3cIc7/ei0As0GwENf0UndFv60u9nfuxYoGAkkgysMI45LmqtDWmsyb1XYlo5+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-MleAFUydPG27DBdgOsaKeA-1; Fri, 10 May 2024 04:05:36 -0400
X-MC-Unique: MleAFUydPG27DBdgOsaKeA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FB8A8065D2;
	Fri, 10 May 2024 08:05:35 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BB67DD96350;
	Fri, 10 May 2024 08:05:33 +0000 (UTC)
Date: Fri, 10 May 2024 10:05:32 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Guillaume Nault <gnault@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Lebrun <david.lebrun@uclouvain.be>
Subject: Re: [PATCHv3 net 1/3] ipv6: sr: add missing seg6_local_exit
Message-ID: <Zj3VTPCPziGw1tDV@hog>
References: <20240509131812.1662197-1-liuhangbin@gmail.com>
 <20240509131812.1662197-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240509131812.1662197-2-liuhangbin@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-09, 21:18:10 +0800, Hangbin Liu wrote:
> Currently, we only call seg6_local_exit() in seg6_init() if
> seg6_local_init() failed. But forgot to call it in seg6_exit().
>=20
> Fixes: d1df6fd8a1d2 ("ipv6: sr: define core operations for seg6local ligh=
tweight tunnel")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

--=20
Sabrina


