Return-Path: <netdev+bounces-40424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D688C7C74CF
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 19:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0613C1C20D50
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 17:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D8F358B3;
	Thu, 12 Oct 2023 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMj+xjMw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926203588F
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 17:32:29 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD8EED
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 10:32:27 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40684f53bfcso12617695e9.0
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 10:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697131946; x=1697736746; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTtI7zieYYaFnkvDEu6TAAF5Hyc1mP1avvewhcF8zig=;
        b=YMj+xjMwooFeJkSldW8XuLqniHjRmri2xrc8d2VvLzI+FtEUn8Xdg2SmbUhcLf2J7W
         0RVtfvel92O05gygFVf3sBZRjKjQCWCVgeClvAMDb8ezTRdrgn6oV7+Qb7hCI9lnpTl2
         S5lWOGaycw1DYm4ciSjqmsFpg9bZhdQik6Kxaf2ppyFhMPdrPC4aAuyu9Dsm5imsVLul
         dJvTTSWkC3kTGTOA+xY3+ebK8jTkdlQFehf2BSByMnCcIY5cGZ3sbFzfdLGHrE3XHIm3
         emF5fVn/j3JpXzStTbXO5Hsm6F1SGVSpuvpMI2OUMphQK+dDvF5vEUS8s8tW63IRBREN
         Cp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131946; x=1697736746;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTtI7zieYYaFnkvDEu6TAAF5Hyc1mP1avvewhcF8zig=;
        b=l+0ZU9fxEev8QG/7tBWId8nD99NNiaLi5RnV/YlVm/pmSbxJKuVrcrhMkVrOwiBeMC
         tGJCGvq2xRB2RXvT3C7kx+tKAcJ9s4zoTrVlehs5bjT+NaHIRe9Io+P8m5sITV1R823y
         1n8j63nd0vEvgzJ1zdErztieyeSrrycUvKOlm47ioBmQc5FP4vkrZfPTiDhrCrowZkTB
         Kop9NEk9dIui60YDy+t06fJ8zsefNbmNA9AnqtmJz8luawnu/6JsqJrUAqLBiflKBXAc
         TJQoyvvI5slu+t7l1G9kMhCkF8ZsyEHK3W+2gLmWTsvtJ9pVB0rLi/S8FJrexG4n89vO
         T8oQ==
X-Gm-Message-State: AOJu0YzGsVJfjvtFKMoeFjsf3q8kt2ghxxJWJcI+fitBZgC5jjAN1f/z
	Z6ccNlgEMzVtJ5lVbY6Er/I=
X-Google-Smtp-Source: AGHT+IFGmcJx9JJ5abCB3tPVHOwc4dhjcMGsFmgN1eEE2zbIyobmCfOI/Kim6i+eUhOOItrBfF4j2A==
X-Received: by 2002:a7b:cd8c:0:b0:401:bcd9:4871 with SMTP id y12-20020a7bcd8c000000b00401bcd94871mr22992249wmj.21.1697131946092;
        Thu, 12 Oct 2023 10:32:26 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id f8-20020adfe908000000b0032d8ce46caasm2981218wrm.93.2023.10.12.10.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 10:32:25 -0700 (PDT)
Subject: Re: [PATCH net v4] docs: fix info about representor identification
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jacob.e.keller@intel.com,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20231012123144.15768-1-mateusz.polchlopek@intel.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <817e0bfc-16c8-1c8b-35f6-ba373b7b1b45@gmail.com>
Date: Thu, 12 Oct 2023 18:32:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231012123144.15768-1-mateusz.polchlopek@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/10/2023 13:31, Mateusz Polchlopek wrote:
> Update the "How are representors identified?" documentation
> subchapter. For newer kernels driver should use
> SET_NETDEV_DEVLINK_PORT instead of ndo_get_devlink_port()
> callback.
> 
> ---

These --- lines in the middle of the commit message will cut off
 the tag block for 'git am'.

Other than that,
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

> v4:
> - changed the docs description
> 
> v3:
> - fixed the lack of hyphen in changelog
> https://lore.kernel.org/netdev/20231010120845.151531-1-mateusz.polchlopek@intel.com/
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
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>> ---
>  Documentation/networking/representors.rst | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/networking/representors.rst b/Documentation/networking/representors.rst
> index ee1f5cd54496..decb39c19b9e 100644
> --- a/Documentation/networking/representors.rst
> +++ b/Documentation/networking/representors.rst
> @@ -162,9 +162,11 @@ How are representors identified?
>  The representor netdevice should *not* directly refer to a PCIe device (e.g.
>  through ``net_dev->dev.parent`` / ``SET_NETDEV_DEV()``), either of the
>  representee or of the switchdev function.
> -Instead, it should implement the ``ndo_get_devlink_port()`` netdevice op, which
> -the kernel uses to provide the ``phys_switch_id`` and ``phys_port_name`` sysfs
> -nodes.  (Some legacy drivers implement ``ndo_get_port_parent_id()`` and
> +Instead, the driver should use the ``SET_NETDEV_DEVLINK_PORT`` macro to
> +assign a devlink port instance to the netdevice before registering the
> +netdevice; the kernel uses the devlink port to provide the ``phys_switch_id``
> +and ``phys_port_name`` sysfs nodes.
> +(Some legacy drivers implement ``ndo_get_port_parent_id()`` and
>  ``ndo_get_phys_port_name()`` directly, but this is deprecated.)  See
>  :ref:`Documentation/networking/devlink/devlink-port.rst <devlink_port>` for the
>  details of this API.
> 


