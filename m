Return-Path: <netdev+bounces-122367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA1A960D80
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C691F23D5C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77561C4EC2;
	Tue, 27 Aug 2024 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2aaUaLR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0441CABF;
	Tue, 27 Aug 2024 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724768664; cv=none; b=aemCis4S7jy4FFpRn62Xyr8/CLR3zFBmKws8Zq8H41cv2q4c0GuDTjFqT2uzTUTinJn3N0Hd8muCEi7mHNc+h2QzvAbuWNm+FPxX2YZ0S0W+JC02iFZGHOgpYukHZMNZ8YjOwSo7JH/lIDVNXYGkwJOX5DiKz8C6Gq24wAKdtaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724768664; c=relaxed/simple;
	bh=nPgT01Ccj6BYdANgzuzeqwZikvxxVf26U3E7v4rABQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7HktODjCz8UO6VecGTgVM4wuj4O7iFi5N1ozWyOeY1v9NjxdhI/VvzsJonRt8GA+MbvC1HgFAnIPfcMdV6ptTH3MsgdHrD3TAqvbITZrGl04gdRRkADJcI0n4uETKJzRPi60Xg1HivpiAn0E0O4YB4XD83OhQv8kv5F0Io1Cs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2aaUaLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E621C4FE0E;
	Tue, 27 Aug 2024 14:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724768664;
	bh=nPgT01Ccj6BYdANgzuzeqwZikvxxVf26U3E7v4rABQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K2aaUaLR+vlsq6FXo05CtYWkDVLlGaePedsQap2L6qi7EMpIF4U3SHyia29VXMR8p
	 9R6x1pgOgfBgIHe/tNnZQl4sgl5fuEA8cxkfpmCXMVBgjjw6vQryx1KKLpJyWqPvz0
	 44TpDuosRMbrGzG8eqsYxpt/B1ZtMNrUWxW4AFYo6VQz05TWEjiTiAunka2wH722Xg
	 SeIzp4h+lYGCkWgCYACHuRwWQS5newLKz4A+RjbU6lFeC3vZJ/cKV4P9mfb+taJ+XX
	 /x94vV9IGUO1fN9u2stcGng+yDogei7OPNNnXio6QeZ9rrWjTAhWOm8FEQDnlz+1Qp
	 GGcREDQQjxoHQ==
Date: Tue, 27 Aug 2024 07:24:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yan Zhen <yanzhen@vivo.com>
Cc: louis.peens@corigine.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, oss-drivers@corigine.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.vom
Subject: Re: [PATCH v1] netronome: nfp: Use min macro
Message-ID: <20240827072423.4540bed6@kernel.org>
In-Reply-To: <20240827084005.3815912-1-yanzhen@vivo.com>
References: <20240827084005.3815912-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Aug 2024 16:40:05 +0800 Yan Zhen wrote:
> Using min macro not only makes the code more concise and readable
> but also improves efficiency sometimes.

The code is fine, you're making it worse.

How many of those pointless min()/max() conversions do you have 
for drivers/net ?
-- 
pw-bot: reject

