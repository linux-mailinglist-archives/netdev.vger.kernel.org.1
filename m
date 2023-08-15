Return-Path: <netdev+bounces-27744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AF377D15F
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 19:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC751C20D2E
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 17:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08A415AED;
	Tue, 15 Aug 2023 17:52:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E0413AFD
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 17:52:50 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F6910F4
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 10:52:49 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68866e64bceso584578b3a.3
        for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 10:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1692121969; x=1692726769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2StmdPyNiVVnHqGg8Az+OnsGftsS/Ij8qxhNGiftp8=;
        b=i4ogCwHfyiWCj7xrL6vJ9GO8+xoLOQMHusFVf/ODOFXyH1S/bB1uFPAefjOV2b7SUR
         alblkZakhcXVyPjwEmVZxA1imHOlUXZCguNXmpdT47o9sBoSjS2KObdxCv2mHiPyPLBt
         zFH3h8aCh3CGZm2Yr1JK6wM9WmSLytHdzFNsDHEMem6i6h5xYddNcdXSwzquYcWwvSt8
         23zMHATg/KePDMg5Df6OY69a7axVB9S6dX5/w4bhoDurB9rBjIjwePwz06gFFW0hVsDV
         2Wqnl+yk9SprZ+3WI6ux90Kt7FWAGDC/zdbmgjraH/HlSuI2UaNR7Lv5YRm4+A1TUUp2
         agGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692121969; x=1692726769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2StmdPyNiVVnHqGg8Az+OnsGftsS/Ij8qxhNGiftp8=;
        b=DIYHvPJSp5Ea7Q0QCQWBX13RqvAuvNoqy9iwatAGJLXKXj4dQf1g1r+8mJ98h1YW8U
         mC79jeQDEyResGyPjTrrYUw9aRryjGHKLa7+fMzjUFZ+z23D/SqgUsQ+Sd1lFHe6PNOA
         h/9xMpcq5voeGswSDGZ2LEQIy18jnR582HP4B+l9XoxOA+lRo/vznMphp2ERxjP5Xcyt
         iUKS7A2l1cySrISa4yQzrBQln2hJPW6ktVaZ4fJQ+nhVsWqfsMWPetG9IdjcJpZmHaK5
         IiAO4/aJUR0zMu6gRFPjs+6hzsIXdWCQQDy6cqtXfwXAhZQXE97c6dRQ+3KiPZsrfR8+
         +peA==
X-Gm-Message-State: AOJu0YxAaPSkwYlisIIxA8xNTpq0IFnqqHL1ItCKQIH0ssdKD4Dgd4Tp
	DbsAu8687sOpgo5pV1xtYnxThg==
X-Google-Smtp-Source: AGHT+IHgf4UnZEOqk2NnYD8qihR+MQD9lCNlI+Du2bxewG1P6d0nX/uFTVz9mi4N1njEA8z36VIaaw==
X-Received: by 2002:a05:6a20:9151:b0:126:af02:444e with SMTP id x17-20020a056a20915100b00126af02444emr17888235pzc.8.1692121968820;
        Tue, 15 Aug 2023 10:52:48 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id x5-20020aa793a5000000b00682ad3613eesm9583676pff.51.2023.08.15.10.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 10:52:48 -0700 (PDT)
Date: Tue, 15 Aug 2023 10:52:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: jiri@resnulli.us, xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
 vladbu@nvidia.com, mleitner@redhat.com, Victor Nogueira
 <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH RFC net-next 2/3] Expose tc block ports to the datapath
Message-ID: <20230815105246.0a623664@hermes.local>
In-Reply-To: <20230815162530.150994-3-jhs@mojatatu.com>
References: <20230815162530.150994-1-jhs@mojatatu.com>
	<20230815162530.150994-3-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 15 Aug 2023 12:25:29 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> +struct tcf_block *tcf_block_lookup(struct net *net, u32 block_index)
>  {
>  	struct tcf_net *tn = net_generic(net, tcf_net_id);
>  
>  	return idr_find(&tn->idr, block_index);
>  }
> +EXPORT_SYMBOL(tcf_block_lookup)

Use EXPORT_SYMBOL_GPL?

