Return-Path: <netdev+bounces-16069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4D574B47E
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 17:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A54D1C20FF8
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3279E10795;
	Fri,  7 Jul 2023 15:44:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F03C123
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 15:44:57 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52F1173B
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 08:44:56 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-401d1d967beso336631cf.0
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 08:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688744696; x=1691336696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlgengT9aAUSDCSQdfdVcjavg+ikjdd9vhZv6EODEuE=;
        b=NjS1x/b0fmLihlzYoavyXYbgBgclV6WvI+vCN8PpUFtK8PeAyUuQVytwUeg/vTub8z
         r3wqdbRgPYCAALlrh+sKsBeB0Cqp2zJDhwUvSN1Q9juTqRAKmL12WhwLVTQZqbdbae1L
         ePlPnnxmzM7q6UntmYjaydKQ4554HtH1YowyUn8SEFCqjTYqDsOZV06SBaqndKnGh37z
         H9+iV2DnoiIHPejCuDLZn/cu2ngwj4At1AFji3xDVA0C5US6Vi6/zTVli+SLJ72mzF0x
         2BT7BHW4VZviqep2cXB77xOgT9KMMHvSIwMNsZXXZhOABDgJafqqgHlilNAzK7JC5CKV
         //Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688744696; x=1691336696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlgengT9aAUSDCSQdfdVcjavg+ikjdd9vhZv6EODEuE=;
        b=bG6Up1Kyg3yvH+5eqJLM/XqqJXmKddn3OBpMUvjKXpNg+gDNRX2cqbZ2+deh9N1VIt
         YC8eRkvv6XNXgJrrm2dLofvfmiBhv12R8/9zK7VdZd4OtAbt9VSt0g+L3e60uJ5P/G06
         xHFZgKfDi85l5/+/LshQYzrheCg3vvGZLVoI3N7yWBCbIoYot1PInIBITaHAWACVxVwP
         4TcnyxZKyocj5G3q75YIgeXUwd1OCWt59ehIWDfnLQUFMcwDm2ER8fE1Dstv64QHHrPB
         +Ahis0E2ywF63r8Z1a6AaF1kbiObavPxRQj1SKo6T5Yt+dzGQ8TVyqj6nEuTtfVgkxOW
         RRTg==
X-Gm-Message-State: ABy/qLblIyLDoJfrpcNmxO6jEdyOPRTyxEeSaXb2FaSbXJp9JDlOnhiG
	xl+9a2eihtLLGKcyxtYAv1Pos72ezxAND7nFAemGKQ==
X-Google-Smtp-Source: APBJJlGVqhZT0XzeXUaZFLXoagNunWsFBAbhlb1W2YjWYdhXaqoASCAAa5Mkb/yUEJtYmVHGXUUym5QFA+ohkI+7zMo=
X-Received: by 2002:a05:622a:89:b0:3f8:5b2:aef0 with SMTP id
 o9-20020a05622a008900b003f805b2aef0mr236394qtw.24.1688744695640; Fri, 07 Jul
 2023 08:44:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230616193427.3908429-1-arjunroy.kdev@gmail.com> <ZKcZZPB7jaDlasdR@casper.infradead.org>
In-Reply-To: <ZKcZZPB7jaDlasdR@casper.infradead.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 7 Jul 2023 17:44:44 +0200
Message-ID: <CANn89iK3WkWZPJqD2=bVczPJ615zL1HHuDQ1VDXyw8AB2hyeJQ@mail.gmail.com>
Subject: Re: [net-next,v2] tcp: Use per-vma locking for receive zerocopy
To: Matthew Wilcox <willy@infradead.org>
Cc: Arjun Roy <arjunroy.kdev@gmail.com>, netdev@vger.kernel.org, arjunroy@google.com, 
	soheil@google.com, kuba@kernel.org, akpm@linux-foundation.org, 
	dsahern@kernel.org, davem@davemloft.net, linux-mm@kvack.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 9:43=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Fri, Jun 16, 2023 at 12:34:27PM -0700, Arjun Roy wrote:
> > However, with per-vma locking, both of these problems can be avoided.
>
> I appreciate your enthusiasm for this.  However, applying this patch
> completely wrecks my patch series to push per-vma locking down for
> file-backed mappings.  It would be helpful if we can back this out
> for now and then apply it after that patch series.
>
> Would it make life hard for this patch to go through the mm tree?
>

No worries, can you send a formal revert then ?

(With some details, because I do not see why you can not simply add
the revert in front of your series ?)

Thanks.

