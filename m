Return-Path: <netdev+bounces-164265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689DFA2D292
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 02:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019D416CD4D
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 01:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769B94594A;
	Sat,  8 Feb 2025 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmJu6Ykf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5078E3BBE5
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738977581; cv=none; b=QQA9W2vlhJwvJlAQ3MUhEm+oeV/TdXdF/NquihUYMTY4vwnBcCyT4zUIZ/tLehyPw8/oD4fGNpCYXA7vB0OKHjRtFsYzjydTyDAPeKpkxoNuwv0ilrch9Ri/eX299iIcG8asBVnfA8ypVGXztBcqXzJLikY78JwsXe2Myd2hYlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738977581; c=relaxed/simple;
	bh=HIc+r3YEQbg42bPKF7G4Cwx9BlV3CQRCLxIr+bWzgJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUrNxdQg62CMFB/hYXKhKgwG4zSGbvOL4aZUoV7RvyA2t89fta2dYIjF+B6NKkbF0PGmnbQT7Lpzi3HTcY6HoV0ysVxsLz+wvxqn3+orUWJgenRO9x2dSl5yOcLhivYnZ+mDKos1w8Hz3pwfiHYqCjYtW1Kn2az1O0xDoo7XEbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmJu6Ykf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047E7C4CED1;
	Sat,  8 Feb 2025 01:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738977581;
	bh=HIc+r3YEQbg42bPKF7G4Cwx9BlV3CQRCLxIr+bWzgJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rmJu6Ykf2mX1BKSHe4JEboMcS6xFjDj8TSqkbFiOecIv/RVt8HeY2zxFoEA+dexJW
	 MlW+i8hNulZ7XxF39Bf/BKvsiDZLYTT7As3oMMiGU+KaXfEnfywwh6Ub90w3dOOQ90
	 mbeVAk7PFUpFiAojh7iVEqIJFKx1fUK1aBgVrCSXHf+L4o2hnti92Tc7AhkP9pp9Je
	 ZW8g2D2xg1M55MOXLuzvAinKcSR3ZJANYFqVnOFSVHbNN7Fe44aJXdjhkwSb+Hhg5h
	 MgUZEY0nWr6zRCrqynuvYvyC9MKC+9rQzuDsnFz7S6dAnyFxMzrzkcJk/wrij5SuaC
	 h9/Fj9yN9gUMw==
Date: Fri, 7 Feb 2025 17:19:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: mengyuanlou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v7 5/6] net: ngbe: add sriov function support
Message-ID: <20250207171940.34824424@kernel.org>
In-Reply-To: <20250206103750.36064-6-mengyuanlou@net-swift.com>
References: <20250206103750.36064-1-mengyuanlou@net-swift.com>
	<20250206103750.36064-6-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Feb 2025 18:37:49 +0800 mengyuanlou wrote:
>  static irqreturn_t ngbe_msix_other(int __always_unused irq, void *data)
>  {
> -	struct wx *wx = data;
> +	struct wx_q_vector *q_vector;
> +	struct wx *wx  = data;
> +	u32 eicr;
>  
> -	/* re-enable the original interrupt state, no lsc, no queues */
> -	if (netif_running(wx->netdev))
> -		ngbe_irq_enable(wx, false);
> +	q_vector = wx->q_vector[0];
> +
> +	eicr = wx_misc_isb(wx, WX_ISB_MISC);
> +
> +	if (eicr & NGBE_PX_MISC_IC_VF_MBOX)
> +		wx_msg_task(wx);
> +
> +	if (wx->num_vfs == 7) {
> +		napi_schedule_irqoff(&q_vector->napi);
> +		ngbe_irq_enable(wx, true);
> +	} else {
> +		/* re-enable the original interrupt state, no lsc, no queues */
> +		if (netif_running(wx->netdev))
> +			ngbe_irq_enable(wx, false);
> +	}
>  
>  	return IRQ_HANDLED;
>  }

You need to explain in the commit message what's happening here.

IDK why the num_vfs == 7 is special.
Also why are you now scheduling NAPI from a misc MSI-X handler?
-- 
pw-bot: cr

