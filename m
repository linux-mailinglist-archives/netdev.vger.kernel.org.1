Return-Path: <netdev+bounces-163922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C6CA2C088
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 11:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7C7168F3C
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557B61B4133;
	Fri,  7 Feb 2025 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwUMJ7zM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309B780BFF
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738923916; cv=none; b=tZ7/QXDXWTeWaUp+IEay89QkhoJqWeoMjlKkS8aM15qNEgKP28j4qvd+qor9kzBMohZsoIqUJsUGh7TaFZSo/q6mMLDBt7hUGgVfLxBkY6TDQWAwclFK9xTYhn5IWnxVyzNoFMlEUp7BbaDGiWlbPGIrWl1U6+EwvarnEcTkHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738923916; c=relaxed/simple;
	bh=I2q0FoV43+9sH+XTQuRkQL4F9g4e1iWfAdsRC+49Rpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WeLMQF147Njc85F8/OaDuZk6F9FV2/lazNiD7SfGabiClv6CSh/aV/267y7cLW9zEos/3sUasjkhf3KWZ4AeJIHToSop0JPew9QuDr2VLvUo0n+/FDBn2/fSPqraqqanWP7XiOuLql5imf1FTXED2Jw0zsn15NecQ8ppbY3hRQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwUMJ7zM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552F7C4CED1;
	Fri,  7 Feb 2025 10:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738923915;
	bh=I2q0FoV43+9sH+XTQuRkQL4F9g4e1iWfAdsRC+49Rpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cwUMJ7zMM+LqXh/1XBLgwPWA2922Qjx9EaIefT3IyK8iyef3+dC5dK5MSLYLV7Htc
	 uBkZdLYHjVHmLkvmyieVbnJr007LXnohmpBfd/4L6dl5ZRaGc/o5QFvwJAz2Y6NNfA
	 HbIkZZyMGSXQN4f5f1j+oqXr++zFaGkbfP6KMTDHeMluD2IKsWkjTNAVuJgtevx9kD
	 U+efDr2k5tvQsnWEhMl9WAGcY0nRiRj2Il3//rVXBCCeVMX5KL01YURu94IRkBbAl8
	 WRLeu/PBukt5MMoJwtRYrYuE0mEPDE/fl7Yv9ozJ3gW+bZ004slDKD7Wq+0LjQw+yr
	 9uGjv9Ji6ABYQ==
Date: Fri, 7 Feb 2025 10:25:12 +0000
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net] ixgbe: fix media cage present detection for E610
 device
Message-ID: <20250207102512.GN554665@kernel.org>
References: <20250206151920.20292-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250206151920.20292-1-piotr.kwapulinski@intel.com>

On Thu, Feb 06, 2025 at 04:19:20PM +0100, Piotr Kwapulinski wrote:
> The commit 23c0e5a16bcc ("ixgbe: Add link management support for E610
> device") introduced incorrect checking of media cage presence for E610
> device. Fix it.
> 
> Fixes: 23c0e5a16bcc ("ixgbe: Add link management support for E610 device")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/e7d73b32-f12a-49d1-8b60-1ef83359ec13@stanley.mountain/
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


