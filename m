Return-Path: <netdev+bounces-42636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EB37CFA86
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A36281FB3
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0448F225D8;
	Thu, 19 Oct 2023 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="w/A1F/E1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97C9225D6
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 13:12:34 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F2FF7
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 06:12:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32d8c2c6dfdso7087635f8f.1
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1697721152; x=1698325952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v1QQy/TzuYABfNuKOiHX44LqVgl9CKlKEp054v57jP8=;
        b=w/A1F/E1M5ZzFJVzk3pYMPOVDhfaYYwwuUhefsP+TBxCapTghjPfUFZlgLbC3iqLQf
         UtW2DOLeACHW7vuTN1KJSnG8goGgnrNXwxbrilsuEU3GpJs8FKa3o2e9B61D47kJHh0w
         HjTV3W93cD6SOaxNAq/D/3aY3zreEHvXaY0kyXXc3u3OquvnGqeyb/V49w/2YoiA09XK
         d/zKGSbAz/6UtovCbxz+3izNGQMUHOn64qwISrEMxlz+LBvXfbhOGfCK6ysklKaapqjv
         MmCc6U4GWC7ttH5PBbZxVBJvne/IpEOEcRfJgydkI4s4F1UFVlt4prW+X2vJv5Qkwam5
         86Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697721152; x=1698325952;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1QQy/TzuYABfNuKOiHX44LqVgl9CKlKEp054v57jP8=;
        b=au3dhSdFMwGude2AJ8qxcL87N8DBksHtUu/v/2obUdAj75MeMUQcgLPXNK9UbBLYLl
         7hxI/97fRabB5rAsBmVWjg8TSk31aw7ofh20Qfk/AmHXIz/eqEImJhtEzRZx2bQtdebY
         bAhA4yyKmjdJSGCOi1nV2qq6mx8FxLR0WpFK9nEso9pCzOfbbUcBa07MiCwlXrjUruPY
         HQdlU193KFGnijavtuZeoENHGgR5wxsfOT0SpK9RgtKSw4NiQ5r6Vj81vQLWTp5YOEq6
         4eBE9UIOBDCrXpm/RuXCfHAIl3hXe0gTGSLSNM6JG02OEt08zl9ueI4KDqmBJ6gDAGqr
         Fm4A==
X-Gm-Message-State: AOJu0YxVuCyecILmpG/pcWqf0R0aJy91YUpQuQlmuUf3hUCJwLYMwH8z
	Zv/IerQHnVmomHSVM+LwjRH5Lw==
X-Google-Smtp-Source: AGHT+IFexvu64+meSkENrUA+zLK1LPB2h7F55aVILI31rqt8hwPhK57eKqM4fL7YoWVbrjtBB7nRvQ==
X-Received: by 2002:a05:6000:1112:b0:32d:8958:c570 with SMTP id z18-20020a056000111200b0032d8958c570mr1674797wrw.29.1697721151677;
        Thu, 19 Oct 2023 06:12:31 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id d15-20020adfef8f000000b003231ca246b6sm4472800wro.95.2023.10.19.06.12.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 06:12:31 -0700 (PDT)
Message-ID: <632c55ba-9adb-8afb-3558-94ea5f0168f8@blackwall.org>
Date: Thu, 19 Oct 2023 16:12:29 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH iproute2-next v5] iplink: bridge: Add support for bridge
 FDB learning limits
Content-Language: en-US
To: Johannes Nixdorf <jnixdorf-oss@avm.de>, David Ahern <dsahern@gmail.com>,
 Roopa Prabhu <roopa@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20231018-fdb_limit-v5-1-7ca3b3eb7c1f@avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231018-fdb_limit-v5-1-7ca3b3eb7c1f@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/18/23 10:04, Johannes Nixdorf wrote:
> Support setting the FDB limit through ip link. The arguments is:
>   - fdb_max_learned: A 32-bit unsigned integer specifying the maximum
>                      number of learned FDB entries, with 0 disabling
>                      the limit.
> 
> Also support reading back the current number of learned FDB entries in
> the bridge by this count. The returned value's name is:
>   - fdb_n_learned: A 32-bit unsigned integer specifying the current number
>                    of learned FDB entries.
> 
> Example:
> 
>   # ip -d -j -p link show br0
> [ {
> ...
>          "linkinfo": {
>              "info_kind": "bridge",
>              "info_data": {
> ...
>                  "fdb_n_learned": 2,
>                  "fdb_max_learned": 0,
> ...
>              }
>          },
> ...
>      } ]
>   # ip link set br0 type bridge fdb_max_learned 1024
>   # ip -d -j -p link show br0
> [ {
> ...
>          "linkinfo": {
>              "info_kind": "bridge",
>              "info_data": {
> ...
>                  "fdb_n_learned": 2,
>                  "fdb_max_learned": 1024,
> ...
>              }
>          },
> ...
>      } ]
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
> The corresponding kernel changes are in net-next.git as commit
> ddd1ad68826d ("net: bridge: Add netlink knobs for number / max learned
> FDB entries").
> ---
> Changes in v5:
>   - Removed the RFC status again, as the kernel changes landed.
>   - Link to v4: https://lore.kernel.org/r/20230919-fdb_limit-v4-1-b4d2dc4df30f@avm.de
> 
> Changes in v4:
>   - Removed _entries from the names. (from review)
>   - Removed the UAPI change, to be synced from linux separately by the
>     maintainer. (from review)
>     For local testing e.g. `make CCOPTS="-O2 -pipe
>     -I${path_to_dev_kernel_headers}"` works as a workaround.
>   - Downgraded to an RFC until the kernel changes land.
>   - Link to v3: https://lore.kernel.org/netdev/20230905-fdb_limit-v3-1-34bb124556d8@avm.de/
> 
> Changes in v3:
>   - Properly split the net-next and iproute2-next threads. (from review)
>   - Changed to *_n_* instead of *_cur_*. (from review)
>   - Use strcmp() instead of matches(). (from review)
>   - Made names in code and documentation consistent. (from review)
>   - Various documentation fixes. (from review)
>   - Link to v2: https://lore.kernel.org/netdev/20230619071444.14625-1-jnixdorf-oss@avm.de/
> 
> Changes in v2:
>   - Sent out the first corresponding iproute2 patches.
>   - Link to v1: https://lore.kernel.org/netdev/20230515085046.4457-1-jnixdorf-oss@avm.de/
> ---
>   ip/iplink_bridge.c    | 21 +++++++++++++++++++++
>   man/man8/ip-link.8.in | 10 ++++++++++
>   2 files changed, 31 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



