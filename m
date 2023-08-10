Return-Path: <netdev+bounces-26141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A31776EF0
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 06:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0567A1C21422
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 04:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A070ED1;
	Thu, 10 Aug 2023 04:12:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E377ED0
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 04:12:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8611EE7E
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 21:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691640758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MpZ1xdG2a7UripeaaXQi64sXQC9E4hMZ1zP5gcfMmYk=;
	b=ahe9/iJUVX1xzq/C1YqTwrBDD76K9GEP7aTWfd/OzSqzK7G1bV4dCVXbLEcZFDvDuymxSR
	j/f/IgGhJ1ua3xz1khKTX7AEn4OU0NoHVAcDj7WT+4zkIMmVERjF6cs1gpLAcuQuPu3fYa
	BabVHQcS+IW2f0nysmYTNP6EsHrqyF4=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-sm8RpqRgNkiVWDC95pN2Xw-1; Thu, 10 Aug 2023 00:12:37 -0400
X-MC-Unique: sm8RpqRgNkiVWDC95pN2Xw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b9cd6a555aso4705961fa.3
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 21:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691640756; x=1692245556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpZ1xdG2a7UripeaaXQi64sXQC9E4hMZ1zP5gcfMmYk=;
        b=f78udzRK3XXnSxowynPeaJm506r+f8wWfj4A5gpzKWZpdeM7keAmByprRthJAI+Tct
         kLJPFAnfM/3LTG/GGXAGU51laDMknLu+8btVYb6Tl7zvoFkySOM6yWnk0xt28V7ahNiJ
         JyNGKEZavJ7pqw6E+3JKBrtmVNDY0ghwqSZUuvIeN88DknIOVh10PPmn/uxjyOKQMqww
         GSyzrffcfZu0Djp/B2+cb7bK1bgjlpKsEiGI32CAnznsY+49EecvjlHhe0vTAudBpAeo
         NAVfnzgWaRdwU/lj8eFiuMx5o331s12Ai+lYrbVQaKqslFJwsi4BWd6A9IsyZtxagCyX
         gMxw==
X-Gm-Message-State: AOJu0Yxd+oB21HkheUC/IGQBK5SIiRoi7Whf9KbN2K2R4OlK7ydtn/cZ
	3YAxCeNXc3i/aXL49y9u8IKcS5E18a9GsTPt2bYxla2uHNgBUuD/5m1i4Ki+dl+l5C9ctI8f8hb
	lacbQkqC/FsQK5zkE6PGk+vePQAsACFsd
X-Received: by 2002:a2e:884a:0:b0:2b9:ec57:c331 with SMTP id z10-20020a2e884a000000b002b9ec57c331mr940297ljj.6.1691640756074;
        Wed, 09 Aug 2023 21:12:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaAekTnhnaCJl4cn+CYttu+Q7kBOi1OQnauownq+9tUz7svhr/pDPkmAYG6E44ev8Mnzua0MchL6zCrzalZvI=
X-Received: by 2002:a2e:884a:0:b0:2b9:ec57:c331 with SMTP id
 z10-20020a2e884a000000b002b9ec57c331mr940280ljj.6.1691640755792; Wed, 09 Aug
 2023 21:12:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230810031557.135557-1-yin31149@gmail.com>
In-Reply-To: <20230810031557.135557-1-yin31149@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Aug 2023 12:12:24 +0800
Message-ID: <CACGkMEu_vzfcD=BzkL=HAkfi+RVq1F2vpDDQBGg54O_PL1fWGQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Zero max_tx_vq field for VIRTIO_NET_CTRL_MQ_HASH_CONFIG
 case
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, eperezma@redhat.com, 
	18801353760@163.com, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 10, 2023 at 11:16=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com=
> wrote:
>
> Kernel uses `struct virtio_net_ctrl_rss` to save command-specific-data
> for both the VIRTIO_NET_CTRL_MQ_HASH_CONFIG and
> VIRTIO_NET_CTRL_MQ_RSS_CONFIG commands.

This is tricky.

>
> According to the VirtIO standard, "Field reserved MUST contain zeroes.
> It is defined to make the structure to match the layout of
> virtio_net_rss_config structure, defined in 5.1.6.5.7.".
>
> Yet for the VIRTIO_NET_CTRL_MQ_HASH_CONFIG command case, the `max_tx_vq`
> field in struct virtio_net_ctrl_rss, which corresponds to the
> `reserved` field in struct virtio_net_hash_config, is not zeroed,
> thereby violating the VirtIO standard.
>
> This patch solves this problem by zeroing this field in
> virtnet_init_default_rss().
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


