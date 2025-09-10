Return-Path: <netdev+bounces-221898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7461EB524B3
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B27017DBD8
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 23:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C55A24DCE2;
	Wed, 10 Sep 2025 23:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="sXTxHEII"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE31522F;
	Wed, 10 Sep 2025 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757547077; cv=none; b=DzA+hJxQ1jgDC+F5ypj9cEZpAhR4I/Woc2MH2/VLSGtWavT9P+Ix+mwE2R6RDroXpgP7QGs2BYpFLytipTtdM2h2mHm9zJOnledWnHzV9eOOBBgL16n3Ufk4BCIHi4zVFqaiYkcX9X3e5N20PljxbW06XBJ8Li8ztAMdHpaKu20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757547077; c=relaxed/simple;
	bh=dIitYuDvpHeoEvtt5HXFP3lx4tiZ1BKefqVs6vie4mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cDi9e8rmCg64C2JHxh5kauk3SQ36/ZI/cWKZ4AitLd0N9taEm5EoCH3K2qiAX3jyG2nvGBEnZQ/Vty/z309NR6TXF5eIWbAOzF0DYrb5R3VAfQc/gdWsXTyRb4+ZeUrdfVHINh/c8hau6TzxNFxWRP0UxfeQTcmYBL+7dpaa9kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=sXTxHEII; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757547070;
	bh=dIitYuDvpHeoEvtt5HXFP3lx4tiZ1BKefqVs6vie4mE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sXTxHEII4He2+UHba2PRjHXoqBm0eq9GBxPz5Daa86KBFaP/VlIO7mA5kD+IAoRhm
	 iSkXXBhiCxskYPctP7wdbzOt6b2g3D12uc86UiEW5nUZ/Yd1Ax1WY26AvXQRZgMNO1
	 2D7gweLaAEVHwUIDMsG3H4FsVv+vKemB7e11k/g3b8xLeTwOSwPEVxJi6fYLuEvXWk
	 qr5zwd3tyTFEAHZJyKQepnQ4OnCKIo5zzGQ1h78Hn4/2Eh8eLRSFsPraTCbuuMJcfE
	 16Vz+p2S7IGtb6nMxneTw+VV1oGGekYu2hE/p1oN0THqfB0kcfaHKOG6M/HFROkZib
	 OkbBvd/eJFicQ==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 621556000C;
	Wed, 10 Sep 2025 23:31:09 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id DBD83201555;
	Wed, 10 Sep 2025 23:16:31 +0000 (UTC)
Message-ID: <e33b03ca-2d55-4541-825b-d3d01bd1a3a7@fiberby.net>
Date: Wed, 10 Sep 2025 23:16:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] tools: ynl: fix errors reported by Ruff
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>
References: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20250909-net-next-ynl-ruff-v1-0-238c2bccdd99@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/9/25 9:07 PM, Matthieu Baerts (NGI0) wrote:
> When looking at the YNL code to add a new feature, my text editor
> automatically executed 'ruff check', and found out at least one
> interesting error: one variable was used while not being defined.
> 
> I then decided to fix this error, and all the other ones reported by
> Ruff. After this series, 'ruff check' reports no more errors with
> version 0.12.12.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Matthieu Baerts (NGI0) (8):
>        tools: ynl: fix undefined variable name
>        tools: ynl: avoid bare except
>        tools: ynl: remove assigned but never used variable
>        tools: ynl: remove f-string without any placeholders
>        tools: ynl: remove unused imports
>        tools: ynl: remove unnecessary semicolons
>        tools: ynl: use 'cond is None'
>        tools: ynl: check for membership with 'not in'

LGTM. When I first saw this, I expected it to collide
with my v2, but I have checked, and they don't clash.

Reviewed-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

