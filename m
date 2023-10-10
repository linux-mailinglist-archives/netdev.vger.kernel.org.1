Return-Path: <netdev+bounces-39745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF7C7C4441
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 00:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8508F281E49
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 22:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3CC225AE;
	Tue, 10 Oct 2023 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHjyVqsB"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C2E35515
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 22:36:28 +0000 (UTC)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6D0A7
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:36:26 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-79faf4210b2so234762139f.2
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696977385; x=1697582185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fp1+19JThVDp5aV8ZmVBXvT9jXnK6YGxCfcTc284ZzQ=;
        b=SHjyVqsBKPTMwlV0lC4fzUyyQa1JFIIiGfTULar5DkF6EuFdmk9QiqZ5eRvezbU7XU
         ZHSeAJhzLbwUZwH+T1Vd29I7DlyutJjvfQH60HWr6Q9F+OcF5CvXGxV+EhnHErdG0Zvg
         qeNH9XvXj46BDGtDNXpFS2jXodRlmSdtKbwSQMLM1T1GScttYsLmgbJ7fJIOw5IW9bWn
         /O61iO83caXEbswsdwOHlU1OT0xFo4eG5vaygWV7RD5iMKYzW8u51A43hqF36+WSoYCe
         DpZ2OvVQeIe5aLwwN8wstCf8j+zK4A4wbqOTaEy6w1ZuV4bitGtvnDf7uEVyWJRD+lPZ
         08Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696977385; x=1697582185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fp1+19JThVDp5aV8ZmVBXvT9jXnK6YGxCfcTc284ZzQ=;
        b=Eib/Qo7DBo2+rQxLC2VayEry7zFNFqO8kgtKFqr8/MFEleP+CaKp7Dm6fZWpU7C5/S
         i17dds6yeq1kTyZrJkcRk3Z0+q5Kz+d/8LSKgVQbpsieORRjsdCwHdWwcb5f5qYqWulC
         h/l6EEjk2/jIiXl54j5KLVNnhtPvPmZs/71YNvUcZinsh7GKuC3/gvSsKlFeyCeFCE0r
         cDJaZ94/bHtBOgu3EaxQfSKwYXAWmksY+rihkMwisUSIwvpShMIxtNKUbbojrgSj0jQt
         gR4FrH6f9EQ8FGmKaKEz/J+SPCEsjhfL9zR4YIx152TI0pm78CcG3plG9Xwzmhnq7CJH
         H8HA==
X-Gm-Message-State: AOJu0YwvidjlaDi6UFSGRboE+9f8+1SY9/d5Vsh/ctTbbsyrFXhEbdYw
	yl/XTesATMGthz8KRnmYlRSKXj3Gr4qjLKV3rmUMvw==
X-Google-Smtp-Source: AGHT+IEoHPDq/5iygy94KT86qlz3QZwHbRQso0lz7RaMmjKkCunaMgvNTfv7uf58Yir3pWdJMnT3eQ==
X-Received: by 2002:a6b:e704:0:b0:78b:b892:e334 with SMTP id b4-20020a6be704000000b0078bb892e334mr22796097ioh.11.1696977385502;
        Tue, 10 Oct 2023 15:36:25 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id dp19-20020a0566381c9300b0043a1a45a7b2sm3051398jab.62.2023.10.10.15.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:36:24 -0700 (PDT)
Date: Tue, 10 Oct 2023 22:36:22 +0000
From: Justin Stitt <justinstitt@google.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] e1000: replace deprecated strncpy with strscpy
Message-ID: <20231010223622.tnurv2ujreo56qwz@google.com>
References: <20231010-strncpy-drivers-net-ethernet-intel-e1000-e1000_main-c-v1-1-b1d64581f983@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-intel-e1000-e1000_main-c-v1-1-b1d64581f983@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 06:35:59PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> We can see that netdev->name is expected to be NUL-terminated based on
> it's usage with format strings:
> |       pr_info("%s NIC Link is Down\n",
> |               netdev->name);
>
> A suitable replacement is `strscpy` [2] due to the fact that it
> guarantees NUL-termination on the destination buffer without
> unnecessarily NUL-padding.
>
> This is in line with other uses of strscpy on netdev->name:
> $ rg "strscpy\(netdev\->name.*pci.*"
>
> drivers/net/ethernet/intel/e1000e/netdev.c
> 7455:   strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
>
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> 10839:  strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index da6e303ad99b..1d1e93686af2 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -1014,7 +1014,7 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	netdev->watchdog_timeo = 5 * HZ;
>  	netif_napi_add(netdev, &adapter->napi, e1000_clean);
>
> -	strncpy(netdev->name, pci_name(pdev), sizeof(netdev->name) - 1);
> +	strscpy(netdev->name, pci_name(pdev), sizeof(netdev->name));
>
>  	adapter->bd_number = cards_found;
>
>
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231010-strncpy-drivers-net-ethernet-intel-e1000-e1000_main-c-a45ddd89e0d7
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>
Hi, this patch was bundled up with some others. It has a new home:

https://lore.kernel.org/all/20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com/

