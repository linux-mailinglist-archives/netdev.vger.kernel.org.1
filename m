Return-Path: <netdev+bounces-103239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABF79073C4
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CD5283E00
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DE8143C5F;
	Thu, 13 Jun 2024 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApsU5p51"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E7A1422AB;
	Thu, 13 Jun 2024 13:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285601; cv=none; b=WVXlEwmqQP8poItjILnrUEUX1rxjj+NrZuVv7VMcdIi1qfLEUmQc5EVcKjsOq8ncuM5XToMvlMxtHuz7e3P/rDY0kwELQCvHZh7C73AENjDtVvfyYRUhqvZoQpTjSQg7CqC3NSehfH8YpRzxCCrnPGIxtBEB5RcFzTvXpD+8qHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285601; c=relaxed/simple;
	bh=ZvFoWGAWvnBf//F4o18dRrfkf3eHoTbQgj16D114TlA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFPPmXaDfZuXZC5YnbG22IFKs5f6Hj4yayLZRXsjh0XLfFiG9uv4vDuKIQjpoB9lNerOmSuL6UciDDja0JDbJp2bJsHei7RbGC4adF1izFQ3YEe5eqgmIs91EoOppm5SdLr1KB7gcMy0Phl2NyJ4BnHVg5V2SRz6oYSWxA4nvtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApsU5p51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E752C2BBFC;
	Thu, 13 Jun 2024 13:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718285600;
	bh=ZvFoWGAWvnBf//F4o18dRrfkf3eHoTbQgj16D114TlA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ApsU5p51nIKLxGpr9Ycft2yFdlECZGSYzS89weDI2ljDyoprlXnq1ztB1tYynQqz+
	 /tjQMogocTS7SnffnjX81pMS66ECSzL4tI4dUm7dqAMUxY9H6g0XQt/osler8fGk66
	 9b/urJfpQUZ7CcySRisivDhN0pRiDhQBD0NA5KzV6reKw1QZVdz5V0mNR+afgjyJLr
	 bAhjfkVvH6GiLpl+hSCMUddG/EkIy1Kgx4JxecZTwTDC8Z/WBkGK3WwsKZKgPvro7C
	 ZbqpEiG6dCiaKl5OsibHcffyQc4MT/I6MixXTqgVL5e9BK4/8GWAb4vANI/DP4Kd6L
	 zV01wbC4nf51A==
Date: Thu, 13 Jun 2024 06:33:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
 <richardcochran@gmail.com>
Subject: Re: [net-next,v5 0/8] cn10k-ipsec: Add outbound inline ipsec
 support
Message-ID: <20240613063319.2870214b@kernel.org>
In-Reply-To: <20240613071955.2280099-1-bbhushan2@marvell.com>
References: <20240613071955.2280099-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 12:49:47 +0530 Bharat Bhushan wrote:
> This patch series adds outbound inline ipsec support on Marvell
> cn10k series of platform. One crypto hardware logical function
> (cpt-lf) per netdev is required for inline ipsec outbound
> functionality. Software prepare and submit crypto hardware
> (CPT) instruction for outbound inline ipsec crypto mode offload.
> The CPT instruction have details for encryption and authentication
> Crypto hardware encrypt, authenticate and provide the ESP packet
> to network hardware logic to transmit ipsec packet.

Read the rules, please:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
We're drowning in patches right now. 
I'm tossing this, come back next week.
-- 
pv-bot: 24h

