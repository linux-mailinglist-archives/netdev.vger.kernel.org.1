Return-Path: <netdev+bounces-38637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B1C7BBCE3
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 18:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E191A1C209BE
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2401D1A58E;
	Fri,  6 Oct 2023 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NovB3Fuy"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10281846
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 16:38:27 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EB5AD
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 09:38:25 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4060b623e64so14902485e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 09:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696610304; x=1697215104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7dWGSS3YOrcsvfE31ne7UgGiti282vWu0wuljkGr9n4=;
        b=NovB3Fuyl8NLN0wwOKzZgjEKmXF3HDXE4HVPKQy/s63Gx7PXUrg+YDbJWKjt5rujZ8
         gCTHWQhHjelAcICjo/Q+1FFzC8wGnsixWjU/FVUYCg7CA8JOmf3DRxmZEDcgKo9HB4Dj
         bDPBIRSISJF4X+qpSvDLtvat1/1i60znG0CK/uS/lY8FFn/z46kd+TE8NUIiiS9Wp9m8
         34YuG52733nQrXzwhoYwHuurvpNUbNufKvg5RlJ5yzhKWe8ZeiyCtqtf1YcwhCeSqSIP
         9Ou7R0OfqI+/PjlX3eslxVCnw1+BRDQRGMRf5V5lx6XFmQgdIdm4PeGYaKpzlBYA89Z3
         mZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696610304; x=1697215104;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7dWGSS3YOrcsvfE31ne7UgGiti282vWu0wuljkGr9n4=;
        b=GkJzYQXTqhfFtZmhLrD0pzkXA+q6fc8B2yl548muruty28r3Ad7qXXDV5yN8JPkAsc
         z8RshB3iIqyaXbnBxBTUtq/4XbskPC5blmQeskSyKy6msrEPFOHtaUFHzeq54HiqL3nY
         7GeyKrbN9PvLE5Dq+nQBZ+C4fZQy0AkUh9jx1dDKBKmrSErBhujusu8YFMaHOWjYshDn
         ugji3Gd/3EXZCE4JqK52CdlAgfuHNI4lJrhNlMBg8KxzdfBn7c+A+CWvBSCCXkjRLKZ/
         05iLuYZncdhOVIgNI6pGa8fy/S7D/P3V91kuCvyUiDUN23cdcKSNhLhoXefi6uYXnViU
         DdBQ==
X-Gm-Message-State: AOJu0Yyti83odPgCZufFsvpWSkWM414HGoeLMFvtKbc5G9IDDjW7AXa7
	pCxy37wYGUR1RV2G1EYut3k=
X-Google-Smtp-Source: AGHT+IHtbEc+QIkRxAbCwc9TY9f1d3wwkO7FQVls5eDQewnUGLia8nas2gnOAqPbmytf58a2OzrJ5Q==
X-Received: by 2002:a7b:cd06:0:b0:406:80ac:3291 with SMTP id f6-20020a7bcd06000000b0040680ac3291mr5134665wmj.13.1696610303677;
        Fri, 06 Oct 2023 09:38:23 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c230b00b004053a6b8c41sm4071788wmo.12.2023.10.06.09.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 09:38:23 -0700 (PDT)
Subject: Re: [RFC] docs: netdev: encourage reviewers
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew@lunn.ch, jesse.brandeburg@intel.com, sd@queasysnail.net,
 horms@verge.net.au
References: <20231006163007.3383971-1-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <e3bff9c3-4b0f-c176-4053-9ef7e800b111@gmail.com>
Date: Fri, 6 Oct 2023 17:38:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231006163007.3383971-1-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 06/10/2023 17:30, Jakub Kicinski wrote:
> Add a section to our maintainer doc encouraging reviewers
> to chime in on the mailing list.
> 
> The questions about "when is it okay to share feedback"
> keep coming up (most recently at netconf) and the answer
> is "pretty much always".
> 
> The contents are partially based on a doc we wrote earlier
> and shared with the vendors (for the "driver review rotation").
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[...]
> +Last but not least patch review may become a negative process, focused
> +on pointing out problems. Please throw in a complement once in a while,
> +particularly for newbies!

sp: compliment.

Otherwise looks good.
-ed

