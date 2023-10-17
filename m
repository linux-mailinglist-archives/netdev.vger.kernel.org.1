Return-Path: <netdev+bounces-41992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C367CC8F0
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 18:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07F9EB210C5
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 16:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113582D033;
	Tue, 17 Oct 2023 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="nxQAjXMb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A652D02F
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 16:35:36 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66F1B0
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:35:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so9858447a12.2
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697560533; x=1698165333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8ktmgUFN4e8+KQGeUyrdOM78MzRQtE5LLsWYhWTO6YE=;
        b=nxQAjXMbmK0OOTNZrix0H0ylU7gfqM71VYvdqKDK+4DwC4AYuHCSJe3NGrxbPkSkNu
         z6DBD0ibT/7z5aNfRmaz/ogyWOYY2H+TldcElM57MegMayLQN47SIhD/q9WzJiwynZjL
         LzTO0wjJNsBiuW4kqzP7aOlsHn0YmSqz4TGVIFSj76rTDPG9ylX76lC5khpEkdCDXfTp
         9ByBr02GUXmB7OwWvn/Hu+myui3es9JzALQm90AkwoRQmLAzkaUNhHe9hSRzxOUfW2ta
         bCtynwqT77pq63MTbBa0D0ep8y260s/rjWf5bDODywTbXv6bJ1Qd9SkMgihQKBvNs9dg
         hYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697560533; x=1698165333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ktmgUFN4e8+KQGeUyrdOM78MzRQtE5LLsWYhWTO6YE=;
        b=n2xSPSLgxA+3wOelE3WtQH9t0/qoj6Xk0mECis5E5/3go3i4m8RYdx2QjpNiRcN4LJ
         ODutZfoS+2lMZf30ztesPpRYsA2HFwuz1vD5+t3MnB8FwwaUo3qvpCxuN4UPJ+VTkUYy
         iPDl6mYowmRzjKYGRgiFUslEeAG3a/VJCR3r7d75PsqiGzsEKGI0B2O9RMC0Ai9JMjZS
         15UAUgyPAgiOy8GlUOflQsDrorgf7SPiqVb/v5/lzHAdmV4sxyOHwLgQHfHQEZf3KMRg
         pQ3qDF4c97OIIsdkOZp1q/Veu9yWj40Hq3lA+d0koQcGkZEX0K9FRyr5ajIBx1QOiMvT
         VQLg==
X-Gm-Message-State: AOJu0YzZ8r1LVnSQ3EAbDVRJO8Tyr7GGub6j4Y2MPqlzK+dnyx7ucaon
	kqn8eFsd2qYTJxg1KdkWJime/Q==
X-Google-Smtp-Source: AGHT+IF1bmnRb7vyMmIOG6KrfafwN/IlE64x2FUOdtNv5hQEXBJZHkHmuJ3ZwwwDfGYm3gowmFLIQw==
X-Received: by 2002:a05:6402:280a:b0:53f:1067:4b93 with SMTP id h10-20020a056402280a00b0053f10674b93mr2501991ede.16.1697560533258;
        Tue, 17 Oct 2023 09:35:33 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id ev12-20020a056402540c00b00533e915923asm1479404edb.49.2023.10.17.09.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:35:32 -0700 (PDT)
Date: Tue, 17 Oct 2023 18:35:31 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net 3/5] net: avoid UAF on deleted altname
Message-ID: <ZS630zlfkUGEi5vg@nanopsycho>
References: <20231016201657.1754763-1-kuba@kernel.org>
 <20231016201657.1754763-4-kuba@kernel.org>
 <ZS485sWKKb99KrBx@nanopsycho>
 <20231017075259.5876c644@kernel.org>
 <ZS6yBP+aZk67q8Tc@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS6yBP+aZk67q8Tc@nanopsycho>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 17, 2023 at 06:10:44PM CEST, jiri@resnulli.us wrote:
>Tue, Oct 17, 2023 at 04:52:59PM CEST, kuba@kernel.org wrote:
>>On Tue, 17 Oct 2023 09:51:02 +0200 Jiri Pirko wrote:
>>> >but freed by kfree() with no synchronization point.
>>> >
>>> >Because the name nodes don't hold a reference on the netdevice
>>> >either, take the heavier approach of inserting synchronization  
>>> 
>>> What about to use kfree_rcu() in netdev_name_node_free()
>>> and treat node_name->dev as a rcu pointer instead?
>>> 
>>> struct net_device *dev_get_by_name_rcu(struct net *net, const char *name)
>>> {
>>>         struct netdev_name_node *node_name;
>>> 
>>>         node_name = netdev_name_node_lookup_rcu(net, name);
>>>         return node_name ? rcu_deferecence(node_name->dev) : NULL;
>>> }
>>> 
>>> This would avoid synchronize_rcu() in netdev_name_node_alt_destroy()
>>> 
>>> Btw, the next patch is smooth with this.
>>
>>As I said in the commit message, I prefer the explicit sync.
>>Re-inserting the device and taking refs already necessitate it.
>
>You don't need any ref, just rcu_dereference() the netdev pointer.

Oh wait, you are right. Sorry for the fuzz.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

