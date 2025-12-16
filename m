Return-Path: <netdev+bounces-245022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F4ACC547B
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 22:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE3273019E3A
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 21:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FEE33D6F1;
	Tue, 16 Dec 2025 21:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmYjVQVX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB6B31AF1E;
	Tue, 16 Dec 2025 21:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765922330; cv=none; b=HpSy7RW7uDkWg8LmZXEEKvnU60SfzpeYvuDPvsQedSv6v+5rUhL8FYegB5B4FHvHrlcGDhOWemqNuzVJSE6VKiFcxw/PG6lEPufONLI6b3Xj33QVxLwuquWOBqXVkFfy1f/NrbdqIOcYZjXVNt9ZW3liOZtXMS/iXmGAPvQjgJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765922330; c=relaxed/simple;
	bh=J4UYQDKzCH/5iGNRAtJadt8ptSMV0RITVhETmRl0sB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wci+mtwY9URr6Jcow2A0m1b5DDig4DUumQUsk9GDBhFP5QTs2maDZQJWPdk8Q9zM4DVCr+mu9GniulfJv12yHpoxaCuMEK6ptlyp0A9IipYhOZLcTyMpM5tyeADkPQyO4iQ19cJrM7AoclP681CEIMuoL07zzk+P/B4LA3yuv30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmYjVQVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FF9C4CEF1;
	Tue, 16 Dec 2025 21:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765922329;
	bh=J4UYQDKzCH/5iGNRAtJadt8ptSMV0RITVhETmRl0sB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CmYjVQVXNuPupYfcs2dMk44NM5masx14KTaUxiE49W/r8V+AudxPnBoon9g13etEx
	 6LbEIdHUxzvkJUKUf9D8HBvC8vZEjmAtxwyjt9kivKHMqeWU+835uXtEG26v75ISsz
	 yK2GPTmF8Kp8tzcXsBeErERw2Q24SPRgR2oxZBuNEaaZtWRC1e/M9FMGcaPR26FHgU
	 qwlX841Meuc6LESbdv+lPTu3p2Ldhv2N5FZcnbrnm7wVB3MnEQCmLHxxxSamGN1t7l
	 5sGV/DKDxj1BT0D92EEm5BkP5syseYe4E/WZF3CFrfMK0ewwTmrP29MlwNboWF/wiv
	 p/GJYH8VGkxpw==
Date: Tue, 16 Dec 2025 13:58:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: Richard Cochran <richardcochran@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
Message-ID: <20251216135848.174e010f@kernel.org>
In-Reply-To: <fb01b35d-55a8-4313-ad14-b529b63c9e04@linux.alibaba.com>
References: <20251030121314.56729-1-guwen@linux.alibaba.com>
	<20251030121314.56729-2-guwen@linux.alibaba.com>
	<20251031165820.70353b68@kernel.org>
	<8a74f801-1de5-4a1d-adc7-66a91221485d@linux.alibaba.com>
	<20251105162429.37127978@kernel.org>
	<34b30157-6d67-46ec-abde-da9087fbf318@linux.alibaba.com>
	<20251127083610.6b66a728@kernel.org>
	<f2afb292-287e-4f2f-b131-50a1650bbb1d@linux.alibaba.com>
	<20251128102437.7657f88f@kernel.org>
	<9a75e3b2-4d1c-4911-81e4-cab988c24b77@linux.alibaba.com>
	<c92b47cf-3da0-446d-8b8f-674830256143@linux.alibaba.com>
	<20251213075028.2f570f23@kernel.org>
	<fb01b35d-55a8-4313-ad14-b529b63c9e04@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Dec 2025 22:03:57 +0800 Wen Gu wrote:
> If you're suggesting creating a new subsystem, I think we should first
> answer this question: why can't it be part of the current ptp subsystem,
> and what are the differences between the drivers under `drivers/ptp`
> and those in the new subsystem?

I can't explain it any better than I already did here:
https://lore.kernel.org/all/20251127083610.6b66a728@kernel.org/

I talked to Thomas Gleixner (added to CC) during LPC and he seemed
open to creating a PHC subsystem for pure time devices in virtualized
environments. Please work with him and other vendors trying to
upstream similar drivers.

