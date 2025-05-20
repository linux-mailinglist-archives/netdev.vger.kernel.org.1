Return-Path: <netdev+bounces-191758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9110AABD1B1
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1735A3A656E
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 08:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937B6262FDC;
	Tue, 20 May 2025 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArM55lAJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C13125DD0F;
	Tue, 20 May 2025 08:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729104; cv=none; b=nhDdZg8lfKrJf1m1sMx8rbzbp9nFfqobtAylKt2DW2jHCHy1VEbkN1QJwJJw9L7StBSsaNt12sao/GpqP+uLXanIyMhHnyaRYjj74Dig4cxtgNu9Ay2j7/5HE8OY462iUq7VHxCAVV6tAxM+xILEcWLbXi2rZ7/kLn55JiBh5F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729104; c=relaxed/simple;
	bh=P+mil3BSAgflT+81N7kdHl0B7fEVM15Pgtvbj74DtNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tohyWP9Yg6ySYLyAsAsAYbLUGcgOUrqe4GG70aKvEPVeO72VifYzaCIK8fnGKtcTCJ0+ArQqvS5lFwhYhhVh8SaL9vekrxzcugYeOe94syEpP59G1OpPAQ4v7gGNylA7z3gdTegkEYPvSKzGhHFpP260vaBVneb6Ol9gp/RO8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArM55lAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF1AC4CEE9;
	Tue, 20 May 2025 08:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747729103;
	bh=P+mil3BSAgflT+81N7kdHl0B7fEVM15Pgtvbj74DtNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArM55lAJgCZI3dn02U3g3Vyxhw/8xWgSOgDXoPPSrcOPvMPb5yBCw4RfSFgyYXukR
	 gqFHLkqEk8ptvk3LRZIw5Zn8nE6wGko7DPmtrPnrp1vskayF1yRO21wRed+ERyiHrE
	 RSZQrJXRhSd3arfdvn13Lg57Of1tyZSsqpgCp1/cLI6cT9lRrGBD/Xr2ctmCGGuuE6
	 Iwe0CvlcOvZ1jbhv2lqs5ChegCNr5rmUmUAR/2VuqGzAd9lIpYYzAuMV3zAsESzC5C
	 RT+tEXaoPN3LTvgYtT6VXBaYmiKPCAiJ0PwG3LxU/jSp79SN3cHjsfUN+62dRwuPeM
	 a0CnZtE96yw0g==
Date: Tue, 20 May 2025 09:18:19 +0100
From: Simon Horman <horms@kernel.org>
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>
Subject: Re: [PATCH iwl-next v3 7/7] igc: add preemptible queue support in
 mqprio
Message-ID: <20250520081819.GS365796@horms.kernel.org>
References: <20250519071911.2748406-1-faizal.abdul.rahim@intel.com>
 <20250519071911.2748406-8-faizal.abdul.rahim@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519071911.2748406-8-faizal.abdul.rahim@intel.com>

On Mon, May 19, 2025 at 03:19:11AM -0400, Abdul Rahim, Faizal wrote:
> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> 
> igc already supports enabling MAC Merge for FPE. This patch adds
> support for preemptible queues in mqprio.
> 
> Tested preemption with mqprio by:
> 1. Enable FPE:
>    ethtool --set-mm enp1s0 pmac-enabled on tx-enabled on verify-enabled on
> 2. Enable preemptible queue in mqprio:
>    mqprio num_tc 4 map 0 1 2 3 0 0 0 0 0 0 0 0 0 0 0 0 \
>    queues 1@0 1@1 1@2 1@3 \
>    fp P P P E
> 
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


