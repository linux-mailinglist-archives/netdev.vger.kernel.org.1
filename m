Return-Path: <netdev+bounces-15144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367E9745ED1
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 16:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E533D280DA8
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 14:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276A3F9F6;
	Mon,  3 Jul 2023 14:42:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA983FDF
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 14:42:52 +0000 (UTC)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C448C10E5
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 07:42:42 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55ae2075990so2311779a12.0
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 07:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688395362; x=1690987362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrA308we96oVwz/kgmxRDcKXJtyEBbepsNUANAmoIY0=;
        b=Ipef32BA2RNaBK8hQFCP5rn7/iZ5F+7/2ITqgBNoT//Pyxpw5oJDZHImVjcaj/f9cr
         oBov6aTuCU/uWiIANJI0IGAVCGW2NceXrknYsmfRXoEStDWuLTlj0WO1coDT98FpDZpd
         OoSbiBIH1+0SnVorEzx6R15ihrj8UvThvWlRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688395362; x=1690987362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrA308we96oVwz/kgmxRDcKXJtyEBbepsNUANAmoIY0=;
        b=PoySDkAG9+uiL8q1sBp660pVetuyRuVc7jj5zTCGwUaraCkinAgqnqA3fwu/iRUs3f
         N9GLSs+4xnOBWDWlo9QZztJHjG/bBsggTTDKCa805GgPVUTohBLrJWdJyFjnBGW5Z/Nq
         83IikaUU3Q/RcP+G8y9Qb/IP7dXC3YaEStvU0Ldgz7txaJDF2z7DOouJW8vDJ3mvhC+r
         QNnakft60fVtmZr5dPpV/DnlimyVnGnWLsXmpfVr0CvY3fBOut418MYcOE6LFVoDliLk
         HpvIjFMsCnvaDmj5jtdPVz2CxLaPJW4JdODPdF1o/F53iq6O75Hpfi6iyct7ujUqU0ZN
         /biQ==
X-Gm-Message-State: ABy/qLamRn4JylEaNJ1f1aO1OrU+61lFebvSkYKgcrqkqteotwiIbMfD
	GS8gcMrwV1j3qMVcr6R1xeV7nscWZmt8x1a5caVb0Q==
X-Google-Smtp-Source: ACHHUZ5mTAPpxbNhYNSgpszF3WnuYH2PV51tm62xSaVgy4bpo+CAIhriuYCoo7xWSfATi1JfQBwW7sG7ccxjqSs1lls=
X-Received: by 2002:a05:6a20:a128:b0:11a:c623:7849 with SMTP id
 q40-20020a056a20a12800b0011ac6237849mr10155512pzk.48.1688395361920; Mon, 03
 Jul 2023 07:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230615152918.3484699-1-revest@chromium.org> <ZJFIy+oJS+vTGJer@calendula>
 <CABRcYmJjv-JoadtzZwU5A+SZwbmbgnzWb27UNZ-UC+9r+JnVxg@mail.gmail.com>
 <20230621111454.GB24035@breakpoint.cc> <CABRcYmKeo6A+3dmZd9bRp8W3tO9M5cHDpQ13b8aeMkhYr4L64Q@mail.gmail.com>
 <20230621184738.GG24035@breakpoint.cc>
In-Reply-To: <20230621184738.GG24035@breakpoint.cc>
From: Florent Revest <revest@chromium.org>
Date: Mon, 3 Jul 2023 16:42:30 +0200
Message-ID: <CABRcYmKkDyMBqe0C5AGZVihGQhXzCjsQrg5fBhtTX3qjxe7jOA@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: conntrack: Avoid nf_ct_helper_hash uses
 after free
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, kadlec@netfilter.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, lirongqing@baidu.com, 
	daniel@iogearbox.net, ast@kernel.org, kpsingh@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 8:47=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Florent Revest <revest@chromium.org> wrote:
> > > in this case an initcall is failing and I think panic is preferrable
> > > to a kernel that behaves like NF_CONNTRACK_FTP=3Dn.
> >
> > In that case, it seems like what you'd want is
> > nf_conntrack_standalone_init() to BUG() instead of returning an error
> > then ? (so you'd never get to NF_CONNTRACK_FTP or any other if
> > nf_conntrack failed to initialize) If this is the prefered behavior,
> > then sure, why not.
> >
> > > AFAICS this problem is specific to NF_CONNTRACK_FTP=3Dy
> > > (or any other helper module, for that matter).
> >
> > Even with NF_CONNTRACK_FTP=3Dm, the initialization failure in
> > nf_conntrack_standalone_init() still happens. Therefore, the helper
> > hashtable gets freed and when the nf_conntrack_ftp.ko module gets
> > insmod-ed, it calls nf_conntrack_helpers_register() and this still
> > causes a use-after-free.
>
> Can you send a v2 with a slightly reworded changelog?
>
> It should mention that one needs NF_CONNTRACK=3Dy, so that when
> the failure happens during the initcall (as oposed to module insertion),
> nf_conntrack_helpers_register() can fail cleanly without followup splat?

Sure! :) On it.

