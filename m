Return-Path: <netdev+bounces-38638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7B67BBD13
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 18:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BED281994
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077AB262A1;
	Fri,  6 Oct 2023 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq6iAUV3"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77CA28E03
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 16:42:32 +0000 (UTC)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519A310E5
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 09:42:08 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-7ae19da7b79so938979241.2
        for <netdev@vger.kernel.org>; Fri, 06 Oct 2023 09:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696610527; x=1697215327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7fLMnqL2G3VingLYxATjYUEpnWfC+K5xF5x8ar3oyI=;
        b=aq6iAUV3sK9U9Bzj1Un7WLEKrd6wwceecF+JTKUEaQ0OyisLJ/IwvoB9naOmgIoZeG
         dZe4T2+fLBg38dtGGnQzedgMozRWdZ0WNX8fR1mav7CQpED7dotc5JGfQ92NxW0wEjMF
         uNStdk1wt2g8Oi7P1THZn1ifgLDEcKYy6RC5MW/bX1hhlCZWxbBUavF9EC6XObHbdWsx
         +Cu6LdeVpO7l1LiuVngLtvFmrJhaXN9Dl3wcCpTU+wWhkQsi5GRUKCT9hAv9e7zKHi3a
         isFLdTCd6lryG0a9H2MB2XwtZ3zcx3vii0Elg9cojf1eV6ehhZ0HaQIg8mRzWr9EUuSh
         fMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696610527; x=1697215327;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7fLMnqL2G3VingLYxATjYUEpnWfC+K5xF5x8ar3oyI=;
        b=fn2Og/i0DaCwURuwL9qpAsD2SBJkm/risZiDzQvBHvcFcKGqis6770dAu0m9pUufu9
         um/n3VkpIL3n+w1kpSC6Uf1RVk+RLtKq04gSs0gqmQGHR86XtPLnC4MrxBqZ7VYlbLCe
         sHA3i4XVJOtFIiN5Q4JKmNzRwZ9KDCoAJzM7OPGIGF0/+sTRIelFUXhP+BuManZd1VL4
         KxtXRhmGMm911bJTG/7wPyM8AllClQ5GhSy5/05GTa6FGsSFJZvjqNgJsVPIaXDY8omn
         8AhifmB9TRLp2mQbMTimq5ddCDlyHdIZQ/Ajtajh6ucxximB+1klCS6Q3LFpmfYoSADc
         1oSw==
X-Gm-Message-State: AOJu0YyZLr79AmNglca8AlZRRuUmSp7HHVDU+8bm7aX7XP03htSCnf6b
	xnP5+oNrHkZPR3yVKbNSTDk=
X-Google-Smtp-Source: AGHT+IHycAY1/QmneOzg1FGb3DR/zSPkFy6zkqyMGozsR7XBsM5R8X5ywadFX43/HQ7RQ/pdrPdJNA==
X-Received: by 2002:a67:f6c1:0:b0:452:635e:2710 with SMTP id v1-20020a67f6c1000000b00452635e2710mr9044729vso.0.1696610526838;
        Fri, 06 Oct 2023 09:42:06 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id kb4-20020a05622a448400b00415268abe26sm1400029qtb.8.2023.10.06.09.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 09:42:06 -0700 (PDT)
Message-ID: <37df3fd6-1ae4-4251-b27f-4e32298c0da8@gmail.com>
Date: Fri, 6 Oct 2023 09:42:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] docs: netdev: encourage reviewers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew@lunn.ch, jesse.brandeburg@intel.com, sd@queasysnail.net,
 horms@verge.net.au
References: <20231006163007.3383971-1-kuba@kernel.org>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231006163007.3383971-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/6/23 09:30, Jakub Kicinski wrote:
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

LGTM with the typo that Edward spotted, thanks!
-- 
Florian


