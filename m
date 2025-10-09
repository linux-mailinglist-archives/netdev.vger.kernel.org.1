Return-Path: <netdev+bounces-228371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9190BBC917D
	for <lists+netdev@lfdr.de>; Thu, 09 Oct 2025 14:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE6BE189EB12
	for <lists+netdev@lfdr.de>; Thu,  9 Oct 2025 12:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45FB2E6CB3;
	Thu,  9 Oct 2025 12:42:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B832E62B5
	for <netdev@vger.kernel.org>; Thu,  9 Oct 2025 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013776; cv=none; b=QpXhnMLYJowl0BPonl33enPC5ck1uPlSuaOB6xzTqakFfvwZSOvfUR2/XD14iA7ga3CKWbLpT3qrN9+HjMytIXfR2hz5bX5YyZXnkjgNrFX3MaTlYIHqAVzc/Mn6X1l50Y7FfKWrwYaT6++yzLS6JOxw2EDWCxkekCqZM3Ijp/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013776; c=relaxed/simple;
	bh=WmpQBY6TbZ5ansusUYRaOEUZ7KkH3epNLcYEh/JQ11A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sRIRaUXL+BrXrH2TndEdU9a8f9gmLGkJWfd+94KkHU+QdrM7D6ErVgbkeg+cR+CSC7Bs8+wxVMCCjFmRI1Ts5a4g8l+mZjbfKnE1eR/sN6YdMtO0PARp+/EZQTHnyG8KoA3OGPbXj7xlEDtOboyiDSn/hBW0RU3G2cXe7gphYgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b472842981fso112425166b.1
        for <netdev@vger.kernel.org>; Thu, 09 Oct 2025 05:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760013773; x=1760618573;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DyrRfyeyAKkW55cTD8t/TpjrjYwQIMXKnAOmH4iGp1U=;
        b=viZbkDZu6z0QJAx7WJOsj1B2xVeYh/3GY4OXDe91SBvFs8oUeRpEh0ccywyNM+KrH8
         M1HhzbE3eqUvdVWa6cXdfvJZ/HiOQbhbm99wm/sruWUdvEVoCcvkRuuAXVwcEpm7F544
         Uwj8nj0QNohyl9ypwvAqwGU2styzGm3vnmGTKPHUBg18viNkIp6FYnDc0nZ1xTpAVeo9
         kkEdXeYbyixK9jnQUHGEOOcUlB1h62mh+5pj79gGSjK8AamUIXxg66x+fTyEWD5gAvpw
         0j+DO8gEIaBapQnapgBUEhl4ohYyzRb+jRywX1UO7PaEr+A6X6bgq3ewHOGbO/Cq9lxI
         ozdQ==
X-Gm-Message-State: AOJu0Yw2IaP5InTmaZHI9eh8zhVA1Nvv300TRqbSDL8HrHBSqPyqbpK8
	BrbP6jUmpIk1/BUa3ffYhuawqFODrKKFBDYxkvfNF85Rzqyq5/ODvYfj
X-Gm-Gg: ASbGncueDrJYUDh3b7jPv5NxAW263F8RgH3MSJboDpKxnP2Qaz7N4WIc+bza1QaUdGj
	z2R4Mf4YNGeQPjKHmO+YRIxvy5nGERl2jPK+dQDNrY5ObppdOhHZtDMSVkJkBMJ6Rz7yk31nFkD
	URO4gNww4b73vffUlE9j7u2Xa/4TbEynKloWUB7u5oM4VOlWpT+IvF20cTiO1PmHhiLlj5OJJJO
	NLIyNIDsWnYkdm5rSULtrxtVUDRHnXk0U1bNwa6VkxSg1vv+6VS6LA5NE7mNBim4eW/CqR1FMF3
	eBKkGm9TVaU+/SYRXHf0d+CC/BsouzgkAn9WmKu+wdDY7nkzmXRJK8Hr3j0MBXPkwzmvEyriiLD
	BV1dBWDl93tQCdJ4wztkll10ffrEmB0VBfbhyJErWeQ==
X-Google-Smtp-Source: AGHT+IFuKfX7/ZZVmvCxT5q69r5K5958LNTBo4BJneTc+LU73F5QtYlXnUH99ORNGxM9LdOlBjnCZw==
X-Received: by 2002:a17:906:7313:b0:b40:8deb:9cbe with SMTP id a640c23a62f3a-b50aa793004mr810654666b.2.1760013772798;
        Thu, 09 Oct 2025 05:42:52 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55a8843fd6sm5490966b.74.2025.10.09.05.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 05:42:52 -0700 (PDT)
Date: Thu, 9 Oct 2025 05:42:50 -0700
From: Breno Leitao <leitao@debian.org>
To: saeedm@nvidia.com, itayavr@nvidia.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dcostantino@meta.com, kuba@kernel.org
Subject: mlx5: CX7: fw_tracer: crash at mlx5_tracer_print_trace()
Message-ID: <hanz6rzrb2bqbplryjrakvkbmv4y5jlmtthnvi3thg5slqvelp@t3s3erottr6s>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I am seeing a crash in some production host in function
mlx5_tracer_print_trace() that sprintf a string (%s) pointing to value
that doesn't seem to be addressable. I am seeing this on 6.13, but,
looking at the upstream code, the function is the same.

Unfortunately I am not able to reproduce this on upstream kernel easily.
Host is running ConnectX-7.

Here is the quick stack of the problem:

	Unable to handle kernel paging request at virtual address 00000000213afe58

	#0  string_nocheck(buf=0xffff8002a11af909[vmap stack: 1315725 (kworker/u576:1) +0xf909], end=0xffff8002a11afae0[vmap stack: 1315725 (kworker/u576:1) +0xfae0], s=0x213afe59, len=0) (lib/vsprintf.c:646:12)
	#1  string(end=0xffff8002a11afae0[vmap stack: 1315725 (kworker/u576:1) +0xfae0], s=0x213afe58) (lib/vsprintf.c:728:9)
	#2  vsnprintf(buf=0xffff8002a11af8e0[vmap stack: 1315725 (kworker/u576:1) +0xf8e0], fmt=0xffff10006cd4950a, end=0xffff8002a11afae0[vmap stack: 1315725 (kworker/u576:1) +0xfae0], str=0xffff8002a11af909[vmap stack: 1315725 (kworker/u576:1) +0xf909], old_fmt=0xffff10006cd49508) (lib/vsprintf.c:2848:10)
	#3  snprintf (lib/vsprintf.c:2983:6)

Looking further, I found this code:

        snprintf(tmp, sizeof(tmp), str_frmt->string,
                 str_frmt->params[0],
                 str_frmt->params[1],
                 str_frmt->params[2],
                 str_frmt->params[3],
                 str_frmt->params[4],
                 str_frmt->params[5],
                 str_frmt->params[6]);


and the str_frmt has the following content:

	*(struct tracer_string_format *)0xffff100026547260 = {
	.string = (char *)0xffff10006cd494df = "PCA 9655E init, failed to verify command %s, failed %d",
	.params = (int [7]){ 557514328, 3 },
	.num_of_params = (int)2,
	.last_param_num = (int)2,
	.event_id = (u8)3,
	.tmsn = (u32)5201,
	.hlist = (struct hlist_node){
		.next = (struct hlist_node *)0xffff0009f63ce078,
		.pprev = (struct hlist_node **)0xffff0004123ec8d8,
	},
	.list = (struct list_head){
		.next = (struct list_head *)0xdead000000000100,
		.prev = (struct list_head *)0xdead000000000122,
	},
	.timestamp = (u32)22,
	.lost = (bool)0,
	}


My understanding that we are printf %s with params[0], which is 557514328 (aka
0x213afe58). So, sprintf is trying to access the content of 0x213afe58, which
is invalid, and crash.

Is this a known issue?

Thanks
--breno

