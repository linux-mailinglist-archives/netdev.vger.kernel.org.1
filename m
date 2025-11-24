Return-Path: <netdev+bounces-241240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA00AC81E8D
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7856C3A968F
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AD623C4FA;
	Mon, 24 Nov 2025 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmYOz2nB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC7F219A79
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764005563; cv=none; b=q+v3gRVw9mpXrVZ4F30mtx6n8wAZLU9RAKUDXZcm0X9QyS7Yzz8HyQSwEcsiFgDRP1w2+cnoVv7OA08eLMFM8KOSufHyHSY2KCqPD9ZH8s4xqrDEAw/EpaUy/QyIYoEgVrO+jneqjbd1PitQevdP8I+VRhqlB8kAjmOMcbZ39FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764005563; c=relaxed/simple;
	bh=ma/0TaoXCun72lY5nXwWBDsiBcSBHSICTXllRwTjprA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X5KTW6buHVjjxdvRS/DutMEraWPJRwKAvZPMuHD/masAzE8UQNp4+qj49vVf7RIJ8kUr8B7BKOA6UzAfYcNs+FXrub3RMIzt4BhYkdjSwEunifEjzny2UNyS8kHhNJiklAdcrzTzHlkHZZtWQi1R6XanKRWLAxneUVZ5kkC22S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmYOz2nB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FAD9C4CEF1;
	Mon, 24 Nov 2025 17:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764005562;
	bh=ma/0TaoXCun72lY5nXwWBDsiBcSBHSICTXllRwTjprA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TmYOz2nBvdDlesmgt1z0TQMe2pblaxHjya4TmdrCbZ3qrJaTI/fPx6+VpVtDTQ+2G
	 iPfFdwuVFCZWYWASiBlcVnceskEy/DgAhLuyz2Enedsbtj4E0pT8hbMCssh+skQpDf
	 mtsDcwYhh60Sfbt4/d6xsZO11d6JvH18/5/FLG4rgmHe0UFv6HJAAC+bmbfUNZNX1M
	 Jrg1FpUU6PkqxDVqZA9LwUMvGvh5Cr1hoLkq4JP/Wr7GgSZ0dnN2kTTyjqEo2jUgpM
	 Qe3p9JSSQQocOrVuL0HxeymggqClmOl00ILsXYC10W1j63I2/ENlP15Mo8EXkOxUWs
	 aBP5LWwHaDezg==
Date: Mon, 24 Nov 2025 09:32:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next v2 3/5] selftests/net: add LOCAL_PREFIX_V{4,6}
 env to HW selftests
Message-ID: <20251124093241.555d7d21@kernel.org>
In-Reply-To: <20251123005108.3694230-4-dw@davidwei.uk>
References: <20251123005108.3694230-1-dw@davidwei.uk>
	<20251123005108.3694230-4-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Nov 2025 16:51:06 -0800 David Wei wrote:
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
> index 8b644fd84ff2..4004d1a3c82e 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -196,6 +196,7 @@ class NetDrvEpEnv(NetDrvEnvBase):
>      def _check_env(self):
>          vars_needed = [
>              ["LOCAL_V4", "LOCAL_V6"],
> +            ["LOCAL_PREFIX_V4", "LOCAL_PREFIX_V6"],
>              ["REMOTE_V4", "REMOTE_V6"],
>              ["REMOTE_TYPE"],
>              ["REMOTE_ARGS"]

The DrvEpEnv does not need the local_prefix vars.
Only NetDrvContEnv should require those.
-- 
pw-bot: cr

