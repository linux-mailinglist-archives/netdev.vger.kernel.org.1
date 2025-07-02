Return-Path: <netdev+bounces-203514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F612AF63D6
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72A361C43E3D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 21:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCC3232368;
	Wed,  2 Jul 2025 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYZSx/l5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012722DE700;
	Wed,  2 Jul 2025 21:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751491198; cv=none; b=vGhtIDhVu3MdJP8GeUMAlt0KyNfRcRglpNhfcvVbILtB40mccsd+8RLav/K2S9687Um+XeIxAAU3I9TVkNRWAH0FSMHFgGPLRExvVazu0g0Bh881NzTwjl0ZNQfkoawJPtsmx/awHq90hQ5HGPuHrO9hz2dakViwGFDh5HHi9fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751491198; c=relaxed/simple;
	bh=BIpRaOcU0sXftdnL3c/j+CqOlYrtkvdB7rfmx8h0pm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sccac8VWbTgZKYP5wJUF+gmwRfI1gs44KA2YyTddRgy40ozz4tgeoRLa6osCbXm6+kD50p7CkL3hFmAksR2wG0CtAKiubQUEMojhzS4ogFEbH5LRRfXvKgdQe+MRKM9L4RCmuh6SxckFss801+ReokURiqOnUWrDMZCQ2S83pg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYZSx/l5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BC9C4CEE7;
	Wed,  2 Jul 2025 21:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751491197;
	bh=BIpRaOcU0sXftdnL3c/j+CqOlYrtkvdB7rfmx8h0pm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sYZSx/l5GAljQyxRKhba6MYUIrBa9Lo3ocNzEe+kLaUzbPL1HCfYWOsz3V1RKOEnd
	 nWtzBBRAcb8aNLT2/bmSWyala/BNnfKdgTv2iWfC72lPaDIMqFrmctGrtuZc8bCAYW
	 E3lKBUaY3LQQ+LSA67v4yZagHPv9RgdZmynjKoLNQDzRJjVdZBLmHZyV+pmDhH2lu/
	 POBZPuRJrCatYiJitLl4MQdpU2Pb4th1fJbfHB3RgV5IFTpgorvd9V7WWJJZBr5zSp
	 ovlvj52ZM2KNuywbC4tlvDVDnjH6cC3LKGnrGLPX3iTLsW4r0pv3aTmD1R1DsEQXsW
	 J/Vg6O+Aa3s/g==
Date: Wed, 2 Jul 2025 14:19:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Faisal Bukhari <faisalbukhari523@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix typo in af_netlink.c
Message-ID: <20250702141956.52a36266@kernel.org>
In-Reply-To: <20250628105542.269192-1-faisalbukhari523@gmail.com>
References: <20250628105542.269192-1-faisalbukhari523@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 16:25:42 +0530 Faisal Bukhari wrote:
> Subject: [PATCH] Fix typo in af_netlink.c

Subject should be something like:

netlink: spelling: fix appened -> appended in a comment

please fix and repost
-- 
pw-bot: cr

