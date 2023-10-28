Return-Path: <netdev+bounces-44970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 159A77DA5CE
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 10:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422982822E6
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 08:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0668F4E;
	Sat, 28 Oct 2023 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EyoEZy+G"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0988F49
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 08:24:44 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A348ED
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 01:24:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so4755109a12.0
        for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 01:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698481480; x=1699086280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bkFshng92MVsu3H8XxKlEoY3lCYrKhteF06/VM9f0Kg=;
        b=EyoEZy+G0/5Ogy0nRrUzqnmdazirSEihuBtYrfxNFkLYoTwMD8kLVbWnlDkPZzGWqA
         pryz9gaeQEsV6Ag34GqmqqdeUFSg7T8ePyuzsdLnyzUQ/TiBtL2LRFn+0GQNjsiDQXM0
         vptLFWDiP34fCRRg9RUHYp4XDi3A9bhYWwMozQTvrQ153GaqWgHsfa1Wxkt3VANgScXJ
         Qln0GfVFjvB3XFUGFviYdLFKajasPbpEop+c0937r0mv3CC47R1IAYAns3xTjFvjxEIO
         VXo2YqH3/TxFjzYGR5oaJHMXZTrFrHAW/Isjoxjx0H477ghUKwF3O6aHQlYWR/GEhJyP
         P/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698481480; x=1699086280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkFshng92MVsu3H8XxKlEoY3lCYrKhteF06/VM9f0Kg=;
        b=rD7x/MwR/olOfmu3KS6h8M/z3JFYLJJALV0wXL4Lrv/tJvC720O3G0DID1iWdDHKWL
         6uRjr5iCKX6vXv+mHh5k99R49nuVyHUT9wSYMkUwKFwPWSQl8h26LMiKavC2Ls44oxeK
         l6mn1OIPj0a7uuIrRSKdEbM4BXb5VTpfFD6MVxaxB7O4oCGh+JyxJ1AFw8qmoWg5MRn/
         f53HgUsW+Dc8H+skqQV/ULFcO5/N9z6+WN4QNoImMQIL+pioXSdH2IR/anCBQu0SWgxc
         ja7oQWqjgv/HrN7Fo/zTL2TlYRAXTRttBpGQdrVszoW6qo1EA27oQvMCQCb2cyoNf4Bm
         ndHw==
X-Gm-Message-State: AOJu0YzTe3GlpPh2IM5v8Aj0lNPUPyVcVB7rw0UwRFPZii9sX3l3qt+O
	cdO5b/kmcJ6RdAcZY7St2FJ1Fw==
X-Google-Smtp-Source: AGHT+IGPLMph/6iANab0gSEtv1tEqWd51HLLRzRPsSt7JmQmBxiaWUoua/3NXFwaIGoxDtbU3l4rKA==
X-Received: by 2002:a17:907:c293:b0:9be:d55a:81ba with SMTP id tk19-20020a170907c29300b009bed55a81bamr4094343ejc.65.1698481479747;
        Sat, 28 Oct 2023 01:24:39 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id a13-20020a170906190d00b009ae3d711fd9sm2417681eje.69.2023.10.28.01.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 01:24:39 -0700 (PDT)
Date: Sat, 28 Oct 2023 10:24:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com
Subject: Re: [patch net-next v4] tools: ynl: introduce option to process
 unknown attributes or types
Message-ID: <ZTzFRZbRJhLbtE97@nanopsycho>
References: <20231027092525.956172-1-jiri@resnulli.us>
 <20231027145419.6722f416@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027145419.6722f416@kernel.org>

Fri, Oct 27, 2023 at 11:54:19PM CEST, kuba@kernel.org wrote:
>On Fri, 27 Oct 2023 11:25:25 +0200 Jiri Pirko wrote:
>> - changed unknown attr key to f"UnknownAttr({attr.type})"
>
>Not what I wanted but okay. Let's move on.. :)

Feel free to patch the way you wanted. But I don't see any nicer way
now. What you suggest with the class does not make sense to me.

