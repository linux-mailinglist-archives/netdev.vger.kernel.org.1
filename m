Return-Path: <netdev+bounces-15264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E812B746796
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 04:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6471C20A9A
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 02:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED05C181;
	Tue,  4 Jul 2023 02:31:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E9E366
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 02:31:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72110184
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 19:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688437914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ted07POMAjXkCxr60JUuoQPLiHenYB1eh+ROZj9qTg=;
	b=WRXnA/RBYxrLj8/ATCENTRHT/Tl5HhnIWGi6YfFJRVybnqAALhuzssu3BGfPiRyuiIpvJj
	Y4AKLck66POqRy5Ra3NK25rOEHtCctEomAdB7AMmCBbEAUn9ssXYS0gj7KuvI+vWrxz1qz
	YD3J9kgotinwabZ+UxEd79xhVAFMoIM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-UWIQ2GbPPDyzt3ibHE50Aw-1; Mon, 03 Jul 2023 22:31:53 -0400
X-MC-Unique: UWIQ2GbPPDyzt3ibHE50Aw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b620465d0eso43559111fa.0
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 19:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688437911; x=1691029911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ted07POMAjXkCxr60JUuoQPLiHenYB1eh+ROZj9qTg=;
        b=PNMaMERKhY5IWK8EGides38MKrm9hFrdUUCaS7ZD9iwLqPVGTrL9pUdn/+NUgni0zu
         hbjdB3pB01JEwdqHbuooL3XR48abOncLu2CDKLsHHS0UdhWqWrvTbeFmm9nzQfyuiFtk
         djsZcEKVbS7o9k1McTX6k1a3MGQOsJh7yH0h7TOdGq5XkIL54JxFaLX4gkABTgEhASo6
         4MwP2p1meqlrAbaSiXi/DkIoRgIS9qB7F5x5e0YHj0jWF7BWfq6Xa7pyXU/0Zofe5NfS
         hmpWM5kgkSygK1aMYfez6GXrU7nh7j3VlSIzKmrk8e4TN4o0laAdqos+/Us9RfJSmVPN
         OL1g==
X-Gm-Message-State: ABy/qLbmUw4xCnxyuDMYEtKccq6MdtTQ1JK/jEZ4qjDhlOk4b6i79SY+
	Uj4JSNMF4yMMyglLdbpfhieY+pxRTXiVYtKFfLUXhDx4q/CUtpL6rgdhqUqCm8aFVICZvxerc4+
	UMYpZFaGxRtcuy6qI31SL2VaO/Z1zli/U
X-Received: by 2002:a2e:b165:0:b0:2b6:de59:1ba4 with SMTP id a5-20020a2eb165000000b002b6de591ba4mr5146450ljm.20.1688437911780;
        Mon, 03 Jul 2023 19:31:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEankywN0m0pyVhlEKLjGH/ScUvE8FF66a/JMtbnyvq6ch5zE2f6KfMC9jixVttfTAnoEWdGkjeni0rrC1He1g=
X-Received: by 2002:a2e:b165:0:b0:2b6:de59:1ba4 with SMTP id
 a5-20020a2eb165000000b002b6de591ba4mr5146438ljm.20.1688437911506; Mon, 03 Jul
 2023 19:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230703175329.3259672-1-i.maximets@ovn.org>
In-Reply-To: <20230703175329.3259672-1-i.maximets@ovn.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 4 Jul 2023 10:31:39 +0800
Message-ID: <CACGkMEs1WyKwSuE2H0bkYigjhqHYJy6pPGnQLjWgOFt9+89hJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] xsk: honor SO_BINDTODEVICE on bind
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 4, 2023 at 1:53=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org> w=
rote:
>
> Initial creation of an AF_XDP socket requires CAP_NET_RAW capability.
> A privileged process might create the socket and pass it to a
> non-privileged process for later use.  However, that process will be
> able to bind the socket to any network interface.  Even though it will
> not be able to receive any traffic without modification of the BPF map,
> the situation is not ideal.
>
> Sockets already have a mechanism that can be used to restrict what
> interface they can be attached to.  That is SO_BINDTODEVICE.
>
> To change the SO_BINDTODEVICE binding the process will need CAP_NET_RAW.
>
> Make xsk_bind() honor the SO_BINDTODEVICE in order to allow safer
> workflow when non-privileged process is using AF_XDP.
>
> The intended workflow is following:
>
>   1. First process creates a bare socket with socket(AF_XDP, ...).
>   2. First process loads the XSK program to the interface.
>   3. First process adds the socket fd to a BPF map.
>   4. First process ties socket fd to a particular interface using
>      SO_BINDTODEVICE.
>   5. First process sends socket fd to a second process.
>   6. Second process allocates UMEM.
>   7. Second process binds socket to the interface with bind(...).
>   8. Second process sends/receives the traffic.
>
> All the steps above are possible today if the first process is
> privileged and the second one has sufficient RLIMIT_MEMLOCK and no
> capabilities.  However, the second process will be able to bind the
> socket to any interface it wants on step 7 and send traffic from it.
> With the proposed change, the second process will be able to bind
> the socket only to a specific interface chosen by the first process
> at step 4.
>
> Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Acked-by: Jason Wang <jasowang@redhat.com>

Is this a stable material or not?

Thanks

> ---
>
> RFC --> PATCH:
>   * Better explained intended workflow in a commit message.
>   * Added ACK from Magnus.
>
>  Documentation/networking/af_xdp.rst | 9 +++++++++
>  net/xdp/xsk.c                       | 6 ++++++
>  2 files changed, 15 insertions(+)
>
> diff --git a/Documentation/networking/af_xdp.rst b/Documentation/networki=
ng/af_xdp.rst
> index 247c6c4127e9..1cc35de336a4 100644
> --- a/Documentation/networking/af_xdp.rst
> +++ b/Documentation/networking/af_xdp.rst
> @@ -433,6 +433,15 @@ start N bytes into the buffer leaving the first N by=
tes for the
>  application to use. The final option is the flags field, but it will
>  be dealt with in separate sections for each UMEM flag.
>
> +SO_BINDTODEVICE setsockopt
> +--------------------------
> +
> +This is a generic SOL_SOCKET option that can be used to tie AF_XDP
> +socket to a particular network interface.  It is useful when a socket
> +is created by a privileged process and passed to a non-privileged one.
> +Once the option is set, kernel will refuse attempts to bind that socket
> +to a different interface.  Updating the value requires CAP_NET_RAW.
> +
>  XDP_STATISTICS getsockopt
>  -------------------------
>
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 5a8c0dd250af..386ff641db0f 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -886,6 +886,7 @@ static int xsk_bind(struct socket *sock, struct socka=
ddr *addr, int addr_len)
>         struct sock *sk =3D sock->sk;
>         struct xdp_sock *xs =3D xdp_sk(sk);
>         struct net_device *dev;
> +       int bound_dev_if;
>         u32 flags, qid;
>         int err =3D 0;
>
> @@ -899,6 +900,11 @@ static int xsk_bind(struct socket *sock, struct sock=
addr *addr, int addr_len)
>                       XDP_USE_NEED_WAKEUP))
>                 return -EINVAL;
>
> +       bound_dev_if =3D READ_ONCE(sk->sk_bound_dev_if);
> +
> +       if (bound_dev_if && bound_dev_if !=3D sxdp->sxdp_ifindex)
> +               return -EINVAL;
> +
>         rtnl_lock();
>         mutex_lock(&xs->mutex);
>         if (xs->state !=3D XSK_READY) {
> --
> 2.40.1
>


