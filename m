Return-Path: <netdev+bounces-43790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB857D4CF0
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257B8281838
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 09:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C12A24A07;
	Tue, 24 Oct 2023 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QWmAcWMh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C20CCA4D
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 09:51:32 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBB410C6
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 02:51:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso31677265e9.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 02:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698141089; x=1698745889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dlhk8Z4MNGAJNlAwZKSD8+Gfu1Hv7jMp2quDDwwtBiw=;
        b=QWmAcWMh7lyB1SpYJcoXvFp2ArSXQZm2+sPI/ZE6sadQyBBkUCVGBgeEiivbVQzCZ8
         bpNwNrON6rJKI7kpwD3ZhhE7/+wnO7yDo1DbJaZK4VpBqbP1DpYrd9V3FqaX+C3foA8U
         kTccY4Saos/+LnSgoK1tFk4nbki1//QPaDkIBWi12ccMG+YlwvHCnAGlPQquFe6dNXSw
         ZnOmE1h8bDFsLWLBj0PaWzABy9zFwN2JssZTPIuwrlrh2HIoh8F1cuEgPs/ePTbtfu5Z
         Cq3Sc931mVwPlgA8fjRnKd5m91PLVF0LUuwB05AYCQhfDjx3nQswh3thQkybqVZWqTpG
         qgow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698141089; x=1698745889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dlhk8Z4MNGAJNlAwZKSD8+Gfu1Hv7jMp2quDDwwtBiw=;
        b=apwWdS04rLoT+SJVCVasBzKz/U+ae3wyvnDUjcUEX6By5d1cKJ9rfmjU+4fHCdfg52
         XxfzPBmTC6aDYtvfpqgKdwqBjI5Pl0HAsla1rhq3Xtk+yedj4Ks0MWce7kHLG3uOBx1U
         gTP3MaDrWZtJ9D7wKMKS5KSb1F9ofxXUWEjwJsc7brRW7TvIgCKIZtHjDIMr5MmSieCt
         XYugvclKZFO+AkfJzEExtTejbdyBd8gNYUhyOMtcbJEpvoSY85GF1opDsQA6km0VkQzW
         jIR6Sz1xVBrrL8cvtgFH3XpcREFbkRhWOc0NqgsOUKb5HbhwIqxmFirARp3CTcc5Fdtt
         gQcQ==
X-Gm-Message-State: AOJu0YyF3dkdq5y+yCMzOAwltMnwROMmGj5pudJGBAdrpf2A87DkqHMW
	pFR/ihtQu4yzsPmxwDULSvufNw==
X-Google-Smtp-Source: AGHT+IH9Kj04S7itMREQN6Y5d8cJZTKSFimqEcnJnixpWHPoL9XRQ/FUmKNnXVGhJvgXj2558wkCTQ==
X-Received: by 2002:adf:e34f:0:b0:32d:a781:111 with SMTP id n15-20020adfe34f000000b0032da7810111mr8671201wrj.15.1698141088754;
        Tue, 24 Oct 2023 02:51:28 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id x18-20020a5d60d2000000b003248a490e3asm9544652wrt.39.2023.10.24.02.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 02:51:28 -0700 (PDT)
Date: Tue, 24 Oct 2023 12:50:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	George Cherian <george.cherian@marvell.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	Coiby Xu <coiby.xu@gmail.com>, Simon Horman <horms@kernel.org>,
	Brett Creeley <brett.creeley@amd.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Eran Ben Elisha <eranbe@nvidia.com>, Aya Levin <ayal@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
	Benjamin Poirier <bpoirier@suse.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v3 08/11] net/mlx5: devlink health: use retained
 error fmsg API
Message-ID: <8bd30131-c9f2-4075-a575-7fa2793a1760@moroto.mountain>
References: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
 <20231018202647.44769-9-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018202647.44769-9-przemyslaw.kitszel@intel.com>

On Wed, Oct 18, 2023 at 10:26:44PM +0200, Przemek Kitszel wrote:
>  	if (rq->icosq) {
>  		struct mlx5e_icosq *icosq = rq->icosq;
>  		u8 icosq_hw_state;
>  
> -		err = mlx5_core_query_sq_state(rq->mdev, icosq->sqn, &icosq_hw_state);
> -		if (err)
> -			return err;
> -
> -		err = mlx5e_reporter_icosq_diagnose(icosq, icosq_hw_state, fmsg);
> -		if (err)
> -			return err;
> +		mlx5_core_query_sq_state(rq->mdev, icosq->sqn, &icosq_hw_state);

When we remove the error checking then Smatch correctly complains that
icosq_hw_state is used uninitialized.

    drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c:268 mlx5e_rx_reporter_build_diagnose_output_rq_common()
    error: uninitialized symbol 'icosq_hw_state'.

> +		mlx5e_reporter_icosq_diagnose(icosq, icosq_hw_state, fmsg);
>  	}
>  
>  	return 0;
>  }

See also:
    drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c:229 mlx5e_tx_reporter_build_diagnose_output_sq_common()
    error: uninitialized symbol 'state'.

regards,
dan carpenter

