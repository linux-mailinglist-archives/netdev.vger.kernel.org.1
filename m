Return-Path: <netdev+bounces-99314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F01A8D467F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 09:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4403A1F21F08
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 07:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18781142E60;
	Thu, 30 May 2024 07:56:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6C920322;
	Thu, 30 May 2024 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055781; cv=none; b=hdHyTlynsppRvHJ5TDCCwlvDBjVtQg/bQiL6LyWauDFuJHvCZwH5LM8BuWff7OYW2DtrMBm/A0oZ2XMeuD56TQs3oiL36AY0eINK9zMUSV81caBpZF8LFscVkowM+OtO7k+kqZOTrlB3VJplTP8GOrvCW7zKADNK2nareRz3afc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055781; c=relaxed/simple;
	bh=jZYkJjTMMLj6Qp75t5LqXGLqfkGsSkYKiCFJDOFDvPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U3LfD0SiWo7epqvd9kCJGO1IEP4kvufAPLQ3w3v4FDsLCW+l7AlT6qg7voHAV7w+73t7YLCwa4zeL+oo/uTz21NhGoxuojaPqyqgrNPX0Mz5Osk98ELk8FvEULnDAJ/tTd/Fq+TPYgDfn/NXeAD/h54bNokSe6HqA+s2V4GanvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.13.3] (g258.RadioFreeInternet.molgen.mpg.de [141.14.13.3])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8BF5D61E5FE01;
	Thu, 30 May 2024 09:55:33 +0200 (CEST)
Message-ID: <8d61678f-7494-4c26-a039-f5db633ab140@molgen.mpg.de>
Date: Thu, 30 May 2024 09:55:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] ice: irdma hardware init failed after
 suspend/resume
To: En-Wei WU <en-wei.wu@canonical.com>
Cc: jesse.brandeburg@intel.com, intel-wired-lan@lists.osuosl.org,
 rickywu0421@gmail.com, linux-kernel@vger.kernel.org, edumazet@google.com,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, wojciech.drewek@intel.com
References: <20240528100315.24290-1-en-wei.wu@canonical.com>
 <88c6a5ee-1872-4c15-bef2-dcf3bc0b39fb@molgen.mpg.de>
 <CAMqyJG0uUgjN90BqjXSfgq7HD3ACdLwOM8P2B+wjiP1Zn1gjAQ@mail.gmail.com>
 <971a2c3b-1cd9-48c5-aa50-e3c441277f0a@molgen.mpg.de>
 <CAMqyJG13Q+20p5gPpLZ1JYBS6yt5HZox0=gaT87vDyxN1rxRyA@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAMqyJG13Q+20p5gPpLZ1JYBS6yt5HZox0=gaT87vDyxN1rxRyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear En-Wei,


Thank you for your quick reply.

Am 30.05.24 um 09:08 schrieb En-Wei WU:

>> Sorry for being unclear. I meant, does resuming the system take longer
>> now? (initcall_debug might give a clue.)
> I've tested the S3 suspend/resume with the initcall_debug kernel
> command option, and it shows no clear difference between having or not
> having the ice_init_rdma in ice_resume:
> Without ice_init_rdma:
> ```
> [  104.241129] ice 0000:86:00.0: PM: pci_pm_resume+0x0/0x110 returned 0 after 9415 usecs
> [  104.241206] ice 0000:86:00.1: PM: pci_pm_resume+0x0/0x110 returned 0 after 9443 usecs
> ```
> With ice_init_rdma:
> ```
> [  122.749022] ice 0000:86:00.1: PM: pci_pm_resume+0x0/0x110 returned 0 after 9485 usecs
> [  122.749068] ice 0000:86:00.0: PM: pci_pm_resume+0x0/0x110 returned 0 after 9532 usecs
> ```

Thank you for verifying this. Nice to hear, it has no impact.

[…]


Kind regards,

Paul

