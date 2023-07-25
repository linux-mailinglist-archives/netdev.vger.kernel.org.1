Return-Path: <netdev+bounces-20663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CB17606C6
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 05:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7650281730
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 03:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DEC4C93;
	Tue, 25 Jul 2023 03:40:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D361FB7
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 03:40:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7D4171E
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 20:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690256400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GISuUr8VKD3+R5zYA0JDar9R1Gto/+3V5HYVR91I9wg=;
	b=WPgJRGsEntq4twOupDWlq9DRz2Zg8oij0MGnvftCUCyyA+iiRvfljWxxjT0eGzCR43xXTL
	n2Jyaid/HMk+PPvhu23oMHXnvTu93Yj8J80HPR57TQFIIwTyx8zYgfc+6StuLSh0rJO76/
	X24/r2LYAORjEP0TdQzYhOdhyRab8D0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-NCcjFW54OvyNsMICGA-a0A-1; Mon, 24 Jul 2023 23:39:59 -0400
X-MC-Unique: NCcjFW54OvyNsMICGA-a0A-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b934194964so42577171fa.1
        for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 20:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690256397; x=1690861197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GISuUr8VKD3+R5zYA0JDar9R1Gto/+3V5HYVR91I9wg=;
        b=HDi4R+Y/ZG+Dvs2e+R0j28IoJxvhHIbzByDNAUtVZ+5c7r4aeMtVlxomBtM6+6ny4p
         VSyzK+m4fGXh8RJQNKxK9rkHxPtHGbOsIHfsf8W24xX3oMolmLWslhobyvZ1ZZISLGgg
         ERC5UtxikNM5Cw+chnT0zHtG+BntE5botxlufrIaL6iknauLA6sKbS8vvItuwszmQ7/X
         A68tlEqaqDfvdcM0fXDlwj2rSsWflDFGJuFXG27C8q8srbsPlCy26VnQJ/eD2HBckiP6
         ALMQnCCFzoSCFZhbFCZuaOiwHXflaDxMeS+62o7eavn4a48KBi/8mzXN8mvo2qw+GULL
         tD4w==
X-Gm-Message-State: ABy/qLa3Omf1Efjb4TYaYy5uq8r6r8Qa6quK1YZ1U7vt1Aym4PRBVlU3
	k5MLQcOPE6H1f0HvcVoVqIZZYwFur557lXYN9K5o9s/Yhh8iQn/HmlqkVAnU9WnodSV9XbRwtDf
	w0epnxi5iMAXTmjY4ijt4SzrWlMqpvaZ6UtECa5NR7anyOA==
X-Received: by 2002:a2e:a0cc:0:b0:2b9:20fe:4bc4 with SMTP id f12-20020a2ea0cc000000b002b920fe4bc4mr6712987ljm.40.1690256397225;
        Mon, 24 Jul 2023 20:39:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFAZsBRP+Cx9Rj7r5jrD6td5p8IVRIg7B6cy0snnenBCqMo5IsS1kwAaaIV25dcC36SsUrktKHa01Fvrdsb4oo=
X-Received: by 2002:a2e:a0cc:0:b0:2b9:20fe:4bc4 with SMTP id
 f12-20020a2ea0cc000000b002b920fe4bc4mr6712982ljm.40.1690256396951; Mon, 24
 Jul 2023 20:39:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724221326.384-1-andrew.kanner@gmail.com> <20230724221326.384-2-andrew.kanner@gmail.com>
In-Reply-To: <20230724221326.384-2-andrew.kanner@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jul 2023 11:39:46 +0800
Message-ID: <CACGkMEt+LW8FBNwcn6f0cBwTOuKy+ZPy3Smg6fJgo9OrCUAOjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: net: prevent tun_can_build_skb() to exceed
 xdp size limits
To: Andrew Kanner <andrew.kanner@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, brouer@redhat.com, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 6:15=E2=80=AFAM Andrew Kanner <andrew.kanner@gmail.=
com> wrote:
>
> Tested with syzkaller repro with reduced packet size. It was
> discovered that XDP_PACKET_HEADROOM is not checked in
> tun_can_build_skb(), although pad may be incremented in
> tun_build_skb().
>
> Fixes: 7df13219d757 ("tun: reserve extra headroom only when XDP is set")
> Link: https://syzkaller.appspot.com/text?tag=3DReproC&x=3D12b2593ea80000
> Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
> ---
>  drivers/net/tun.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 18ccbbe9830a..cdf2bd85b383 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1582,7 +1582,13 @@ static void tun_rx_batched(struct tun_struct *tun,=
 struct tun_file *tfile,
>  static bool tun_can_build_skb(struct tun_struct *tun, struct tun_file *t=
file,
>                               int len, int noblock, bool zerocopy, int *s=
kb_xdp)
>  {
> -       if (SKB_DATA_ALIGN(len + TUN_RX_PAD) +
> +       int pad =3D TUN_RX_PAD;
> +       struct bpf_prog *xdp_prog =3D rcu_dereference(tun->xdp_prog);

This misses rcu read lock.

I wonder if things could be simpler if we move the limit check from
tun_can_build_skb() to tun_build_skb():

rcu_read_lock();
xdp_prog =3D rcu_dereference(tun->xdp_prog);
        if (xdp_prog)
                pad +=3D XDP_PACKET_HEADROOM;
buflen +=3D SKB_DATA_ALIGN(len + pad);
rcu_read_unlock();

Thanks

> +
> +       if (xdp_prog)
> +               pad +=3D XDP_PACKET_HEADROOM;
> +
> +       if (SKB_DATA_ALIGN(len + pad) +
>             SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) > PAGE_SIZE) {
>                 *skb_xdp =3D 0;
>                 return false;
> --
> 2.39.3
>


