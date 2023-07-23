Return-Path: <netdev+bounces-20204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA0875E41E
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 20:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF30C2816A1
	for <lists+netdev@lfdr.de>; Sun, 23 Jul 2023 18:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A088C46A0;
	Sun, 23 Jul 2023 18:10:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475C2108
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 18:10:35 +0000 (UTC)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAFDE54
	for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 11:10:33 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-583f837054eso2659207b3.3
        for <netdev@vger.kernel.org>; Sun, 23 Jul 2023 11:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690135833; x=1690740633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dprTtuffGOX9oj2WDT3zrtBf8IoHwtXKeYwbtaPyTqM=;
        b=mB62wRwRzloAk9DDOgrx2w4WlS43L0lvyaawK6Msa4HAI0zP+eTQhck0ZilbnCiN6f
         /hnRDI2jyqy/F0z5ozaq5XeZf3Ay6749UW+nOLgRR0FKqrvJMHP7p++9KgbrXxrHTnHP
         M1CZnNhka0bQUg26Rif8WWQnJdIEKeHGGJ8e9ODqlyoI/cKjCYoBMsd20pv5zGylfuwM
         f8Bfux6trGJRjyXjERo3M7n3GBXOLnEzJ+h9eV0Y0YSQkuTiQgL0HeV2Ujn0Ya+zosD1
         bhjqSioay3i8ZVmEYwmICjeovLIEWHP6V9o7Wi6MpbxY65L3HoTM9tPSHenVOgpnhffC
         r61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690135833; x=1690740633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dprTtuffGOX9oj2WDT3zrtBf8IoHwtXKeYwbtaPyTqM=;
        b=PS/Qyo5+dTFDUVl25B1gyazBmyzb1K3Rn2u2BxNJyzVPgLYrLvabS46xjXmfFiiBEW
         0npUMQyDFs9ELGtB/QpTB+M1VvoHWnnvVJCKRi9wDhyK9lYAoWzs9nBVcWhQNHnzH0p6
         RAOVDumX3/XwmbtTf6AynRCFe0lx2aJBsbwpmKAK2Me6dBvEwBLgYxTIUSkYruXiqDfW
         BM4drRpHO3N+K/uFJZwTjnRtkt/U2oDiFKetcsqGhsRL122CVgex6QMbjcStiKs54PRE
         5kEv1O3lSPycaqH71VmFOcAX5X5Vfa/eiX5BJ7Hi2UwZzlfQA+HHNoXyB6Zz8uR+JLk7
         /RmQ==
X-Gm-Message-State: ABy/qLZK2lh6RndlkOwwi3xKz6C5h1HKkBxuVTqHP0lnHZQUx66qf1lP
	J288qegcLhdDWJzj2+cxnCQ=
X-Google-Smtp-Source: APBJJlF10zg82pY1b6pZqizTXXr5sxDKh85jehCO62nICCNk2kAzsVtADpWPtEkngvWJJFbfcs+07g==
X-Received: by 2002:a0d:ef42:0:b0:583:9018:29ec with SMTP id y63-20020a0def42000000b00583901829ecmr6374854ywe.32.1690135833167;
        Sun, 23 Jul 2023 11:10:33 -0700 (PDT)
Received: from localhost ([2600:1700:65a0:ab60:7684:b87a:afde:8ec6])
        by smtp.gmail.com with ESMTPSA id u1-20020a0deb01000000b0054bfc94a10dsm2308861ywe.47.2023.07.23.11.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 11:10:32 -0700 (PDT)
Date: Sun, 23 Jul 2023 11:10:31 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com,
	jiri@resnulli.us
Subject: Re: [PATCH net-next 1/5] net/sched: wrap open coded Qdics class
 filter counter
Message-ID: <ZL1tF6QB2jhy1cjw@pop-os.localdomain>
References: <20230721191332.1424997-1-pctammela@mojatatu.com>
 <20230721191332.1424997-2-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721191332.1424997-2-pctammela@mojatatu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 04:13:28PM -0300, Pedro Tammela wrote:
> The 'filter_cnt' counter is used to control a Qdisc class lifetime.
> Each filter referecing this class by its id will eventually
> increment/decrement this counter in their respective
> 'add/update/delete' routines.
> As these operations are always serialized under rtnl lock, we don't
> need an atomic type like 'refcount_t'.
> 
> It also means that we lose the overflow/underflow checks already
> present in refcount_t, which are valuable to hunt down bugs
> where the unsigned counter wraps around as it aids automated tools
> like syzkaller to scream in such situations.
> 
> Wrap the open coded increment/decrement into helper functions and
> add overflow checks to the operations.

So what's the concern of using refcount_t here? Since we have RTNL lock,
I don't think performance is a concern.

I'd prefer to reuse the overflow/underflow with refcount_t than
open-coding new ones.


> diff --git a/include/net/tc_class.h b/include/net/tc_class.h
> new file mode 100644
> index 000000000000..2ab4aa2dba30
> --- /dev/null
> +++ b/include/net/tc_class.h

Why not put these helpers togethre with other qdisc class helpers in
include/net/sch_generic.h?

Thanks.

