Return-Path: <netdev+bounces-25049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D664772BF8
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A41B1C20A7C
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB14125BD;
	Mon,  7 Aug 2023 17:03:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92316125B3
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:03:45 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24E9C2
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 10:03:38 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-317b31203c7so4223945f8f.2
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 10:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691427817; x=1692032617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NOdhagZkiM1AcimeksH69IMlgJ/y4zYboWvUWJPvGg4=;
        b=HlCIfitM7L3hsAEPC6n8PhTxzYhd77+zRdQIBLdFapADWDdkOdfi5Oi99De2+e7bG+
         7yIG5YSgtGLplOGXxe9x4Vq+YltOKZf6J87vzAy3cWPfakXOz3/4IxpsDpvQPXc+GbA+
         o3seWLGziwJabq5i/5fxBHt4k7M4XBeOKEx3AC1yUV/8JBDDFAyTmzJEeMnSTqDAOkUP
         fTJmfqKlkBLYwQGH8BArYFr9gICXS3HqWbVhW3bkhh4o9NnbuZYwhL7pBRJ6LC0+LLzn
         GEluhviFsp0H5n89xEF7UtPhmqKC651gzEAYVX2IFRAGGIYPix2qcXNwa0QQ/sz5p1PH
         ytdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691427817; x=1692032617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOdhagZkiM1AcimeksH69IMlgJ/y4zYboWvUWJPvGg4=;
        b=A9mVF6J3npKP9sivRWTtEjnFV9zYHaLN2AV/b9kRrWyhFmROKvdpm58QZRLvHic7t5
         JAizYFM5I4sSfBgQvAAADQjgK8lVzKaBZFi197myXaYqCyzskFQWauWjhPy9UgD+MKEp
         LnT1/tJFX4g3LIUIj7snLu8Yx0XttdkbM+pmoQyOhGMDOrUElyIXW1fl0QAclCHbcbUj
         6XlyUf9grY/IcIUei3/0r/49GwaowWESyE1hperZtfAb24Jq1vjYBmc0wcBP3Rdf1XV5
         d30CcoTz/TO8W2N02CHyvABE4UPWYmiq0EqPCtt30Vs1pGhZv/gNCg8aBLXXCAXmLn5p
         m1SQ==
X-Gm-Message-State: AOJu0Yx1X6/hYY0yXEs7FrsSsVdji43+ZIVziswkDRblS4cBJycV8gqb
	tPQGaL990uVCzbXxwj35YFhRFA==
X-Google-Smtp-Source: AGHT+IHVGRrrnV/m/hq/Vv/RnUWMzlW0WvTszyhQ9i4Usv8RQnWnT38BiYev3lRsgbZXJLUuNE7nRg==
X-Received: by 2002:a05:6000:10cc:b0:313:df08:7b7e with SMTP id b12-20020a05600010cc00b00313df087b7emr7041630wrx.14.1691427817389;
        Mon, 07 Aug 2023 10:03:37 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id i1-20020adfe481000000b00317e77106dbsm4364340wrm.48.2023.08.07.10.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:03:36 -0700 (PDT)
Date: Mon, 7 Aug 2023 19:03:35 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] devlink: Remove unused
 devlink_dpipe_table_resource_set() declaration
Message-ID: <ZNEj55YqvMtI3anG@nanopsycho>
References: <20230807143214.46648-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807143214.46648-1-yuehaibing@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Mon, Aug 07, 2023 at 04:32:14PM CEST, yuehaibing@huawei.com wrote:
>Commit f6b19b354d50 ("net: devlink: select NET_DEVLINK from drivers")
>removed this but leave the declaration.
>
>Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

