Return-Path: <netdev+bounces-45236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA36E7DBA53
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 14:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1500F1C209CB
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 13:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515A815EB2;
	Mon, 30 Oct 2023 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="1WpNljdf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E433239
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 13:12:33 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC83C4
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 06:12:32 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c4fdf94666so58249511fa.2
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698671550; x=1699276350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BCgzPLdh5Zbi3HFUCrtnL+eU3rwEEkUPSInjtoIMgtc=;
        b=1WpNljdfZVmFtMlZYruDuRcYUhjJ9MD+VR7VrOdyJtNS9apbbAO49RlahxGlVKcjAD
         D0uRxI+JAR9zqN2Z7Fap8EwOCCnunt5n30tpnq7/UUcwE8dnAycjMY6cK+I/lAo5UQDd
         XEMZdkx6CNRdsfMnzmz9hBZ0xCAW74KqUvvELi7gxed90p6YwFjSiJQicSqTHkvJ5B42
         F7sr+X3G8ieuPdejA13b3p/cTGhrJsU3n9uPZfC33KleeFbHc2f3EArQ2Ob/4gEB7Rhy
         prlIVoviqE2KVq6avTm+OWL6A4aydMO+2OrqujmbPsaQkdpD7VKTSLi8Fb71+VjwYZnB
         f8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698671550; x=1699276350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BCgzPLdh5Zbi3HFUCrtnL+eU3rwEEkUPSInjtoIMgtc=;
        b=ZIQRN96jG+6b1OipfvOOcOYTf3Eea7gKxjqGxDmwSANNMik24O8zhD9qqg5/tka2Nx
         MQqOlxW4QYONkzaUNAAFdOb7HRKdHA0/rxexhw1NuxBlJq5SKCoRAgq0cR5FylQp7GGN
         aKUt0oDP0Fi50rnncuJJ3KHDZPVRtoIL+0HNCJ1hw9NfKhiddNov4zE/4KuGIEVOBgjo
         M0ke1TV3KRKVAL811j6mkDdL/581Nw4nwo/kd38MR9b6Bpj6sEsrGxwPF2i0Zn4IujxV
         m2TgWPe9CeVPsSiEzPILye5YbRAUHR+yo1Ap9OSGWD6CUTRmOVN+kpwc1qLnfifsxVx+
         ioAw==
X-Gm-Message-State: AOJu0YzX2T7HZ3O0XyN5bpbU1ln7A5y5FJvXgTRTwSrBsTGF3E++sn6y
	6pCqv3QfDlxbVo/wDvcEQ5KTYg==
X-Google-Smtp-Source: AGHT+IGKlfCKy/4QIKk3P+v1ZYLfujM9kkcdY93OtQsT2LLTfOcExVPaFyyeTw1T+Zsbxl0ZP6h2bg==
X-Received: by 2002:a2e:a781:0:b0:2b6:de52:357 with SMTP id c1-20020a2ea781000000b002b6de520357mr8042231ljf.40.1698671550112;
        Mon, 30 Oct 2023 06:12:30 -0700 (PDT)
Received: from [192.168.0.106] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id ha7-20020a05600c860700b004053a6b8c41sm9095805wmb.12.2023.10.30.06.12.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 06:12:29 -0700 (PDT)
Message-ID: <1de34b92-e6fc-4c73-0995-b7400f2ecef1@blackwall.org>
Date: Mon, 30 Oct 2023 15:12:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC Draft PATCHv2 net-next] Doc: update bridge doc
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20231027071842.2705262-1-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231027071842.2705262-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/23 10:18, Hangbin Liu wrote:
> The current bridge kernel doc is too old. It only pointed to the
> linuxfoundation wiki page which lacks of the new features.
> 
> Here let's start the new bridge document and put all the bridge info
> so new developers and users could catch up the last bridge status soon.
> 
> In this patch, I copied and modifed most of the bridge description from iproute2.
> But the Bridge internals part is incomplete as there are too much
> attributes while I'm not very familiar. So I only added 2 identifiers as
> example. Some part of the documents are generated by ChatGPT as I'm not
> good at summarizing.
> 
> As a draft patch, please tell me what other part I need to add or
> update. Thanks!
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> v2: Drop the python tool that generate iproute man page from kernel doc
> ---
>   Documentation/networking/bridge.rst | 205 ++++++++++++-
>   include/uapi/linux/if_bridge.h      |  24 ++
>   include/uapi/linux/if_link.h        | 454 ++++++++++++++++++++++++++++
>   net/bridge/br_sysfs_br.c            |  94 ++++++
>   4 files changed, 767 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst

Thank you for working on this, I'll be able to review it in a few days.
Sorry about the delay.

Thanks,
  Nik



