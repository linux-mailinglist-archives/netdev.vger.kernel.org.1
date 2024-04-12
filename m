Return-Path: <netdev+bounces-87226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1244E8A234C
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 03:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B9E285714
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 01:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1F34C92;
	Fri, 12 Apr 2024 01:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rP3jUCpt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BFE4C6C;
	Fri, 12 Apr 2024 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712885828; cv=none; b=F4LHEC7lsfE/6ugd2vOKKPsAAm30sdx35Z0NBdO4yAOZCGnrUUx9T9Zi8hM7Af8kiEjXpsrncYghHbgKjyT5uaUgEe64Zzk+ycCGI0lHXSz0EC9a3rttPhYvVAQtdLjF684Ih+0w6wPxA4FQmQghqB8jQs3nSk1i8ILq/GJSKVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712885828; c=relaxed/simple;
	bh=rrwOUlSp5R9FskhZiOgiL4Shh+tlcWPb9/Ndpf1E/1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GkSMqXuuI7zs2ybrlUPkI5Kem3bEkqcXfRNm41CnE0UjyNN5AN99u6Ex1LnKN69N7VKghPYELmbhX2R3k0Ig0+q42vQGIi8Xi3ATI9gu45vHxh9UgyYIUNyc0c9ajsVP5nAOTY/IGt0bh/NBjDSNSotZDAJSV2DhJaAeHyZf/jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rP3jUCpt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B37C072AA;
	Fri, 12 Apr 2024 01:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712885827;
	bh=rrwOUlSp5R9FskhZiOgiL4Shh+tlcWPb9/Ndpf1E/1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rP3jUCpt1pUEYZSrjmOOgLaSEU54tshLM56KRtojwra/If5nehMyZHUMksnudf/TK
	 cPLZWBCbTts3XpF3/jPvO0ON85DTUDu3GcnTA5mnNXEdGWJi3OWNJfU9stLoGRmNz/
	 kcjPf/zTNzRaSqgq8rc8unaV/aAI2jAAjyVeDYvaPabJEgo1t5xR8dlkryibKaLTuU
	 K7WblVqSMyqroHzqjjzOkkqBgTR/2R7KrCzgmza0hXM+jjh2GCF2w2y7iYUGkSfrtH
	 uI3QHZFIjhVH3kHJKCVOF0fKdIy53KkfBW82ab4De9bFc60VTq9VDZQ5mJcciBApja
	 tIVjst0akKJzQ==
Date: Thu, 11 Apr 2024 18:37:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>,
 kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [net-next:main 26/50] net/ipv4/tcp.c:4673:2: error: call to
 '__compiletime_assert_1030' declared with 'error' attribute: BUILD_BUG_ON
 failed: offsetof(struct tcp_sock,
 __cacheline_group_end__tcp_sock_write_txrx) - offsetofend(struct tcp_sock,
 __cacheline_group_begin__tcp_sock_...
Message-ID: <20240411183706.70e5dfcd@kernel.org>
In-Reply-To: <a59e2164-7159-445e-9f87-fcf6cb4b57d6@gmail.com>
References: <202404082207.HCEdQhUO-lkp@intel.com>
	<20240408230632.5ml3amaztr5soyfs@skbuf>
	<CANn89iJ8EcqiF8YCPhDxcp5t79J1RLzTh6GHHgAxbTXbC+etRA@mail.gmail.com>
	<db4d4a48-b581-4060-b611-996543336cd2@gmail.com>
	<CANn89iJMirOe=TqMZ=J8mFLNQLDV=wzL4jOf9==Zkv7L2U5jcQ@mail.gmail.com>
	<20240410183636.202fd78f@kernel.org>
	<a59e2164-7159-445e-9f87-fcf6cb4b57d6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 12:21:22 -0700 Florian Fainelli wrote:
> > Florian, does arm32 break a lot? I may not be paying sufficient
> > attention. We can add more build tests but the CPU time we have
> > is unfortunately finite :(  
> 
> Yes, that is why I mentioned multi_v7_defconfig, you an see the build 
> failure with that configuration. Of course Eric fixed it now, thanks!

Would you be willing to type up a bash script along the lines of:

https://github.com/linux-netdev/nipa/blob/main/contest/tests/build-doc.sh

perhaps some inspiration from:

https://github.com/linux-netdev/nipa/blob/main/tests/patch/build_allmodconfig_warn/build_allmodconfig.sh

? (the former runs on the test branches the latter commit by commit)

