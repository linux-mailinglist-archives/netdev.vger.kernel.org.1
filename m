Return-Path: <netdev+bounces-24665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9DD770F79
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 13:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 662411C20AE4
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 11:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E437CBA32;
	Sat,  5 Aug 2023 11:42:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E11AD4B
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 11:42:15 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBA84237
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 04:42:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so392868766b.3
        for <netdev@vger.kernel.org>; Sat, 05 Aug 2023 04:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1691235733; x=1691840533;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=k6Y9MNbIt5MMr2JktZgXr7fTuliQI1Ck5YB33zesjx4=;
        b=XiEYqHCjrDcHG55aUzGYQuK1EczndKnWBI6Bhk8PO8x7RmpuM2FSd6O9f0xZIImxnZ
         K80M8YZkYW6c9WOIZ8ATSsDw3fASmOkxR6Z7qj1+eyteH3EMdTfNUDizuWhzHQcep0Rz
         TkQmf7DFK7P6Zua3Od6tNUrwPR/05QVd6Q61Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691235733; x=1691840533;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6Y9MNbIt5MMr2JktZgXr7fTuliQI1Ck5YB33zesjx4=;
        b=DwK8s/71INHi4Xq5jt0pkqDYVRAOoNBImNgyD+h3iUFrQJWTbwA2bzvU+tt1JTg4p9
         rl7MJFi1eC4jlNi1Uqctx1PlXmbPBadc+zbkl36BUoz35Q9TVIax3sKKt1NYHm2M6f3V
         Z1EQewyWbDul77I54k5XNs6ZQkPRbRKPGYq+fkNKN5dU9f4iLxSr4Eh8RjCKQ528fnhS
         BnvenV5xYlc6IUpHkCqA2K/pgb+tOZtI72UI3Vd8ihps/zz08cUEmUACECUh1WRBnTsP
         LWlfAeFll4n5JbBul7PEbBfh3aXrvxLUlkr9WL040JmdL8ZDlnzZIIXzpvpdXk9QFVqI
         Oozw==
X-Gm-Message-State: AOJu0YxVIFg9EXjSihaRDSv4enTbTPO+X9sCBhtc7wHMZxPeHRvYNKq2
	hn7gzoBy0Qz7nhEabzikqw9uFw==
X-Google-Smtp-Source: AGHT+IGTs0CwwRaOkTaLx3T6Sd7D3qdIfFpZYkNjlkKWuleOZnLuzPAmjNoBgvkSYFBoriZd9m1OHw==
X-Received: by 2002:a17:906:3014:b0:99b:f8ab:f675 with SMTP id 20-20020a170906301400b0099bf8abf675mr3729947ejz.14.1691235732980;
        Sat, 05 Aug 2023 04:42:12 -0700 (PDT)
Received: from cloudflare.com (79.184.136.135.ipv4.supernova.orange.pl. [79.184.136.135])
        by smtp.gmail.com with ESMTPSA id bw5-20020a170906c1c500b00988f168811bsm2604423ejb.135.2023.08.05.04.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 04:42:12 -0700 (PDT)
References: <20230728105649.3978774-1-xukuohai@huaweicloud.com>
User-agent: mu4e 1.6.10; emacs 28.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, John Fastabend
 <john.fastabend@gmail.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf] bpf, sockmap: Fix map type error in sock_map_del_link
Date: Sat, 05 Aug 2023 13:41:41 +0200
In-reply-to: <20230728105649.3978774-1-xukuohai@huaweicloud.com>
Message-ID: <87zg35wwa4.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 28, 2023 at 06:56 AM -04, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>
> sock_map_del_link() operates on both SOCKMAP and SOCKHASH, although
> both types have member named "progs", the offset of "progs" member in
> these two types is different, so "progs" should be accessed with the
> real map type.
>
> Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

