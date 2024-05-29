Return-Path: <netdev+bounces-99038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03348D380A
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 15:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660EB1F23A63
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01E317BB4;
	Wed, 29 May 2024 13:41:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2404D179BF
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990099; cv=none; b=uDHRXhURtXh2D0AWpJelOZA/HebDpMs+582/TBNyU3lySnrMikDKnEz+VDaGf+FVM7mcssTNahf8qJ45XMYuo92l6vs5FTQASgweJVXuyUQpa8WKrQnRjAPW3Y8tyoVmbS2O0m2hwQ3lCz9rj0GQeLYZmP95cEW/z3uZhgcjVBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990099; c=relaxed/simple;
	bh=3EYMtm2mLyc+/2Ws8ttfhdvLQho4tcZRPXkcEA7b5TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TeJBLJcKmQS7pU7Qny307rFVYvd0YunFcJEjNSBQv04+SW6lEWi4Zopoj18ndQKv9faPDaHbQ4gmczSjC8senjU0PRS3K6WUpv4XMHYJO4Fe6RJzEZXml3/bBSt7Z69OGLgKbyuediuc6gZn1a5qVSjA9th1+tLuQ62VkVFiwf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-doo1szRqNdq4GVWYaCb5Ng-1; Wed,
 29 May 2024 09:41:26 -0400
X-MC-Unique: doo1szRqNdq4GVWYaCb5Ng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4E7E29AA384;
	Wed, 29 May 2024 13:41:25 +0000 (UTC)
Received: from hog (unknown [10.39.192.53])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 22C5B103A3AA;
	Wed, 29 May 2024 13:41:23 +0000 (UTC)
Date: Wed, 29 May 2024 15:41:23 +0200
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
Subject: Re: [PATCHv2 net-next] ipv6: sr: restruct ifdefines
Message-ID: <ZlcwggXSO3qUI1vU@hog>
References: <20240529040908.3472952-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240529040908.3472952-1-liuhangbin@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-29, 12:09:08 +0800, Hangbin Liu wrote:
> There are too many ifdef in IPv6 segment routing code that may cause logi=
c
> problems. like commit 160e9d275218 ("ipv6: sr: fix invalid unregister err=
or
> path"). To avoid this, the init functions are redefined for both cases. T=
he
> code could be more clear after all fidefs are removed.
>=20
> Suggested-by: Simon Horman <horms@kernel.org>
> Suggested-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v2: add a new label to call seg6_iptunnel_exit directly (Sabrina Dubroca)
>     add suggested-by tag (Sabrina Dubroca)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks.

--=20
Sabrina


