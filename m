Return-Path: <netdev+bounces-41985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061F27CC870
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 18:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDA128189F
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ED945F6A;
	Tue, 17 Oct 2023 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="udMVZrhV"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908B745F65
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 16:10:52 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF26F5
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:10:48 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-407da05f05aso6079815e9.3
        for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697559047; x=1698163847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GOZy9r3gitQDazXMraa4da2VGsolgs7iqty+tLP15Ug=;
        b=udMVZrhVHBfong0gNbwFNoEnL9Ars+M0rwsUF1hwTifYGcXLyJik2YCGbekHbSds/J
         U4Jz70WvVyXWm7j09Fo7xIi6ww3r6ZGizLERI8kIy7Tof52YQs2jIaU/YJVMTC3nG7P7
         wfweRvzBQmrRSbesmhKKIH7DfuV+3DMIl4CoKLEhwR8H2+pHzUMGGf5B1pigvG0RosVT
         1xdspdVeiqW6uDS96v290Y4gvQh9pgQpVj6NRHP+zypTyWPvIb64oJrDSpx5rdLCBuGI
         nMTjvvGqcNbVpn2BZac14E7vemJE0a5369MRoKoSKSuUoMkTEyrf0+RDNPUNHGmlG9lO
         +lRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697559047; x=1698163847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOZy9r3gitQDazXMraa4da2VGsolgs7iqty+tLP15Ug=;
        b=LDVS9zke73QqtCnzANda2S8mCU1bLZE/LmgGfJezeLPu5G8uyjxNTUi+FAFS5iJk5u
         4n7s0E1Isemz94rhtDHMGVWaliHd8UnztMTbtOnSQX59NxG0ntAkDNiW1elQR8r9lUVZ
         6y08cAjyKXqgaXYoX8qrWaR5mF5fJjv9UJQ2TlPvTHic5/iAUnwB3qOCi8vbwzgT93EE
         WMmkB3CwEf9yO4w7r5X0+4WlziXMsogFWqo005GpxUjdFRLsPZnb831LND5DDDbjbmBR
         cucD7P16TvbTEcMIqldSGEA8OJXAqv0vi/diB1PKbKMzURF/a6wf6GabTaCen02N4Iah
         +x5g==
X-Gm-Message-State: AOJu0YzEKA9O+QBHZZqAysNqfTp0MMvm0S3+TWYjLhis/XYqq+5g7Rmt
	MXdTGS7VmoqTfuY99lzZ4L5VTM0TcqW6SNhZDFI=
X-Google-Smtp-Source: AGHT+IHUKgmUBlF1bXwGVmAYjKZFMFJSpGCM+V9H0vQquCa+SmNm4hNAQiCyJk74htxwV/xXTuAp/g==
X-Received: by 2002:a05:600c:1d13:b0:406:5301:317c with SMTP id l19-20020a05600c1d1300b004065301317cmr2017984wms.6.1697559047206;
        Tue, 17 Oct 2023 09:10:47 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id fj7-20020a05600c0c8700b0040772138bb7sm10249419wmb.2.2023.10.17.09.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:10:46 -0700 (PDT)
Date: Tue, 17 Oct 2023 18:10:44 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net 3/5] net: avoid UAF on deleted altname
Message-ID: <ZS6yBP+aZk67q8Tc@nanopsycho>
References: <20231016201657.1754763-1-kuba@kernel.org>
 <20231016201657.1754763-4-kuba@kernel.org>
 <ZS485sWKKb99KrBx@nanopsycho>
 <20231017075259.5876c644@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017075259.5876c644@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Oct 17, 2023 at 04:52:59PM CEST, kuba@kernel.org wrote:
>On Tue, 17 Oct 2023 09:51:02 +0200 Jiri Pirko wrote:
>> >but freed by kfree() with no synchronization point.
>> >
>> >Because the name nodes don't hold a reference on the netdevice
>> >either, take the heavier approach of inserting synchronization  
>> 
>> What about to use kfree_rcu() in netdev_name_node_free()
>> and treat node_name->dev as a rcu pointer instead?
>> 
>> struct net_device *dev_get_by_name_rcu(struct net *net, const char *name)
>> {
>>         struct netdev_name_node *node_name;
>> 
>>         node_name = netdev_name_node_lookup_rcu(net, name);
>>         return node_name ? rcu_deferecence(node_name->dev) : NULL;
>> }
>> 
>> This would avoid synchronize_rcu() in netdev_name_node_alt_destroy()
>> 
>> Btw, the next patch is smooth with this.
>
>As I said in the commit message, I prefer the explicit sync.
>Re-inserting the device and taking refs already necessitate it.

You don't need any ref, just rcu_dereference() the netdev pointer.

Synchronize_rcu() should be avoided if possible.

