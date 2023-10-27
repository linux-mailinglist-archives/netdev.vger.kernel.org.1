Return-Path: <netdev+bounces-44689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C19FC7D93AF
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 11:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC5FB20B87
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 09:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F8715AD7;
	Fri, 27 Oct 2023 09:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ikRrhRpw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6F915AC4
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 09:30:38 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CB6AF
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 02:30:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99357737980so291198266b.2
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 02:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698399036; x=1699003836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+R3d9PrexLe3gHqXe8BjIbJjsmG22nyj6pAcb2QmK0=;
        b=ikRrhRpwiTPfrXoR1Xj82qw70SkQlYUID5WijpvfRzraRP6m3zh2ZPgo3gFALChhcd
         vc/WLigmNMWW/6poS+vBjbAgIPvQj6z83y+DkZu8AbKCCXcCO/HNPwYPG2pqryZwr+WM
         /bPJFtbgXgQjmXKDTK0NkrKGuf3ztAUtwOBFFLx3ZjgX2wGnwRaD7dV8PWj1zYbDpUjW
         rVzuCcDgZixBb5+DFbM9oGsjtGH1DFP0wPUKJHBmJA/MHBITEw/B21Z3Pd/RfKno1bno
         qRsm4Mxv765KZv5ASowJxDZywPadMUWbaKyIbTtGDk/+uKaWl3sJ9sr7ex0U6VWZMWxO
         kEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698399036; x=1699003836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+R3d9PrexLe3gHqXe8BjIbJjsmG22nyj6pAcb2QmK0=;
        b=kbWwyaommH9H9LYQBH2iUMO2o8rZNgZVzFs7+aXmkhs72oHqcjiBYRUoWxQpa0ANRY
         k3L5rcPTAZiV2ZESkK/d3JtMH5r6vro7MYYT7TgP5dRGE/ON2acTnLaekOnqjsBo8jIJ
         ooIeOS0BSl/nRYeHWQZ5vPQGB/uDqDq7BppRTno3NVzht6t0+FnKumst7GFVH2cF6Nhd
         jIPjRmFrMUwLXXNZrPFn6QBh5V1vLgxzf1kXoFJDHRLyMbTBn+fC44EmvWeLm7UlbzFK
         BMZpCTfUCIx5HfHeqT/aciFgkUkZWpLMuYey6Im92To+8lrEyqTVJN3xdLnHsvB+g4ZG
         luig==
X-Gm-Message-State: AOJu0YymIDK1mB7I4zlY6/EQCVJByRCkwdTF40Dp0O3hyDA4fX6czxgX
	rCbuYIiZh808OOhJC7TcC7m8mg==
X-Google-Smtp-Source: AGHT+IEXfxosY9UYBFT7kn60Eflg4n2RBNYMz4ANNEgx8PXX5eWKIPHrJn4fvTbfhq/x/o1xRx7BJw==
X-Received: by 2002:a17:906:fe04:b0:9c3:cd12:1925 with SMTP id wy4-20020a170906fe0400b009c3cd121925mr1743870ejb.58.1698399035904;
        Fri, 27 Oct 2023 02:30:35 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ov6-20020a170906fc0600b00992e14af9c3sm912509ejb.143.2023.10.27.02.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 02:30:35 -0700 (PDT)
Date: Fri, 27 Oct 2023 11:30:34 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org,
	Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
	smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
	yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org,
	imagedong@tencent.com, ast@kernel.org, jacob.e.keller@intel.com
Subject: Re: [PATCH v17 01/20] net: Introduce direct data placement tcp
 offload
Message-ID: <ZTuDOhYzp4FeCZaA@nanopsycho>
References: <20231024125445.2632-1-aaptel@nvidia.com>
 <20231024125445.2632-2-aaptel@nvidia.com>
 <ZTfSOv0F7licIO6Y@nanopsycho>
 <253jzr8juvl.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253jzr8juvl.fsf@nvidia.com>

Fri, Oct 27, 2023 at 11:07:58AM CEST, aaptel@nvidia.com wrote:
>Jiri Pirko <jiri@resnulli.us> writes:
>>>@@ -2134,6 +2146,9 @@ struct net_device {
>>>       netdev_features_t       mpls_features;
>>>       netdev_features_t       gso_partial_features;
>>>
>>>+#ifdef CONFIG_ULP_DDP
>>>+      struct ulp_ddp_netdev_caps ulp_ddp_caps;
>>
>> Why can't you have this inside the driver? You have set_caps/get_stats
>> ops. Try to avoid netdev struct pollution.
>
>Ok, we will move ulp_ddp_caps to the driver and add a get_caps() operation.
>
>>>+struct netlink_ulp_ddp_stats {
>> There is nothing "netlink" about this. Just stats. Exposed over netlink,
>> yes, but that does not need the prefix.
>
>Ok, we will remove the netlink prefix.
>
>>>+enum {
>>>+      ULP_DDP_C_NVME_TCP_BIT,
>>>+      ULP_DDP_C_NVME_TCP_DDGST_RX_BIT,
>>>+
>>>+      /*
>>>+       * add capabilities above and keep in sync with
>>>+       * Documentation/netlink/specs/ulp_ddp.yaml
>>
>> Wait what? Why do you need this at all? Just use the uapi enum.
>
>The generated enum does not define a "count" (ULP_DDP_C_COUNT) which we
>need to know how big the bitfield should be. Maybe the code generator
>can be patched to add a #define with the number of values in the enum?

Yeah. One way or another, don't duplicate the uapi enums.

