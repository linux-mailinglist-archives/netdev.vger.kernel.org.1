Return-Path: <netdev+bounces-54739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D70ED80805C
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 06:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8175C1F2122F
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 05:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9668A11726;
	Thu,  7 Dec 2023 05:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ou1eulSy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2CC1AD
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 21:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701927993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QxiqDGFIicHFEtEIHtNQNblDDB+Ip0Yoq6i22AXMcsw=;
	b=Ou1eulSyabayFdautSHc5oxVnhnZ57YhHzXu1sFulzqCmqtAh73+Ir7nAbtOeeObuTIilg
	nWIK0hS0Yj0TER8oExh2yQLjLPPp2Y5l685flujCp4dgJDqhu0TOnFP1Bwa7EGG2TmNWJu
	IbMT9mq2z3S0rD01UctOOKEEJJModyo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-pnKNpsoCMGC0hQTiQtBzOw-1; Thu, 07 Dec 2023 00:46:32 -0500
X-MC-Unique: pnKNpsoCMGC0hQTiQtBzOw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2865681dcb4so576428a91.3
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 21:46:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701927991; x=1702532791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxiqDGFIicHFEtEIHtNQNblDDB+Ip0Yoq6i22AXMcsw=;
        b=f/iXdnSqRwIBG5hjrSmPUqsBmim6RJNAwmeL2MVovKEaui+2HwaZnGIA5/MG5OErxX
         oGLW/W92lta5ntAoKDfI6WI7tUVxTOwrUKRYJaM8sx8yeU7nU+KTXdXxR/p2KZ9nzNes
         NrNrOiZCBUfaUOSoH7fHXJ80pJ2p5mVmvG1vfXo0x0UEllcRVvln01DDVopQTBLVY3mj
         dwkASooPWAdeRm4d8PKyATyT/yEGXT1KJRseH0kKoXzQlhvijN20VwlMgojwqKftoVYv
         Ktp3VAfO/LBMqALTWcI5suJ73rN775MSsRq4qMxVphCMG1K/4udXdrFVPtEIl1bt17kR
         1jvg==
X-Gm-Message-State: AOJu0YxSnbLd71wCx+2rh016RsNcnErIeGjxadd1jF7SqhP0ZIDAkSsX
	9M3P9yxMLtrx1ueSknelDk6VH0YpZYoaCSaVYLUdU5uk2v0eKHZgIpoosYhqh4UPi5golF0fYon
	WKelqJgIKB3YYK421IiDGZ1UFBN/6ToZB
X-Received: by 2002:a17:90b:310b:b0:286:bff2:c41b with SMTP id gc11-20020a17090b310b00b00286bff2c41bmr1876733pjb.23.1701927991079;
        Wed, 06 Dec 2023 21:46:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUfgjoIKpasl0QD67eKC09rD6Vvob1+V2GPMTPFb8/kThT/w3JyyDRtZYtlMl19xjCR/LXa/IPCZwYXFZnNus=
X-Received: by 2002:a17:90b:310b:b0:286:bff2:c41b with SMTP id
 gc11-20020a17090b310b00b00286bff2c41bmr1876711pjb.23.1701927990817; Wed, 06
 Dec 2023 21:46:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205113444.63015-1-linyunsheng@huawei.com> <20231205113444.63015-6-linyunsheng@huawei.com>
In-Reply-To: <20231205113444.63015-6-linyunsheng@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 7 Dec 2023 13:46:19 +0800
Message-ID: <CACGkMEsiDbZcCAKDxK7hQ=pqWM-GHG2UaKRGM264ozqKVwZRPg@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] net: introduce page_frag_cache_drain()
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Shailend Chand <shailend@google.com>, Eric Dumazet <edumazet@google.com>, Felix Fietkau <nbd@nbd.name>, 
	John Crispin <john@phrozen.org>, Sean Wang <sean.wang@mediatek.com>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 7:35=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> When draining a page_frag_cache, most user are doing
> the similar steps, so introduce an API to avoid code
> duplication.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---

For vhost part:

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


