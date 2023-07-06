Return-Path: <netdev+bounces-15874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8420474A353
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 19:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352712813CC
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 17:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640C6BE64;
	Thu,  6 Jul 2023 17:43:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C839460
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 17:43:24 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B47E10F5
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 10:43:23 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55bbb6f6219so1104005a12.1
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688665402; x=1691257402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1d4dS5X4mOcUFqaYDlBqbPGHvZ0D/b2hFGAQQIE5nj4=;
        b=qBMQrikKzv0sgqQtu4U3ru5ROt77wCDN7HJEZJa19Gr7iEbUYlkyaTDviExKB0UHdJ
         o8SZrncT/4Uh/QZofWLym0VhhIvwk7iCm0OHZzjGgIptK/+C16IrLhqmdpR608pOjO2s
         imRyIHcisSWW9tFuIX84DCMAm+bfe2wY6XfvMUw9DJPCor8GkdDjvnxDg1faT2FoozqQ
         duvBAwgcF6O0mdLk4YsKJz7rvXsg+t3pDveBxFZKHpnX1HH4gKlX9ASkX3wOBzj5YI+1
         dWsFKjNR59WvizNN48l3ImzUobgQu/31P0lObaK219TvUeVWuQ69zLBm7oRu/0T/NXZc
         bv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688665402; x=1691257402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1d4dS5X4mOcUFqaYDlBqbPGHvZ0D/b2hFGAQQIE5nj4=;
        b=Cio0XyAYPfADlmig4Ye9sgaABxdU07OUEe3q6mGWGhiwEo84EW6M4nn8Uz5wnFzzZl
         sVdveb1TIgk9nBPV6omuacQy0Q1zUqIkZ5/Pv2aY23wVIN6rFDqnfGS6iY6A+aCQMEH/
         V+VhC55GkPRIevpqTmFSdDrRmLUdbVEeYBBX4+1NxnH7yw0rezgfbB0M+2HrYnX/fDog
         BX5P+78QvpsN7Wx1fL6gqYG7Zxp/ORl4AzPXeVDudOjeupcLdDNYxcqw6Qamds5XxMXY
         RGZEQI+SmLJoBfyZVbvd8pSx78JROQlTzlE6YZ0Xlzo3ryisgMTucnuzddG4+beofkov
         8ydQ==
X-Gm-Message-State: ABy/qLaFBQo//fMTMxE5S+fA+iJutWf2zZ2VCy5S3+qr30hvqi/olI/u
	4gjzYqu+QXF9I75MvK9DSl4oKkU=
X-Google-Smtp-Source: APBJJlGkIfRcijMErYmInxuXIeVJi6aEOdV8m3eTn5zkrPOLieSc1smcx8jcixd6s751dvsotnCJYF0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:705e:0:b0:55b:da1f:7e03 with SMTP id
 a30-20020a63705e000000b0055bda1f7e03mr1537469pgn.3.1688665402568; Thu, 06 Jul
 2023 10:43:22 -0700 (PDT)
Date: Thu, 6 Jul 2023 10:43:21 -0700
In-Reply-To: <20230706100243.318109-1-liuxin350@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230706100243.318109-1-liuxin350@huawei.com>
Message-ID: <ZKb9ObvvhOaKXJcp@google.com>
Subject: Re: [PATCH bpf-next] bpf, sockops: Enhance the return capability of sockops
From: Stanislav Fomichev <sdf@google.com>
To: Xin Liu <liuxin350@huawei.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	hsinweih@uci.edu, jakub@cloudflare.com, john.fastabend@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzbot+49f6cef45247ff249498@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, yanan@huawei.com, wuchangye@huawei.com, 
	xiesongyang@huawei.com, kongweibin2@huawei.com, zhangmingyi5@huawei.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/06, Xin Liu wrote:
> Since commit 2585cd62f098 ("bpf: Only reply field should be writeable"),
> sockops is not allowd to modify the replylong field except replylong[0].
> The reason is that the replylong[1] to replylong[3] field is not used
> at that time.
> 
> But in actual use, we can call `BPF_CGROUP_RUN_PROG_SOCK_OPS` in the
> kernel modules and expect sockops to return some useful data.
> 
> The design comment about bpf_sock_ops::replylong in 
> include/uapi/linux/bpf.h is described as follows:
> 
> ```
>   struct bpf_sock_ops {
> 	__u32 op;
> 	union {
> 		__u32 args[4];		/* Optionally passed to bpf program */
> 		__u32 reply;		/* Returned by bpf program	    */
> 		__u32 replylong[4];	/* Optioznally returned by bpf prog  */
> 	};
>   ...
> ```
> 
> It seems to contradict the purpose for which the field was originally
> designed. Let's remove this restriction.
> 
> Fixes: 2585cd62f098 ("bpf: Only reply field should be writeable")

The commit you reference explicitly says that there is no reason to allow
replylong[1..3] because there is no use for them. Has something changed
since it was added? Any reason to expose those fields?

