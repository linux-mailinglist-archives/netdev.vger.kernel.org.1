Return-Path: <netdev+bounces-13148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E58F473A7CB
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 19:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C263C1C21156
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 17:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE810200DF;
	Thu, 22 Jun 2023 17:55:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04AD200D8
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 17:55:29 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6A41FF1
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 10:55:26 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-25eb3db3004so3614398a91.0
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 10:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687456526; x=1690048526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jp48nVtGyA7Br8JQvoHipeg5lrmuPTRf+zZ/Ox3/D1Q=;
        b=hyuLl0aOwBk06RO/KCeKwpeASbRRuwk+J8d/SapksEOFoivhOssFweFwx6v6if4gAx
         WhgI3RAANIA6zZeriPODW8jQW2VK98pVKgEkawYkKJ2AUUekakUtz04V24oGGLO02Bdx
         Uw89ZbLnXPXdQtwTeEPYX782hHML9gnLfQBOBGEpeFIe4hZ/4VNvGLyFxxSej2C168VP
         4EsLh23xpe5+fGM8xZPfiMVNbKlsFpggYZW45VDlm9q2p9wmSZvDrIDdfdwMj1SCnvD5
         ZPtwNdEgTv/dBAJeyTWijby0if7eyivywp/XrheMYBkZPtWRur/mkSPyus8xQf6ZcPF9
         hkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687456526; x=1690048526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jp48nVtGyA7Br8JQvoHipeg5lrmuPTRf+zZ/Ox3/D1Q=;
        b=CZH/5uCPNGYtBkZPvTVrjodpQqbyyceEhI2ad+tLoYNtCpF7DJTjU3i2DQnNMkmpBZ
         TAg8fmfcYGzuaTLwP44DjToG7AhJpe+f2mk4OeXCjE8d+OqQplI2xFjtplLdZRAeab9F
         xshQw+aoruHMQtLj0J4IBxNa/x8FG7k3ZUQlSWQdwDb/0xt4fjxMNLP6p+UZQclGQbSl
         hwsd17IemOnQtJCElE28Mih9Notf5NlL6U7SNwmmp4w8u+Y6hJaAymLxJz1zFfg9oRKC
         alxQYz8kUoSmS6gmUdFRJOR1RIxLiNd2S8YkTuNeECYBDJ1NDe0iwF3Cz67O/SB5VZfQ
         5sPA==
X-Gm-Message-State: AC+VfDw7BgGRZJ8zy2lUHyCGsPavoEtKLTJVHjsNLBUgvSmQY+GPjRmL
	aqV8FxYahBc2gn2KsqN65/4z11MhjpJnqDZGsldvXA==
X-Google-Smtp-Source: ACHHUZ7FtQbcRUc8WTLtjIXwmhf0dP4E0sMApQm7RE+yKIgq4QNlnxIanJNTRDZhTsnXNaRQmz1bVKfp83v4/d6NFV4=
X-Received: by 2002:a17:90b:3141:b0:259:548b:d394 with SMTP id
 ip1-20020a17090b314100b00259548bd394mr13787062pjb.28.1687456525795; Thu, 22
 Jun 2023 10:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-6-sdf@google.com>
 <00c76c9d-cce8-f3a7-2eda-1c4cc6f36d93@brouer.com>
In-Reply-To: <00c76c9d-cce8-f3a7-2eda-1c4cc6f36d93@brouer.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Thu, 22 Jun 2023 10:55:14 -0700
Message-ID: <CAKH8qBthYBKdxGs8idSXwM6VRpv4-sQH+j9N_QD9eXDmrAnmEA@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 05/11] bpf: Implement devtx timestamp kfunc
To: "Jesper D. Brouer" <netdev@brouer.com>
Cc: bpf@vger.kernel.org, brouer@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 5:07=E2=80=AFAM Jesper D. Brouer <netdev@brouer.com=
> wrote:
>
>
>
> On 21/06/2023 19.02, Stanislav Fomichev wrote:
> > Two kfuncs, one per hook point:
> >
> > 1. at submit time - bpf_devtx_sb_request_timestamp - to request HW
> >     to put TX timestamp into TX completion descriptors
> >
> > 2. at completion time - bpf_devtx_cp_timestamp - to read out
> >     TX timestamp
> >
> [...]
> >
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 08fbd4622ccf..2fdb0731eb67 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> [...]
> >   struct xdp_metadata_ops {
> >       int     (*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timest=
amp);
> >       int     (*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
> >                              enum xdp_rss_hash_type *rss_type);
> > +     int     (*xmo_sb_request_timestamp)(const struct devtx_frame *ctx=
);
> > +     int     (*xmo_cp_timestamp)(const struct devtx_frame *ctx, u64 *t=
imestamp);
> >   };
>
> The "sb" and "cp" abbreviations, what do they stand for?

SuBmit and ComPlete. Should I spell them out? Or any other suitable
abbreviation?

