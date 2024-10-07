Return-Path: <netdev+bounces-132745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72ACF992F74
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 16:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A44991C224E6
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6001D6195;
	Mon,  7 Oct 2024 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gol2X4v9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7147C1D47C0;
	Mon,  7 Oct 2024 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311521; cv=none; b=YGBcF/CR09vzdMFtnqf1QgGHpUsNz5aSEoe2ic2E8ryEYRbVRCuDTlIHPbOatGz4Y9cnxEwkLQypV3uaGTR4B/tS73MpgwbI7U3fgksczd76gUq5KLomHUgQg0vYOdaVcPEB2rU0U1AViwV/QQHwsLPRA+UWconJ1JDtjny6vMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311521; c=relaxed/simple;
	bh=hSajBHGM+flLRc5oBx191ZTF/vm+3lfcaE0iN1tllm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HM+aIXjDI3HUj9kJFK8601HjDRWrsczvTyoZXfAAqHHFIXEQn+EZgQoL76rY7VpZHdfLYsH2zXkXc6HO8TzL3MP+byvNGAGKJXqvnx/eHY1b4G2C6Q/7wKV+vZ7egsqi0a1jBGwv1DdYgUSrhk5t6wg6cZeaBrQLLl1jxJbXLHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gol2X4v9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEBBC4CEC6;
	Mon,  7 Oct 2024 14:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728311521;
	bh=hSajBHGM+flLRc5oBx191ZTF/vm+3lfcaE0iN1tllm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gol2X4v9Xa1D5MmE6DmIcxsFPh/BXt0Y7vmsLoGCIydjR1KS2wkYdu1c8wSMZOCh4
	 xqAp9lGl0ykTg9OYN7kahibECuxPhaGr3JcK8AcLI5Mz2An0PepmNa5QVeCNLRnW8k
	 VZUQcZHjv6GFVftpqOw2us1Cv2Bo4SFAB/WP3GyJf2iJoli71yPT0EsqTA+tqQude5
	 3SOIvsAOLagSGPhvwOc1+eMYc8UqIDjnQoZ8JWak5UmadfjqYEQ62IBje4vu8k5Q8/
	 TF/e8NiyI4Z9vRSkNMHcsC6x+dSSTHZWw4oBab8rMPvh6vFWVnsp/PFIAXjtLg2SZm
	 eQf9O5V5ZNZSA==
Date: Mon, 7 Oct 2024 07:31:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
 chunkeey@gmail.com
Subject: Re: [PATCH net-next 00/14] ibm: emac: cleanup modules
Message-ID: <20241007073159.5d1f2041@kernel.org>
In-Reply-To: <20241006022844.1041039-1-rosenp@gmail.com>
References: <20241006022844.1041039-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  5 Oct 2024 19:28:30 -0700 Rosen Penev wrote:
> The modules are fairly old and as such can benefit from devm management.
> 
> All except ZMII tested on a Cisco MX60W. No problems found.

Only send the second batch once the first one is merged.

