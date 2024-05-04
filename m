Return-Path: <netdev+bounces-93424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2D58BBA9A
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 12:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA9B1C2098C
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 10:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ED11946F;
	Sat,  4 May 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJdCmycb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC88182B9;
	Sat,  4 May 2024 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714820312; cv=none; b=DGeuuGHg12FttEIMkq0np0WG5gli3/YK97+HJl/wAkVfD9ioeEWcOCRpEzb5D0mXX9sy6995xFu2SKMAMrrnQ2af+X2amcICmeFhnOzo/EEhI3b1hxYqkpwjgReGG4UbTkBm1G6kEQ1ObhQZ1uARtoPgkyBCV2RyoilIvjaYzcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714820312; c=relaxed/simple;
	bh=QLQ0RTBUFkiq9+4ew2tgFckcrt/iGvMJTo/xNi5eO5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yhy3vKg+6IIZ/O2NnhJYaPC4mS27HS3AKxquInbckCBATKCbnRdPSypxdmRVNZwCzKNSy7gpGDs/U21x8UM+wA3Pe4AWP6NRMm99Zt6DYLa0aGRl51lpivs46zZvFEcZjBkd1GV+2uCYieIURtBLzzOAKLQB+haf+UYLfXCt6G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJdCmycb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82D42C072AA;
	Sat,  4 May 2024 10:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714820311;
	bh=QLQ0RTBUFkiq9+4ew2tgFckcrt/iGvMJTo/xNi5eO5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJdCmycbF69Wncj1a1ZNj+3M5xlopPTxvwLdmFe0dpsq1ly07X4sAVTGF+qeNE0I9
	 32iOxWqMkxA5FICndxviWdTDYXiiIMlndJvo+ofoyyYMX7CFrWQa92gMgkdEIG2gxq
	 a7qMIKbT5jgxM1bF7/dWoVAcsPN+4WswB36Vgrog2injJCeyEb8F+xjwzfOSTTW2pf
	 tl6j67dl2Ej/1zkw+TOjuVksmCFjg0UlQ45Brhrmv3RxhE7hvt/5PmiPiAG58Kdf1U
	 811yjgQ2zgC86b9f8MUKRPCAKP9uO6c31I/jDOiUB5kmVxXqzUcfLQ3qoVN0RPrxHh
	 Ss2ItrV7/xZSA==
Date: Sat, 4 May 2024 11:58:25 +0100
From: Simon Horman <horms@kernel.org>
To: Shi-Sheng Yang <fourcolor4c@gmail.com>
Cc: matttbe@kernel.org, martineau@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	geliang@kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH v2 net-next] mptcp: fix typos in comments
Message-ID: <20240504105825.GE3167983@kernel.org>
References: <20240502154740.249839-1-fourcolor4c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502154740.249839-1-fourcolor4c@gmail.com>

On Thu, May 02, 2024 at 11:47:40PM +0800, Shi-Sheng Yang wrote:
> This patch fixes the spelling mistakes in comments.
> The changes were generated using codespell and reviewed manually.
> 
> eariler -> earlier
> greceful -> graceful
> 
> Signed-off-by: Shi-Sheng Yang <fourcolor4c@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

