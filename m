Return-Path: <netdev+bounces-39574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873247BFE7E
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 15:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DF228137F
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70041DFFC;
	Tue, 10 Oct 2023 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6zuLrRo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF16F1DFEC
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 13:54:08 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585E1C6
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 06:54:06 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32d81864e3fso5302f8f.2
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696946045; x=1697550845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eT+vtxAkNGuwbpq6fLuhkyN/bftw+pqMmPrbQNUdcQU=;
        b=P6zuLrRotEb9fnlcKtmnMraMbDsriExOB4wzFRf3B0CtvpNUJCL/0lLVvFv32Zhkbm
         h81e5KAZrhfXqFLT14MkJqhfvHHU1d4mJQPlbju+w4e5e9rwlqb6Av/as2v8uULzNPug
         g6AduRPjxq8qx5KxC9fv3/hZfrK5j+Vqtw0GWUX84gZ0n9WyZqHL337mb2MmyYivigc+
         NML+Ppt+jZFfr6SxyVaI0by/kjgd+7LSuPhj0GRmg4CxcGwLx4geR2m9HVXmJVvj4LcV
         LhIewtSmvnYviNAy37fAGJScWM5+q7KgMirpVDA5grC5e35syHpQDv7TPaly6oCd08BF
         ch2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696946045; x=1697550845;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eT+vtxAkNGuwbpq6fLuhkyN/bftw+pqMmPrbQNUdcQU=;
        b=vIuLfgJFIAYg50x9eYZFvcmTOVNnQjha4rrWVNS9NR9nZmSqFl2aZtWxsLWKThNFCU
         B+wXBtgwn/T4jWnChLQVIO+c6Bl3kfVBC0loirGCGZ3hmYBo3x89YopN0xJ14SMM0KYr
         NObjFLztq2ZLadWZvKJcXdLt5BA9WoPLwAgipDH9PuliIzP/34konRszR1AFw4Fhe6Y0
         w+2TUxgdbTW5+59eJsf6uXV42BK5pum8JpIk/lei0TAkipISirsgACiCpY6DerjBYTns
         vErMf9btOt0itmvuXLyLzhfxT927I5JydZisUA1gbOXXKxYc3SnqEllz78CqlIE1Qti+
         sxjA==
X-Gm-Message-State: AOJu0YyLKywQraXTkhXlXMebY2a2JC4nwYwTlquYKbJifNGeTjZYnozV
	SJtQcRCl3Mo98gbKLrs/RrN2/+uuY88=
X-Google-Smtp-Source: AGHT+IH1jwkcFFhGKgEH7q5msnQ7C6Ap7897bnBTra0UWS1vz3MO3sQzJDHyx5W4gFKBuj1/H+1GQg==
X-Received: by 2002:a5d:4d12:0:b0:323:16c0:9531 with SMTP id z18-20020a5d4d12000000b0032316c09531mr15723300wrt.13.1696946044541;
        Tue, 10 Oct 2023 06:54:04 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id e15-20020adff34f000000b0031c6e1ea4c7sm12814444wrp.90.2023.10.10.06.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 06:54:04 -0700 (PDT)
Subject: Re: [PATCH net v3] docs: fix info about representor identification
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jacob.e.keller@intel.com,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20231010120845.151531-1-mateusz.polchlopek@intel.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <8c0284fa-2edf-023d-9a28-5824f31e48ed@gmail.com>
Date: Tue, 10 Oct 2023 14:54:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231010120845.151531-1-mateusz.polchlopek@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/2023 13:08, Mateusz Polchlopek wrote:
> Update the "How are representors identified?" documentation
> subchapter. For newer kernels driver developers should use
> SET_NETDEV_DEVLINK_PORT instead of ndo_get_devlink_port()
> callback.
> 
> ---
> v3:
> - fixed the lack of hyphen in changelog
> 
> v2:
> - targeting -net, without IWL
> https://lore.kernel.org/netdev/20231009111544.143609-1-mateusz.polchlopek@intel.com/
> 
> v1:
> https://lore.kernel.org/netdev/20231006091412.92156-1-mateusz.polchlopek@intel.com/
> ---
> 
> Fixes: 7712b3e966ea ("Merge branch 'net-fix-netdev-to-devlink_port-linkage-and-expose-to-user'")
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
>  Documentation/networking/representors.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/networking/representors.rst b/Documentation/networking/representors.rst
> index ee1f5cd54496..2d6b7b493fa6 100644
> --- a/Documentation/networking/representors.rst
> +++ b/Documentation/networking/representors.rst
> @@ -162,9 +162,9 @@ How are representors identified?
>  The representor netdevice should *not* directly refer to a PCIe device (e.g.
>  through ``net_dev->dev.parent`` / ``SET_NETDEV_DEV()``), either of the
>  representee or of the switchdev function.
> -Instead, it should implement the ``ndo_get_devlink_port()`` netdevice op, which
> -the kernel uses to provide the ``phys_switch_id`` and ``phys_port_name`` sysfs
> -nodes.  (Some legacy drivers implement ``ndo_get_port_parent_id()`` and
> +Instead, driver developers should use ``SET_NETDEV_DEVLINK_PORT`` macro to
> +assign devlink port instance to a netdevice before it registers the netdevice.
> +(Some legacy drivers implement ``ndo_get_port_parent_id()`` and
>  ``ndo_get_phys_port_name()`` directly, but this is deprecated.)  See
>  :ref:`Documentation/networking/devlink/devlink-port.rst <devlink_port>` for the
>  details of this API.

I think the text as a whole would be clearer if you kept in the language
 about the kernel using the devlink port to provide the sysfs nodes.
Otherwise the reader will be confused as to why we suddenly start talking
 about them in the parenthetical.
How about:

Instead, the driver should use the ``SET_NETDEV_DEVLINK_PORT`` macro to
assign a devlink port instance to the netdevice before registering the
netdevice; the kernel uses the devlink port to provide the ``phys_switch_id``
and ``phys_port_name`` sysfs nodes.
(Some legacy drivers implement ``ndo_get_port_parent_id()`` and

-ed

