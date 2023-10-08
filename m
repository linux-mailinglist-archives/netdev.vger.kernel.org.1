Return-Path: <netdev+bounces-38907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBA27BCF73
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 19:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C1C28114A
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 17:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C2717735;
	Sun,  8 Oct 2023 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx/Sivyp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED7E11725
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 17:56:13 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB2BA3;
	Sun,  8 Oct 2023 10:56:11 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso2787463b3a.0;
        Sun, 08 Oct 2023 10:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696787771; x=1697392571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZ3V3/WIgMOXNTQMLjEbSnI+9wH67IrtaCQKwXc776o=;
        b=Yx/SivypN+SmQ0hLXY2r5oqQxRBE3L2sJ9GgDNvbq/rSiF5pmyp4Ah+JugsCqvza+f
         WfqTa+KX4+Q5dtNE6TfStwxT2v7IcjeXIAled3hwIwDwxLwtU6z86KPsrbAkOgDkfXpd
         rTi8Gd8W9tjGCO8vl0eheCylKYoI5nZCLXyPhRti58I/JDOVzJMDnrONFtzof5ZlEIqq
         OBPHy1Hr2fUMhZf/HWekuNK3tg7HvblBCbPHF8zmtM89eRiWDnq853X9k7cY+/6LRWgj
         Id0VAjdOSgcSzlAYybHfA4X0OhzsQqUT+57FOBFlIdNhQ8ylp24WsCxcBonuvLNLora3
         efGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696787771; x=1697392571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZ3V3/WIgMOXNTQMLjEbSnI+9wH67IrtaCQKwXc776o=;
        b=BF9FFmFzGorN8ZkhpJVi3DEyp1Dmy5pXwJATACYr49LgLvwgLp6uEzdfh44JsDJAuJ
         s0aNGC5BJ0R/cCXUgwZzNzw2EXDBKo4jAHq6Fe1+s8hhsH3W7CeajDDDEtDZzI5wMbnM
         cqED0zC4uXVYucFEYgjwTtgf9PvCQWW3X48qraNDCrj4+FfTPNA5FRPRPHUXsPjd9lno
         67NYD8e67KcZ5C/uUIT5+VoxvOr2tj/AYU1T/yWQPQfWKDc5+EEIjwdENRf/ifRiAIGu
         AuFI2/mpYT53nR3hQJ+oVViFRziCZ6afyuju8wZZCNlO6yOQSSUc9oVQhQhLi3UaZ1Sy
         NQ9w==
X-Gm-Message-State: AOJu0Yx5uVgAsVFIUxhwezZh3l2aRTP/BPCf0edxSzc7SNole4sWpIxK
	ixDqlmfJhwm5BMscmkjYc/Y=
X-Google-Smtp-Source: AGHT+IFQRUlCxOh9bg4szXxxTdkiXZAhyVLgLHbMhr1GVAVfukmQjzxuiJoHNl7g5ElNRKV330vluQ==
X-Received: by 2002:a05:6a00:1d85:b0:68e:2c2a:aa1d with SMTP id z5-20020a056a001d8500b0068e2c2aaa1dmr11798246pfw.11.1696787771033;
        Sun, 08 Oct 2023 10:56:11 -0700 (PDT)
Received: from localhost ([2601:647:5b81:12a0:a3e9:5a65:be6:12db])
        by smtp.gmail.com with ESMTPSA id k22-20020aa78216000000b0069337938be8sm4785516pfi.110.2023.10.08.10.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 10:56:10 -0700 (PDT)
Date: Sun, 8 Oct 2023 10:56:09 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, jhs@mojatatu.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sched: use spin_lock_bh() on &gact->tcf_lock
Message-ID: <ZSLtOViO2p31Jzd6@pop-os.localdomain>
References: <20230926182625.72475-1-dg573847474@gmail.com>
 <20231004170120.1c80b3b4@kernel.org>
 <CAAo+4rW=zh_d7AxJSP0uLuO7w+_PmbBfBr6D4=4X2Ays7ATqoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAo+4rW=zh_d7AxJSP0uLuO7w+_PmbBfBr6D4=4X2Ays7ATqoA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 05:01:07PM +0800, Chengfeng Ye wrote:
> Hi Jakub,
> 
> Thanks for the reply,
> 
> I inspected the code a bit more, it seems that the TC action is called from
> tcf_proto_ops.classify() callback, which is called from Qdisc_ops enqueue
> callback.
> 
> Then Qdisc enqueue callback is from
> 
> -> __dev_queue_xmit()
> -> __dev_xmit_skb()
> -> dev_qdisc_enqueue()
> 
> inside the net core. It seems that this __dev_queue_xmit() callback is
> typically called from BH context (e.g.,  NET_TX_SOFTIRQ) with BH
> already disabled, but sometimes also can from a work queue under
> process context, one case is the br_mrp_test_work_expired() inside
> net/bridge/br_mrp.c. Does it indicate that this TC action could also be
> called with BH enable? I am not a developer so really not sure about it,
> as the networking code is a bit long and complicated.

Doesn't __dev_queue_xmit() itself disable BH with rcu_read_lock_bh()??

Thanks.

