Return-Path: <netdev+bounces-30565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4A47880BC
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 09:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2561C20F3B
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 07:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C7A17FC;
	Fri, 25 Aug 2023 07:16:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098AC377
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 07:16:05 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF3A19A5
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 00:16:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3ff7d73a6feso5356315e9.1
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 00:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692947762; x=1693552562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EGdsALVRXjJgIK0jmTnM1X5AxhbnZxe/FlNJGVOo8ws=;
        b=JAZNXc1qL03F91g1zCAgEH+Kndd5rgP9dgUhX1tur0sqmS+JFh38VP4WPe/gVy7Q18
         tAHwC+YTWRgOz3i0t5UHsDZ+0SJd46f98r4ghyFtyAOc9lzBCdW2UU/CVeae+uMzTHSe
         3D3GNvnK3gpe+uRiGKACmdFfy/+8GeUFQ0Czg0qvmhIuIj6bVCY6cczug+MMQfLLgfpH
         Hlyw/KPGaaO462YAygJjgzQZ0vPUJuDzAPDx00QC6UabYNLEf5tZw8BoRsZx3/rolLB7
         5UXKs57KwKDXZsaDJMH5VpRLIPngfSgvlwIGZORjZ+k5deD4KB/wWxidAW6HMPxFOM1s
         hCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692947762; x=1693552562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGdsALVRXjJgIK0jmTnM1X5AxhbnZxe/FlNJGVOo8ws=;
        b=KKMcHXdeeyJSp1MiANJ6HBo+9dEQkOXZprDeyNIcRsr0jP0ZBld5pGummazpnnM9rX
         W6WeaRTGu0Hpw0pwYPK62Qt/mQYuKgTjL2jZ9Huy7oech8hIehaFWlS07BJm2wQxUQ4E
         gwDF6g1w7ZzmSlxYnhrG/luHtERI9sQ058ZMPx4lQHa895qXMk6j1O23TlOmzjTuH1Wc
         2JQb2yKkBxhCLJviCYf3dDI7BSZd6Myy/5e67v/sg/8sGf70WS6wF+uktLIhkY9K0SUR
         lfxeyp8VXb19u1jVBcRXPDZBe7cJe+wwUTu7BwXk6y9XyrI35u1bRx1kHFEYkDhkrR/s
         tsGg==
X-Gm-Message-State: AOJu0YzKVjGqSvzDy8D0yMBJ/7xbi25kUkqNLVJrQeb57HclWYUO3Oeo
	Phm9o7cfi3zMjsJOmKCMt/EQRQ==
X-Google-Smtp-Source: AGHT+IEAVsVYrE8VbSd8MoHxEH8HNkqmvh+ci64My9jdmruPlQK+uvS9ea8yfQGPFQfMLK37+8l44w==
X-Received: by 2002:a05:600c:255:b0:3f5:fff8:d4f3 with SMTP id 21-20020a05600c025500b003f5fff8d4f3mr13600273wmj.7.1692947761950;
        Fri, 25 Aug 2023 00:16:01 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id b3-20020adfde03000000b0031accc7228asm1344120wrm.34.2023.08.25.00.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 00:16:01 -0700 (PDT)
Date: Fri, 25 Aug 2023 09:16:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Dima Chumak <dchumak@nvidia.com>
Subject: Re: [PATCH net-next V4 2/8] devlink: Expose port function commands
 to control IPsec packet offloads
Message-ID: <ZOhVMF2VCfu+aTvY@nanopsycho>
References: <20230825062836.103744-1-saeed@kernel.org>
 <20230825062836.103744-3-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825062836.103744-3-saeed@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 25, 2023 at 08:28:30AM CEST, saeed@kernel.org wrote:
>From: Dima Chumak <dchumak@nvidia.com>
>
>Expose port function commands to enable / disable IPsec packet offloads,
>this is used to control the port IPsec capabilities.
>
>When IPsec packet is disabled for a function of the port (default),
>function cannot offload IPsec packet operations (encapsulation and XFRM
>policy offload). When enabled, IPsec packet operations can be offloaded
>by the function of the port, which includes crypto operation
>(Encrypt/Decrypt), IPsec encapsulation and XFRM state and policy
>offload.
>
>Example of a PCI VF port which supports IPsec packet offloads:
>
>$ devlink port show pci/0000:06:00.0/1
>    pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
>        function:
>        hw_addr 00:00:00:00:00:00 roce enable ipsec_packet disable
>
>$ devlink port function set pci/0000:06:00.0/1 ipsec_packet enable
>
>$ devlink port show pci/0000:06:00.0/1
>    pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
>        function:
>        hw_addr 00:00:00:00:00:00 roce enable ipsec_packet enable
>
>Signed-off-by: Dima Chumak <dchumak@nvidia.com>
>Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

