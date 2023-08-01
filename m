Return-Path: <netdev+bounces-23409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D334D76BE04
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 21:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1594A1C2104D
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 19:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06356253A9;
	Tue,  1 Aug 2023 19:45:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3AB4DC6B
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 19:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE04C43395;
	Tue,  1 Aug 2023 19:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690919118;
	bh=ti5LkQA5JhXyI0X9UAFrEqsRrWpYkoksPS0/FGqPOPA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NYOS3SyGQg0RV6QZJT2vvBBq5eCXOD9VzPgehd8IOVUND8/C5WrYKtHeM59LrOLyU
	 WHuw39tdIhmBCDlHT7yS89UUvh7J2DWsKUDLqb46u3309RQ6LZF/H4qdvMJ+zdWdgc
	 TUlaAoaKcebjdhM6iCr7GqMxjAGaT2hdM0lEmCYEsyseUYQtaXHWlU/5oil3ObF+/a
	 QVc/RJ+HQzlABvuwsyYVqrKTj0rzn+kPz3oHVaD6Er23UxMiI91NlkgEjICCyEjLZK
	 VLXLntrRizFb4Mo0R1K7lHOn3mw9wYY5QS04jedOKK0QtCdPlyObgx2QVwsS6vb3r5
	 7Y38+iUJ1FgEg==
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-76c9e9642b1so309443585a.3;
        Tue, 01 Aug 2023 12:45:18 -0700 (PDT)
X-Gm-Message-State: ABy/qLYSNqr68pzU2l6N6+kxEBXrBM6CQMxO7xNKKqofdIe6NqIQlFxe
	RnvZyOOmmr12xTT4/e/yQIJr8UTRJSV1l/WU5kA=
X-Google-Smtp-Source: APBJJlGeJukdX/Bd3xELyMkrBtt+c36lWEfrvNJy2vE2YfgjJ6X14u/rvhfabm0vzEbYNueFaHmK3X7V+PlT0NoIBBM=
X-Received: by 2002:ac8:7f94:0:b0:40f:d63c:dc5b with SMTP id
 z20-20020ac87f94000000b0040fd63cdc5bmr3778461qtj.63.1690919117140; Tue, 01
 Aug 2023 12:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230729123152.35132-1-yuehaibing@huawei.com> <ZMaJQMWO9HF32D84@tissot.1015granger.net>
In-Reply-To: <ZMaJQMWO9HF32D84@tissot.1015granger.net>
From: Anna Schumaker <anna@kernel.org>
Date: Tue, 1 Aug 2023 15:45:01 -0400
X-Gmail-Original-Message-ID: <CAFX2Jfm8RRLkWJfK+eO_bGPpGat6cY0EkkJ-DK=+e-=9H=MtKA@mail.gmail.com>
Message-ID: <CAFX2Jfm8RRLkWJfK+eO_bGPpGat6cY0EkkJ-DK=+e-=9H=MtKA@mail.gmail.com>
Subject: Re: [PATCH net-next] xprtrdma: Remove unused function declaration rpcrdma_bc_post_recv()
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, 
	tom@talpey.com, trond.myklebust@hammerspace.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 30, 2023 at 12:01=E2=80=AFPM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On Sat, Jul 29, 2023 at 08:31:52PM +0800, Yue Haibing wrote:
> > rpcrdma_bc_post_recv() is never implemented since introduction in
> > commit f531a5dbc451 ("xprtrdma: Pre-allocate backward rpc_rqst and send=
/receive buffers").
> >
> > Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>
> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
>
> Anna, can you take this one?

Yep! Applying it now so it doesn't get lost!

Anna

>
>
> > ---
> >  net/sunrpc/xprtrdma/xprt_rdma.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt=
_rdma.h
> > index 5e5ff6784ef5..da409450dfc0 100644
> > --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> > +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> > @@ -593,7 +593,6 @@ void xprt_rdma_cleanup(void);
> >  int xprt_rdma_bc_setup(struct rpc_xprt *, unsigned int);
> >  size_t xprt_rdma_bc_maxpayload(struct rpc_xprt *);
> >  unsigned int xprt_rdma_bc_max_slots(struct rpc_xprt *);
> > -int rpcrdma_bc_post_recv(struct rpcrdma_xprt *, unsigned int);
> >  void rpcrdma_bc_receive_call(struct rpcrdma_xprt *, struct rpcrdma_rep=
 *);
> >  int xprt_rdma_bc_send_reply(struct rpc_rqst *rqst);
> >  void xprt_rdma_bc_free_rqst(struct rpc_rqst *);
> > --
> > 2.34.1
> >
>
> --
> Chuck Lever

