Return-Path: <netdev+bounces-36505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7CA7B00C7
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 11:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id F2F211C2083E
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 09:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDD424214;
	Wed, 27 Sep 2023 09:43:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A7F20B22
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 09:43:01 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8103C0
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 02:42:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4053c6f0e50so100944885e9.1
        for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 02:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695807778; x=1696412578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jTz0G114erb+zgxWJJJu8ke7KB3cZFh8aNZRWXOoo4Y=;
        b=HerZBvAcfr3XwkU3Wkp+myztVQLErbE7JYKsxiSuuJJEd8rQfZrnuJrAr+R6NIiRoC
         skj4EIhJHgXiQQ+dm8CMMRVUE7w93dbGeKWl6AUT37lmOwu7HWu4Nmy7x3bgec3uZkLz
         +2qjnN2fcxBoZDYJ+2Jxq7h6DQkWXexeIWPUNwA8CoHZj1fcjaLX6D1dfnUMYyPywQQU
         dBeMPM1PnaCkmYdMbcsllklqLEpy8wHNmk32rQGgfKYALWqpw3v+R9/bsokVaFSYQPMR
         UVOvwmXVNf35aLBwfvUG4H8HhWDvXpP7HcvVQmM9MVIoYZthxG5cRD4jzeGN/C5u1r0I
         WWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695807778; x=1696412578;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jTz0G114erb+zgxWJJJu8ke7KB3cZFh8aNZRWXOoo4Y=;
        b=O2aeR+M+CFNwQgyUXAAPzDeWtGqSBpGhEsDWqgWi8nARZtew9tuVWhAu/wZKFiBkhw
         kPkXvqrtzOOPTyoKG9YfLHlEwJ2SpXJvxEScyMyoQngO9FGuu/0EKVV49hqWYZG9npLU
         qhXEPjkHx2gbaIteNRV9zQIiaBS7KbVHxoTxagN/OBrGkbPNxqP4xR44MLuNrXvwH/hZ
         9nN0OiGbQhqBEVMA9Kocik6azdXi8XMvDxDTpdFzwwl/z+T0Wf3kFDKuZfGork6N1j5l
         5MktoC187pxIhL62nLnKfOTHqDSbjS93K7uVyBfcuOQw7bgnJl+P3/gsEoTD8kQ89jGr
         ukUw==
X-Gm-Message-State: AOJu0Yyb7FYa+nYU98mbQ9k+DwXlIbAbKMRmPsG6tevx05LX6LNNoGxb
	1g/QlkOjux1UM0CTo3olVE0=
X-Google-Smtp-Source: AGHT+IFn4ZBOp4RKT74Hg5qxa49Z0bguSdo8cmPa57d4aAjLkBpVSLnukdbSIBeJOh/yMuIR5EBzXw==
X-Received: by 2002:a05:600c:1e14:b0:406:44e6:15f0 with SMTP id ay20-20020a05600c1e1400b0040644e615f0mr1044093wmb.5.1695807777823;
        Wed, 27 Sep 2023 02:42:57 -0700 (PDT)
Received: from [192.168.5.75] (54-240-197-233.amazon.com. [54.240.197.233])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c230e00b00402f7b50517sm17441790wmo.40.2023.09.27.02.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 02:42:57 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <646b31b4-2fd6-4bff-ae6b-1b35626533c0@xen.org>
Date: Wed, 27 Sep 2023 10:42:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: paul@xen.org
Subject: Re: [PATCH] net/xen-netback: Break build if netback slots > max_skbs
 + 1
Content-Language: en-US
To: David Kahurani <k.kahurani@gmail.com>, xen-devel@lists.xenproject.org
Cc: netdev@vger.kernel.org, wei.liu@kernel.org
References: <20230927082918.197030-1-k.kahurani@gmail.com>
Organization: Xen Project
In-Reply-To: <20230927082918.197030-1-k.kahurani@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 27/09/2023 09:29, David Kahurani wrote:
> If XEN_NETBK_LEGACY_SLOTS_MAX and MAX_SKB_FRAGS have a difference of
> more than 1, with MAX_SKB_FRAGS being the lesser value, it opens up a
> path for null-dereference. It was also noted that some distributions
> were modifying upstream behaviour in that direction which necessitates
> this patch.
> 
> Signed-off-by: David Kahurani <k.kahurani@gmail.com>

Acked-by: Paul Durrant <paul@xen.org>


