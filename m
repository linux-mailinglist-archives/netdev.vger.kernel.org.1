Return-Path: <netdev+bounces-147764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFD19DBA98
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 16:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3AB161F9A
	for <lists+netdev@lfdr.de>; Thu, 28 Nov 2024 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEC51BC9EB;
	Thu, 28 Nov 2024 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWhdPQJt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CDA1B85F8;
	Thu, 28 Nov 2024 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732808108; cv=none; b=C2AKhaAoHtFRYDjkLii3hnG9/lE+LjaDP/PiSQLYlPaX4Oof4qlrWyB5td6DsnBzcOioim8Duzb7WrMgJIT1+zhrik8gQHRuDQS1t/l3Y35rIgloq6RP5XE68dJ8OubGtG+Z7tMnPuTAO+loqTgX0yHb2mvPBTyN7319VHsn974=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732808108; c=relaxed/simple;
	bh=kBXLA91PuhxzfLwiBNi4wzmlbQLHS6D8OaADWzOyDvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJpbwYcf+KWmjnf4xP7ztINRy4EUO+sblR0aYEomJE7Km0Rh+XHsuv0vwcf+kiy0+6vFjbY9JwyHh4peFbuMJTb4e71qsJ4tLxXRyBgGe8oIbHhaX8vGG3heSQc02Lte+CvSdIFAk6zgR6ye3CYUyyu6dU0y5Us6L5eE8opACBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWhdPQJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F01C4CECE;
	Thu, 28 Nov 2024 15:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732808107;
	bh=kBXLA91PuhxzfLwiBNi4wzmlbQLHS6D8OaADWzOyDvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SWhdPQJt5Ngq9UppJQH5z94SRuMZxtPFnLUo/ToGTgRytCxmTKNWU5W5AlslRg5Kk
	 Kx0MfrnEirKNukaPndQE0iP8DXjC6cGkpf+WumBl/dBWe10xsqr3LVYaOL+OJ5Co1f
	 yj3TaKZGzfYMdAW2oLfjDfxAOqaapEJd14BTiU7sZUzQ2HIEhg7MYSDkcdNpjVwlCP
	 MwVMjbTXgFA6VZxfPIpE2sMehXg3+uzHYg4fC9tiSIEzVf3VlRUFHhiIosX1At4RzG
	 UFInoPSJhdfNzgqCZBeN9YVgfXrTY5wRyNOglYhKGRbR0Ceurj+xi+mxhB+Ts2WSir
	 4zMZh/e/rpX/w==
Date: Thu, 28 Nov 2024 09:48:56 -0500
From: Sasha Levin <sashal@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Networking for v6.13-rc1
Message-ID: <Z0iC2DuUf9boiq_L@sashalap>
References: <20241128142738.132961-1-pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241128142738.132961-1-pabeni@redhat.com>

Hi Paolo,

On Thu, Nov 28, 2024 at 03:27:38PM +0100, Paolo Abeni wrote:
>      ipmr: add debug check for mr table cleanup

When merging this PR into linus-next, I've noticed it introduced build
errors:

/builds/linux/net/ipv4/ipmr.c:320:13: error: function 'ipmr_can_free_table' is not needed and will not be emitted [-Werror,-Wunneeded-internal-declaration]
   320 | static bool ipmr_can_free_table(struct net *net)
       |             ^~~~~~~~~~~~~~~~~~~
1 error generated.


The commit in question isn't in linux-next and seems to be broken.

-- 
Thanks,
Sasha

