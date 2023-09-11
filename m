Return-Path: <netdev+bounces-32867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B941B79AA0E
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 18:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BC562814A2
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 16:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AE8125C2;
	Mon, 11 Sep 2023 16:15:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975A81172B
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 16:15:22 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B9FCC3
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:15:20 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4cbso5840922a12.1
        for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1694448919; x=1695053719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYDGjPvAsusOGB7j7DcK3nJZSfXUha+a9/zNHj7uGhU=;
        b=xJsSGmsuTCSkwpIw8i11ri9xXvadW61m8SU2gcX8PO5ZKF4x9ZGtQNPfvhjy8AyKt5
         9d2bwVGm7qa1Zq4p910mCPBROzd5oub/GFarhi4YDLWXpOmz16LvtFUByrNQ3Xp1aHiX
         Fn4j3DtVvW2dKcPlT+tSlBeCnCLzTI4DNw3v1QQ4b/RqC8+GcFDKHSyH9/eKB0md7kPB
         MhdYZdivRX2zrdFvi8S3yGvceECITFr8Ztgi0AAPsTtGsLsmzGl+WZrXnUAWcHoSdFWH
         5E15VmVCMI9QtnJZxzKfAMeE1QYiz34dJ0Rq86B7fUq+OqV8EG3m+olgQQ5MPS/mMSgE
         lsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694448919; x=1695053719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yYDGjPvAsusOGB7j7DcK3nJZSfXUha+a9/zNHj7uGhU=;
        b=UunVUREY47EZRi/NWHZnV8u9lULii5qIzkyK749GWgel3joX/RibaiFJfjPJTKi1mi
         3p4ptO73N5pQxFPlMUDhhrRqw+xHLCW3w66cYfKz07WqpkniCoRdD0sMcZ93GHJE5YqP
         gFJq3lb6tflYT/fOOnkCRJjL0Hg0qjNluiIy63v1QAJKt+QligiIRiUmJ78qi++1E0Nu
         TAsrgCWRK5ONLb+7sSqNqoQHLffOpFf/XzTGFYHSF/6+rqC5XLkFzuZ/TDcbtIr2ADf+
         kcRm2F5LE4AHwg8hCjz6NAyWe/MXaM3YLHkLTOqvkZJaB1a6hDDQy3gBfy9NwhNBDdoN
         Q1ng==
X-Gm-Message-State: AOJu0YwSLyABMMso+tWf9OutPrBpyLkVfVrA5WEXLOo2ewaevKZkiF02
	ITs8a6GO+8Jq9eHnNr7AYb1S+g==
X-Google-Smtp-Source: AGHT+IHIkFPvoSy5xjebQpvv3/QLEOAjuwHInhCr5Yl6PKK9Ai/V/LGaIu1O/SIV1icHU3XfyHHxMw==
X-Received: by 2002:aa7:d5ce:0:b0:523:47cf:5034 with SMTP id d14-20020aa7d5ce000000b0052347cf5034mr8933651eds.34.1694448918910;
        Mon, 11 Sep 2023 09:15:18 -0700 (PDT)
Received: from fedora ([79.140.208.123])
        by smtp.gmail.com with ESMTPSA id n13-20020a05640206cd00b005256771db39sm4816471edy.58.2023.09.11.09.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 09:15:18 -0700 (PDT)
Date: Mon, 11 Sep 2023 09:15:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/core: Export dev_core_stats_rx_dropped_inc sets
Message-ID: <20230911091513.4f2f2aed@fedora>
In-Reply-To: <20230911082016.3694700-1-yajun.deng@linux.dev>
References: <20230911082016.3694700-1-yajun.deng@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
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

On Mon, 11 Sep 2023 16:20:16 +0800
Yajun Deng <yajun.deng@linux.dev> wrote:

> Although there is a kfree_skb_reason() helper function that can be
> used to find the reason for dropped packets, but most callers didn't
> increase one of rx_dropped, tx_dropped, rx_nohandler and
> rx_otherhost_dropped.
> 
> For the users, people are more concerned about why the dropped in
> ifconfig is increasing. So we can export
> dev_core_stats_rx_dropped_inc sets, which users would trace them know
> why rx_dropped is increasing.

ifconfig has been frozen for over 10 years, and is deprecated so there
is no point in catering to legacy api's. There are better API's such as
ethtool and netlink that can provide more info.

