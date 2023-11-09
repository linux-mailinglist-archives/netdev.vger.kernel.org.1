Return-Path: <netdev+bounces-46757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038CB7E637F
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 07:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA9E1C20856
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 06:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE57BD2E5;
	Thu,  9 Nov 2023 06:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h14heiQ2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56619D28D
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 06:03:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBC826A9
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 22:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699509820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aizM3ELlXHXW7JfsEczOmSTmLbm7Vpen9q9fzHEgyOk=;
	b=h14heiQ26xrs8Dd6fjq9Fv5jzTC2S1930Uw4+K5pmq5sDZ0QESPQ64Ix4irvuxKYoOkruz
	PxpjQasnHOOpFoNQsnrElH0tFtcIPlPFD0V/Vy1SYfE/nFjdzAuXDuaSl8UccGSE/p3reC
	oGdwZ9tbmLuM+tAadVlkcUroLlauMyc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-SVwcIynKOqSj3BIxyJR7Dg-1; Thu, 09 Nov 2023 01:03:35 -0500
X-MC-Unique: SVwcIynKOqSj3BIxyJR7Dg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-507cee14477so476726e87.3
        for <netdev@vger.kernel.org>; Wed, 08 Nov 2023 22:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699509813; x=1700114613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aizM3ELlXHXW7JfsEczOmSTmLbm7Vpen9q9fzHEgyOk=;
        b=QrugOWBB663/P0iArBYkQ5TmaLGXQ8qH5rh+Gz1MuSRtybaa3afp8WzAWeGadBUj4/
         IsBVxtWWfiGoajlW9tDT2MRO8+7sxiX6p5h70rosKuTyysv6A8XZSZLyfQ5K8/ephYCm
         coDbMta9H5iXZrj8YY/oznUoH05PMM5yrpVOm/DYY1NztGIeeZmal6cIHKPVnSkDhvDZ
         UEJH9sl+8A3QYLZn8YfIPcI0MOehInLdS5Mxch4ICzkZSFNG0Qu2YnhxhQQu07T+EWkj
         NQifHP4Y+4tLaWJRrylxdq/K2jDJS82ZEA47CnG5//s5V4fOrsJeMQmB4wnAJ9KKBZJj
         q9Hg==
X-Gm-Message-State: AOJu0YxYdl9RcJPszOAeRW4OIu2aUXXYU/F+5v7rq6ONHYS1UFuLIC3Y
	RE2s6CfKd70EuD026E2xIC49DWm0vlJaREy1EYZT7tXIuGpoFv9gktci+IOGywpB6F9IHP7gJhS
	ZLe8ZCO4PqWIHGz0HBkcM4L9IeEZ6VHNmxnmyc3C2EyEVkg==
X-Received: by 2002:a19:4f17:0:b0:503:2deb:bbc1 with SMTP id d23-20020a194f17000000b005032debbbc1mr411126lfb.22.1699509813662;
        Wed, 08 Nov 2023 22:03:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYsjgTD24MZnXktKx7aRviir9RZpQgol0T8Q0VdFoaD8xNFvxps4WomMhc0qsMn/K7CszOgRlSkSBitpfIyVI=
X-Received: by 2002:a19:4f17:0:b0:503:2deb:bbc1 with SMTP id
 d23-20020a194f17000000b005032debbbc1mr411106lfb.22.1699509813388; Wed, 08 Nov
 2023 22:03:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com> <20231107031227.100015-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231107031227.100015-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Nov 2023 14:03:22 +0800
Message-ID: <CACGkMEss6=0ZcmEV-YNSVXiH48TzT1A_VdqrUHbLNn=qW5835g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/21] virtio_net: move core structures to virtio_net.h
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 11:13=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Move some core structures (send_queue, receive_queue, virtnet_info)
> definitions and the relative structures definitions into the
> virtio_net.h file.
>
> That will be used by the other c code files.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


