Return-Path: <netdev+bounces-90246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7058AD465
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 20:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBFC2288BD5
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 18:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADC6154C0B;
	Mon, 22 Apr 2024 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXWOTLES"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437EA154C01;
	Mon, 22 Apr 2024 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713811847; cv=none; b=Tg9Z/V83S+JY8ZWrbx5oOvM9ysTRt1fZAsovaF6Rrh3Y3qujYIqdJudFH+rrLtGw+B1AzI7sEqo7LFwQ2TlZsN7XkJYVL2XDHhM9hl4xShXOEPkpM9j2Y0YqVIG/RKwr72e4MmNG4TpTFE/Dx9/aE/4bO0eNoQOIq1pfggq6Me4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713811847; c=relaxed/simple;
	bh=U6XcDoar01u1E1JAQJlAWvBzcAcrtkDEIX7j6adblpg=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=clPsfymg4yEkR+xtRRHmo6Q1ecOh+tyEQ/WaIKdgb0RPJ4c8KiuhHgRV7WGQYjvwpfMdmpG3tLVxrBsHvbh7uLWhhXuvyluzkX4MxOL+XdVrJHLVWvioCJuy/RJyFqpa0juWC+zBZ3RrdDAdzuUNG058Ld6XgWyH+PntLw7ygWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXWOTLES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4D4C113CC;
	Mon, 22 Apr 2024 18:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713811846;
	bh=U6XcDoar01u1E1JAQJlAWvBzcAcrtkDEIX7j6adblpg=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=kXWOTLESo+QvjCU6Cu5tcEqGocKV1yDheJqbG/2A9MfIjIYlJLBtGXVYX4wluYlV9
	 QjdQbRvLmDe9kGxgmIVCOdEB0bqa2fXEkmNhKEQOtvdGvn2rpUJ3EHAUuM4ZgAmdgf
	 YZHr0Mhl3mmHjosUhyg4FGnqWwKtWhXY3zjTBA1Vs2MwENoiQ38BJOZxKWzYgNGWPq
	 pkP6xgDBaTZLS9OFKu0r86YDjnx+D/vAhvAwwCdIhCeyqu5X5bKKTymJ6cifyJ81vG
	 DHo8X+LEUz1XxM/6pDjttdTsgFSHN6pLwM+jBNxc+hGa+13Pe95VcnKHLdRaw3v+9Q
	 eBDwJw8SqJ45w==
Date: Mon, 22 Apr 2024 11:50:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - April 22nd
Message-ID: <20240422115044.53e6a3eb@kernel.org>
In-Reply-To: <20240422094932.4dd0fc13@kernel.org>
References: <20240422094932.4dd0fc13@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Apr 2024 09:49:32 -0700 Jakub Kicinski wrote:
> Subject: [ANN] netdev call - April 22nd

Ugh, I need to script this. Tomorrow, April 23rd.

