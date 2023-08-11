Return-Path: <netdev+bounces-26634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98006778773
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 08:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B7521C210F8
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 06:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D39185B;
	Fri, 11 Aug 2023 06:28:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC94EC6
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 06:28:31 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C032D56
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:28:28 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe5c0e587eso15877115e9.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691735307; x=1692340107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cpHllMP4SHxkSojawCu74l62nRNjnVIewdcFlVSPly8=;
        b=cph7bS3FJjW4RaaIDG/VOXXWlsIgifBLbUOCAi4HcBExggqBN3YfAmNjc4SrmOnmZV
         ZvB1O9/vJXdB3PYgBWDhYxsAzjU4SK1bwcaltNajflhq+UzYuhU865i/93f26RwC9nXx
         Bi5WNm1oB0z3LFCLR2ZxSmhrWEWiwfejoMJn9SV1fGPwa9l1vC5abP53+Dny7sE5No+g
         /i0hRo/rhHtf/JB6uqXVzfgPpN3jA7namK9hOZfKdEcw6nxydop4sj8/PltFfXBNBCHQ
         TeNgT/U6MXzjK7rPNaOqzBO481YVLQciJQN/RmMMejYHEEPeZUXt+tAu4iqkDoC5ztrp
         ytxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691735307; x=1692340107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpHllMP4SHxkSojawCu74l62nRNjnVIewdcFlVSPly8=;
        b=k0MKkkyJqRp0ccgTvJ7JobO0U69xm8l4KrEIOFzmgchqx6+qIuxguxGa3GrETL3PcY
         nA38VChtkUgdCNc/JBGXcyhBHZXGmOBOODz8OXsafjvEmtBsegMoqjW6tFfoqTUou6Pk
         TpkJ2VPB/W8uNgZF3/ify5pNkVrYuT3kbLnsl3CgbQWque/pBIhh4owLqD2BaF3zpGRt
         vObAylbWbnUnTHRvZQi9/+T2WiK/5iYpJ48h0RdjE5WfzyCPlLRwHaQsh8by4/g70NZ7
         WUyg16Y4lY/AVXa0LuiZDYuoIV6PAt4FAT/DMDIcdJvGOld5qLLVPbEpuE6or4EE+xB0
         mgPQ==
X-Gm-Message-State: AOJu0YxAGc/vvrOGSbOK6sZCXY9RcqrMXWe4WtHnWU0OorhJdm/2lVl+
	Ttw1+YF8TqL4Op1mcr96HF0abw==
X-Google-Smtp-Source: AGHT+IFO51nR0NxpVRDNqOg6LhzRFHLgpX/uWstBFVF9utITvVux5/bFoTezTcdD+MuAkSy6SjZFLw==
X-Received: by 2002:adf:fd82:0:b0:317:5351:e428 with SMTP id d2-20020adffd82000000b003175351e428mr582852wrr.4.1691735307263;
        Thu, 10 Aug 2023 23:28:27 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id k3-20020a056000004300b003177074f830sm4382853wrx.59.2023.08.10.23.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 23:28:26 -0700 (PDT)
Date: Fri, 11 Aug 2023 08:28:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes@sipsolutions.net
Subject: Re: [PATCH net-next v2 06/10] genetlink: add a family pointer to
 struct genl_info
Message-ID: <ZNXVCefkLQ3/GS8G@nanopsycho>
References: <20230810233845.2318049-1-kuba@kernel.org>
 <20230810233845.2318049-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810233845.2318049-7-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 11, 2023 at 01:38:41AM CEST, kuba@kernel.org wrote:
>Having family in struct genl_info is quite useful. It cuts
>down the number of arguments which need to be passed to
>helpers which already take struct genl_info.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

