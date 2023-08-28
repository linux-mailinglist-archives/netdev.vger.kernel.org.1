Return-Path: <netdev+bounces-31069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0848978B39E
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 16:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B09280E3A
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 14:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F3C12B85;
	Mon, 28 Aug 2023 14:52:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A51946AB;
	Mon, 28 Aug 2023 14:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81441C433C7;
	Mon, 28 Aug 2023 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1693234326;
	bh=689hsPQmFlOPXUwqRoJiKSQvQ9176u81ZfPPvaoMMcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k9U1Hn5yk8TFPMEJJMyMYeiPyw2w4JMvqHpdK7jLvgd3NfJMWytTrM+W1LSGrYuF6
	 IX9DFyHxlzR+djm8NuglJJZed9NHfBLfCl/nXNNSWl4FS/kE6wBLV4PbrTxLnWi1DL
	 isxhW1rxyblUwX3nA3MBVwqo9mFWz+5rwr9QUnDM=
Date: Mon, 28 Aug 2023 16:52:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: clang-built-linux <llvm@lists.linux.dev>,
	linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Sasha Levin <sashal@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: clang: net: qed_main.c:1227:3: error: 'snprintf' will always be
 truncated; specified size is 16, but format string expands to at least 18
 [-Werror,-Wfortify-source]
Message-ID: <2023082853-ladylike-clanking-3dbb@gregkh>
References: <CA+G9fYscGFiG1TVLyfETVu3NV5BAe8sCOXRGDnky-w31aB6yVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYscGFiG1TVLyfETVu3NV5BAe8sCOXRGDnky-w31aB6yVQ@mail.gmail.com>

On Mon, Aug 28, 2023 at 05:57:38PM +0530, Naresh Kamboju wrote:
> [My two cents]
> 
> stable-rc linux-6.1.y and linux-6.4.y x86 clang-nightly builds fail with
> following warnings / errors.
> 
> Build errors:
> --------------
> drivers/net/ethernet/qlogic/qed/qed_main.c:1227:3: error: 'snprintf'
> will always be truncated; specified size is 16, but format string
> expands to at least 18 [-Werror,-Wfortify-source]
>  1227 |                 snprintf(name, NAME_SIZE, "slowpath-%02x:%02x.%02x",
>       |                 ^
> 1 error generated.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Is this also an issue in 6.5?

thanks,

greg k-h

