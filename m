Return-Path: <netdev+bounces-98671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D148D2059
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 17:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E711284983
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078FC171063;
	Tue, 28 May 2024 15:30:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333EF16FF4F
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716910203; cv=none; b=Jwgy/Gl1pTGQHlR3F0adtzbWe/5DKNUDkA93TFcJsK0ibjZcmb6DQGW093Kmt1qK3YjGegiF3uzvNQVWP81dpnndBhZJ/UrMPy4SlldK8U6W6tgJNHf+qLcbjO1s3ZliL7s8RPnZ71czkfpMn6vzW/CTyAhS8aOVXUQVOQLQ9wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716910203; c=relaxed/simple;
	bh=nB7/2jLAhlpI5XJJBQaHY4sAuw/ZcPhlPmon7AXPXCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WKUXwjNyqxUeIMdp65hVq0rynQr/uH6zG+QXOVDjXqVGJV7zIas6Zx01NQzm+64/B77qvzsokgkS/yLJR7HKOJL+wG/ff/Q+sXbhFkambco4ZFnLL29vjt4U/7+/SUb7LuUgRkyvmvIaP6WMxW/DpNTI7PGz6zp6bSK6z+ynDaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-sFdyVLPpPz-QVL9eRU7eEA-1; Tue,
 28 May 2024 11:29:55 -0400
X-MC-Unique: sFdyVLPpPz-QVL9eRU7eEA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 004C71C05138;
	Tue, 28 May 2024 15:29:55 +0000 (UTC)
Received: from hog (unknown [10.39.192.53])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 60A81492BC6;
	Tue, 28 May 2024 15:29:53 +0000 (UTC)
Date: Tue, 28 May 2024 17:29:52 +0200
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
Subject: Re: [PATCH net-next] ipv6: sr: restruct ifdefines
Message-ID: <ZlX4cLiUoMYzVdQG@hog>
References: <20240528032530.2182346-1-liuhangbin@gmail.com>
 <ZlWsWDFWDCcEa4r9@hog>
 <ZlXVXblc20QmZXlf@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZlXVXblc20QmZXlf@Laptop-X1>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-28, 21:00:13 +0800, Hangbin Liu wrote:
> On Tue, May 28, 2024 at 12:05:12PM +0200, Sabrina Dubroca wrote:
> > Hi Hangbin,
> >=20
> > 2024-05-28, 11:25:30 +0800, Hangbin Liu wrote:
> > > There are too many ifdef in IPv6 segment routing code that may cause =
logic
> > > problems. like commit 160e9d275218 ("ipv6: sr: fix invalid unregister=
 error
> > > path"). To avoid this, the init functions are redefined for both case=
s. The
> > > code could be more clear after all fidefs are removed.
> > >=20
> > > Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> >=20
> > I think this was suggested by Simon?
>=20
> Yes, and David Ahern also suggested this. And I thought you also mentione=
d it?

I don't think I did.

> I was afraid there are too many suggested-by tags here :) I can add them
> in next version patch.

Yes, please add tags for David and Simon.

Thanks!

--=20
Sabrina


