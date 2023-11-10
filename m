Return-Path: <netdev+bounces-46965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6343E7E76EA
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 03:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9EECB20B90
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 02:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BDDEA9;
	Fri, 10 Nov 2023 02:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="eAnxbr0Z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0183EA6
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:00:04 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A77D63
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 18:00:04 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc2575dfc7so13154325ad.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 18:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1699581603; x=1700186403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8He9YqTbkF51s3BPfGK5kHNl+dAW8mFOthpsJ1/NB/g=;
        b=eAnxbr0Z6EFCvIrRxqKulygnqgp8CrBImG2KCxM/rRBPmj773HlQfRmOqjjznCNjCr
         yEAnQ0lSYDtixGojLm86GCYscCNI+IMWJSweJxVwfz00A6Kner1A7c+gAbZGSLscstue
         kM581lJIP6Dv03AoRij+QRmwaS5qdwyP1dhvep0CuO6KYi4FmyIpTVOfFrDDY3N71lpD
         +kUvrtTNe1LNmKn1zsY40EM+xz1TOYAFPiQ8BbXnmSzk8Qq27fOfxvB5hpMrAWyhQYnL
         HWDnA1DLKrNAFs3x7fBNKmsWojER2ev2Fh836RVjwmKAC4ocIdB8dQPjQ4U/8NQayPEn
         R9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699581603; x=1700186403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8He9YqTbkF51s3BPfGK5kHNl+dAW8mFOthpsJ1/NB/g=;
        b=Sp+pOvTzZ4lHAT8k84iuIYgHEInVggF/RwUW7ZLiJca4+SqUAaPWgn/BNFq1ASk0HQ
         D9g55VokRpXoeaIddPP+c94Elvx+jBhZKDAp2lPNKC1EllX8TiYpG99e2CrI0M2mroqe
         wDNiWKIAaaxr0N6/489JvBWjcY8FRAlElSa2nzrvIAJXBAsIgEkVxwQfyF11IL1BhRCn
         +u4eRak0os6Tw8ykRIse9zLOojn5QpwI1IfH+qlwwHb4xGe/DD+6xgHfejoYFdXslq5r
         Qq0qV0iDQOqVIMLxkliy1jKoXELkZcT7JhDx/lrC2geYvl7BpF99zOLVj0XB7RSpsg9+
         9HiQ==
X-Gm-Message-State: AOJu0YyjsCFwsoIC4DvS+Z5QbdVvPOGHypmFSktBeZLmvXKExspYoA/Z
	lTZiJnW6DITlLxINNgTCqvCoaw==
X-Google-Smtp-Source: AGHT+IE4KY6yaw72j08kBhj3R5o1+nr9gUA37fKV6+VvATUxyWzWJnD5AwHpG3AcU1SsiDOnqbsJXA==
X-Received: by 2002:a17:903:2cf:b0:1cc:32df:8eb5 with SMTP id s15-20020a17090302cf00b001cc32df8eb5mr7576653plk.6.1699581603429;
        Thu, 09 Nov 2023 18:00:03 -0800 (PST)
Received: from [10.54.24.52] (static-ip-148-99-134-202.rev.dyxnet.com. [202.134.99.148])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001cca8a01e68sm4169882pld.278.2023.11.09.18.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 18:00:02 -0800 (PST)
Message-ID: <99bd5dc1-18fa-4b5c-8c86-236aa976506d@shopee.com>
Date: Fri, 10 Nov 2023 09:59:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] boning: use a read-write lock in bonding_show_bonds()
To: Jiri Pirko <jiri@resnulli.us>
Cc: j.vosburgh@gmail.com, andy@greyhouse.net, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231108064641.65209-1-haifeng.xu@shopee.com>
 <ZUz/AB/kdChj5QHE@nanopsycho>
From: Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <ZUz/AB/kdChj5QHE@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023/11/9 23:47, Jiri Pirko wrote:
> 
> s/boning/bonding/
> ?

Yes, Eric has pointed out the problem in last email.
Thanks.

