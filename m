Return-Path: <netdev+bounces-47645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5B87EADCA
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 11:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1157828107E
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 10:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51161863F;
	Tue, 14 Nov 2023 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIhAW+cS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E2E19453
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:16:42 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D24583
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 02:16:42 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6c4884521f6so4584862b3a.0
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 02:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699957001; x=1700561801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h9HLh5chAiBR///+94swHNlYrbRytOcJ5TEltqsM6iU=;
        b=NIhAW+cS1PoPymmdvhRwmPkL7dGNNhDBKz3Y2CBtUGAeEZQ8r+QqUh8bcp31pFfprY
         036l6MoZ3R8kb14GNpMKVpV0YGd1Tuqdj+/6865ICqmQ1R95VX0XIqX8mDf3cBOskToJ
         1/E+yamp/3F2DURJgmjKgv9VIPYxsQGA9q9KuaSvzYIbYXZw2zMMzTpuQkhxKTaQvrZq
         Rg9ciD6zZcwzXi8XsE3l650sk0/iY0+dNNivMb5xqgDyEQIyXrp1Q/H3ISc3+TzS/UQR
         he/KCRP22Qr/zMynfGGSsicO7MmNcX3V40F+V/Us+aqVt209qQKL809pqWtoKz/5vZJJ
         gJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699957001; x=1700561801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9HLh5chAiBR///+94swHNlYrbRytOcJ5TEltqsM6iU=;
        b=Q0h+kD1EogtTUjsyPG8TemrAi4FAAOa1zI5G5MF3aGUGrNfaHeO0hnQ7fmUlqKDADQ
         Klxz/uw9Qzn3T1+e0uh5dAFiYHLGUTyzVEzSwcKiHaQXVqHoUudVuI32q69MYtb0y0VU
         04I39Yo5cbfpxiadLSYZR+OvXgEhVsYyFRvfHzrCS0X/TiO3XNboC+D/UERHo9+IvVqt
         bVGy/kfnlU3oygIXUn8KYnCAaDI1oMN0KquDEW1kZWUEJjEUg77o5rTcLx5wkNLdq2fB
         RaxtGcyfWvEvT3Rlu88PVOJ2zpbRyTulXbVpHngsTNcCfjo+H9Xli/B5uW/RrjEOpM4f
         2ivw==
X-Gm-Message-State: AOJu0YwCexEHHRoOj2w8Vt1swqkvWEeC1M9F+REejLt4ufZTYrT3bLMm
	LJZ4ouTghxd9Eeg1GBooPwk=
X-Google-Smtp-Source: AGHT+IHgw8rnk/JvUyUOMgz/sQV4TylsG0Ys2QzZjOCzG3324zOZKYbmVp5nN5S1jyzNiwVfDtMEPg==
X-Received: by 2002:a05:6a20:a112:b0:14c:c393:6af with SMTP id q18-20020a056a20a11200b0014cc39306afmr7536771pzk.0.1699957001449;
        Tue, 14 Nov 2023 02:16:41 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e7-20020a635447000000b0056b6d1ac949sm5209067pgm.13.2023.11.14.02.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 02:16:40 -0800 (PST)
Date: Tue, 14 Nov 2023 18:16:36 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, j.vosburgh@gmail.com,
	andy@greyhouse.net, weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next,v2] bonding: use WARN_ON_ONCE instead of BUG in
 alb_upper_dev_walk
Message-ID: <ZVNJBEuJw+rT/Biq@Laptop-X1>
References: <20231114091829.2509952-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114091829.2509952-1-shaozhengchao@huawei.com>

On Tue, Nov 14, 2023 at 05:18:29PM +0800, Zhengchao Shao wrote:
> If failed to allocate "tags" or could not find the final upper device from
> start_dev's upper list in bond_verify_device_path(), only the loopback
> detection of the current upper device should be affected, and the system is
> no need to be panic.
> Using WARN_ON_ONCE here is to avoid spamming the log if there's a lot of
> macvlans above the bond.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
> v2: use WARN_ON_ONCE instead of WARN_ON
> ---
>  drivers/net/bonding/bond_alb.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
> index dc2c7b979656..a7bad0fff8cb 100644
> --- a/drivers/net/bonding/bond_alb.c
> +++ b/drivers/net/bonding/bond_alb.c
> @@ -984,8 +984,10 @@ static int alb_upper_dev_walk(struct net_device *upper,
>  	 */
>  	if (netif_is_macvlan(upper) && !strict_match) {
>  		tags = bond_verify_device_path(bond->dev, upper, 0);
> -		if (IS_ERR_OR_NULL(tags))
> -			BUG();
> +		if (IS_ERR_OR_NULL(tags)) {
> +			WARN_ON_ONCE(1);
> +			return 0;

Return 0 for an error looks weird. Should we keep walking the list if
allocate "tags" failed?

Thanks
Hangbin

