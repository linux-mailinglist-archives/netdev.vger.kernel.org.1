Return-Path: <netdev+bounces-13294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7684373B1FF
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 09:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79DA1C2104E
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 07:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E47A17F7;
	Fri, 23 Jun 2023 07:46:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4336917D3
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:46:28 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FC42736
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 00:46:06 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98862e7e3e6so33886766b.0
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 00:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687506364; x=1690098364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+iQJZz9hEg89sqi4PWoni97EtVUqEhCuQI2ITf4HAXA=;
        b=2TvXFALf689o+kg1n/BoUwKWd/3XYQin0SBUbtKYKNgUhCzzbJ+zHnhiPm5dgZWZAx
         QOV/GJ86Rl2FDFDbDPni5ZM0BkL37FEMoYPwXMiER9Sh9mD5ES/THtN/j9IgbyCSFV3e
         ef8aWCcaO4aza0Hid7+CB9HASZE3Y9IV1lpJPLMqLGErRJVeEuvHVQ3AGNST32knIj/s
         zLsnBn3JqlZw10Xqokx03IWjwM4pAI9pZJx+J/CwDEu+M+drvk3uudoNTX7B0xdkf6x8
         yEqmKo6VvFbXwWM6U0zfiTfV68+g8Eait/IWtuqpT0BnIAUkejeY9cOZSOOQfHLly9Jk
         MwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687506364; x=1690098364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iQJZz9hEg89sqi4PWoni97EtVUqEhCuQI2ITf4HAXA=;
        b=bqeAlLvpXBoQzgPmCZEqrmW7RDIYYfyOMdKqJgo7WSuwHStr6blODtbizeFipBOzZR
         ERcyRe4l8Qea0j1ssfkl7FraWED5GAr9glpVH51DjTOKVSwkzFHg7/NO4JuQsIbS9S2d
         a6x+PwnVZryKdQLcRizlsIU/waOvJzMPM6UC6USIjb/vs7ZNhW9VCoyqw3xtCPnCXg96
         kRJyc7vgT+bQTMAWdwF7sQESIqgCa0sOhXRd1kPcI2kJRy2ePAtgurn2xkZKnrxyfW9D
         FOsg8EJM80Rz69kUeJM2qXVs71PnPhbGn8AYN+7RQxbJY9Tey337G34T2F5//mz56Sea
         SNWg==
X-Gm-Message-State: AC+VfDy5D6SNu1Ave4hny4Wec3kNVeq42zJ9bwyVh2A+l8HXaRmCzqID
	txNvCj0a8JTxGD+Bzq7Y2aJiIQ==
X-Google-Smtp-Source: ACHHUZ5Uu/KXy31dWeHa3Pa3sMiSVMIOiEa5B6VK+4dppa1hGkleBn/K+E+EPKZ82KnSXCt3aO8F+Q==
X-Received: by 2002:a17:907:94c8:b0:987:33c3:e288 with SMTP id dn8-20020a17090794c800b0098733c3e288mr17120210ejc.29.1687506364243;
        Fri, 23 Jun 2023 00:46:04 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id l17-20020a170906939100b0096f67b55b0csm5596839ejx.115.2023.06.23.00.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 00:46:03 -0700 (PDT)
Date: Fri, 23 Jun 2023 09:46:02 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: rtnetlink: remove netdevsim device after
 ipsec offload test
Message-ID: <ZJVNutrYRNFBe33L@nanopsycho>
References: <e1cb94f4f82f4eca4a444feec4488a1323396357.1687466906.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1cb94f4f82f4eca4a444feec4488a1323396357.1687466906.git.sd@queasysnail.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Jun 22, 2023 at 11:03:34PM CEST, sd@queasysnail.net wrote:
>On systems where netdevsim is built-in or loaded before the test
>starts, kci_test_ipsec_offload doesn't remove the netdevsim device it
>created during the test.
>
>Fixes: e05b2d141fef ("netdevsim: move netdev creation/destruction to dev probe")
>Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Thanks!

