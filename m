Return-Path: <netdev+bounces-14981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E47744C8B
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 09:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038D3280E43
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 07:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B60138C;
	Sun,  2 Jul 2023 07:49:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A42136A
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 07:49:42 +0000 (UTC)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155D010E5
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 00:49:41 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-543c692db30so2701754a12.3
        for <netdev@vger.kernel.org>; Sun, 02 Jul 2023 00:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688284179; x=1690876179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvxoQCcibS+AeU+E0ygHuM6m7OcRFNmks4L94pMdxYI=;
        b=ZtZXwH2MeGsjV8yFfBnJjWlbkQzmf4oSMr3YNv3pBErULIxGVXHyX3fa05xeDAaUcR
         FtoTrbYdH97gMy7NhtyE8jKvgcB1m+5PJkZ4pXFp36b0WrwMVW6GCTQcPyG4IlQXpqXQ
         H/ebOzOmkPiqEc0GPETYzScw6NtBD80CoFCeZsaEbxFyao3c8ckIcEa0TOig5Yem7olB
         ZcWNGsHW1+0NGnU8lRyK3+5ISROloHE8U32K27k2x/fwd5k1v7bGEMkA1AQWRJwFJDL/
         L+31h03h+9svZnYKFBNrm7BV89IrZm+nrmZcwQLIpy4JgKzUOM0XNEe/tCbIVfif9nfS
         gkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688284179; x=1690876179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OvxoQCcibS+AeU+E0ygHuM6m7OcRFNmks4L94pMdxYI=;
        b=RMpfEnwJbB/6wvQMDZPQ8kZiNYYtfQZ1F/tphUj/IE2VVBzdpm31fI5ZlOjibsQNS3
         LLMzu30UB9xBOklOwRJ1ZVi8ZeLViaFRh48o70UloOki0XuNgD5xz3z43oUotokfOfdd
         o6eXmuh9LycH3VDh9T4wM5oZXrMMLVbxkgHX7afKU6aCXCU20MLp2aXJ6p1B2eThsCQN
         zyyaYTk78Rm9iDS3x6D68VwJBvoq09Ef/5EoMfNs0MSqxbxoNUsAN8LfFs/LZCvkk7LM
         dK20gTir5vOJC+NHSAUEuf8hakVY7iUU4dS1c1xVvmN2goykBFr5DBvl2QXfe0DZ+w1t
         DN9Q==
X-Gm-Message-State: ABy/qLZuzSqwqhsl2fo8wfn1nrcl4wOsBevi+8oUshX21jZ8HbUt0Po3
	jX7V/Zuc7t0B/rvSsz9u+omhIcUa23WYJtLKvYis
X-Google-Smtp-Source: APBJJlGufhzK/2ECRJBm7gDRrro6kXoBCSrchWDG2fH7jB9xtkPCg+JFTBP6i6pSVuIMpszBV7lZcb+qPuqMMarDNGE=
X-Received: by 2002:a05:6a20:8e14:b0:123:4ffe:4018 with SMTP id
 y20-20020a056a208e1400b001234ffe4018mr9366994pzj.60.1688284179674; Sun, 02
 Jul 2023 00:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627113652.65283-1-maxime.coquelin@redhat.com> <20230627113652.65283-2-maxime.coquelin@redhat.com>
In-Reply-To: <20230627113652.65283-2-maxime.coquelin@redhat.com>
From: Yongji Xie <xieyongji@bytedance.com>
Date: Sun, 2 Jul 2023 15:49:28 +0800
Message-ID: <CACycT3vvOaNcrigbaqbGKJM9KxKR3nGmOQRDUfd1e08+XDp1rA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] vduse: validate block features only with block devices
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	David Marchand <david.marchand@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	virtualization <virtualization@lists.linux-foundation.org>, Netdev <netdev@vger.kernel.org>, 
	xuanzhuo@linux.alibaba.com, Eugenio Perez Martin <eperezma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 7:37=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch is preliminary work to enable network device
> type support to VDUSE.
>
> As VIRTIO_BLK_F_CONFIG_WCE shares the same value as
> VIRTIO_NET_F_HOST_TSO4, we need to restrict its check
> to Virtio-blk device type.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---

Reviewed-by: Xie Yongji <xieyongji@bytedance.com>

Thanks,
Yongji

