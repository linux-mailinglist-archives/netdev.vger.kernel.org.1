Return-Path: <netdev+bounces-23130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18B876B09F
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8EB1C20E29
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230C220F86;
	Tue,  1 Aug 2023 10:15:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10F81DDFF
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:15:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA63C433C7;
	Tue,  1 Aug 2023 10:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690884906;
	bh=eJbCYWu/oNoVo12hNU0Y2uGd6cqhYGeLANDV/ZOujYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=co06mUPRCh1m/vMywunK00wEEqXyC8olboC9SJLjtZla1/p4S93bUsPSI66wDWVLw
	 iV1nPFASixMKSRHOOTGFvxqrHVdT0Zn0tyZVnZ9jedUxsd5mfItxrZp3JbQSosEu0g
	 jRyydGb1vk860PN6BuOC5b2s1GPykgU3ValzOFGGIRtMh2kFGfYcvfzOjG6KI0eDO2
	 KRTgZgTlHllEQd/Reg9YdaJD1v/Oi7UCo9GYRh9MmIYUdVslxqWR0drih+rWWEgn/D
	 d4Q6SC2xaWgB4PIqQmC0ytw+MfmFqyzw6KdhR9ehFitj+16j7i4DyBfdXPVurCEN4R
	 DPbLfdNR/izdA==
Date: Tue, 1 Aug 2023 12:15:01 +0200
From: Simon Horman <horms@kernel.org>
To: Ruan Jinjie <ruanjinjie@huawei.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
	jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, richardcochran@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH -next] octeontx2: Remove unnecessary ternary operators
Message-ID: <ZMjbJW+VmNE891iN@kernel.org>
References: <20230801024413.3371379-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801024413.3371379-1-ruanjinjie@huawei.com>

On Tue, Aug 01, 2023 at 10:44:13AM +0800, Ruan Jinjie wrote:
> Ther are a little ternary operators, the true or false judgement

nit: Ther -> There

> of which is unnecessary in C language semantics. So remove it
> to clean Code.

The target tree of this patch should be 'net-next'.

	Subject: [PATCH net-next] ...

> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

Otherwise this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


