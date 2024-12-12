Return-Path: <netdev+bounces-151293-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2939EDE80
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 05:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA289281430
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 04:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC5B16FF4E;
	Thu, 12 Dec 2024 04:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4XLPVkk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D8416DC28
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 04:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977829; cv=none; b=pJ5jEqYdXbfhDTTye9D3LJJup4UtMbJvEbIndEjYOfCV1hfE9pJWscGs1PbtC34tUkcSCh1QiP8NnSk4zAx2k7As6ZQiel3MGmCK/VDTqaKjPrONojo8fGRc6AyOMcoPSepitf4cmtToGGlPYy6UZbOEYHTG9mFewbS8+Q0Dgn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977829; c=relaxed/simple;
	bh=GavwOoVige0kkl6obAhhbC3B4+cp6dcnawpG9x3MaDY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qyMa2NQ9j2xNisiMwY9IkiGCWPIBUb0qhqHpkh6M00z04ZJH63viG8PO+n/+aug07C8MDkUtSTdOcPzJvK5gW+BEeIWXfG3f8SizOnnfpnai0y7JMAS/FcuPJawjSdDwcnwRi+Cr9y6gVWpAXrpe3v7y6A68L9Gd2QQhOh7iNH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4XLPVkk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9862EC4CED0;
	Thu, 12 Dec 2024 04:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733977827;
	bh=GavwOoVige0kkl6obAhhbC3B4+cp6dcnawpG9x3MaDY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f4XLPVkkLWaW8U9OwiX+AbOdM3/VBycyNQ5ejiopg22Zw6cXGasD7XUKdKUkrBiBs
	 3Y0DFhwvWFZQ4DDMtlC0VaxaGKJ62fAb4e3PZdpBtoud3gGbYGehKXRacFTcwHqcti
	 R3gZ9aQkuLz3opnHQVfRslBS8ak89vpWDvU9ygb1rZ1ENkYmHp412CU0JfnyDkObLd
	 tGYa5ASDa4Ba00A9y87ULlflCfL+/gqMpZhsCpry5PiHnBq5aBzM8KIOdm+NM1xRqX
	 jCV8WL/Im5KI9uF9ucOS8e3fkBMIAQo2MS9O2SCfn9zzh+ApyGV2+kdpWeBIZII9Ms
	 6ro1MGIlQvXdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB714380A959;
	Thu, 12 Dec 2024 04:30:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10 00/10] lib: packing: introduce and use
 (un)pack_fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173397784350.1847197.11269459764302654216.git-patchwork-notify@kernel.org>
Date: Thu, 12 Dec 2024 04:30:43 +0000
References: <20241210-packing-pack-fields-and-ice-implementation-v10-0-ee56a47479ac@intel.com>
In-Reply-To: <20241210-packing-pack-fields-and-ice-implementation-v10-0-ee56a47479ac@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: vladimir.oltean@nxp.com, akpm@linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, masahiroy@kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Dec 2024 12:27:09 -0800 you wrote:
> This series improves the packing library with a new API for packing or
> unpacking a large number of fields at once with minimal code footprint. The
> API is then used to replace bespoke packing logic in the ice driver,
> preparing it to handle unpacking in the future. Finally, the ice driver has
> a few other cleanups related to the packing logic.
> 
> The pack_fields and unpack_fields functions have the following improvements
> over the existing pack() and unpack() API:
> 
> [...]

Here is the summary with links:
  - [net-next,v10,01/10] lib: packing: create __pack() and __unpack() variants without error checking
    https://git.kernel.org/netdev/net-next/c/c4117091d029
  - [net-next,v10,02/10] lib: packing: demote truncation error in pack() to a warning in __pack()
    https://git.kernel.org/netdev/net-next/c/48c2752785ad
  - [net-next,v10,03/10] lib: packing: add pack_fields() and unpack_fields()
    (no matching commit)
  - [net-next,v10,04/10] lib: packing: document recently added APIs
    https://git.kernel.org/netdev/net-next/c/a9ad2a8dfb43
  - [net-next,v10,05/10] ice: remove int_q_state from ice_tlan_ctx
    (no matching commit)
  - [net-next,v10,06/10] ice: use structures to keep track of queue context size
    (no matching commit)
  - [net-next,v10,07/10] ice: use <linux/packing.h> for Tx and Rx queue context data
    (no matching commit)
  - [net-next,v10,08/10] ice: reduce size of queue context fields
    https://git.kernel.org/netdev/net-next/c/f72588a4267b
  - [net-next,v10,09/10] ice: move prefetch enable to ice_setup_rx_ctx
    https://git.kernel.org/netdev/net-next/c/ac001acc4d35
  - [net-next,v10,10/10] ice: cleanup Rx queue context programming functions
    https://git.kernel.org/netdev/net-next/c/39be64c34ca3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



