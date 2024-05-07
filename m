Return-Path: <netdev+bounces-94018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0528B8BDF5E
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F9C2B24D11
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 10:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2046214E2F6;
	Tue,  7 May 2024 10:05:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A95F14D443
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715076358; cv=none; b=gUt7UYMjxL/o7oeBj8BAjl8CRmY1JAU1kpDIo+oc4Rqbg0ofrbkHevu+jgdVagluyLGrI/n6ZMaI9LAmliG1BQTwOwHh50Q4VkDwdnTHNMLhjf19Fm9SbknqNyU4FklaEEnMWUhMEUo4q4yPiVtrjWfB+J3VDZBxMh2RaxcT314=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715076358; c=relaxed/simple;
	bh=JAWTYLOZ+fdI8Fpjl2EX06+U/j/gor6LJG4F6rl38p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IIl/gptHpRURV6zRBs/Ni5tgQWSb4Vi6EAJXHl9RUJ05wKX1LHlPa3gBCKPSWgVMy/OtAkdifLfu5a/NXA2KDrE0LYi6aqKu6VZ/jKCrww0MvAObtV1d7TDw7OIry1I0EewAnv8vWx+nDPjWM/3HRCZhaLrOwTBYuqP53WzpqIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-107-YGieF2GQOCa7AZgf_6ycwg-1; Tue,
 07 May 2024 06:05:49 -0400
X-MC-Unique: YGieF2GQOCa7AZgf_6ycwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F1263801EC4;
	Tue,  7 May 2024 10:05:49 +0000 (UTC)
Received: from hog (unknown [10.39.193.137])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 13CBD3C25;
	Tue,  7 May 2024 10:05:47 +0000 (UTC)
Date: Tue, 7 May 2024 12:05:46 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] net: annotate writes on dev->mtu from
 ndo_change_mtu()
Message-ID: <Zjn8-vBfwzM85yyB@hog>
References: <20240506102812.3025432-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240506102812.3025432-1-edumazet@google.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-05-06, 10:28:12 +0000, Eric Dumazet wrote:
> Simon reported that ndo_change_mtu() methods were never
> updated to use WRITE_ONCE(dev->mtu, new_mtu) as hinted
> in commit 501a90c94510 ("inet: protect against too small
> mtu values.")
>=20
> We read dev->mtu without holding RTNL in many places,
> with READ_ONCE() annotations.
>=20
> It is time to take care of ndo_change_mtu() methods
> to use corresponding WRITE_ONCE()
>=20
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: Simon Horman <horms@kernel.org>
> Closes: https://lore.kernel.org/netdev/20240505144608.GB67882@kernel.org/

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

--=20
Sabrina


