Return-Path: <netdev+bounces-40952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DE17C92D7
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 07:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 066B6B20AF9
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 05:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83FC186B;
	Sat, 14 Oct 2023 05:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICYTGHBr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880397E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 05:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838B0C433C7;
	Sat, 14 Oct 2023 05:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697260809;
	bh=Ytj2/J6JoBkWt+fErmzSJIMEUCzhsog0az/dPrYSoqI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ICYTGHBrHoTDiCb37W1wDlaDlK2hb/Usrv/wIXwmxTCIWFzfO9QvRdHfeAbkk45gm
	 OtFGC3aMI5oB9BrXLw5R675UrRIvEZleHHRci0z0YyJaAxxHmHI/eNdGcYSQMbxXvk
	 YLu9JKXVZl/AZ3mfmFT0q0FyYyBjudqMVgdOhDYF07XRNDENqcCOqdNfkvAJBUXs1x
	 aSOqcfKQK4oY4fcBsv9vsR4oUCAKoNw1LmLpFV8o5NXLHe+4VDpZPNJo5CWLgpDi8k
	 NDFu6b2/fgdUCusNpdKVD8TemfPcRWlfp+cNascn79BgHfWV5a9cACas3mSKLjrj6h
	 C5hreUQFnu+qg==
From: Kalle Valo <kvalo@kernel.org>
To: Abhishek Kumar <kuabhs@chromium.org>,
    Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: johannes.berg@intel.com,  linux-kernel@vger.kernel.org,
  netdev@vger.kernel.org,  ath10k@lists.infradead.org,
  linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] ath10k: mac: enable
 WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON on ath10k
References: <20230629035254.2.I23c5e51afcc6173299bb2806c8c38364ad15dd63@changeid>
	<169634426707.121370.9448850980134728319.kvalo@kernel.org>
Date: Sat, 14 Oct 2023 08:20:05 +0300
In-Reply-To: <169634426707.121370.9448850980134728319.kvalo@kernel.org> (Kalle
	Valo's message of "Tue, 3 Oct 2023 14:44:28 +0000 (UTC)")
Message-ID: <87il793hmi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Abhishek Kumar <kuabhs@chromium.org> wrote:
>
>> Enabling this flag, ensures that reg_call_notifier is called
>> on beacon hints from handle_reg_beacon in cfg80211. This call
>> propagates the channel property changes to ath10k driver, thus
>> changing the channel property from passive scan to active scan
>> based on beacon hints.
>> Once the channels are rightly changed from passive to active,the
>> connection to hidden SSID does not fail.
>> 
>> Signed-off-by: Abhishek Kumar <kuabhs@chromium.org>
>
> There's no Tested-on tag, on which hardware/firmware did you test this?
>
> This flag is now enabled on ALL ath10k supported hardware: SNOC, PCI, SDIO and
> maybe soon USB. I'm just wondering can we trust that this doesn't break
> anything.

Jeff, what are your thoughts on this? I'm worried how different ath10k
firmwares can be and if this breaks something.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

