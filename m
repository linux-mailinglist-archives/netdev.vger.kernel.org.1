Return-Path: <netdev+bounces-243094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54636C9972F
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 23:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C192B341492
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 22:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65B72882B2;
	Mon,  1 Dec 2025 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZF63XPxj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD6C2882A7;
	Mon,  1 Dec 2025 22:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764629684; cv=none; b=W+ShNJN0RtdR9yALvs4xTOBN1s4An5bhsOj3SNzEy+znAK+B8xDQdxY1aZfL3jkUVnGGURBA4xnx9ccDl6qIYGFxViL2mZvnTk6OBKih5nTUt88s0krQrOLHPduuGA0U6z+d+nM2FX7FealX1oiPtvBN8/X99h3XL7PhKeNnVn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764629684; c=relaxed/simple;
	bh=xa0FaMI8VopU6/yx/GXsozWefA7LOGEtdw8YVpBezMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLgxBoPEaqrKBedvAdhMNKZS+PUea8SW8Yd9wwb372FbDhuFqNMuoca1tXA8IBjyM1ST62JpgvhhccOKbXQRc9/Q8oylwjdPXWo4bjNNxhW/rhtrBeaiyjbyqg1oIERHxysvUSnndO4K/4fregcFwevQNTIk7TKhEd5PbYlRTr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZF63XPxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEADC4CEF1;
	Mon,  1 Dec 2025 22:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764629684;
	bh=xa0FaMI8VopU6/yx/GXsozWefA7LOGEtdw8YVpBezMw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZF63XPxjIoOMMVmSoAeZQ0CmR5VdYLmn4KkKtCWZ9n7SpW4KP9c614ULOzGUAwDm7
	 5cUtPnGtNa9d4W8rzwfQbUP4Rn7pBUlf9NVO7oGbKtOFPc3sIDkFbCg+bvwS3AxtUw
	 Tn3KopAPdGROhKwiT2KaGOFqvS+sZWmLqkNxtq1+Zm5FcGdZ+uFf9+AR6s/PR1jqTk
	 DcwiCNAaCZCJUP+J/OVFHFLAy4jz8qi0bLTmRL12oz1LYD5g6w8fHRuAYXiv3mMUut
	 d83VFjV+53M76c6UrjoS2NXlchEQCsxoC0Rvrjzy85MNW2rviiJFpsalTRzv9+y+LM
	 YbN+JC6YYO2OQ==
Date: Mon, 1 Dec 2025 14:54:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] r8169: add DASH support for RTL8127AP
Message-ID: <20251201145442.5f16b825@kernel.org>
In-Reply-To: <20251201224238.GA604467@ax162>
References: <20251126055950.2050-1-javen_xu@realsil.com.cn>
	<20251201224238.GA604467@ax162>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Dec 2025 15:42:38 -0700 Nathan Chancellor wrote:
> I am seeing several new error messages from r8169 after this change in
> -next as commit 17e9f841dd22 ("r8169: add DASH support for RTL8127AP").
> 
>   [    3.844125] r8169 0000:01:00.0 (unnamed net_device) (uninitialized): rtl_eriar_cond == 0 (loop: 100, delay: 100).
>   [    3.864844] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
>   [    3.878825] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
>   [    3.892632] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
>   [    5.002551] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
>   [    5.016286] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).
>   [    5.030027] r8169 0000:01:00.0 eth0: rtl_eriar_cond == 1 (loop: 100, delay: 100).

Thanks for the report and bisect! I'll revert the change and we can
revisit for the next release.

