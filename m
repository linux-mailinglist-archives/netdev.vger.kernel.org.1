Return-Path: <netdev+bounces-46233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 117447E2AB8
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 18:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 428721C20BDC
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 17:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F2329CEE;
	Mon,  6 Nov 2023 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aic7iPul"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40AD2F38
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 17:11:32 +0000 (UTC)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D8183
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 09:11:31 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7a6774da682so203771739f.3
        for <netdev@vger.kernel.org>; Mon, 06 Nov 2023 09:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699290691; x=1699895491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U0LYl7TPKQ+bVs/FZFQ7VJND4FNh7+P2HHWokpmCYfU=;
        b=Aic7iPul1lnxiFRlNd2/fWj7xQdxhxKqM3NMTE6G3nOLvq+9wQm2wwOI6wugqKvtO+
         FFh1eYVfZzwZEGn4P4DEsMIPLE98CyoKoW0BvScxAdyFg/i5YHRx3BCmD55nRJzs9FXJ
         EcS23pFrEiaHdAv9oohvMD2mz/JkPX7NfeUW1xD4JXE/4PXJbo+cVCGV+NMQy4YmsegA
         UFukGdbTECljjP44osAU7+x1CDK/H7HcQuMkuGGiSUhwAGNEi2WCCPqtg8xeLGA/FK7n
         WGlBstQjV8uXZuoB5ta7QL1GyqUP8LyCE1MLC7qWNpVp+AxFHzi4zV/QVhTejaOxTQRU
         YLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699290691; x=1699895491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0LYl7TPKQ+bVs/FZFQ7VJND4FNh7+P2HHWokpmCYfU=;
        b=WAwfUqt9842VPAnEH81D4XeCnG91DdgHoCzkJNvOLKU1sgHZRQAJffIe7jv0tU7TCd
         lsGlUOH83EY2/8wLcZ1xhRsvnW555okoOVFhqkZM3gqrDSuWqGpSoybi6ke/hNLpmtbD
         pwsBnrR0gFXh5RfCP0Cgtuxt74kNczwjvytVS5SEj0igBmQbpWLG83Rmb8FBEH+YXhTr
         JrVWi2eq5CroEk0PBbAeGO9v5gd+QLnG4TbbNjBeDQY0bqu+W4dU3C1wNGm9/k34j41b
         upywFDTkV0461IC2PCGTHt44Y5lZzTv0x/KgltwqnOzEOZnCNMz79/5Kf+w2w7290GQI
         1qTg==
X-Gm-Message-State: AOJu0Yw0AellezNhNIsROrBuGST9OaGhh8nJ6A0a8y722YL5dHPEjdTQ
	ysa10jE3I/OQLqhg4sGfUz4=
X-Google-Smtp-Source: AGHT+IHmiMQdg6j8pSnJuwmRX490jlfeaLlggiun3WXbRn0byiNYyKnV2DDzfQrZBHfKxlM4uOS1ZA==
X-Received: by 2002:a05:6e02:12e6:b0:359:3d9a:2837 with SMTP id l6-20020a056e0212e600b003593d9a2837mr279738iln.2.1699290690857;
        Mon, 06 Nov 2023 09:11:30 -0800 (PST)
Received: from ?IPV6:2601:282:1e82:2350:f8c4:a6a1:fdaf:9432? ([2601:282:1e82:2350:f8c4:a6a1:fdaf:9432])
        by smtp.googlemail.com with ESMTPSA id u7-20020a02aa87000000b0040908cbbc5asm2259181jai.68.2023.11.06.09.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 09:11:30 -0800 (PST)
Message-ID: <6a13b47a-c040-417b-a4e2-8796b72faf85@gmail.com>
Date: Mon, 6 Nov 2023 10:11:29 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch net-next v4 1/7] ip/ipnetns: move internals of
 get_netnsid_from_name() into namespace.c
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org, daniel.machon@microchip.com
References: <20231027101403.958745-1-jiri@resnulli.us>
 <20231027101403.958745-2-jiri@resnulli.us>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20231027101403.958745-2-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/27/23 4:13 AM, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> In order to be able to reuse get_netnsid_from_name() function outside of
> ip code, move the internals to lib/namespace.c to a new function called
> netns_id_from_name().
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v3->v4:
> - removed namespace.h include
> v2->v3:
> - s/netns_netnsid_from_name/netns_id_from_name/
> v1->v2:
> - new patch
> ---
>  include/namespace.h |  2 ++
>  ip/ipnetns.c        | 45 +----------------------------------------
>  lib/namespace.c     | 49 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+), 44 deletions(-)
> 


dcb
    CC       dcb.o
In file included from dcb.c:11:
../include/namespace.h:61:31: warning: ‘struct rtnl_handle’ declared
inside parameter list will not be visible outside of this definition or
declaration
   61 | int netns_id_from_name(struct rtnl_handle *rtnl, const char *name);
      |                               ^~~~~~~~~~~

--
pw-bot: cr

