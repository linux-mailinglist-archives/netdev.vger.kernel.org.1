Return-Path: <netdev+bounces-195445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5160AAD0335
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D78C16CE45
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F69288514;
	Fri,  6 Jun 2025 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6Rysxo0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A179A2857DF
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 13:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749216683; cv=none; b=ZBFCDQq8uzze2T0CJRu2llv/3onurNHaDuP3PeiWxpUFIA3Zmk1+ZVlwungs9UUi3HgE8A97PbXdHnS5U4o0o5N4rR5mxAsD0vavGnB21X6AYSV5A4tGTul/K+FhMeDwXXqIQpQUqY7NejQM/sjhP+PoDQJk7gPFV4YwBHUZvog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749216683; c=relaxed/simple;
	bh=6EJMDWai3fI9MpfZ2CXs4XNC+QgWVQZY28L1rT4d/+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FGxm1OZjOS3nDvSWx9CM+tiyfE/JvLLm6XqMbR6HFJvo3UurKayIg38tOvn3TFOFwCIStf+Ki9J3zvW8uRYcyr5HNYln6aDscgPu56V4t5zWkr7AhC/CHgchUqpQYYS9vKyy49ZMdBo2dnpIv2oQS9qZUGKC8Shpj1Bzb4uyr1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6Rysxo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805E3C4CEEB;
	Fri,  6 Jun 2025 13:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749216682;
	bh=6EJMDWai3fI9MpfZ2CXs4XNC+QgWVQZY28L1rT4d/+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q6Rysxo0jU/R4yhdd0MowKAywFG2rMagVNvMEnfMAWmSl2iKYZd+UAeTzQ9GPJcbQ
	 m0LEOlyeaxPM3qxc8LO4DE+nS6xWKDhPzMYiL5qPGlXF4TcYkEJiwYkwZxVpYGAkw+
	 aaBTWdPbRvdbfXbNntr8PnFhiGrv7Xrte/cMPKgPprMnBq9KWoRNrBT4msTWKx7JCt
	 wGVvCvDpHP9jjTYLCj5SNcIKEXH3emJi2IJiuwHapWS7usb7pa9w+K29bvF9C4HkzW
	 cnkftt/Y+IPpgUZK4TDTMyWKfvAZqqJi+eY1GOsGOgIoB2uX69bJvRQWnaX5otJYC1
	 4ZLf0yir7RAHQ==
Date: Fri, 6 Jun 2025 06:31:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xin Tian <tianx@yunsilicon.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 leon@kernel.org, andrew+netdev@lunn.ch, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, jeff.johnson@oss.qualcomm.com,
 przemyslaw.kitszel@intel.com, weihg@yunsilicon.com, wanry@yunsilicon.com,
 jacky@yunsilicon.com, parthiban.veerasooran@microchip.com,
 masahiroy@kernel.org, kalesh-anakkur.purayil@broadcom.com,
 geert+renesas@glider.be, geert@linux-m68k.org
Subject: Re: [PATCH net-next v12 00/14] xsc: ADD Yunsilicon XSC Ethernet
 Driver
Message-ID: <20250606063120.72c429ad@kernel.org>
In-Reply-To: <20250606131342.GG120308@horms.kernel.org>
References: <20250606100132.3272115-1-tianx@yunsilicon.com>
	<20250606131342.GG120308@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Jun 2025 14:13:42 +0100 Simon Horman wrote:
> Hi Xin Tian,
> 
> Thanks for the updates. Unfortunately the timing of this submission is
> not ideal.
> 
> ## Form letter - net-next-closed
> 
> The merge window for v6.16 has begun and therefore net-next is closed
> for new drivers, features, code refactoring and optimizations. We are
> currently accepting bug fixes only.
> 
> Please repost when net-next reopens after June 8th.
> 
> RFC patches sent for review only are obviously welcome at any time.

Yes.

Please read
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
before you send any more code out.
-- 
pv-bot: 24h

