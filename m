Return-Path: <netdev+bounces-39444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5DF7BF442
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D29281A41
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 07:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFF0D26D;
	Tue, 10 Oct 2023 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="02s/HCIa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E614BC8CF
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 07:26:45 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F43D64
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:26:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405524e6768so51579315e9.2
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696922796; x=1697527596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mdCECjcQ8yLFY05ydH1cEetfy6fTzHwV8d56+ifpwgI=;
        b=02s/HCIaxebFheSm+g7k948sl5c2Ki0QX/hNl6Ld18sjnvdrSbpAHTxy3MO2xxRwzv
         0VVknShx5FITZWT8BP2O9dGpT4zuMG7x7ytvhSoeZAXEAt+q73mGN4lEBwMp5MiA97aY
         6lOgKYFFgRvm6nny6eMN4HAoG5MWxt15gsdy0I5F62jluCyvlJOhJUEgS+FxID5Tg294
         OJSRmMR22nyqfenE8vsUUTq5x2XO4jqYQopmXeqStgMZUGN0Tyuw0ktGZ/yTRXcG6CeB
         cLPSaVjXIRUVhmtBYGc/IEikZzNryBJSLhZl2EH0sCR6tc3i+ywjh2yOszswp8xyUJi1
         FU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696922796; x=1697527596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdCECjcQ8yLFY05ydH1cEetfy6fTzHwV8d56+ifpwgI=;
        b=cM1Myyz+2s18nG8neokA3bqoCnfXuRyCKUg2zWmh5cKtW0tbU1Wadmxsxv2rKrfwIg
         EStss5SL09D6cWqaV59IS2du4w3b2rUM0u+FsbOFaEEVvmSWgtdefGSTMPN8Gj+q5CPB
         EDszV6WwRZ1xFRTbVGTxmxuNAu7VpIWBaNz27w5r7idGcza5zqDgYMXWdBRyuMDB6cel
         0Uc2QH+02w5T8LpYanSw078YViPJQF5yDSISPuT/Cx4G+Ce0umlA31PmpDcpoyRbX79f
         FWbF3ZBMmmaZGcaX/h1cvnCnQ/xos46lb7gDTrsyakid6eYz80kBz9bLbZGqGiEYB45J
         Hldw==
X-Gm-Message-State: AOJu0YxwSqTy19rQyTyTZxeubX5/S2PpqQkXmhuc0Z6KWH/0+FKpKWWD
	0SK+eLMRljHv5c2qLtF5WRlwag==
X-Google-Smtp-Source: AGHT+IHPsuRIDS+FMzvHoytvW0TbGq5FA5GpCf7AiQpHBFEGmiKWTTrH+SLE668t3FaYvZSQHeDwHw==
X-Received: by 2002:a1c:f202:0:b0:407:566c:a9e3 with SMTP id s2-20020a1cf202000000b00407566ca9e3mr740404wmc.21.1696922796370;
        Tue, 10 Oct 2023 00:26:36 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id z18-20020a05600c221200b0040607da271asm15441190wml.31.2023.10.10.00.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 00:26:35 -0700 (PDT)
Date: Tue, 10 Oct 2023 09:26:34 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com
Subject: Re: [patch net-next] netlink: specs: don't allow version to be
 specified for genetlink
Message-ID: <ZST8qgEKFLduNx3X@nanopsycho>
References: <20231009154907.169117-1-jiri@resnulli.us>
 <20231009182644.0f614c2f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009182644.0f614c2f@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 10, 2023 at 03:26:44AM CEST, kuba@kernel.org wrote:
>On Mon,  9 Oct 2023 17:49:07 +0200 Jiri Pirko wrote:
>>  Documentation/netlink/genetlink-legacy.yaml | 8 ++++----
>>  Documentation/netlink/genetlink.yaml        | 4 ----
>
>You missed genetlink-c

Ah, will fix.

>-- 
>pw-bot: cr

