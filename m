Return-Path: <netdev+bounces-58858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AC2818601
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 12:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0689B1C23534
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 11:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F7A14F6C;
	Tue, 19 Dec 2023 11:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMDxoloA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D62B14F68
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 11:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0027CC433C7;
	Tue, 19 Dec 2023 11:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702983937;
	bh=Xan9OqFnkjXD7ZpmSsIbY/MakraHLHQyHXooQOvJ+VI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UMDxoloAmp6IbL4Ssnizmw1K75UjMC4/XVE5DWuwRrllGiZ6BqcWpmXgpfTCnbyQ5
	 w6IjTv3o57bfS0d67TZD3zYjz2rGMFpxjZdRFk1Kqp4r7M5Rejtlm8+RlhdKDlqs27
	 qlimxIPBHnRjRtXJCbkQeY0AUy88YAqdyjMUNlT2aa7scc5IFa/g8qywEwUWOvTF4q
	 E2zPQKmVDgDMiD6o8QspCWAn5pQ4m/1L1F4u1bycanABvUBbyM82mwKEVynZ97H8S/
	 kphfPhHpGIGeC98UDPYoLkzeRs0qLXXtSceMjmDZBlb0lzQ51t1kNhVk7CnIYfmp0G
	 M95CfCsnguQVQ==
Date: Tue, 19 Dec 2023 11:05:33 +0000
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v5 1/2] ixgbe: Refactor overtemp event handling
Message-ID: <20231219110533.GH811967@kernel.org>
References: <20231218103926.346294-1-jedrzej.jagielski@intel.com>
 <20231218103926.346294-2-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218103926.346294-2-jedrzej.jagielski@intel.com>

On Mon, Dec 18, 2023 at 11:39:25AM +0100, Jedrzej Jagielski wrote:
> Currently ixgbe driver is notified of overheating events
> via internal IXGBE_ERR_OVERTEMP error code.
> 
> Change the approach for handle_lasi() to use freshly introduced
> is_overtemp function parameter which set when such event occurs.
> Change check_overtemp() to bool and return true if overtemp
> event occurs.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: change aproach to use additional function parameter to notify when overheat
> v4: change check_overtemp to bool
> v5: adress Simon's comments

Hi Jedrzej,

Thanks for the updates, this version looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


