Return-Path: <netdev+bounces-38224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB897B9CEB
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DB788281BAE
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 12:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AC4134C5;
	Thu,  5 Oct 2023 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNBXdUeX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D855011CA6
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 12:16:11 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1719261A0;
	Thu,  5 Oct 2023 05:16:08 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-307d20548adso896033f8f.0;
        Thu, 05 Oct 2023 05:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696508167; x=1697112967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K9RLPKw/fdVMOG2mqUZ1IRmtC3X+vMbGsjNsnzZlTRY=;
        b=UNBXdUeXgUzUFGA4y04IfXkfA79DH8CSlX+6NgwrUJxUUDXxJkLrN3QVXQzqxJpBvU
         q2ibQn46etLD/XUP4lol3pBO1+b2e1RGr1N9b8yxGgtObWGdZcOcLk5Zf4LMxstqaKy/
         qiuEGcdGfqWjqfiv4acmnISS0M//uzL+nIt2b1cxdJB0FjekP/Jd33rCgVExqnwOLgn0
         1GNgPkMcVFd9if2X6hkxqYWgYcd0Nlo2YueclaxCQMcfTs+97yVF4CV4Ib6M7GfyrBTl
         hciGk1ssg+yytJNBQ1GGxk+v/FKl0bwzXlZZERLpEwQtTKHe9ua16Iq2O0BMxfFzWSyY
         c7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696508167; x=1697112967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K9RLPKw/fdVMOG2mqUZ1IRmtC3X+vMbGsjNsnzZlTRY=;
        b=P0rMuOCVZvgDJgTlr0B+2/g7dcDlERUBs0NdSqJdHPK9D7F7kJOxwngk8D2RBlA2SY
         SaJ/Vhq5S+YpYf+24sdNPIhr5eBnBd004YccsP9eNsY4Bc+N+dj+/88pDnf4uZlkXIS3
         GX+H4pRrxEKBjxYY1+8nmxOkaQ9FMvazfPcWVhEuOclWm8cr2NHIR8Q/zKQSbgDHkXBx
         6EtfNTc3j3WK1XMZI88D3GLjx4rfGiRh957Aeotx5YKLH6gLv+RV/L4rP2QGgToZ0kc1
         dcBn6cWHXWDGXS3KWejJMjgrqsLcqgRDn+Kn2NO5vSIqGM8r1mcyFHHiiP8rFWcY9qw9
         sjsA==
X-Gm-Message-State: AOJu0YxObJZUhITJ5ZX1UBaxT5uwG6KHAVyrlxUJk8qh6OLbirE40hpJ
	9q7iCGNBq2oYru4rmrJB8HQ01SDRRK98k5jEhWs=
X-Google-Smtp-Source: AGHT+IGcFTOdc9DVt1jQkccvp+BluXK8jOFb5t5ML2mh2pR8qWoJvyzHS8RhH+58BfEtm4AwdF7uOM965BiKgfKDTRM=
X-Received: by 2002:adf:ec83:0:b0:323:3346:7d51 with SMTP id
 z3-20020adfec83000000b0032333467d51mr4462588wrn.18.1696508167002; Thu, 05 Oct
 2023 05:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926182625.72475-1-dg573847474@gmail.com> <20231004170120.1c80b3b4@kernel.org>
 <CAAo+4rW=zh_d7AxJSP0uLuO7w+_PmbBfBr6D4=4X2Ays7ATqoA@mail.gmail.com> <CAM0EoMkgUPF751LpEij4QjwsP_Z3qBMW_Nss67OVN1hxyN0mGQ@mail.gmail.com>
In-Reply-To: <CAM0EoMkgUPF751LpEij4QjwsP_Z3qBMW_Nss67OVN1hxyN0mGQ@mail.gmail.com>
From: Chengfeng Ye <dg573847474@gmail.com>
Date: Thu, 5 Oct 2023 20:15:55 +0800
Message-ID: <CAAo+4rU0jBCcUha97nwVBWW0jmFnrYMowMzEkY+ocdzd=1LiNQ@mail.gmail.com>
Subject: Re: [PATCH] net/sched: use spin_lock_bh() on &gact->tcf_lock
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Horatiu Vultur <horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Does it mean that dev_queue_xmit() should be executed under BH?

Thanks,
Chengfeng

