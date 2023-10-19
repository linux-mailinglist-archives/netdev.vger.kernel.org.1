Return-Path: <netdev+bounces-42649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0247CFB7E
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFFFAB20DB7
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8812A27472;
	Thu, 19 Oct 2023 13:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="R2o4Sha3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98BEDDA6
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 13:44:51 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E30911F
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 06:44:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99de884ad25so1285749966b.3
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697723089; x=1698327889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cDIa/2A+6yZh839uWJwLCiFpvbLP65/3nH2vhPGAYh4=;
        b=R2o4Sha3hypVKhADo2600rPDKSwklCwGpqqzQf6GpQor/iTdGH8kr7Y1rZ9HRIPQNG
         J/GV7VE9tAolUmBwvuLt63IqRCyMMfEqJkzHYuiBom3sLS7D9kkd2Mmd82XdE0AsPbbC
         22NFp47iXO1wrVGr0f86zARYiLsuIQvKL8D23hsFK8EjWbSOCXBNqBaadRbQ1L/gZkJa
         Mw92KX0bwrLhgxLwaasEQ+LQ/5p7ToBqftiFG6DG1of30dEngCSPpQef2flmZ8zaiw6B
         UGY6t29UPmM4XbRk4pdB0g+sxtwi7LkEkr2hIqqbBPNNqfhu+oIqgZE9T/Itv6MNmjyy
         UX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697723089; x=1698327889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDIa/2A+6yZh839uWJwLCiFpvbLP65/3nH2vhPGAYh4=;
        b=MrjbehKsNaQUTqitt6KlL2Lgo+T4A9jmisA6YIF6UniJGCyoFhekcph/j1llvIU8Yr
         ddxOJbgZ8pvZ330IK4x1vgOm+r+eY3tHWzsjtzWpIODMtnMwxoLR/goOH5QKzh0J56mw
         np6nXIzfVgcngyutaujYr/6Eq46DOgTbJmtAE0a6/hZJgKoCVQ3UF2Xqsym5+Gu+VY5A
         qoRZm/1LZlyjZuo3JxvFjiBVVUn4aOhgRwf0TAp8nHUDW7zcFMWS7UhX1zQCZ+hJraxc
         HLApo2jDwiZd7c44CzA6lA3uNyHfk3T+Phv5LAUMkH0sTEhNvIwYbDU5F4qZ4FkILvXh
         kzwQ==
X-Gm-Message-State: AOJu0YzDSviUnKk6BUaaP5YB478Agp6EqVUjDCUUM/+Jr30JYKjAfKeW
	kH8K/y9gxRQxwWoVuTm8OgfM/Q==
X-Google-Smtp-Source: AGHT+IETLLRDDnMEJLBCzEtlZkAeUnLoQo2/NWVU9pzn/11MjRj5stLhakDevcHcxNOLId/UiRPsjg==
X-Received: by 2002:a17:907:2dab:b0:9bd:a063:39d2 with SMTP id gt43-20020a1709072dab00b009bda06339d2mr1859239ejc.16.1697723088637;
        Thu, 19 Oct 2023 06:44:48 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id c15-20020a1709063f0f00b009ae6a6451fdsm3624414ejj.35.2023.10.19.06.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 06:44:48 -0700 (PDT)
Date: Thu, 19 Oct 2023 15:44:46 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
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
	Benjamin Poirier <bpoirier@suse.com>
Subject: Re: [PATCH net-next v3 00/11] devlink: retain error in struct
 devlink_fmsg
Message-ID: <ZTEyzpat4we6f4kE@nanopsycho>
References: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018202647.44769-1-przemyslaw.kitszel@intel.com>

Wed, Oct 18, 2023 at 10:26:36PM CEST, przemyslaw.kitszel@intel.com wrote:
>Extend devlink fmsg to retain error (patch 1),
>so drivers could omit error checks after devlink_fmsg_*() (patches 2-10),
>and finally enforce future uses to follow this practice by change to
>return void (patch 11)
>
>Note that it was compile tested only.
>
>bloat-o-meter for whole series:
>add/remove: 8/18 grow/shrink: 23/40 up/down: 2017/-5833 (-3816)
>
>changelog:
>v3: set err to correct value, thanks to Simon and smatch
>    (mlx5 patch, final patch);

2 nits:
- always better to have per-patch changelog so it is clear for the
  reviewers what exactly did you change and where.
- if you do any change in a patch, you should drop the
  acked/reviewed/signedoff tags and get them again from people.

that being said:
set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

