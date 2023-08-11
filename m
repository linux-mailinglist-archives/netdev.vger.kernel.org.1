Return-Path: <netdev+bounces-26849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E448B77937A
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 17:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8DBE1C216AF
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 15:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875E82AB41;
	Fri, 11 Aug 2023 15:48:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A68C2AB3D
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:48:51 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDA230D8
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:48:49 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-407db3e9669so247171cf.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691768929; x=1692373729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1LSHVIb9UFewOc6C0cD7YznG7qCPc2ebrFIqE79xMTg=;
        b=s8Mz5GqhAAT4q6vGrdOzXaJudtrGog0Ocsp1selmLwBPN8st0Z6gyYx36mk8S1MG9n
         YXG0bc6hY2ba+8m2a9TNioyaDVgCmvkEfmrmXsFgkvd2ayAaLUaLYji7gOaQG+yPoIRz
         ezbTbNx+Yhn7dVeJSG7T9p/8udtOA720WHDfvRkBY1GsA5XFzCOhdrHEZqLM7POT36ER
         QXJO8JBTrZ2dHHb+vOQqH2tCnlfG8Jaae/cCLqLwSZijm1KQH+BNu0MWvTe0w2XWFZ3W
         55XZ4M91ptr36HtJemPivQq50fFkED4Yi9vf51m8lEZETIxKDlZvArbuWp8OgiaWaM8A
         dUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691768929; x=1692373729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1LSHVIb9UFewOc6C0cD7YznG7qCPc2ebrFIqE79xMTg=;
        b=kmD080mNRg2M1jLGj1qWUqmIl9tsE3/jruUUgdO8FvhfHZ4DTFcST/W51pkAkUP0xR
         z9DIvVF9o11nB9mJV4rXyb7cQP0a4/J5KYgvlR60Cm6beXB89uyJylvHNwBfBRVAJpUI
         +UHj1C6ePYL4ICKPg3vKKH3UCpqaajjb16zF9z1ki3MJL7KkIx8sTBfOZGsy/lGRZAeF
         VC4QVJKcBfC8foFvBu/t12hL8n6yO/aCNByfgQDvZqNFpBA6YZaJ6C3kbBUb/tyhy9gz
         Km2V/cO8vg4JYmkgsYOotNLsAu19jKkYyxWP1YXU9Dzc3jdKJzCjtQ2dM/Fder7tGqBh
         3+RQ==
X-Gm-Message-State: AOJu0YxEEn4FGZ2orrygVMR2+/e/v8r/+D3j3oh3NIsoa3Ln6tEf+Q3W
	lXDN+pvgKmxtacQs2N121BvJTRwCSvy4FIwc6N/nVg==
X-Google-Smtp-Source: AGHT+IH+PqXwthH0SiAVCdPC/kJd+tpX6FmU5nDdAuZANyBiIUF8HIjq4B6xfmSYnVkkqcpA3zJiidcdcg8BAtwnS8o=
X-Received: by 2002:a05:622a:156:b0:403:ff6b:69b9 with SMTP id
 v22-20020a05622a015600b00403ff6b69b9mr177084qtw.13.1691768928950; Fri, 11 Aug
 2023 08:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230811073621.2874702-8-edumazet@google.com> <202308112211.xpcXWwEP-lkp@intel.com>
In-Reply-To: <202308112211.xpcXWwEP-lkp@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 11 Aug 2023 17:48:37 +0200
Message-ID: <CANn89i+f6vzEP13gX9FBw_Lkx5fPFLn7jPQ=6b7MRMW2S7xijA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 07/15] inet: move inet->mc_loop to inet->inet_frags
To: kernel test robot <lkp@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, oe-kbuild-all@lists.linux.dev, 
	Simon Horman <simon.horman@corigine.com>, Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 4:11=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Eric,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/inet-=
introduce-inet-inet_flags/20230811-154157
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20230811073621.2874702-8-edumaze=
t%40google.com
> patch subject: [PATCH v2 net-next 07/15] inet: move inet->mc_loop to inet=
->inet_frags
> config: nios2-randconfig-r001-20230811 (https://download.01.org/0day-ci/a=
rchive/20230811/202308112211.xpcXWwEP-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230811/202308112211=
.xpcXWwEP-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308112211.xpcXWwEP-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    net/netfilter/ipvs/ip_vs_sync.c: In function 'set_mcast_loop':
> >> net/netfilter/ipvs/ip_vs_sync.c:1304:13: error: 'struct inet_sock' has=
 no member named 'mc_loop'
>     1304 |         inet->mc_loop =3D loop ? 1 : 0;
>          |             ^~
>
>
> vim +1304 net/netfilter/ipvs/ip_vs_sync.c

Oh right, thanks.

