Return-Path: <netdev+bounces-209609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D4FB10068
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 08:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F794E68E0
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 06:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191DF205E02;
	Thu, 24 Jul 2025 06:12:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A78B148830;
	Thu, 24 Jul 2025 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753337566; cv=none; b=m/uEbw0gJcJHtmcdDwasM9zoFeBBN/azHbADjfw3rIhmQBlKy4MqslRJi/J+yqvugdv819D+VZ2c/oc+unu1r+Apmi/U4OoTMe9/fee5gyvMtcYIkwyVfn7zqQWle1JTLer0OzgLnRbxj2sbKkjouN4S7eQCspwETkbQ+Kio4eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753337566; c=relaxed/simple;
	bh=CByW3Y3+zXKsW1KVgHar09KXfov0Pnop6z7uMFXJ9wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQCHiDRcdWOrYOYtNYbwVL+Gw6/uMuXIRiOfyHV1dRWw0hEDje9lVo+MFnJvVav2B0lOeQ/ZVfBvXAE+hBnrZw8tqvKBIQRavjn6DKSzOWM0uhmK7BzWQTghMBG8wHnJj29Urqppni5nzRvxXyE6PP10DnIhecRy9KvSFB/ij8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz10t1753337450t4ba43d06
X-QQ-Originating-IP: IbpEF2adBK0K3OR0Dr975OKXmkffwF0i3hlqe5FSep0=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 24 Jul 2025 14:10:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12413902011030237247
Date: Thu, 24 Jul 2025 14:10:47 +0800
From: Yibo Dong <dong100@mucse.com>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/15] net: rnpgbe: Add build support for rnpgbe
Message-ID: <173AE84ACE4EE2AE+20250724061047.GA153004@nic-Precision-5820-Tower>
References: <20250721113238.18615-1-dong100@mucse.com>
 <20250721113238.18615-2-dong100@mucse.com>
 <20250722112909.GF2459@horms.kernel.org>
 <0E9C9DD4FB65EC52+20250723030111.GA169181@nic-Precision-5820-Tower>
 <20250723200934.GO1036606@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723200934.GO1036606@horms.kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Ndw/mc8X39ObfM92LSarzqTQNNyDZ5M4hnRkSi+toTBH0w6nDlyd00An
	6YZpGvoM9enhMoZwUbhQ2RW1f8mzuWwcpnZa+hOQKbzA6+Y5awep0hyV1dUa7fB50yc0P74
	wdsPRneR2DITPfSXDo1oKWb7fqtvRunUGh1euW0oCoJydB6HTEmDglXN1F0TQPU0pAGxUnF
	dFvbe9ZNS3kIZNd8jacCgAxuz/E9Jhif1wrCfxA31TTKcT+ZixWSuAwnHGZKXujM7qEwHvT
	/okngwUuDZf30Om6/p0O/ojgvLLzfmJxIcTI/i9a5edyczIkrzgiQRCoGjJcmXFU/7+cX1y
	CDTaqqtlOKEpD/mG97hN+bAeYcwX6Y3VshCdKnmnAdGxJTp5X2b1k0MXCdNSS93uHm85Jty
	N4iSxJveSGIouOECoygHbagOknTn9R268bBLyYIqJYmWdlu0yxafCR52yTdMOWvu35jUJ/Q
	xBmDGl9BYgf0lLHk7Og6MSg2zhXzT3JkJnRcxvTNdhNwWVAwy0njRvXJUP/Wcb4c46fmSas
	ZOfa/7hQCWvajRyTaO9oXMbMUuzb50eGGTZlilGEK6MwgwX+gUefaNlIdGVHXtOosYLvAB6
	DMXbiafg0GbHEGNRNourZC1sbbc8iuFu5/ebCvF/O9N9KX3HDxRW3ME2Ks14toImO+2xhV9
	nUydx+U4wn3IGkTB5CLw1d+PLtjCxIndJiZlI2JHYFSYdtHK+vXhQy9oXaXnbqUnQ6rB6HN
	WHjjKpTfSMa2AbJtIXOpSCRdXE1pHKSeZWiwYoUJFx1j1Uq2exj7TQ/9MtcjdVJFt4SuCoU
	/Hazyx09CEdnas/rv/lD0ujHoF0UvW7QShtNVzoyDSl6biXax6tvXGvtPFznHytK2LTbPN2
	SQzW8yOYLMB1m6sMWYtuv86VwS6uSuHYZSo2K0nz0ipr7byg0EozWXQM/i374zfyuULNTTJ
	tm4V9GEnrGTM1t5AsM8vAn+FmcEeEKV/qckkdE6NLj9y7w4QkZjM8LBV8BUmA7isCwPw=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Wed, Jul 23, 2025 at 09:09:34PM +0100, Simon Horman wrote:
> On Wed, Jul 23, 2025 at 11:01:11AM +0800, Yibo Dong wrote:
> > On Tue, Jul 22, 2025 at 12:29:09PM +0100, Simon Horman wrote:
> > > On Mon, Jul 21, 2025 at 07:32:24PM +0800, Dong Yibo wrote:
> 
> ...
> 
> > But I can't get this warning follow steps in my local:
> > ---
> > - make x86_64_defconfig
> > - make menuconfig  (select my driver rnpgbe to *)
> > - make W=1 -j 20
> > ---
> > if I compile it with 'make W=1 C=1 -j 20', some errors like this:
> > ---
> > ./include/linux/skbuff.h:978:1: error: directive in macro's argument list
> > ./include/linux/skbuff.h:981:1: error: directive in macro's argument list
> > ........
> > Segmentation fault
> > ---
> > I also tried to use nipa/tests/patch/build_allmodconfig_warn
> > /build_allmodconfig.sh (not run the bot, just copy this sh to source
> > code). It seems the same with 'make W=1 C=1 -j 20'.
> > Is there something wrong for me? I want to get the warnings locally,
> > then I can check it before sending patches. Any suggestions to me, please?
> > Thanks for your feedback.
> 
> I would expect what you are trying to work.

I want to reproduce the warning locally, like this: 
'warning: symbol 'rnpgbe_driver_name' was not declared. Should it be static'
Then, I can check codes before sending patches.

> And I certainly would not expect a segmentation fault.
> 
> I suspect that the version of Sparse you have is causing this problem
> (although it is just a wild guess). I would suggest installing
> from git. http://git.kernel.org/pub/scm/devel/sparse/sparse.git
> 
> The current HEAD is commit 0196afe16a50 ("Merge branch 'riscv'").
> I have exercised it quite a lot.
> 

nice, after installation, it works. I reproduced the warning, thanks.

> For reference, I also use:
> GCC 15.1.0 from here: https://mirrors.edge.kernel.org/pub/tools/crosstool/
> Clang 20.1.8 from here: https://mirrors.edge.kernel.org/pub/tools/llvm/
> (Because they are the latest non -rc compilers available there)
> 
> 

