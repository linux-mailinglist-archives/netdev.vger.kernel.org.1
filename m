Return-Path: <netdev+bounces-204706-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A692EAFBD80
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0337C4A49BA
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 21:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23172874E5;
	Mon,  7 Jul 2025 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUev6aT6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989B628727D;
	Mon,  7 Jul 2025 21:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751923793; cv=none; b=KUL5WwKHRf2UvYC5DGdEPVquOprKnQVEVyhuOGmMaDwJ9bzl/Rxm2NviZQTVl2IrWNugBNHcLaSeyB32Ow6sb1q4WiS1Rrt+tl3yS6tx7mVP42WBufYp5QqVZcPDbpZ0S2mfAORH5ZL5Ww+5d7eb+on0URzNseYNA6JFVizqAoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751923793; c=relaxed/simple;
	bh=N9sLCdScIDm4NLfJfjfFN2VZQUW/uhXLornv7Y3uzo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ciuCzk+pDtQrDTz8u/lfO837xRW/vk9C/APhwWE/jLnMqde2xWbcVEqVhvubGiVmQTsoDAuGSJ9LDudYnNv4yxoAQUNSc6vsXQzhg3lPVHaAhxN9kx8vm8LkZ1yaH3zhdHAxgtoTvR+de/sBB1z57kABCOZLtMhXzWZZmxrySQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUev6aT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE883C4CEE3;
	Mon,  7 Jul 2025 21:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751923793;
	bh=N9sLCdScIDm4NLfJfjfFN2VZQUW/uhXLornv7Y3uzo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FUev6aT6jFhMGQReR1m+RFVnBRNZPolUaHmyrS+Eg8e2CFqokxYNXkoykPKe0CVpL
	 XZRGyoq3DMMzTL6u+JDdEHRudqjhJZj8GRhKRfWHmjCI/gjalFqEQeu+44Jchsjeea
	 PUZk7oToRZaVUtriuxT1fc4j3LLzQamPpriNrs5YzTOVEygunb6uqoqubpzYzZGJju
	 q87P9Z+aW/8ZRFuICJZiK7f4sHzxrNWrTMLC93SQqRjFaer3uWvAaJvmz9+R2+HvW2
	 kLMn5ifSVBzEYB9SGQGu/WWviHuHCgu/+TzBw4yfHMoyMJspUXNc1hh1FgyYqE8jZM
	 1frMWGDyEZEsQ==
Date: Mon, 7 Jul 2025 14:29:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, stable@kernel.org
Subject: Re: [PATCH v1 2/2] appletalk: Fix type confusion in
 handle_ip_over_ddp
Message-ID: <20250707142952.1d904046@kernel.org>
In-Reply-To: <20250703052837.15458-1-linma@zju.edu.cn>
References: <20250703052837.15458-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Jul 2025 13:28:37 +0800 Lin Ma wrote:
> Subject: [PATCH v1 2/2] appletalk: Fix type confusion in handle_ip_over_ddp

I don't see a 1/2 patch anywhere, please repost correctly
-- 
pw-bot: cr

