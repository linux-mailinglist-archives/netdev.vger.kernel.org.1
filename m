Return-Path: <netdev+bounces-23813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7286076DAF8
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 00:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D790281BA8
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 22:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBD0134B6;
	Wed,  2 Aug 2023 22:50:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB11110956
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 22:50:56 +0000 (UTC)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921A89B;
	Wed,  2 Aug 2023 15:50:55 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-686f8614ce5so300275b3a.3;
        Wed, 02 Aug 2023 15:50:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691016655; x=1691621455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSZP6s8E87YIozKHHuno/d/txSVRFI7AHAk3fEQT3oo=;
        b=QbZOKhR3PWBARSvzW1NZN7USu+BXZj4uutwyCwIutvUqKuNeJSvrER2r8Mlt2CmIEq
         LhY5Qmf35B05TAGS0ITQQrvsiWiNhMWcBw+uo6QcfjnnAcxd7fhdKSASsfGhf+CYtUuV
         CRf1lLjFluFu6KMs8hbaegRxh0zISof9jHIOSRsE58nphpjXsgsWp+n0PECvkvPTLfvE
         Ueq94L44zfkbjyhE7+opy6sSrqKKAva7qk0mommmmrSHghFg0xQaCuhIVG7zbOhLUAJv
         k7oofj6aySnB3oBelnjWChr6uS7t65k2m3Mu7oQFJMAIL1a92DYDa0SgFc71MtQadJjl
         r1Eg==
X-Gm-Message-State: ABy/qLZxp+Bd/Ccjm8Q0EtgYfRQ6HjD+v3ebI7fYgV2099VcY+cV0LG3
	X6IIQXiOFAofXK1bBpD3pK8=
X-Google-Smtp-Source: APBJJlEQyc/oGseiiXbsMGMZUszVgfMcxK3SQMnZu2T/xFQsiEwlYTiKIL/zNbyeM4OOfg2IpeyZfg==
X-Received: by 2002:a05:6a20:a10e:b0:13d:b318:5c70 with SMTP id q14-20020a056a20a10e00b0013db3185c70mr13020943pzk.19.1691016655000;
        Wed, 02 Aug 2023 15:50:55 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id x26-20020a62fb1a000000b00686e6e2b556sm11467645pfm.26.2023.08.02.15.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 15:50:54 -0700 (PDT)
Date: Wed, 2 Aug 2023 22:50:48 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	sharmaajay@microsoft.com, leon@kernel.org, cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com, vkuznets@redhat.com,
	tglx@linutronix.de, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, schakrabarti@microsoft.com,
	stable@vger.kernel.org
Subject: Re: [PATCH V6 net] net: mana: Fix MANA VF unload when hardware is
Message-ID: <ZMrdyFgwr9sL7BmZ@liuwe-devbox-debian-v2>
References: <1690377336-1353-1-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690377336-1353-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023 at 06:15:36AM -0700, Souradeep Chakrabarti wrote:
> When unloading the MANA driver, mana_dealloc_queues() waits for the MANA
> hardware to complete any inflight packets and set the pending send count
> to zero. But if the hardware has failed, mana_dealloc_queues()
> could wait forever.
> 
> Fix this by adding a timeout to the wait. Set the timeout to 120 seconds,
> which is a somewhat arbitrary value that is more than long enough for
> functional hardware to complete any sends.
> 
> Cc: stable@vger.kernel.org
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> 
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>

Hi Souradeep. The subject line of this patch seems to be cut off half
way.

Thanks,
Wei.

