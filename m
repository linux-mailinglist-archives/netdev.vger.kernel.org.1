Return-Path: <netdev+bounces-23055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413A276A871
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 07:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 444A82811D2
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 05:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE2D46B4;
	Tue,  1 Aug 2023 05:46:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0061E3FEF
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 05:46:29 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4376611D
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 22:46:28 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe1344b707so8347428e87.1
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 22:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690868786; x=1691473586;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VtfeVm+pZg2c5VCnLnxW1fO82KR5VHswyzC54DKBGoQ=;
        b=RCrXJYro/hO9TGbgFNl/MGklx4O1HzWnDT98GialYHRAyHMmRaTQWaQBJNHHBRGvCx
         he8PMaUVxGBZHE2knw1477flscoUt3MDjDVsFarORred6Q2fg0CDP/wICEpAF9F0jq92
         qAZCyvwsc09QmSl1hJ3DCuqGE+KygIehVbgmfJQcyCIqhlAq4RyCA1MA+z9SHqmGhW53
         LvI7Mccfm3cTidctkiMUDXupLTb4TBIsU/a65N+6+Bi04CfnA3dW4wEC4V9P1hEV66bw
         G1szQztPP/jfkA1MEg0QRM+DKqzneQaxiUnZuhLvZnLVk3SXdfYaS4hUndpkAYlmUoUc
         Fwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690868786; x=1691473586;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VtfeVm+pZg2c5VCnLnxW1fO82KR5VHswyzC54DKBGoQ=;
        b=e1EUm85P0sYr3aYZeCrOZhKHy3+e2PlRnogNBYKjQf7NL2sOcafNBeZvhtyawkFZGy
         k7AAE4RGm68G7n8/0w06pm7KCmQHcXTg1qlQQOj5PdGKuNxaX03cltmb964SUNmr+oyF
         NRcwHOGuygoBRBH1fWkgcAaDga4tUTGnr5aUKInzsc3+CpeodLMcF4GBxG/PnZw+wNWi
         QN+Du4Er7dUde1ja/1lzCC7vptm6PyN4u+OkBnyQaC5ahwpcwCW/KaYYRTEaOEBTHK2q
         r408TjdSdgxOfDYSjzdreRBxCid/ibADGTkMHP4kA35BClCRoWZvHKfdVvQJy+QaNAqP
         c83w==
X-Gm-Message-State: ABy/qLYLQueoNjoDL6mI8TcS7rswUknhVTpwSLh4xPWYGh5eCRNBuVFw
	uUQOm5ds06pizFilzSx3SahMzA==
X-Google-Smtp-Source: APBJJlHMaC5V5AYOVUvFg1FoZfR2acUsBo8Fh3lxOaTxGZ3kE39gfSC6OwcF8Eywvzt/QzkN0zwM/w==
X-Received: by 2002:a19:771d:0:b0:4fe:825:a07f with SMTP id s29-20020a19771d000000b004fe0825a07fmr1238613lfc.57.1690868786399;
        Mon, 31 Jul 2023 22:46:26 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f9-20020a7bc8c9000000b003fa96fe2bd9sm15814946wml.22.2023.07.31.22.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 22:46:26 -0700 (PDT)
Date: Tue, 1 Aug 2023 08:46:23 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Alexander Duyck <alexander.h.duyck@intel.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter P Waskiewicz Jr <peter.p.waskiewicz.jr@intel.com>,
	Petr Machata <petrm@nvidia.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: dcb: choose correct policy to parse DCB_ATTR_BCN
Message-ID: <d29e7d32-1684-4400-9907-f2f69092466d@kadam.mountain>
References: <20230731045216.3779420-1-linma@zju.edu.cn>
 <fbda76a9-e1f3-d483-ab3d-3c904c54a5db@web.de>
 <3d159780.f2fb6.189aebb4a18.Coremail.linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d159780.f2fb6.189aebb4a18.Coremail.linma@zju.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 09:34:17AM +0800, Lin Ma wrote:
> Hello Markus,
> 
> > 
> > …
> > > This patch use correct dcbnl_bcn_nest policy to parse the
> > > tb[DCB_ATTR_BCN] nested TLV.
> > 
> > Are imperative change descriptions still preferred?
> > 
> > See also:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc3#n94
> > 
> > Regards,
> > Markus
> 
> Yeah, thanks for reminding me. I haven't been paying attention to that
> and I will remember this ever since. :D

Simon reviewed the patch already.  Don't listen to Markus.  He's banned
from vger.

https://lore.kernel.org/all/2023073123-poser-panhandle-1cb7@gregkh/

regards,
dan carpenter


