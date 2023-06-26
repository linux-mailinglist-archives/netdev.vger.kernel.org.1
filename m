Return-Path: <netdev+bounces-14069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472B573EC09
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 22:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0600A280D2A
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 20:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1096213AC0;
	Mon, 26 Jun 2023 20:47:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B7125AA
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 20:47:26 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98765E4D
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 13:47:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b7db2e162cso12402895ad.1
        for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1687812444; x=1690404444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kms0H0qh0BC4E2qqH9Z2kg6XISwIpNu68Rt88k6ZU9Q=;
        b=b6tD4vEHA9gzY35UuB/3ZPY6VXg3JK4i/zJQpSmzcyjmImYw3S3AZxmuC/LO7qrRHL
         0OPNSnECNq6rI1m+NTfcw5y4T4yOBrqbj14pLGLE6W/zhm7plrIW8tUujSR4hcynV1oy
         P27X5sd+Hc+Q25xcY/jY5XFyFA+6UBpUcLgqxaSBEEv4BCXrxzK7Omy2zHpQzEc/DjPR
         13neo9pSlKT+sV1tPjVkBlICkU85jivaG3EsWDBtcI4FxNBTSYwk2uMDzZdEYlvtSu6a
         NWv0o8xHVXOk9+J+HhT60qemCSboEreLuD/mxA2KGBfXxNMoI6L4H9hGxULcqImpM8Dy
         1qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687812444; x=1690404444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kms0H0qh0BC4E2qqH9Z2kg6XISwIpNu68Rt88k6ZU9Q=;
        b=PJmeyP7UReuEEpJm6cf0QjPv4Az6IwG4XYyBDu2zxaDih5x1KoBJ+vgIuFXWcWKwwF
         Uk9OzBGyfTvJzufCfwlFazYcWcmdqw80vamp8nbSum/oTWhjmUgURQ+85UbjetpHqnxb
         LSupCxrxE0KueyYchPwcotsel3jT/U6u0+mme6mPe6rISFdVEKBKBaAZi9bXM7MY03WM
         TDLpLzyeCZ445TsfbF4aUYgsMXssX2Mo4yBs43KPLX+rQyY4dodsRTTURkADo4yQzebU
         61xqae6WWM5yc4AXZUSS7mAogzNtvwW6TBvZ1wKU6Z2Pu+nKYYLs4/9KqtHK8EvUZn/L
         V25w==
X-Gm-Message-State: AC+VfDxbEWu8yo1Me87IpSmEDDOhBGdbT0tj9y9zbzqto66iTEWls4xJ
	CADrsut9OQzmUH9liz2ma+o3Gw==
X-Google-Smtp-Source: ACHHUZ5fzWr4Vm6bBdKDmKxsox3wJmLPjxaF521aPRnVQeoeej/eMt9HBi1dHHVHz+Pmx4dFCv82Ug==
X-Received: by 2002:a17:902:c085:b0:1b6:a972:4414 with SMTP id j5-20020a170902c08500b001b6a9724414mr4558982pld.3.1687812444029;
        Mon, 26 Jun 2023 13:47:24 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id k19-20020a170902ba9300b001ab39cd875csm4594066pls.133.2023.06.26.13.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 13:47:23 -0700 (PDT)
Date: Mon, 26 Jun 2023 13:47:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Dexuan Cui <decui@microsoft.com>
Cc: Simon Horman <simon.horman@corigine.com>, souradeep chakrabarti
 <schakrabarti@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
 <wei.liu@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
 <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Long Li
 <longli@microsoft.com>, Ajay Sharma <sharmaajay@microsoft.com>,
 "leon@kernel.org" <leon@kernel.org>, "cai.huoqing@linux.dev"
 <cai.huoqing@linux.dev>, "ssengar@linux.microsoft.com"
 <ssengar@linux.microsoft.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, Souradeep Chakrabarti
 <schakrabarti@microsoft.com>
Subject: Re: [PATCH 1/2 V3 net] net: mana: Fix MANA VF unload when host is
 unresponsive
Message-ID: <20230626134721.256c6c16@hermes.local>
In-Reply-To: <SA1PR21MB1335166153541BFDC2B7036BBF26A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1687771058-26634-1-git-send-email-schakrabarti@linux.microsoft.com>
	<1687771098-26775-1-git-send-email-schakrabarti@linux.microsoft.com>
	<ZJmNBKA3ygDryP7i@corigine.com>
	<SA1PR21MB1335166153541BFDC2B7036BBF26A@SA1PR21MB1335.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 26 Jun 2023 20:06:48 +0000
Dexuan Cui <decui@microsoft.com> wrote:

> > From: Simon Horman
> > Sent: Monday, June 26, 2023 6:05 AM  
> > > ...
> > > Fixes: ca9c54d2d6a5ab2430c4eda364c77125d62e5e0f (net: mana: Add a
> > > driver for
> > > Microsoft Azure Network Adapter)  
> > 
> > nit: A correct format of this fixes tag is:
> > 
> > In particular:
> > * All on lone line
> > * Description in double quotes.
> > 
> > Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network
> > Adapter (MANA)")  
> 
> Hi Souradeep, FYI I often refer to:
> https://marc.info/?l=linux-pci&m=150905742808166&w=2
> 
> The link mentions:
> alias gsr='git --no-pager show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"'
> 
> "gsr ca9c54d2d6a5ab2430c4eda364c77125d62e5e0f" produces:
> ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")

You can do same thing without shell alias by using git-config

[alias]
	fixes = log -1 --format=fixes
	gsr = log -1 --format=gsr

[pretty]
	fixes = Fixes: %h (\"%s\")
	gsr = %h (\"%s\")

Then:
$ git gsr 1919b39fc6eabb9a6f9a51706ff6d03865f5df29
1919b39fc6ea ("net: mana: Fix perf regression: remove rx_cqes, tx_cqes counters")


