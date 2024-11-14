Return-Path: <netdev+bounces-144626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718479C7F5F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 01:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D7D1F22BE3
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 00:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA839476;
	Thu, 14 Nov 2024 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tTwYmOTp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED51370;
	Thu, 14 Nov 2024 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731544307; cv=none; b=Y84LrLqpBtCkJcLlv6QbRHL0Tfces7gcYMAUE7mhwxNGnoCO8BClt16GSMHRWJaiRts9r5bCqOhFotSwDpaw81H944ruBcmvMwj5uTFMm02pFunupID4HyTxYOD4sL9czLfgmxNaWnc41uFqSgBHb3uPkzz6nRW7AK9G+t8RBkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731544307; c=relaxed/simple;
	bh=V1Rf0qtz8ESpqpvUUJB1Vn+lK/JNYrSrTSJiFPULVxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDlfPVhp6hhI+dW+b2I4oUDxu9icMJ6eXSCEHGw/77B90Pgs0WmbUAho3QJT1lguWxwIkeZEtL1mA1LRJg3KswD33u7UqyfFK55AdDOqUbikEpflUkJKUXIWAzLMCrCoLXALKJhApM/GmQIX1UfcS+T3LxUoWKfIG4CnSIpKwJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tTwYmOTp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B8DC4CEC3;
	Thu, 14 Nov 2024 00:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731544307;
	bh=V1Rf0qtz8ESpqpvUUJB1Vn+lK/JNYrSrTSJiFPULVxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tTwYmOTpC5yFAxhOVxcnh2bIdUXn1W8yv8yxZlBw925f+BTfj8TatE3qpwCWurjBv
	 D+F5VDqV+bk854ubt3npeZUHVkvlIXgHB9hLzrcxQ9wsWBKe0j0cJ3Vv6FfBChXaE4
	 BKb/UzILkSbSI/uGRaI8JPgtSThv/tGc776H7sXoe1a8Du+OaF39GwbEBbiu9Y9wJo
	 vQagzu5xVR/5Km6cc7A2Q/MOhIRsCOmmxfeeeNRJ8cx/pXtJP9tdeIUW7QfctMQtUn
	 s57CSBf4lRuSgDDIMydrhHXhTtPPy58DIKUfLS/GXeI0ermXpnzJsxGjkJi3nh0Hw/
	 bhmtajpCENmqA==
Date: Wed, 13 Nov 2024 16:31:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <andrew+netdev@lunn.ch>, <horms@kernel.org>, <shenjian15@huawei.com>,
 <salil.mehta@huawei.com>, <liuyonglong@huawei.com>,
 <wangpeiyang1@huawei.com>, <chenhao418@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND net 3/7] net: hns3: Resolved the issue that the
 debugfs query result is inconsistent.
Message-ID: <20241113163145.04c92662@kernel.org>
In-Reply-To: <e4396ecc-7874-4caf-b25d-870a9d897eb1@huawei.com>
References: <20241107133023.3813095-1-shaojijie@huawei.com>
	<20241107133023.3813095-4-shaojijie@huawei.com>
	<20241111172511.773c71df@kernel.org>
	<e4396ecc-7874-4caf-b25d-870a9d897eb1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 Nov 2024 13:59:32 +0800 Jijie Shao wrote:
> inconsistent=EF=BC=9A
> Before this modification,
> if the previous read operation is stopped before complete, the buffer is =
not released.
> In the next read operation (perhaps after a long time), the driver does n=
ot read again.
> Instead, the driver returns the bufffer content, which causes outdated da=
ta to be obtained.
> As a result, the obtained data is inconsistent with the actual data.

I think the word "stale" would fit the situation better.

> In this patch, ppos is used to determine whether a new read operation is =
performed.
> If yes, the driver updates the data in the buffer to ensure that the quer=
ied data is fresh.
> But, if two processes read the same file at once, The read operation that=
 ends first releases the buffer.
> As a result, the other read operation re-alloc buffer memory. However, be=
cause the value of ppos is not 0,
> the data is not updated again. As a result, the queried data is truncated.
>=20
> This is a bug and I will fix it in the next version.

Let's say two reads are necessary to read the data:

 reader A                  reader B
  read()
   - alloc
   - hns3_dbg_read_cmd()
                           read()
                           read()
                           read(EOF)=20
                            - free
  read()
   - alloc
   - hns3_dbg_read_cmd()
  read(EOF)=20
   - free

The data for read A is half from one hns3_dbg_read_cmd() and half from
another. Does it not cause any actual inconsistency?

Also, just to be sure, it's not possible to lseek on these files, right?

