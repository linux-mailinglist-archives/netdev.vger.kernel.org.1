Return-Path: <netdev+bounces-62113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4851825C2D
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 22:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53A6928585B
	for <lists+netdev@lfdr.de>; Fri,  5 Jan 2024 21:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969151E4AE;
	Fri,  5 Jan 2024 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3f4/arv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D56F35EFC
	for <netdev@vger.kernel.org>; Fri,  5 Jan 2024 21:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56168C433C8;
	Fri,  5 Jan 2024 21:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704490747;
	bh=RV+J7PBqwvKZvgZ/b1nmmnj4a92+fizpIh+MOBq2CHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H3f4/arvXbeKPsN2xPl87xMJwPlbjUVHSIz+oMBDiUaK6ht4uo/DyxNiz8TmNpR8P
	 qsLS8fMRaJVaT4jJmeaASbesqVl5v7Wg89/qFWP4XGs4/HZQ/+bQxvhfAH6HroBuxN
	 pXE9wja+h84GMel+fcLfjFaBmRlNAZVqsuxg9fWeecPKOgFnHr++G3SgICY3yYnO3T
	 YzGPXv41eKczgVyymqbfjQx7/4M0Efdd2k2W1Q+6byAl4+/ZfwXnOgxCDCObMwzOAP
	 uOVc5cx1lJKtY2S3p8GXe3LC+TiesrbMfWSuC4UI3XovbJbLtsT2sDhdlPzM5zOfiE
	 JiKQmefqyMleQ==
Date: Fri, 5 Jan 2024 21:39:02 +0000
From: Simon Horman <horms@kernel.org>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, weiyongjun1@huawei.com,
	yuehaibing@huawei.com
Subject: Re: [PATCH net-next] fib: rules: remove repeated assignment in
 fib_nl2rule
Message-ID: <20240105213902.GC31813@kernel.org>
References: <20240105065634.529045-1-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105065634.529045-1-shaozhengchao@huawei.com>

On Fri, Jan 05, 2024 at 02:56:34PM +0800, Zhengchao Shao wrote:
> In fib_nl2rule(), 'err' variable has been set to -EINVAL during
> declaration, and no need to set the 'err' variable to -EINVAL again.
> So, remove it.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>

Thanks, I agree that this seems unnecessary.

Reviewed-by: Simon Horman <horms@kernel.org>

