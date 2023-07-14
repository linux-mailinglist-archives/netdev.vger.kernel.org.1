Return-Path: <netdev+bounces-17861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDF47534C9
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 10:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0F81C21588
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C086C8E5;
	Fri, 14 Jul 2023 08:10:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801B6D30A
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 08:10:43 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F37C1
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 01:10:23 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso1102934b3a.2
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 01:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689322206; x=1691914206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ojUPb9bo+D1AoXnzwrNV2P+tdnMrgukgO7lMP4oVK9A=;
        b=SzfIiJQpK0Sq3x0dQWC1dpcNn6xwv0Qx608UCBgAec8Sg+2zG1chZbMyi0bfxpCyIQ
         74KkBBFh3lR1lsgsELwvFKH2Lb/sqkDggRnhbhB+l9s3xcUCl1galKj9kQnrmGb7D5XG
         t4xOxpae7S28VI9lozsplIAFdblLpFowpviRfwA0cNgFF5g2bs8vugAZvwuFPG35FuSQ
         oCW7tN+2owoD/O3biRngXbBslx4PFvmT1fPzhNeBFVgQ4evYOLD1lofuRTqk/+k857oH
         kihOpJEdkcq/7lLg1gBEjMGXoqMXSqXNUUcIm7T2Ysm5n1199yYzbYufyihJWV/jBSud
         Qr6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689322206; x=1691914206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojUPb9bo+D1AoXnzwrNV2P+tdnMrgukgO7lMP4oVK9A=;
        b=SeItXnbHSS2z6lgVT4CfposkZfUjtznjFLEY8lyak8hRRp6qNzVgySVAxgU9pwg7n6
         v1V4PC4EwbadChUEiB13vSPGatWls3C5jop/I82Am3Di/2OQegalhtnIN/CiroefNxFP
         WUK5T9Nrfip4IuxRWHK2RsNTqm/vo0UEeKbOVwmAozY+xjhzU/jBxO//EogS/AsCb3BF
         HE2I2fgX4Eur2TROXpOHLTjX6nmOdm+7hVw8LQoxzQLEAvP3A7RcZz5pvdk46A5pZGZN
         G0pN4yqMYv9r3mkglZU4QhS3ZaNwcOFh5LfMv1zxBlsDt3GEk7lrGH47NpLgAUyuUUFl
         v0YQ==
X-Gm-Message-State: ABy/qLa7XL/+5ci35bj+OfTCs5T+lGCyvPaoN+xjtU3by99TgzoAITcE
	Neb1CweI+lEFlX2CU+jbRqQ=
X-Google-Smtp-Source: APBJJlEFMi2TxoKXfo5+XFCdBmZ3r9K1xb0sn3Dy/j+79ZPtdbXYxaL5gNZUQTZsm8dvG3sG1ap2Ng==
X-Received: by 2002:a05:6a00:2190:b0:66d:514c:cb33 with SMTP id h16-20020a056a00219000b0066d514ccb33mr3615473pfi.6.1689322205721;
        Fri, 14 Jul 2023 01:10:05 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:782f:8f50:d380:ebf:ef24:ac51])
        by smtp.gmail.com with ESMTPSA id j6-20020aa783c6000000b0063a04905379sm6616598pfn.137.2023.07.14.01.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 01:10:05 -0700 (PDT)
Date: Fri, 14 Jul 2023 16:10:00 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Liang Li <liali@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net 2/2] team: reset team's flags when down link is P2P
 device
Message-ID: <ZLEC2OQGS/gFsfKI@Laptop-X1>
References: <20230714025201.2038731-1-liuhangbin@gmail.com>
 <20230714025201.2038731-3-liuhangbin@gmail.com>
 <076ccae1-22e7-d7ab-1143-41a7a6f73b67@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <076ccae1-22e7-d7ab-1143-41a7a6f73b67@blackwall.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 09:52:03AM +0300, Nikolay Aleksandrov wrote:
> > +	if (port_dev->flags & IFF_POINTOPOINT)
> > +		dev->flags &= ~(IFF_BROADCAST | IFF_MULTICAST);
> > +		dev->flags |= (IFF_POINTOPOINT | IFF_NOARP);
> 
> here too, looks like missing {}

Yes, you are right. I forgot to add the {}. When do testing before post the
patch. I just checked adding gre device to bonding and didn't check adding
ethernet interface...

Thanks for your review.

Hangbin

