Return-Path: <netdev+bounces-27816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEAA77D566
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 23:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0079E1C20E04
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 21:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA6A19888;
	Tue, 15 Aug 2023 21:53:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7080415AD7
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 21:53:11 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31FFBC
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 14:53:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc73a2b0easo38570085ad.0
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 14:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1692136389; x=1692741189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFgqvkiicAJAZ+TyCf93JTwGq6TNxSzsv5dF07TH6Tk=;
        b=gmAfLdULEEBFNh1i4TLpyMNzAW50MQ/RU140C+sH30TiMZMlbr/Hj4soYyZNRytP1G
         aHKBgo6eAYnfm+XDNmWY0ycQ+oSP3Z0ZfjXQxx4kvUbTJ9zxkLG6mkNxk2c3mvIDz4QE
         3Jxq1LXGmOO0JA5ptE+esjApkCszVqERKAvbjmFATjkMw+9/Y3Le2ikvCZ+8phEK7GJN
         3l6yF1nzHwkntDd0Y/OypJauWvN/0iHV3L4KM/WbFjD2UyvsADXAtimKH6/RAqIfyVQq
         6/pp6QFjNXkZ6TmZNGLlyU9dRLzzFLauX9cSos2EYMNvq1cLLfOHwiyOANMa8ajSuJKj
         bqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692136389; x=1692741189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFgqvkiicAJAZ+TyCf93JTwGq6TNxSzsv5dF07TH6Tk=;
        b=Ntw7kmfzEE3XTO5BMbY6s6MseJLsrjKwWquS0PPG1AnS9f32xqIz4pkzooM9vCrG+A
         CH97QXLAyHey8rOjIi/SrNKFZEVdM/WR6N/LEe+LLURqYnLZHhaEseSP0Goz4R6+B3iE
         FjWdd6N9/oW3Nm/ygk98kZDhh4XcyjBdzYXwgQeyqc2A/oMDnW2ajZeUjRzhEh3vzM8v
         vqZjEObf8WWi3WZfTRZ6nwcdFo1wQzYyYImgNOHfy9sRPe1oubuKiTcPSZ7S5W0bd1sl
         QYmOArx3sF7CR95k2A/EmlyZjHYLqJA6JEugzrsXluQ0E+u3LKej7TgPixGtjVtI4w8k
         jBvQ==
X-Gm-Message-State: AOJu0Yzhyq1/sRGb/wTuYXbNwy7Sh9iic/RKKn7RGOSQRcUUeBneNWbw
	aWMnKBBmlczvFklaoZVwTZzZWA==
X-Google-Smtp-Source: AGHT+IGGjoA3PG79FZbEjPEfbQOFHiJqLl/kQtkIigfDUQ8+8bv9rsdQnzufgKqOX8foXdcnVv9jXA==
X-Received: by 2002:a17:902:d714:b0:1b8:9b74:636b with SMTP id w20-20020a170902d71400b001b89b74636bmr88918ply.68.1692136389246;
        Tue, 15 Aug 2023 14:53:09 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b001bdc2fdcf7esm8233900plg.129.2023.08.15.14.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 14:53:09 -0700 (PDT)
Date: Tue, 15 Aug 2023 14:53:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
Cc: netdev@vger.kernel.org
Subject: Re: [Question]: TCP resets when using ECMP for load-balancing
 between multiple servers.
Message-ID: <20230815145307.0ed1e154@hermes.local>
In-Reply-To: <20230815201048.1796-1-sriram.yagnaraman@est.tech>
References: <20230815201048.1796-1-sriram.yagnaraman@est.tech>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 15 Aug 2023 22:10:48 +0200
Sriram Yagnaraman <sriram.yagnaraman@est.tech> wrote:

> diff --git a/include/uapi/linux/in_route.h b/include/uapi/linux/in_route.h
> index 0cc2c23b47f8..01ae06c7743b 100644
> --- a/include/uapi/linux/in_route.h
> +++ b/include/uapi/linux/in_route.h
> @@ -15,6 +15,7 @@
>  #define RTCF_REDIRECTED	0x00040000
>  #define RTCF_TPROXY	0x00080000 /* unused */
>  
> +#define RTCF_MULTIPATH	0x00200000
>  #define RTCF_FAST	0x00200000 /* unused */

This looks like a bad idea. Reusing bits that were unused
in the past and exposed through uapi will likely cause
an ABI breakage.

