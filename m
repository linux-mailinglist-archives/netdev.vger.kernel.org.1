Return-Path: <netdev+bounces-29533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466B2783ABB
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 09:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19BC280FF9
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 07:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73C36FBC;
	Tue, 22 Aug 2023 07:18:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDFD6FB4
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 07:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57456C433C7;
	Tue, 22 Aug 2023 07:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692688724;
	bh=mGoKADrdktxNhOoJegG+v+NkHEBPm/eaw2Mmb6D+K28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N8HFO8gLppo7JP8GGBirwooGLi8SCRhwU8vZ5oAd1bRO8lvul5b62ePt7MRORfPCI
	 Tlf7C7uiO8A/5157OXwGUNMnPjOuOWzSgtW4tiLhY6FJUPUHSVD3eHBDTI2FKO2tKc
	 w7qsL4d37y/s8uo2yaYgFLvsAIbszsZqNf4nb3xryeAQTtSjgq+jDtX6zzTuWlfKfr
	 PiLgHBQK/5Jahz463vL/o4GibyssSqn3ba7wLjwDRsemnVqVP9FkTHYxv+K5A3ZkuG
	 kYgav0/ZtLx8PXKdVM76WzmAD9Zzdx/gZrBKR5Zfa/gEvXO7V+u0PqPaUZPOxjf0Lt
	 FPaGrlggrv9nA==
Date: Tue, 22 Aug 2023 09:18:39 +0200
From: Simon Horman <horms@kernel.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au, dsahern@kernel.org,
	eyal.birger@gmail.com, paulmck@kernel.org, joel@joelfernandes.org,
	tglx@linutronix.de, mbizon@freebox.fr, jmaxwell37@gmail.com,
	weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next] net: remove unnecessary input parameter 'how'
 in ifdown function
Message-ID: <20230822071839.GL2711035@kernel.org>
References: <20230821084104.3812233-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821084104.3812233-1-shaozhengchao@huawei.com>

On Mon, Aug 21, 2023 at 04:41:04PM +0800, Zhengchao Shao wrote:
> When the ifdown function in the dst_ops structure is referenced, the input
> parameter 'how' is always true. In the current implementation of the
> ifdown interface, ip6_dst_ifdown does not use the input parameter 'how',
> xfrm6_dst_ifdown and xfrm4_dst_ifdown functions use the input parameter
> 'unregister'. But false judgment on 'unregister' in xfrm6_dst_ifdown and
> xfrm4_dst_ifdown is false, so remove the input parameter 'how' in ifdown
> function.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


