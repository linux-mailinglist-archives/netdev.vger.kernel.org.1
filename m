Return-Path: <netdev+bounces-58958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A12818B23
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 16:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E791F23A29
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 15:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767731C6BE;
	Tue, 19 Dec 2023 15:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGq+7Uh+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD651CAB6
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702999443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqy3wtKu2RpMhAf44zdAjTFEaoDT5QKe4xFKMUw3+5k=;
	b=KGq+7Uh+tzMBFzLaFya2x9HcOZULEXmNhx9+lf8owxd8JjbocATb5d+C/K9XVONYXl+nLp
	wAvs6H+ruPosqOBwZHfH8oCBrKKyf3lyNVlmZi/eXhqhnUjp3hjvPDaVhNcV1lkRs4xEiw
	i12neOqqBeCP2cRZ+S4BE4AHhBj5kpY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-v79DN1shP0mnWI1ol4PFGg-1; Tue, 19 Dec 2023 10:24:02 -0500
X-MC-Unique: v79DN1shP0mnWI1ol4PFGg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a232f069e60so29942166b.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 07:24:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702999441; x=1703604241;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qqy3wtKu2RpMhAf44zdAjTFEaoDT5QKe4xFKMUw3+5k=;
        b=IJcROrL1gjjL4bCncCjb61p+615PDCHLnpZMDvuS138f3hvirrSEZ2Qj5uC3JVrYnq
         MX8vkAMATv+vuweJtgQc7ZAhR5iRI35wZGi8GhNMZkcfL6Qtl3gh8nQ/SfEdaWbrQba2
         Ssanjxguens+ODT09CKpyKOuDiwLmsjhYmWZZr54223EKw7i0YudRWyk/fmaHZzz1UL0
         llXAOhpjLzhKSkSLqmLthZhB9EolsOGKpHu5sYsQKMUWX5qJTXtoLaBNEUd9c2sU7QHq
         KgKA9y+is03gubqpyqgjwEjbrda1w3D/0dYYgxEcQEgYZGKWQ7cqmVlRYkSFhjMHoPX1
         WSTw==
X-Gm-Message-State: AOJu0YzpLmG5d9qr8KXe4inxT1+HWDYqOugBSR/C4gJQ91Dnhq+gGxmG
	zXzYdlm+cenMjx/8Lqvwjp1+yqYaJqVNcOyZorDT+6YBrweOAnz4sUhiWTxNCfc+ZWEeU1YPF43
	S9kuBCOQpQyXLcGgX
X-Received: by 2002:a17:906:354e:b0:a23:58f9:e1e3 with SMTP id s14-20020a170906354e00b00a2358f9e1e3mr3600141eja.2.1702999441089;
        Tue, 19 Dec 2023 07:24:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFd0dgWBJVckg8y4NbbSgoLWG04HdfE6jM/KTshFzIrCjgjsrKQx/VS4FbrtGGixICTTdPZ4w==
X-Received: by 2002:a17:906:354e:b0:a23:58f9:e1e3 with SMTP id s14-20020a170906354e00b00a2358f9e1e3mr3600131eja.2.1702999440790;
        Tue, 19 Dec 2023 07:24:00 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-245.dyn.eolo.it. [146.241.246.245])
        by smtp.gmail.com with ESMTPSA id jw11-20020a17090776ab00b00a2358b0fa03sm2574203ejc.194.2023.12.19.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 07:24:00 -0800 (PST)
Message-ID: <c49124012f186e06a4a379b060c85e4cca1a9d53.camel@redhat.com>
Subject: Re: [PATCH v5 net-next 1/3] net: introduce page_pool pointer in
 softnet_data percpu struct
From: Paolo Abeni <pabeni@redhat.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, hawk@kernel.org
Cc: lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, bpf@vger.kernel.org, toke@redhat.com, 
	willemdebruijn.kernel@gmail.com, jasowang@redhat.com, sdf@google.com, 
	netdev@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 19 Dec 2023 16:23:58 +0100
In-Reply-To: <b1432fc51c694f1be8daabb19773744fcee13cf1.1702563810.git.lorenzo@kernel.org>
References: <cover.1702563810.git.lorenzo@kernel.org>
	 <b1432fc51c694f1be8daabb19773744fcee13cf1.1702563810.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-14 at 15:29 +0100, Lorenzo Bianconi wrote:
> Allocate percpu page_pools in softnet_data.
> Moreover add cpuid filed in page_pool struct in order to recycle the
> page in the page_pool "hot" cache if napi_pp_put_page() is running on
> the same cpu.
> This is a preliminary patch to add xdp multi-buff support for xdp running
> in generic mode.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  include/linux/netdevice.h       |  1 +
>  include/net/page_pool/helpers.h |  5 +++++
>  include/net/page_pool/types.h   |  1 +
>  net/core/dev.c                  | 39 ++++++++++++++++++++++++++++++++-
>  net/core/page_pool.c            |  5 +++++
>  net/core/skbuff.c               |  5 +++--
>  6 files changed, 53 insertions(+), 3 deletions(-)

@Jesper, @Ilias: could you please have a look at the pp bits?

Thanks!

Paolo


