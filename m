Return-Path: <netdev+bounces-15297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBDC746A5C
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 09:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7753280F43
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 07:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306361368;
	Tue,  4 Jul 2023 07:15:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEA7111D;
	Tue,  4 Jul 2023 07:15:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1D3C433C7;
	Tue,  4 Jul 2023 07:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688454927;
	bh=Qx6SPa/FXBtKHsuhqwtcpwkMWYF76dpQTGSInwUFiQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fimT/YP/AwhUtgGvGKQgdcx3SzNIvCNt5RUuS9ji1RvM5vdWAfDmfhixbrbnTaj9p
	 Tk8ZV65fRATwJUd6IdHdAoqcns/a5N6xzLUlm4O/Tkj1HvnjwH4jaVpPJB1cwJ6lD3
	 lOX5CVIewQ7zemoDIRdUeyU5nmoLMFgq2q71zWD8hj56TNCZ/hqkLoObBMQ2lUrPSF
	 fNBR1YcW0VIUCrZmojkUIU99BpEZtJgGzx7Mop3MyaM9AiAUyDnuCZNBA2l4stl5D2
	 utvmVnQ3jYCiZiMu6XYBkbwnYdqOn5nwk3N5OH96xX1Uqx/6RnXygRzEXNCe7yeOi+
	 Ija1G9VDGSOjw==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1qGaFw-00ALG1-JE;
	Tue, 04 Jul 2023 08:15:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 04 Jul 2023 08:15:24 +0100
From: Marc Zyngier <maz@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux Memory Management List
 <linux-mm@kvack.org>, kunit-dev@googlegroups.com, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [linux-next:master] BUILD REGRESSION
 296d53d8f84ce50ffaee7d575487058c8d437335
In-Reply-To: <202307032309.v4K1IBoR-lkp@intel.com>
References: <202307032309.v4K1IBoR-lkp@intel.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <7d3d61c694c0e57b096ff7af6277ed6b@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: lkp@intel.com, akpm@linux-foundation.org, linux-mm@kvack.org, kunit-dev@googlegroups.com, kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org, linux-riscv@lists.infradead.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On 2023-07-03 16:11, kernel test robot wrote:
> tree/branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> master
> branch HEAD: 296d53d8f84ce50ffaee7d575487058c8d437335  Add linux-next
> specific files for 20230703
> 

[...]

> Unverified Error/Warning (likely false positive, please contact us if
> interested):
> 
> arch/arm64/kvm/mmu.c:147:3-9: preceding lock on line 140

This *is* a false positive. The function is entered with a lock
held, it will exit with the lock held as well. Inside the body
of the function, we release and reacquire the lock.

         M.
-- 
Jazz is not dead. It just smells funny...

