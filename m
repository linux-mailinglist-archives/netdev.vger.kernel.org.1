Return-Path: <netdev+bounces-46136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C93D7E192A
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 04:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4BCB20CDF
	for <lists+netdev@lfdr.de>; Mon,  6 Nov 2023 03:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3E81391;
	Mon,  6 Nov 2023 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="IlEMqcXI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FD1138E
	for <netdev@vger.kernel.org>; Mon,  6 Nov 2023 03:23:14 +0000 (UTC)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24E0112
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 19:23:11 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-28023eadc70so3235934a91.2
        for <netdev@vger.kernel.org>; Sun, 05 Nov 2023 19:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1699240991; x=1699845791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wh9fQ38uqWxfqKSp2NOqm3UoppKALypzJXvqmaMzdus=;
        b=IlEMqcXI0c47V67bbU33wktF5tYNAOMjf09o3E1n7rfmCmvJZhAhC7orcYx7wJCur0
         MdpdwwmypAHkUE9QI/OJya1lsUVkI8dkbAFVLXAmfHqHoWv00sj4en6AYj4MfqtwAjPG
         ob83NXOut1E6KwJ8TgpZ6e56uB6hWTmyKQmjwGyli14kx8owIA7H+Wb+DJKwP8UkjQQN
         LTWCp+vwF9Nm9pTjVtZZ6Ya9CwwAaOA8hSahdsPGVZdCcmGDdvUIDGEuYV2ROF6I8axg
         6DIQgbhSXzGZkKZPsGTSYgveboAjWpxb8J46bIni4w7+PtVqx/bgmsAPQimKyJB8nxIU
         7qYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699240991; x=1699845791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wh9fQ38uqWxfqKSp2NOqm3UoppKALypzJXvqmaMzdus=;
        b=scDiiKYOCmac2w9NbZp3bLTOMVqsRSUTcwG2/k/V/v+0nxOSd+BcnPVG/6OP+DkbkO
         volFhhs+s7N6gU+f8azu4LjOfEoquoFQ54Cp19xYO2dNAZMHf6YlMlnJbqq59w+jWrWN
         dw10IokMGHlpxOMpma/IAjLN385Vu1HedepRdCskdnzZm06vjmi/JSWs6HjKYUYowzSj
         obJgP5URC39ZBBX17XxcJ8Fd2NvpRmXifUuEKfN2EE/aI0cmZF+DWgISWc+1E3GJJeYR
         HPbkaHplJCT0LOMdde9qACZiLL37KvkTLqNMgTx4YdLAOLitlCzYoXj9d7OLM2lf8ZcF
         /miQ==
X-Gm-Message-State: AOJu0YxCSCKZLBCeqIWiMKCcdVYz/QTmHZwAmTDpTK2q+1pBTK9tyfVm
	EHvw5ValB6M/1XG3teNVmmRGYA==
X-Google-Smtp-Source: AGHT+IE12liFS3f22Ksa7SVPcpYz27eVsPPpKK9lLxjgXZ5jyt284l1QQjHweMQTJH1iqfKS8dckwg==
X-Received: by 2002:a17:90b:38c6:b0:280:1af4:b519 with SMTP id nn6-20020a17090b38c600b002801af4b519mr17683108pjb.35.1699240991292;
        Sun, 05 Nov 2023 19:23:11 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id x6-20020a17090ab00600b00277560ecd5dsm4651385pjq.46.2023.11.05.19.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 19:23:11 -0800 (PST)
Date: Sun, 5 Nov 2023 19:23:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org
Subject: Re: Bypass qdiscs?
Message-ID: <20231105192309.20416ff8@hermes.local>
In-Reply-To: <CAGXJAmzn0vFtkVT=JQLQuZm6ae+Ms_nOcvebKPC6ARWfM9DwOw@mail.gmail.com>
References: <CAGXJAmy-0_GV7pR5_3NNArWZumunRijHeSJnY=VEf8RjmegZZw@mail.gmail.com>
	<29217dab-e00e-4e4c-8d6a-4088d8e79c8e@lunn.ch>
	<CAGXJAmzn0vFtkVT=JQLQuZm6ae+Ms_nOcvebKPC6ARWfM9DwOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 4 Nov 2023 19:47:30 -0700
John Ousterhout <ouster@cs.stanford.edu> wrote:

> I haven't tried creating a "pass through" qdisc, but that seems like a
> reasonable approach if (as it seems) there isn't something already
> built-in that provides equivalent functionality.
> 
> -John-
> 
> P.S. If hardware starts supporting Homa, I hope that it will be
> possible to move the entire transport to the NIC, so that applications
> can bypass the kernel entirely, as with RDMA.

One old trick was setting netdev queue length to 0 to avoid qdisc.

