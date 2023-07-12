Return-Path: <netdev+bounces-17261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92581750ED8
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 18:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8C1281ACD
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8589514F95;
	Wed, 12 Jul 2023 16:42:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A61FCF
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 16:42:40 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8B41FC8
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:42:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e5da79223so4143110a12.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 09:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689180157; x=1691772157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bW19SqP+fvSrSLXAkvlkbepiHCJjhpsp8L+HzcG/ses=;
        b=SgfwpiDWROfxicDuY5a0jDAkPQX29D8MNs1R5sSaSiMXu07hvOsRjGj7HzDMnoMyuK
         AnKOFz5cSrsss5qyVXdnVaFbkjetGCqVe5k4VNKvQqq8pjpuoKaOse60yM0U/X4YrTrA
         4S4A6px64gAkeCA3SC0KBg49c/q6SIcP8kiG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689180157; x=1691772157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bW19SqP+fvSrSLXAkvlkbepiHCJjhpsp8L+HzcG/ses=;
        b=CbfsI8fnJ5QkLhR2xALtQBuF4aJoK2/PLWRRf3AZf9RJXSq0akWYHFqiF1aYbYi+qN
         YuBgtGKgY97aamHvCMhiukz85JTMRNRUP+OpjLhWTjLfyqQFyKSaoIYcz79Z7Hjvu6eL
         2g2Dz1BobGFrANgt7HXBsDguoRSH2KQf3y9H/2nO+4FEcns91qp2LZ7rb0uPKgHps8oi
         IjjzpG7MWz+yoQydBUPp348NDas6v9hAipv9l3N1OFQ+gtb5LYrZjIyZMfvuRMZGALHd
         4r5v7c6rioeyizVb21QbaOLY6axsaSjldPpndS2DXV2DkmgNpV5NlUtzlW+Q2PXyaqYk
         an9w==
X-Gm-Message-State: ABy/qLaa3esoq2rvFREeVzWvOw9d/BPYvp+dxr+5MVOd2miUbJ6A2kti
	y4s9yKtVZXxjuaooywYmbcSHsRiE7HYUV8ILcOpbxA==
X-Google-Smtp-Source: APBJJlGzPGGBWdPkIfFETV6ee4h2sW7Me7h2Y4ydRiIsAB+e3U42ZwJVOhWcHj4/9NOqR7spBub/hKIpSmXEM8uEWfc=
X-Received: by 2002:aa7:d951:0:b0:51e:342c:25e0 with SMTP id
 l17-20020aa7d951000000b0051e342c25e0mr15386229eds.41.1689180157295; Wed, 12
 Jul 2023 09:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230711043453.64095-1-ivan@cloudflare.com> <20230711193612.22c9bc04@kernel.org>
In-Reply-To: <20230711193612.22c9bc04@kernel.org>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 12 Jul 2023 11:42:26 -0500
Message-ID: <CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] tcp: add a tracepoint for tcp_listen_queue_drop
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ivan Babrou <ivan@cloudflare.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@cloudflare.com, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 9:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 10 Jul 2023 21:34:52 -0700 Ivan Babrou wrote:
> > There's already a way to count the overall numbers of queue overflows:
> >
> >     $ sudo netstat -s | grep 'listen queue'
> >     4 times the listen queue of a socket overflowed
> >
> > However, it's too coarse for monitoring and alerting when a user wants =
to
> > track errors per socket and route alerts to people responsible for thos=
e
> > sockets directly. For UDP there's udp_fail_queue_rcv_skb, which fills
> > a similar need for UDP sockets. This patch adds a TCP equivalent.
>
> Makes me want to revert your recent UDP tracepoint to be honest :(
> We can play whack a mole like this. You said that kfree_skb fires
> too often, why is that? Maybe it's an issue of someone using
> kfree_skb() when they should be using consume_skb() ?

Hi Jakub,

  The issue with kfree_skb is not that it fires too frequently (not in
the 6.x kernel now). Rather, it is unable to locate the socket info
when a SYN is dropped due to the accept queue being full. The sk is
stolen upon inet lookup, e.g. in tcp_v4_rcv. This makes it unable to
tell in kfree_skb which socket a SYN skb is targeting (when TPROXY or
socket lookup are used). A tracepoint with sk information will be more
useful to monitor accurately which service/socket is involved.

--
Yan

