Return-Path: <netdev+bounces-37722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE3D7B6BF1
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 2AFFC1C2081F
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3CC328BF;
	Tue,  3 Oct 2023 14:44:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3A831A96
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 14:44:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5D0C433C7;
	Tue,  3 Oct 2023 14:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696344270;
	bh=/B3cve6YrGk+HiByt3eCtzticC+G5KGeINugbxRXa+0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=G9ra3rfOvF81SNltY0+7rB9LU2lNRMkOpcFYKiesBTdxVqnBcstMgJaMm8OKYuyzE
	 fhCd/gNuADS31jGfMzsRQVgDa0XjzkUH7PIWqzOyhLAHc9hVFGtSXWiqNUdhcoTcuY
	 0834LPN9Fy1QfcgTUQc1RVcqXa41TU6G3F3BOAQYb50kZJycXoIB1dPNp9W+L0Sr4v
	 uycxxBmg2sRItx23zyRM9uMGWcB3n04SMsL73yA4vAmjQvP4/yssGu7azBtiTN+h01
	 YXHydglDNUwkE918pxqTIKWiXem2aqyDrAeLLcdc0W3Q/q8UjNExAmxCrM68ii2c4c
	 HPA4nrMmYdxQw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] ath10k: mac: enable
 WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON
 on ath10k
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20230629035254.2.I23c5e51afcc6173299bb2806c8c38364ad15dd63@changeid>
References: 
 <20230629035254.2.I23c5e51afcc6173299bb2806c8c38364ad15dd63@changeid>
To: Abhishek Kumar <kuabhs@chromium.org>
Cc: johannes.berg@intel.com, linux-kernel@vger.kernel.org,
 kuabhs@chromium.org, netdev@vger.kernel.org, ath10k@lists.infradead.org,
 linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169634426707.121370.9448850980134728319.kvalo@kernel.org>
Date: Tue,  3 Oct 2023 14:44:28 +0000 (UTC)

Abhishek Kumar <kuabhs@chromium.org> wrote:

> Enabling this flag, ensures that reg_call_notifier is called
> on beacon hints from handle_reg_beacon in cfg80211. This call
> propagates the channel property changes to ath10k driver, thus
> changing the channel property from passive scan to active scan
> based on beacon hints.
> Once the channels are rightly changed from passive to active,the
> connection to hidden SSID does not fail.
> 
> Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>

There's no Tested-on tag, on which hardware/firmware did you test this?

This flag is now enabled on ALL ath10k supported hardware: SNOC, PCI, SDIO and
maybe soon USB. I'm just wondering can we trust that this doesn't break
anything.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230629035254.2.I23c5e51afcc6173299bb2806c8c38364ad15dd63@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


