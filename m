Return-Path: <netdev+bounces-13784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F5573CEE5
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 09:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73329280FB2
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 07:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF468814;
	Sun, 25 Jun 2023 07:19:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF076808
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 07:19:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96910C2
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 00:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687677575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crvYJVJpTbYTunCiIEUekC9+YM4D9xRjLajPL7dk4PA=;
	b=G4zN6XOHAnN3y2uSb+HJOej0Z5o5mlZ47zQxkwEs864wP286TSff9uvJGQh+OQuWsyuuoy
	H6M41m1zFV6QNQ+hacAnI2qb+2kdo5h+p1NtSaTGVv+xt7Xku4V3a8LFIFbaViIp4lRIJ7
	CETEx2DzOU/E3RybbBs95NLxjpgvHwo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-vrJ7CK0PMPCHWmZBLdsRjQ-1; Sun, 25 Jun 2023 03:19:33 -0400
X-MC-Unique: vrJ7CK0PMPCHWmZBLdsRjQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b46dc4f6faso16053581fa.3
        for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 00:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687677571; x=1690269571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=crvYJVJpTbYTunCiIEUekC9+YM4D9xRjLajPL7dk4PA=;
        b=QbYbyhgES8tDfvfrNRn11Iq+P9vSyJRQCRdVNCQQC7uVznt9TWcBN9KBE3CHdkzYAY
         DrcOujEI9Hyx/9CmN3NiYfeU0HScf9wDnWRSw2A3Ueo/RhMeVevVta/wRzumScOe6Qa6
         mY0PgxocfPzMMp8vYD2XOTIZk7aKsBqq8aROt9vT/xzLxiCrwMdzgTei3FXDMQHkSXzo
         8GwnY6NjSUgmBY5OdRlp9ZtZXEwWyZM8u3DuFmoXNVvxm6KzDqh/OBRZl/BX8UMy36wn
         i7FQLWdAsTJbg/7SQPurZyFR206nPspB+8xO4GGmvYkeUr414rulB6HMO2auMxpx81z3
         ZEOw==
X-Gm-Message-State: AC+VfDwb17qryUxc6sO+EkihR1R+lPctzmpPlm8zuq6rc43pLsusEoYh
	xpdyUDYjlTynH/iC2GuKgnCztpzpabmewLTC/vzMeMvi1NoDuFznsXtM+By1ePsvLaYh7pzLNyC
	WZrmVP7tlB9u0VxN/X/UWvkI+NMDrJu6M
X-Received: by 2002:a19:6707:0:b0:4f9:570c:7b28 with SMTP id b7-20020a196707000000b004f9570c7b28mr8024949lfc.32.1687677571712;
        Sun, 25 Jun 2023 00:19:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6TgoGtKPYE2HSayNlGMZC/cfCWA138bcv26/89XSaCn7BDOGhY9nOX2R0SMVgiHTEoVQUlFSg/uM40fccKi2k=
X-Received: by 2002:a19:6707:0:b0:4f9:570c:7b28 with SMTP id
 b7-20020a196707000000b004f9570c7b28mr8024939lfc.32.1687677571423; Sun, 25 Jun
 2023 00:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com> <1687329734.4588535-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1687329734.4588535-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 25 Jun 2023 15:19:20 +0800
Message-ID: <CACGkMEvUM3JgcX72OFCQKuPT4M7a8Gtsd68_QMzBUJBg8=h2+A@mail.gmail.com>
Subject: Re: [PATCH vhost v10 00/10] virtio core prepares for AF_XDP
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 2:43=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Hi Jason,
>
> Do you have plan to review this?

Just came back from vacation, will do this next week.

Thanks

>
> Thanks.
>


