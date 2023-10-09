Return-Path: <netdev+bounces-38930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CC07BD16F
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 02:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49BB2814D3
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 00:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3155681A;
	Mon,  9 Oct 2023 00:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4FY5kIv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76CF63E;
	Mon,  9 Oct 2023 00:34:44 +0000 (UTC)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281EFAB;
	Sun,  8 Oct 2023 17:34:41 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3af608eb34bso2812244b6e.1;
        Sun, 08 Oct 2023 17:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696811678; x=1697416478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cDy6tPfpqj3KR3HrKDaQ7tUSHnBT+iyGC2DxosxlRHw=;
        b=N4FY5kIvBp6l58FSOLotVAeIMXvR/ByUazZ7a1PLOV8DraQ4TMm6FY2vaEyQdusWz2
         4Jufrtul7eFb7O92Xm5bJEf5t7MeD1GIepVnzrLNaNPBBrL1cfnMhA96IMvqJYKrBexC
         dUevpOpeWwa3215urJRyAswAS8Gmka+SeIE/vuT5bHh65AVEmtx479hwF+Sar2HsTzkS
         tgo7NBW+vExhRJZrZ7HXH5FLxmg7Vetc6XHb4UfqIwbxM+L7TS3SEb1Y7tq/ZWO5RWFA
         62q1AfTTyewjDVW7WlcEdSu9+21RjVe0ssKNAMAcbhF8qnw/5jBUBG8im3gvn3y4HHH0
         F1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696811678; x=1697416478;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cDy6tPfpqj3KR3HrKDaQ7tUSHnBT+iyGC2DxosxlRHw=;
        b=A67aVVJqH6csm0EW7A10FaDDGrnUp6FBrufqWl4NDnejfymk2juEvo7i28ZUDQG1BZ
         DxYPnMSFrIFR/ye4ozaCsOsNL1oVMAWqLwKGOLMMKzbIQqO7/Rj7I0SLtRqYVACbDFXA
         +lI9p16kjdbFvRfCDFkFfEC73a+UlqIS3CRVuglGUbOtTKCUFf+Re7vaskD3x33vjRK2
         E/0xymCAC882jFb1DQxKv2Iywsjoy02qhrPaKB0rae1o3MYyJUwzt6iDVSneepdwaBOB
         Iqjf24YOmVbrjZN1CHYy4L8usaXY78vJtnCIaWBtzem3xjrQL9kNYc212oe8KqXjN2IO
         nU9Q==
X-Gm-Message-State: AOJu0Yx4hl4wuuFOWrxs5QtxYMLxjPaYBg6c3Yx+ZJrnCDtOnoWAb4XH
	s2gvX2N5knitrL8UxlEKY3Z37d7mF6ct1S6jq0URkhQhXBI=
X-Google-Smtp-Source: AGHT+IF1lHwAdPSIz68BEqoIzPlJiCE+dBbnohGiqjnajvLPkqdx+GXK2l1vV+xZP96LZI3Q6QBolT4Cx3G546JTHO8=
X-Received: by 2002:a05:6358:7296:b0:164:953b:35a9 with SMTP id
 w22-20020a056358729600b00164953b35a9mr3669149rwf.23.1696811678244; Sun, 08
 Oct 2023 17:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Forest Crossman <cyrozap@gmail.com>
Date: Sun, 8 Oct 2023 19:33:00 -0500
Message-ID: <CAO3ALPxXSkRVu4UO+TXse47FCFimfN+dYjvssocmaRQ3zdMDpg@mail.gmail.com>
Subject: r8152: "ram code speedup mode fail" error with latest RTL8156B firmware
To: hayeswang@realtek.com, davem@davemloft.net, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi, all,

While looking at my kernel log today I noticed the following error:

> r8152 6-1:1.0: ram code speedup mode fail

The error appears when using the latest RTL8156B firmware (04/27/23),
but not when using the previous version of the firmware (04/15/21).

I haven't really noticed any malfunction or degradation in the
performance of my RTL8156B device, but I figured I'd bring this to
your attention anyways just in case either something really is wrong
with the firmware or the driver is simply printing the error by
mistake.

Thanks,

Forest

