Return-Path: <netdev+bounces-37303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA44B7B494B
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 20:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 0D7CC1C203FF
	for <lists+netdev@lfdr.de>; Sun,  1 Oct 2023 18:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E7A182C8;
	Sun,  1 Oct 2023 18:54:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288A91803F
	for <netdev@vger.kernel.org>; Sun,  1 Oct 2023 18:54:01 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35EA94;
	Sun,  1 Oct 2023 11:53:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31f71b25a99so15717523f8f.2;
        Sun, 01 Oct 2023 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696186435; x=1696791235; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3cD6+vLh9d0ZT/ELU9FRBDaG0MrX94eVa84jGJPRbYc=;
        b=j5F4gqElpltv8i3nHLnLvXd5fIh0rJdVa/zUOkc0oqRK9417SLVQed9chMkB6iNgwz
         0wt/pB7Y2DPl4iRdcH50bk3VCsFX50xKMgMoDSxykDLuEVUhzxT7k3Ne2/FviaWS5PpO
         gc/AzPUwxjqq19uR1t0Yvar/ey3xhWT/ZxQcULp7CX7EPIOJuYEYBF+fwMB1AjjzMK3o
         sLVBABzRthsXaIeEfc7nJVOJk6HpTfbmOOpsCBrWZplTUbLviGCq16yy8xpPYjoxZpEJ
         hyjKignNY9PeY25rFuTddrGOKg7RGG98SrYaUo9QxH8KZ4/IeiRR8ZOEh5GotO1aJhSO
         /tIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696186435; x=1696791235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3cD6+vLh9d0ZT/ELU9FRBDaG0MrX94eVa84jGJPRbYc=;
        b=S0dv4MuKBJqfs0KrT9HBLs1DFMroOHOq+YmPuGDWPp7XNMUBpm52/8afaFir0NI/84
         D6UNFfQsFvg9v5wpYzgVS6oegeI7EcouJkK7jF6aNPc9YWnGTyESIhd0iVg2PfC4C1Wc
         vgHg+O0RN5hgNBZCpbAo28RDEe4K4IjtHBC793XhUXHNaku7sYyTP5CeWFnG4O9kY93j
         mnrf1MuP/cj5rng3jhm1/65vtxkn7R3vQQopYTc2VuZrO9+bsE+VRntmPLMXk61xWTlV
         QwKVP/E096QqlAU9AqMZSSRiC10ndTUFf6dP3e2OEKF2+hfp/uTbEsFEhiz1T6K9Q2Zc
         OWsA==
X-Gm-Message-State: AOJu0YzNHzjxfbn7KXapCQyFAR5nLNl5X2ILsrKFZ7wVvW8oerq9LFbX
	I2gz2JgtrYT07MCV93LF8n/aMTBnsqTVi4byBck=
X-Google-Smtp-Source: AGHT+IFlkqsvcgnhD+3Mg6qa7uqBTqo20BB11WgxJqDc6++w/YY2dF7AwWBvKnyzvQerqV40/qL/GvLz0C61N8ICmq4=
X-Received: by 2002:adf:e583:0:b0:31f:f644:de09 with SMTP id
 l3-20020adfe583000000b0031ff644de09mr8222483wrm.6.1696186434871; Sun, 01 Oct
 2023 11:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926182625.72475-1-dg573847474@gmail.com> <CAM_iQpUbDR1S6hY6gPhjXrnWCQHGjQZ6JcB27zbauzdBhP76RA@mail.gmail.com>
In-Reply-To: <CAM_iQpUbDR1S6hY6gPhjXrnWCQHGjQZ6JcB27zbauzdBhP76RA@mail.gmail.com>
From: Chengfeng Ye <dg573847474@gmail.com>
Date: Mon, 2 Oct 2023 02:53:43 +0800
Message-ID: <CAAo+4rX0SVNnydubFLx2hfLJtuarnqFtSxGcUiy5O=HH-y_=Sw@mail.gmail.com>
Subject: Re: [PATCH] net/sched: use spin_lock_bh() on &gact->tcf_lock
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Did you find this during code review or did you see a real
> lockdep splat? If the latter, please include the full lockdep log.

No, it is found during static code review.

Thanks,
Chengfeng

