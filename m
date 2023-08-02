Return-Path: <netdev+bounces-23708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CCB76D3E3
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 18:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F861C212C2
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 16:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E695D2ED;
	Wed,  2 Aug 2023 16:41:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F012C80
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 16:41:12 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC222695
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 09:41:11 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686f94328a4so35669b3a.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1690994470; x=1691599270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YEMmyaEiU78D2J2YqP0fXgvy2Bwv+XoZoJnJYopKYE=;
        b=0iB73p0qc86MAKwqZx957iE+ZfmLvbL6uZMh32IwdfxWW54n6ZKbQUIgUhrKagRIH+
         WYv+oFAa49pG6MCcNIVDh73ZclvXpmbHCxwIW2uCeP6rE8AdFWf/yYiu4n+szmqBTg19
         Ox4v3yZSVx1Bqe24o44bN94ds33rHNBuMG9iXll6bT+hQ7l+tqZLlgMAsLLfYp1mkdF2
         Cob1JVuiOW0F1S7KpBhAgtCKohoyxl8X/stLuRUXjJEv+rVBEMB6NLEyM0n1NSMkDaF3
         siNfqFJBjJvPVqZ16WbaYc8g9DbIoGjdOkaKrmmlQo+sN/wVrMWRTszbx0YZmTMYJu6Q
         P//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690994470; x=1691599270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YEMmyaEiU78D2J2YqP0fXgvy2Bwv+XoZoJnJYopKYE=;
        b=T5ooP19Hw2aeuUO/2xzVcWNT+6iJPcTpoAKsa9M+GbFQfwpgiQlIEjsxtnvrN7hkiL
         MOfMeRslCTdhc4BnYTKb0g0jlE/DTLvq3vmLJGncYxMlvsysUpt1ueBJPAuLdmYPNrqu
         J7mySHhrAxAPPXhr0zARD2dgrH84wnqZx/UFWPfkj9QYpq+Vv3jJkxF8yMk34RTnzPhV
         PeMy/RZJxvCRFjAag13K0J57P6qX7KC2cZxPpy6qmCUia8HV9OqyeAOOlQJA7b6kwilY
         BzzflnxmcNcPVkH+ah2W19+mnnuVm5o07dnDjH3kJ8lREFbz/cn6fPVssWahbX75liee
         vv3w==
X-Gm-Message-State: ABy/qLZtXMABpuunQFKe9mU8Tlb1KIHujgnxsafYOOQRXHGyyh1pHJwC
	ckpYvDEqU0iNERKGLJ+mSG3xCg==
X-Google-Smtp-Source: APBJJlGE0PJJrN1lcUbc/bN/hXmsWeudIX9/nPtYWDZc2btz0QSJ3z0sG7+zZSl4nbjqLvQirmGIJQ==
X-Received: by 2002:a05:6a00:2286:b0:687:570c:da2d with SMTP id f6-20020a056a00228600b00687570cda2dmr6455028pfe.12.1690994470560;
        Wed, 02 Aug 2023 09:41:10 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id v14-20020a62a50e000000b00681783cfc85sm11650360pfm.144.2023.08.02.09.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 09:41:10 -0700 (PDT)
Date: Wed, 2 Aug 2023 09:41:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: Space.h: Remove unused function
 declarations
Message-ID: <20230802094108.1de6feba@hermes.local>
In-Reply-To: <20230802130716.37308-1-yuehaibing@huawei.com>
References: <20230802130716.37308-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2 Aug 2023 21:07:16 +0800
Yue Haibing <yuehaibing@huawei.com> wrote:

> Commit 5aa83a4c0a15 ("  [PATCH] remove two obsolete net drivers") remove fmv18x_probe().
> And commmit 01f4685797a5 ("eth: amd: remove NI6510 support (ni65)") leave ni65_probe().
> Commit a10079c66290 ("staging: remove hp100 driver") remove hp100 driver and hp100_probe()
> declaration is not used anymore.
> 
> sonic_probe() and iph5526_probe() are never implemented since the beginning of git history.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

The static setup in Space.h is a legacy from early days (pre 2.6).
Should go away, but probably has to wait until ISA bus support goes away.


