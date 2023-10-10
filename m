Return-Path: <netdev+bounces-39750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E107C4465
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 00:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8BE281BD6
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 22:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE8029CE1;
	Tue, 10 Oct 2023 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5I1941g"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C315635518
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 22:42:50 +0000 (UTC)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6918291
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:42:49 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-79fce245bf6so248334839f.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 15:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696977769; x=1697582569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l5epg5slVi2ZMZ2XCdkm8B/4iSOhQb3T0qsBgHlWnKI=;
        b=G5I1941gI6rQBPq7eXyI3NrqWeXDwQ7ztwIrGkYXd0AISTMJnQ5Lf/XpUXcgL8yQ90
         68Zd8oaptqJ2l2MK61Igc7ZZu4Hy0EOMszfT//Wo8HPX8nJh7q3tQ9xyGxEi7lvSP8jS
         KCWVbsoMg2s4zZFUhlVfxiVo4Lx0p9Lm0YXjfqqPAHq9ke+gwaO0FSZPSa0ocOKZ/52z
         baz3RIrYElun1W7JzYEJ3tATUE1Ejwb68dxevy3RjdtbbB9Wupo5TXdcvBQGoJHeWG67
         +ogZPATQEs93U4yDCR15PKJsPIJQiWmYTimV5zUPxBOob20v5VdnXVGZQTiwdBbpBRRe
         CE9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696977769; x=1697582569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5epg5slVi2ZMZ2XCdkm8B/4iSOhQb3T0qsBgHlWnKI=;
        b=iXb4hmMHFiYEgWIxUSLn0y86t8AyICXnSX6zteSxeZU8EfB++WkqaBgiAvPAbcfGAs
         5EwZ5QokWnlTd6vEauFpew/iFhxgylfxjsKWrekh1m8AnBzi+o5X7LbAu1fexTdaLPBa
         Xaz0gqZFFcTWDX395ocUbL5hz8berzu2k5HtBP2VmghL8zYpBD+ng3MeoxSCPpDLnSSh
         ZJh3sQrGY1sigxvXZ1XhWNF8xVVver0ZYVaNP25bh4GNAyfzZ9JKBVwRMTVyLG8UTEXy
         qBZ4Yt1DvVIkvfGxlpzNfDxpayQ1v5vMv9Sj1ymjKki6zBpksjUXnHcm4ML1i+xkJi2M
         bSfw==
X-Gm-Message-State: AOJu0YxiSN+CaJpEJbdTrMIFHTpVxlZuPBGz38DwHGW73NKc4xoePZyF
	512PwC7UukOgHu92S2kwTkjkkQ==
X-Google-Smtp-Source: AGHT+IGYNa3gzIhjt40GIF5yGfmofKxjAmOdD0gzDqAUw0ZpUfFc3Tji+MMCm1XS+RHalBJ6bgVecQ==
X-Received: by 2002:a5e:dd0d:0:b0:786:7100:72de with SMTP id t13-20020a5edd0d000000b00786710072demr20110506iop.16.1696977768722;
        Tue, 10 Oct 2023 15:42:48 -0700 (PDT)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id ee24-20020a056638293800b004332f6537e2sm3057256jab.83.2023.10.10.15.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:42:48 -0700 (PDT)
Date: Tue, 10 Oct 2023 22:42:45 +0000
From: Justin Stitt <justinstitt@google.com>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] igc: replace deprecated strncpy with strscpy
Message-ID: <20231010224245.i57oix72csm7kjp7@google.com>
References: <20231010-strncpy-drivers-net-ethernet-intel-igc-igc_main-c-v1-1-f1f507ecc476@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010-strncpy-drivers-net-ethernet-intel-igc-igc_main-c-v1-1-f1f507ecc476@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 09:15:39PM +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
>
> We expect netdev->name to be NUL-terminated based on its use with format
> strings:
> |       if (q_vector->rx.ring && q_vector->tx.ring)
> |               sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,
>
> Furthermore, we do not need NUL-padding as netdev is already
> zero-allocated:
> |       netdev = alloc_etherdev_mq(sizeof(struct igc_adapter),
> |                                  IGC_MAX_TX_QUEUES);
> ...
> alloc_etherdev() -> alloc_etherdev_mq() -> alloc_etherdev_mqs() ->
> alloc_netdev_mqs() ...
> |       p = kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
>
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
>
> Let's also opt for the more idiomatic strscpy usage of (dest, src,
> sizeof(dest)) instead of (dest, src, SOME_LEN).
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 98de34d0ce07..e9bb403bbacf 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -6935,7 +6935,7 @@ static int igc_probe(struct pci_dev *pdev,
>  	 */
>  	igc_get_hw_control(adapter);
>
> -	strncpy(netdev->name, "eth%d", IFNAMSIZ);
> +	strscpy(netdev->name, "eth%d", sizeof(netdev->name));
>  	err = register_netdev(netdev);
>  	if (err)
>  		goto err_register;
>
> ---
> base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> change-id: 20231010-strncpy-drivers-net-ethernet-intel-igc-igc_main-c-26efa209ddb5
>
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>
Hi, this patch was bundled up with some others. It has a new home:

https://lore.kernel.org/all/20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com/

