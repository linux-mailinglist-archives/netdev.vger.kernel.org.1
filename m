Return-Path: <netdev+bounces-22125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02271766206
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 04:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6FF2825A8
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 02:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AB32714A;
	Fri, 28 Jul 2023 02:43:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B66117EC;
	Fri, 28 Jul 2023 02:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AECC433C9;
	Fri, 28 Jul 2023 02:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690512192;
	bh=pm8EEJ3QVFbZRsnnFWhbHs7DxRk67vj7nVk7xzm5K6A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JY3PNodbQLvsX/IukNSn5Vy8hxvOWmgmZbr57BdemunG/lL+U0h/YWYpcQqnNiRqs
	 mxnwR/BO7w1OkCYLZx2dQtDyjf5FdlCcRWeHJLR3PL56T00W16VIjBaQiDOjdkh9/m
	 aRtXi96h3XHUh1AXrzpgggQa2nBFAsKoUCLjV8crWrW8ThqmXF2PUbJb0vv40fCCkL
	 BjGH0CVYHb7/4fpBAM3VQyp3+5BAQlznyNuwDqjJHO1CSxxiezQygfHrsqRDYgipl5
	 Q+q38AFIpg3yybJUMpQaNW9jr5Jf2KT5UKwvNtjrIv1+Atw0zGmyxs3vDU3tsyopi6
	 TE658BcOcHnzA==
Date: Thu, 27 Jul 2023 19:43:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, Naresh Kamboju
 <naresh.kamboju@linaro.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>, "lkft-triage@lists.linaro.org"
 <lkft-triage@lists.linaro.org>, Netdev <netdev@vger.kernel.org>,
 clang-built-linux <llvm@lists.linux.dev>, Shuah Khan <shuah@kernel.org>,
 Anders Roxell <anders.roxell@linaro.org>, "David S. Miller"
 <davem@davemloft.net>, Liam Howlett <liam.howlett@oracle.com>
Subject: Re: selftests: connector: proc_filter.c:48:20: error: invalid
 application of 'sizeof' to an incomplete type 'struct proc_input'
Message-ID: <20230727194311.6a51f285@kernel.org>
In-Reply-To: <DD53AFBE-F948-40F9-A980-2DA155236237@oracle.com>
References: <CA+G9fYt=6ysz636XcQ=-KJp7vJcMZ=NjbQBrn77v7vnTcfP2cA@mail.gmail.com>
	<E8C72537-4280-401A-B25D-9734D2756A6A@oracle.com>
	<BB43F17E-EC00-4E72-BB3D-F4E6FA65F954@oracle.com>
	<799d6088-e28f-f386-6a00-2291304171a2@linuxfoundation.org>
	<DD53AFBE-F948-40F9-A980-2DA155236237@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jul 2023 01:38:40 +0000 Anjali Kulkarni wrote:
> Jakub,
> Do I need to revert the -f runtime filter option back to compile time
> and commit with that disabled so the selftest compiles on a kernel on
> which the new options are not defined?

I'm not 100% sure myself on what's the expectations for building
selftests against uAPI headers is..

I _think_ that you're supposed to add an -I$something to
the CFLAGS in your Makefile. KHDR_INCLUDES maybe? So that the uAPI
headers from the build get used (rendered by make headers).

Take a look at Documentation/dev-tools/kselftest.rst, I hope
the answer is somewhere there.

