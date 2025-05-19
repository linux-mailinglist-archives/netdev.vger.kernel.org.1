Return-Path: <netdev+bounces-191387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B78ABB5EC
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 09:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5323B8CB5
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 07:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8272686B1;
	Mon, 19 May 2025 07:09:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC27267B71
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 07:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747638561; cv=none; b=AFgBKhsX0Ml7YYX28r1NCiKztfs+8/tLLoZtWkPhIAIOjwU5LEUgLHVZs0OGEbAPxH5BvKRreFuf7J1VreWEx4mtCSxYxRbJXggzxpni+Hqhsv0JblK8CowwgzuURVRmIDyDyhaNY0vvTts+oHw2XGbMJvxSrHNnWy1soAsZ8UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747638561; c=relaxed/simple;
	bh=vm+hcJxdjh6i738X2wL5tXux/qq/1w6rOzqwW0Jguhw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=FeczPdsPH5vCZXQxdRQiwy+4/xOl8GzgogMIXKS+iOj+3ukI8icGmdYO3E2pxPK0fkWf8hjG3z91YSam0vvXosm/+fnoGgoPoCw6EwtwjJm5iARvvsijRuCa9sumh9xmjazgHjr8O8m2eRqD9yWfqxFzn7ZIB0k/+j3oIutQFMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas7t1747638496t188t54733
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.119.67.87])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 18046988283776760284
To: "'Michal Swiatkowski'" <michal.swiatkowski@linux.intel.com>
Cc: <netdev@vger.kernel.org>,
	<pabeni@redhat.com>,
	<kuba@kernel.org>,
	<edumazet@google.com>,
	<davem@davemloft.net>,
	<andrew+netdev@lunn.ch>,
	<mengyuanlou@net-swift.com>
References: <67409DB57B87E2F0+20250519063357.21164-1-jiawenwu@trustnetic.com> <aCrV/xlFlxoDsOVl@mev-dev.igk.intel.com>
In-Reply-To: <aCrV/xlFlxoDsOVl@mev-dev.igk.intel.com>
Subject: RE: [PATCH net-next] net: libwx: Fix log level
Date: Mon, 19 May 2025 15:08:15 +0800
Message-ID: <000301dbc88c$ca5757e0$5f0607a0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQGCPLIqHUueQC3qKdJFIo7cu8OQXgDmen8/tIVrogA=
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NjSyPD5q5D+NyKf/AIUpeh4B44I9sRtgg49KWuYt4NqujmPE1evAHKjk
	2dHXFfMBzzjNZTUn5KDctcYQpZk+vfsIAofW6XLLHsgN5uYwNFiJ02IFEdpvy/xpqMsaW5L
	ncUKxOaipoyBEJx5fbCk/FpsPqJzgMfP4AJv0BgR3q2z6b1lnrKznv4+gYXYKxJqbCr25dS
	wZCLOLHqYPuUzhAze5XUUiwV+uhtT+rM6ApPKv4Ol6PG4Db8pCWyFATJ43G+aDeet30UE7h
	7I0YeT8ZttSn33OJAKHM9+FiBaNP950ONugVjuCnYZBKVB01K9pMowCFLEXGDE1JxpFye0y
	D4PriG87U4NkD2KKyr89tSDba/SoBEVswrw87pzW5qI3rXP3ppMl0a0Z1h03Q0yB7JiEnvP
	6MlFhSkbxS2T1ry/fTeg7RApNU9Zj/5mtHIq5OlTwfYk4VW9zsKTzWRhK2OSjpQv4FtkpPO
	Quj7AJ7LO9q4oiKDghR554WLU83gv2KXAnW+PsEeycFxwB02JYghLQRzZ5F73xQQS4npvKm
	r7oF5VtigvecVf5jVestfiKrFi7rBmeBzLJteMQZ9a2op/lFFA/6VU0yWbg+ljnWDtMERyn
	xoidyqNVdxbcvHlhZ6z0KWnDXVpHTWTns1iWBKlMK1A6Le2PR09f1/d2Q+Pv4rmRAQ52d0s
	VIBdSmCm0u/otxDTfIBxz69Sk3W+nEBJX1weGjGtSPjSvYd0v8ogf5qqktIJrGKJOCOF4iE
	pTJOUIiQy89jS8EhZ1Z+ygS84H3vMclihGcpqVshka16aUcAIouZ4JtRsytQlnhuDDwl7FB
	UDcsCAcHE7igR/svHo/xuo/NgHqsI6cJgi2UCIpEYC7VX3lBqfDxO/UZBr+y/6NGKm5Z8DG
	yJicCucdpmxTa7Iz2uhu11etF7BXyxTCAplit4RftQSZ/8vPGH+8QmTrRSwgLYSt5nJpG9y
	NpulN1ujAdhTLggzPidPUohLnRH0FF/gjxLdwys4T2b3qN/DPV2QGZqEAuCAfNgXgS8rMdW
	YOZtKu2GhWtfoCWRnc7mTaedgJQMCZ+pHR60VAlDQfjGfbm0QVCohSuUH3c2ATvQxkVKoNH
	A99d1YPi0OX843FC867Muw=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Mon, May 19, 2025 2:56 PM, Michal Swiatkowski wrote:
> On Mon, May 19, 2025 at 02:33:57PM +0800, Jiawen Wu wrote:
> > There is a log should be printed as info level, not error level.
> >
> > Fixes: 9bfd65980f8d ("net: libwx: Add sriov api for wangxun nics")
> > Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> > ---
> >  drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> > index 52e6a6faf715..195f64baedab 100644
> > --- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> > +++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
> > @@ -76,7 +76,7 @@ static int __wx_enable_sriov(struct wx *wx, u8 num_vfs)
> >  	u32 value = 0;
> >
> >  	set_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
> > -	wx_err(wx, "SR-IOV enabled with %d VFs\n", num_vfs);
> > +	dev_info(&wx->pdev->dev, "SR-IOV enabled with %d VFs\n", num_vfs);
> >
> >  	/* Enable VMDq flag so device will be set in VM mode */
> >  	set_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);
> 
> It is unclear if you want it to go to net, or net-next (net-next in
> subject, but fixes tag in commit message). I think it should go to
> net-next, so fixes tag can be dropped.

It is because the fixes tag commit is not merged in net yet, so I give it a prefix net-next.



