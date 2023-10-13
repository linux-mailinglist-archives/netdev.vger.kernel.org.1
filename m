Return-Path: <netdev+bounces-40621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B837C7EED
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 09:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF6FF1C20A73
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF718101F0;
	Fri, 13 Oct 2023 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="p4vyWKL1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148AF101EF
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 07:49:20 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1556583
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 00:49:18 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b6559cbd74so311237466b.1
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 00:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697183356; x=1697788156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vEo3aJUGn6l90tX8MvscUVUbtsuLRzrV2Jn02J62UEc=;
        b=p4vyWKL1EE3F8QXk49ZTxHrOzOYCV0R+0pQaYjOh7Xl9r4rMjBIf0j1JV8wZvK2h3y
         flulAcKUdz7lmjMi4G6O1MTfSxFdPEJOjSkUuy91TeHT8ISCA3R9NihJ+E0FinRGiTEG
         25Nej1EjrOzB2Tek0JJNrNutSYa3ajU7jcXEZe2KzaGfpOJGY6N0s7s1fHpp0TwXVja7
         1Uq1fmxpBw6T00HDvr6UGIashNBMDu2FmiaG09nLobfqmk/KSbwD3QwVCFUJU8Hk5hIs
         qLBzLV63P/LiSDXzAEjyK2vfzKKabKzTz4nkC9IPLwPvSOR27JHQpU2a2fBgM7IPpNdN
         nUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697183356; x=1697788156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEo3aJUGn6l90tX8MvscUVUbtsuLRzrV2Jn02J62UEc=;
        b=adfbCnmYQuvZowaJhderieWonAO3k1N4vTZnolUuU3JGf32GSWqr6y80ltnbeXbwcz
         BMKrl1wfOiSoCTgppYMPDKyXnRXbdA7llixPlG2NvB/rjdXZRs2Kvs2yJAcfzQPnbiIR
         wfpfw69EbTR20XwXm16VInXWAq0bA6l9NpoTplkcZLomtsmSnAK5m66LDSRO+Ij6f6Ks
         LpapjLD677eLs+EV7O2hRfXV/SRzU0J18tUwTJufX71cSMl0QXdtgepaFtCMlQo4peHZ
         Zr+AmByUI4O258nfXk369knTJXFYvISQzvvhnanI38QsxRWAUqJtniOwIO8oOVK4yPtb
         DvKw==
X-Gm-Message-State: AOJu0YyjAhjKeXzQrPZKQYFfBwij2g2IScCwDfy8pkW8cf9jcJxDqBK8
	Jbfp5WO1UINGFQ2iA9N+Nur8eA==
X-Google-Smtp-Source: AGHT+IGkUcYgjgawQ1WjEwGtx1aaj5N1IRQt9ehTQ5OO/VvgRc+Ozm6uRMgskNt2IDuyi7kCIhv7/Q==
X-Received: by 2002:a17:907:b12:b0:9ba:246c:1fa9 with SMTP id h18-20020a1709070b1200b009ba246c1fa9mr10113118ejl.10.1697183356361;
        Fri, 13 Oct 2023 00:49:16 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id gq7-20020a170906e24700b009adc5802d08sm12074059ejb.190.2023.10.13.00.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 00:49:15 -0700 (PDT)
Date: Fri, 13 Oct 2023 09:49:13 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com
Subject: Re: [patch net-next] tools: ynl: introduce option to ignore unknown
 attributes or types
Message-ID: <ZSj2eW079Zj/0O7z@nanopsycho>
References: <20231012140438.306857-1-jiri@resnulli.us>
 <20231012073223.2210c517@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012073223.2210c517@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Oct 12, 2023 at 04:32:23PM CEST, kuba@kernel.org wrote:
>On Thu, 12 Oct 2023 16:04:38 +0200 Jiri Pirko wrote:
>> $ sudo ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/devlink.yaml --do trap-get --json '{"bus-name": "netdevsim", "dev-name": "netdevsim1", "trap-name": "source_mac_is_multicast"}' --ignore-unknown
>> {'bus-name': 'netdevsim',
>>  'dev-name': 'netdevsim1',
>>  'trap-action': 'drop',
>>  'trap-group-name': 'l2_drops',
>>  'trap-name': 'source_mac_is_multicast'}
>
>Wouldn't it be better to put the unknown attr in as raw binary?
>We can key it by attribute type (integer) and put the NlAttr object
>in as the value.
>
>That way at least the user still sees that the unknown attrs are
>present.

Okay, will check that out.

