Return-Path: <netdev+bounces-171281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A27A4C566
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 16:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8798718874F7
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 15:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97152144B8;
	Mon,  3 Mar 2025 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFcXW4d3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D21213E89
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741016467; cv=none; b=j5uALKnrUqFcT2PdxyA10S+2bGXQpVGW7T2cHdi4t4ltRR75T3rsrdoRZEDOFLU/fbhg4tox62MjR318fLeYsmWZj95RpU1k3GDwdCSQWApoXJDzw4V3L+vKIx8WLEf+lC8rKe6Be0HRwUB9A96NFf0/zkzj0xgc4MIHLnw5O/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741016467; c=relaxed/simple;
	bh=QSf4hF4EPJe7WJNQWtMftjejPIXGkg8EOWTtkAZgiYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPIMskyICd9V8QOUiYoI2jWuepnin9oeQ6RHilaaV9VvWlB4EDIlQ1Lfi4tJB9NRN0E3zV6DuozeFrj9EUnVG5/obDNAJxMf/WmBBXmUPnJ4sISQ8Cgy0NrAfc92fQ25XpGfTE49dmmGljTDLv9QiR1Wl2Ou1kK4IBALMUThjBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFcXW4d3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6D8C4CEE6;
	Mon,  3 Mar 2025 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741016467;
	bh=QSf4hF4EPJe7WJNQWtMftjejPIXGkg8EOWTtkAZgiYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aFcXW4d3l0pODxe4rA7OO4wTWpBSEDUNfTrM51429xJEEClS3PivNSZEEILrRcaHh
	 REQ6zetzJldSSZ9+GOaigVjplOg6a0Ml4O2LUaEZ8g1T5i4Z3Y9ii9kMGqRhkNnGmI
	 ZeZMeysOI1d7K3PO6hw6J9bLkWzG1IxlHD50qt+qCRhxjsJrBxuPBgdu4mTQPSu6Gv
	 fHt3nTCcTljuFgeKyV0VsjNiErrx/M+Zk51AlpI9zwhE5FJwoehOxJj6TP23WZt16b
	 HLMgTKtH3IudKflIBUr41GYmMYgkFVAjcEFQQQ6ujYAGIvXvjc58SCOkyxsj43nLSx
	 cr2huIEeXiBWw==
Date: Mon, 3 Mar 2025 07:41:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: txtimestamp: ignore the old skb
 from ERRQUEUE
Message-ID: <20250303074105.0b562205@kernel.org>
In-Reply-To: <20250303080404.70042-1-kerneljasonxing@gmail.com>
References: <20250303080404.70042-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Mar 2025 16:04:04 +0800 Jason Xing wrote:
> When I was playing with txtimestamp.c to see how kernel behaves,
> I saw the following error outputs if I adjusted the loopback mtu to
> 1500 and then ran './txtimestamp -4 -L 127.0.0.1 -l 30000 -t 100000':
> 
> test SND
>     USR: 1740877371 s 488712 us (seq=0, len=0)
>     SND: 1740877371 s 489519 us (seq=29999, len=1106)  (USR +806 us)
>     USR: 1740877371 s 581251 us (seq=0, len=0)
>     SND: 1740877371 s 581970 us (seq=59999, len=8346)  (USR +719 us)
>     USR: 1740877371 s 673855 us (seq=0, len=0)
>     SND: 1740877371 s 674651 us (seq=89999, len=30000)  (USR +795 us)
>     USR: 1740877371 s 765715 us (seq=0, len=0)
> ERROR: key 89999, expected 119999
> ERROR: -12665 us expected between 0 and 100000
>     SND: 1740877371 s 753050 us (seq=89999, len=1106)  (USR +-12665 us)
>     SND: 1740877371 s 800783 us (seq=119999, len=30000)  (USR +35068 us)
>     USR-SND: count=5, avg=4945 us, min=-12665 us, max=35068 us
> 
> Actually, the kernel behaved correctly after I did the analysis. The
> second skb carrying 1106 payload was generated due to tail loss probe,
> leading to the wrong estimation of tskey in this C program.
> 
> This patch does:
> - Neglect the old tskey skb received from ERRQUEUE.
> - Add a new test to count how many valid skbs received to compare with
> cfg_num_pkts.

This appears to break some UDP test cases when running in the CI:

https://netdev-3.bots.linux.dev/vmksft-net/results/16721/41-txtimestamp-sh/stdout
-- 
pw-bot: cr

