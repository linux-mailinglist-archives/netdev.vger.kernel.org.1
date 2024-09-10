Return-Path: <netdev+bounces-127019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA290973A89
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 16:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2751F1C24C09
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4831419412D;
	Tue, 10 Sep 2024 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjBNvC/n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC9C136E2E;
	Tue, 10 Sep 2024 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979812; cv=none; b=rIazh6YiqxubImCoqwWOEmDTi5mhoYAaryJgu1vxBQ5nAUIpyQq1hhq4k6BUexoQxg8bSdMBgYAi3BkBeOvYPqPfCTUv1qsIGZkCGQhRI2Ie76V6+DXx/04T2M8XgSCQJHUqQT7/ROWLi/AUOkBDB7qjBgPwswhb6B6Ec93nz2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979812; c=relaxed/simple;
	bh=pkQXUEWeHR9vW2l3JN7yFeIl2jLgAIAgmoQiMK44X7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMHAwP64AoyY2do4tpmdY31ZwLpMIv43lStWVQp1AwvzvoI30fk0UNN8RnN2gWjR5CrPfi6H9oc/1iMMe22KrYA5d/U6Ceo82Ng9iFC88PMuhkQeCCy3OqoCvMeP6xJCpuQGqEst8nET3U9sF1e57O8mOgzwdUC83d1MJItEad0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjBNvC/n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2071C4CEC3;
	Tue, 10 Sep 2024 14:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979811;
	bh=pkQXUEWeHR9vW2l3JN7yFeIl2jLgAIAgmoQiMK44X7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjBNvC/nbUUnS4l+lLivYhQmVTE2OU3gyKSXPUfltk8veQkrXLsjZiNE99Qq/oOE1
	 kdKlKVMrOp+OY1sfv8QGGuy/NfI0lNOYMoGShOE8mtXLcoQGfjV9SkaZA9uaB/Asue
	 hOUgIZYDhadZVQZ3ePkqqTKUXX+MLAWbKz7zWnsBIbcc9rlAnRbwOHVrAcRaHfj2y4
	 dw9ELzupdklmfyP3t4jX3Ae/vRHNIThLbQITCxIzYcAHcu1wG/rgZZ1hBUyitnVQY5
	 T8SantBX9r2lPBw87BDTcbv1CWoAteh2Y3nSs5tIMgaq9ORzS8p77qfHhuGYjpJ0D6
	 bvTXfRZ609ZcQ==
Date: Tue, 10 Sep 2024 15:50:06 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, Matthew Wood <thepacketgeek@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davej@codemonkey.org.uk, vlad.wing@gmail.com, max@kutsevol.com
Subject: Re: [PATCH net-next v3 10/10] net: netconsole: fix wrong warning
Message-ID: <20240910145006.GE572255@kernel.org>
References: <20240910100410.2690012-1-leitao@debian.org>
 <20240910100410.2690012-11-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910100410.2690012-11-leitao@debian.org>

On Tue, Sep 10, 2024 at 03:04:05AM -0700, Breno Leitao wrote:
> A warning is triggered when there is insufficient space in the buffer
> for userdata. However, this is not an issue since userdata will be sent
> in the next iteration.
> 
> Current warning message:
> 
>     ------------[ cut here ]------------
>      WARNING: CPU: 13 PID: 3013042 at drivers/net/netconsole.c:1122 write_ext_msg+0x3b6/0x3d0
>       ? write_ext_msg+0x3b6/0x3d0
>       console_flush_all+0x1e9/0x330
> 
> The code incorrectly issues a warning when this_chunk is zero, which is
> a valid scenario. The warning should only be triggered when this_chunk
> is negative.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Fixes: 1ec9daf95093 ("net: netconsole: append userdata to fragmented netconsole messages")

Reviewed-by: Simon Horman <horms@kernel.org>


