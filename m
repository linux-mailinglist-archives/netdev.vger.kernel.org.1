Return-Path: <netdev+bounces-12596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 481C37383FF
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 14:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960F92812E1
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 12:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8BE11CA1;
	Wed, 21 Jun 2023 12:42:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5A0DDA1
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 12:42:01 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D8B135
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 05:41:59 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b46831fd13so3579440a34.3
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 05:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687351319; x=1689943319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEnN1eHhs1tN7/Y7t6he6p9VJhq0VBCBjTgHlWlf5vI=;
        b=HZWfECMgE6MPIaSwTX+cstHxlqQcjci/Cx/EUw7h7RJ21GngIXSeLbaxr1PzBgj/OV
         xGpGnb2+A6VkoT7tktNpSs1a5xqAxWu51LRmuYqq851vfPliIPKJArYjU8jh+MEv/nKQ
         1OMcvACGuNQWIWCp3vi0JOtGzQ5TjxoB9VgXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687351319; x=1689943319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEnN1eHhs1tN7/Y7t6he6p9VJhq0VBCBjTgHlWlf5vI=;
        b=FXKA4LxXoyXAH++dn/P3gd7K4xWqVhOuYgNIPdt6So/uc5bdviz7Eep2xIr8AgdOoX
         MGwBgVZL8nJ24u2qk6r6htgfmv+cOIQpqAm0raqYLpi9JqJLRtv5IqmdiXk9eLqIrIKm
         55XeKGR0CFYhIZbJRl7HmADGVQAe8S1UJbjJKfkwZSg51s7lnwXHnPV64yV6HXF33mFC
         6lWpth32xeYp1elG5KjdyUr2Xkqrm4yCKTSpJN1Iu81PyvL8y5tHYxrkcG5z3+ok+1cp
         iHHAncFnK+tF8xgOejZ/gJrzdw4sh5G0lTC+wp18AInFk0r60HFTDKePsEwvLWGV7A3w
         8r0w==
X-Gm-Message-State: AC+VfDwHnTtSLj0LHXs7l7gFpXhNdvYYvlbpTU6Kz4x6w7ngIC9Fd0/1
	wWeF4hD4V9gEOFcLMo2qwG6TcfYy1F+RBjIF2sCr4A==
X-Google-Smtp-Source: ACHHUZ7Lgbb/KL+C7uMlNHS0la3DKKGcJ/COXaSKZuAoRMdzSFtGhs5NNtbL0yuxXHyxxaWj05O6ICB82oBeoWWr5d4=
X-Received: by 2002:a05:6808:120a:b0:39e:b985:b47e with SMTP id
 a10-20020a056808120a00b0039eb985b47emr15650678oil.36.1687351319039; Wed, 21
 Jun 2023 05:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230615152918.3484699-1-revest@chromium.org> <ZJFIy+oJS+vTGJer@calendula>
 <CABRcYmJjv-JoadtzZwU5A+SZwbmbgnzWb27UNZ-UC+9r+JnVxg@mail.gmail.com> <ZJLbDiwsQnQkkZvy@calendula>
In-Reply-To: <ZJLbDiwsQnQkkZvy@calendula>
From: Florent Revest <revest@chromium.org>
Date: Wed, 21 Jun 2023 14:41:47 +0200
Message-ID: <CABRcYmLgOn9=nNA151ibvRFeAGCzORAymmGsppjRPo9jPrF1ag@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: conntrack: Avoid nf_ct_helper_hash uses
 after free
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	kadlec@netfilter.org, fw@strlen.de, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, lirongqing@baidu.com, wangli39@baidu.com, 
	zhangyu31@baidu.com, daniel@iogearbox.net, ast@kernel.org, kpsingh@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 1:12=E2=80=AFPM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> On Wed, Jun 21, 2023 at 12:20:44PM +0200, Florent Revest wrote:
> > On Tue, Jun 20, 2023 at 8:35=E2=80=AFAM Pablo Neira Ayuso <pablo@netfil=
ter.org> wrote:
> > > nf_conntrack_ftp depends on nf_conntrack.
> > >
> > > If nf_conntrack fails to load, how can nf_conntrack_ftp be loaded?
> >
> > Is this maybe only true of dynamically loaded kmods ? With
> > CONFIG_NF_CONNTRACK_FTP=3Dy, it seems to me that nf_conntrack_ftp_init(=
)
> > will be called as an __init function, independently of whether
> > nf_conntrack_init_start() succeeded or not. Am I missing something ?
>
> No idea, nf_conntrack init path invokes nf_conntrack_helper_init()
> which initializes the helper hashtable.

Yes

> How is it that you can nf_conntrack_helpers_register() call before the
> initialization path of nf_conntrack is run, that I don't know.

No, this is not what happens. I tried to describe the problem in the
following paragraph (I'm open to suggestions on how to explain this
better!)

> > > On Thu, Jun 15, 2023 at 05:29:18PM +0200, Florent Revest wrote:
> > > > If register_nf_conntrack_bpf() fails (for example, if the .BTF sect=
ion
> > > > contains an invalid entry), nf_conntrack_init_start() calls
> > > > nf_conntrack_helper_fini() as part of its cleanup path and
> > > > nf_ct_helper_hash gets freed.

Said differently (chronologically, I hope that helps)

First, nf_conntrack_init_start() runs:
- it calls nf_conntrack_helper_init() (this succeeds and initializes
the hashmap)
- it calls register_nf_conntrack_bpf() (this fails)
- goto err_kfunc
- it calls nf_conntrack_helper_fini() (this frees the hashmap and
leaves a dangling nf_ct_helper_hash pointer)
- it returns back an error such that nf_conntrack_standalone_init() fails

At this point, the builtin nf_conntrack module failed to load.

But now, nf_conntrack_ftp_init() also runs:
- it calls nf_conntrack_helpers_register()
  - this calls nf_conntrack_helper_register()
    - this accesses the hashmap pointer even though the hashmap has
been freed already. That's where the use-after-free is.

I proposed we fix this by not accessing a freed hashmap (using NULL as
a clear indication that this is now an invalid pointer) but I suppose
there are other ways one could go about it such as checking if
nf_conntrack initialized successfully early in nf_conntrack_ftp_init()
etc... I'm open to suggestions.

