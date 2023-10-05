Return-Path: <netdev+bounces-38188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E4F7B9B5B
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 09:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B5A732813B6
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 07:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6004933FE;
	Thu,  5 Oct 2023 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="NjUMWPZL"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B5F7F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 07:26:00 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D097AA6
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 00:25:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9a645e54806so118495266b.0
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 00:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696490757; x=1697095557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtN0im4D7gpLTF/HWTRaQvPFV67NzB2x4wio4/NNMOs=;
        b=NjUMWPZLRh/TC8TwMavyDBwjOksaYV+tjXaAzYj+NLXSO5Md4yTlialyzEoGg2+J0O
         wW5bKk8ebH8mAxJQ8oLSxht0+YGnpdp7laStwdDeNkxW77+D8Nk2GHMAnbM9hKunMUQK
         /4LLC1MIaH0Gix0jxM8V0gChS2Ac11uVTSsnPvQ6wsWnzip8KYikIMcjfg+mIT+GXBTy
         MQHvpicZUi6SRy7EC6MDFEtd1TOZo/YVK/UL4YJ2aAf46ewjWCpZo+nj/7Wd13fMpd/k
         T0rXpCsog1JcrEsY2ePZNVYXfzU/pim5wkkRlr73uxD2HHQX2wO1wlDStrNLxhxFh//I
         Soig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696490757; x=1697095557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtN0im4D7gpLTF/HWTRaQvPFV67NzB2x4wio4/NNMOs=;
        b=j8f8RbwpbXy3W/Ajf+mAZ2POzI82XfXpzlHd1E7v2WMB6WiEtS2uvtyqeb3fF2ryJu
         tbOTlFCON35hOnKFtS1g1Tg0kS7oBzyC4XdfAz5FzDkJpnXLUuB66wonpiVwJarRrOoB
         3KobrvLuZdtndWZlWSZ5Q2RSSxUNDo4F7AqNBXCWYkhVLiDnBBO1GQZp+Kt8JGbUKA7M
         bQqI+wGeJe5IqZ0vDUc0C2pJ1i/lA4mGqKPWikP3RiARbejo2wAO+9Fk9wXrocz9Am2E
         RrbqnNfoqWYcaCtatVhHq2TlN24xS/0RvILPL3Fw0HEZ13gm/dpwI+15EviMS3SxUsub
         D9Dg==
X-Gm-Message-State: AOJu0YxbJxdXBIZ2li+Wz/xJf/FhC3dCtxlaLI6Qy4B7eZkwArbsz9L4
	L+7VnfSGwekIsfvC1pXWDX5n5Q==
X-Google-Smtp-Source: AGHT+IG7IngGqdjtz9E4ZqCaT6njSsPeiLhVPD3lunzy8aB84eyrIKFvSIZznZrqYd5/FUTUsgLxVQ==
X-Received: by 2002:a17:906:76cf:b0:9b2:a7e5:c47 with SMTP id q15-20020a17090676cf00b009b2a7e50c47mr4151554ejn.9.1696490756591;
        Thu, 05 Oct 2023 00:25:56 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id x6-20020a170906b08600b009a19701e7b5sm682302ejy.96.2023.10.05.00.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 00:25:56 -0700 (PDT)
Date: Thu, 5 Oct 2023 09:25:55 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, donald.hunter@gmail.com
Subject: Re: [patch net-next v2 3/3] tools: ynl-gen: raise exception when
 subset attribute contains more than "name" key
Message-ID: <ZR5lA7SwQr3ecUp9@nanopsycho>
References: <20230929134742.1292632-1-jiri@resnulli.us>
 <20230929134742.1292632-4-jiri@resnulli.us>
 <20231004171350.1f59cd1d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004171350.1f59cd1d@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Oct 05, 2023 at 02:13:50AM CEST, kuba@kernel.org wrote:
>On Fri, 29 Sep 2023 15:47:42 +0200 Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> The only key used in the elem dictionary is "name" to lookup the real
>> attribute of a set. Raise exception in case there are other keys
>> present.
>
>Mm, there are definitely other things that can be set. I'm not fully

Which ones? The name is used, the rest is ignored in the existing code.
I just make this obvious to the user. If future show other keys are
needed here, the patch adding that would just adjust the exception
condition. Do you see any problem in that?


>sold that type can't change but even if - checks can easily be adjusted
>or nested-attributes, based on the parsing path.

