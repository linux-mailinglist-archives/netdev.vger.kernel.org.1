Return-Path: <netdev+bounces-25967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0064B7764C3
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 18:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BE8281D34
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE7F1C9F2;
	Wed,  9 Aug 2023 16:13:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EEA18AE1
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 16:13:35 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9748A2130
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 09:13:34 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9ba3d6157so111378231fa.3
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691597613; x=1692202413;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hPlm2xkuUNqvfsLIE+lzEu/w4fUAF7NvkAcoEmwRf3Q=;
        b=hYREuKLiHA+cYXn14kiwR1viCAhM6ddyjPLkENiQtBNJCrFcEWqSV7mw3Y05TOkeiX
         BYbq5bZVG+nMCX1K5NRtrZIx4l7Om9aCKD3J8MKfTil0wksU0DCEguQAAlratraof+dg
         oOvFOZ3OzHBHynSJvdI7h3RiyFX8eYHR7jTjmq98DAI7BCIXtpo5/UlU2i9n4WXXMlXi
         efCo93AqyxWmrtKtTfCdBoFtniXSjztFt5q1hCEcvWXC/RNmDpO0ierg0zq5sBpa/CIF
         96j6ZHiQv/fllPgkB2Co8p2FUVBN3E10Mebd7+5LIzOIvK8DaS+WrGXqaSwDRpEea9ou
         gHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691597613; x=1692202413;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hPlm2xkuUNqvfsLIE+lzEu/w4fUAF7NvkAcoEmwRf3Q=;
        b=IheHgLBiTyWDzItIFttx1Ak4cTTbVJ+z1ZMjslsjMz8OIX+HO78gvOSSwFuWGzkETY
         OuOOU5Jxa3NA5JwmXqPR9KleeqtLUZe6q7h0LaSovYDzvQ3jtRxOXR6MuK1mBCqLnWCx
         hyKfCg2F2kc5YAxjNFTJ6khifNgBAYZllRu0gSrdu+56rJKzEzzxu8aTEQHcZN7SmMhd
         IF2JAZ41zsvmMLtHharM4Fn2eLjdhRb5Hp7MzOxdl2nZHwXsI3o14rymSrXf5yRLTf33
         Dnp7cyGMDuZBtTfYBaA+MBCq/GJOblNDYqp04XZUJ3zAR787Ck4cg5b5IkdH163hHl8h
         OrOA==
X-Gm-Message-State: AOJu0Yxz/AfmvCK4/ZxHkqsVRRqW7JZwut7mgrPw7zPHrE7gtTHS/KB3
	b3SJGn7OYJEDoApAcyJ79k4BMBnVEtccKVTmG4GRJ5eaDBg=
X-Google-Smtp-Source: AGHT+IEGyeUiYGGgET1ATBWrqrfkaIF9099BD/uyl+DMyMEihQDP7mtqFE7hjyNrwawGMxevU+hBjKw3VYYSX/b9z5Y=
X-Received: by 2002:a2e:7a07:0:b0:2b9:c4ce:558f with SMTP id
 v7-20020a2e7a07000000b002b9c4ce558fmr2020056ljc.37.1691597612506; Wed, 09 Aug
 2023 09:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a17:906:d550:b0:99c:eef:dddf with HTTP; Wed, 9 Aug 2023
 09:13:31 -0700 (PDT)
In-Reply-To: <20230809124107.360574-4-shaozhengchao@huawei.com>
References: <20230809124107.360574-1-shaozhengchao@huawei.com> <20230809124107.360574-4-shaozhengchao@huawei.com>
From: Jay Vosburgh <j.vosburgh@gmail.com>
Date: Wed, 9 Aug 2023 09:13:31 -0700
Message-ID: <CAAoacN=Lmh0h_9wQvAe_NRDw_SV22NYA3CN_-uvkOoPs6kQmxg@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] bonding: remove unnecessary NULL check in
 debugfs function
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andy@greyhouse.net, 
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/9/23, Zhengchao Shao <shaozhengchao@huawei.com> wrote:
> Because debugfs_create_dir returns ERR_PTR, so bonding_debug_root will
> never be NULL. Remove unnecessary NULL check for bonding_debug_root in
> debugfs function.

So after this change it will call debugfs_create_dir(), et al, with
the ERR_PTR value?  Granted, the current behavior is probably not
right, but I don't see how this makes things better.

-J

>
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  drivers/net/bonding/bond_debugfs.c | 9 ---------
>  1 file changed, 9 deletions(-)
>
> diff --git a/drivers/net/bonding/bond_debugfs.c
> b/drivers/net/bonding/bond_debugfs.c
> index e4e7f4ee48e0..4c83f89c0a47 100644
> --- a/drivers/net/bonding/bond_debugfs.c
> +++ b/drivers/net/bonding/bond_debugfs.c
> @@ -49,9 +49,6 @@ DEFINE_SHOW_ATTRIBUTE(bond_debug_rlb_hash);
>
>  void bond_debug_register(struct bonding *bond)
>  {
> -	if (!bonding_debug_root)
> -		return;
> -
>  	bond->debug_dir =
>  		debugfs_create_dir(bond->dev->name, bonding_debug_root);
>
> @@ -61,9 +58,6 @@ void bond_debug_register(struct bonding *bond)
>
>  void bond_debug_unregister(struct bonding *bond)
>  {
> -	if (!bonding_debug_root)
> -		return;
> -
>  	debugfs_remove_recursive(bond->debug_dir);
>  }
>
> @@ -71,9 +65,6 @@ void bond_debug_reregister(struct bonding *bond)
>  {
>  	struct dentry *d;
>
> -	if (!bonding_debug_root)
> -		return;
> -
>  	d = debugfs_rename(bonding_debug_root, bond->debug_dir,
>  			   bonding_debug_root, bond->dev->name);
>  	if (!IS_ERR(d)) {
> --
> 2.34.1
>
>

