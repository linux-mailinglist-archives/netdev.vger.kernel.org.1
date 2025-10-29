Return-Path: <netdev+bounces-233748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9866C17F1B
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E2C43B4FC0
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08BA2DF3F9;
	Wed, 29 Oct 2025 01:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gu0Ipmop"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22941A5B9E;
	Wed, 29 Oct 2025 01:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761702176; cv=none; b=mQ6gbUDhSGEGbyN+TjZ9xVABaMh0CaFMXdcxI4GdhGk3V7vhEe0Z/Iet5pFvpcTrEC/7OUHGPcsJQT3e7gl6WempRHO/keT74t1scOHNpnsk05I9FNvKVHwaDm8Rbv+3igX+90CPQT/7412yu7odJkraxwf9k1of489HwpPB7io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761702176; c=relaxed/simple;
	bh=jWr0CgYg7cpIZ8ye/JqrhZKd5ayP3bDy1ZwF3O16X/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qiZNhHiUUKXf9MVXmx9tow87hyUfbHp0ECDw/SJrYZZIOnZL+CfeCwTskpmHBU8T5wgb3DFTVZrKXUa/el9MMyFA+ySLpSwP2VvuwPeNEa2KzsHyTu0/kEatHPj2seiQGFWqK7z3/m/6jZ1D/7r527c6MWDY/TR9xbGtGuiyMiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gu0Ipmop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB38C4CEE7;
	Wed, 29 Oct 2025 01:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761702176;
	bh=jWr0CgYg7cpIZ8ye/JqrhZKd5ayP3bDy1ZwF3O16X/Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gu0IpmopdDJ0HKluYSPYjp764rrWndEMic4i3aRfW100trY3Tb1v1PQye/nx5K7Nj
	 NKhejn5KOMHDQwH/SVMRRIuSaefoa3XqqJZhetpLkNHFwlKV/nAd6KbpxmXCaKqfPX
	 GUel1QmkZMNfQ2VMKsdagbCJu7P1J5ZXwifrIYPL//uj4pl3KEQnUhAhpsItiekh1T
	 PUXptc+kNKhE+mk9hL6HNf1At8zQkRROuh8CAnaD5iyxcrNbXokOsb3Yn2PmyAIhMU
	 PLjOjiUzK+s+SWSfjF8G+6gXaa7YkdHtBYyXCxoeui9bRFUvhM0rSE9OGXQMVLTFkC
	 GSxOfsUmTLabA==
Date: Tue, 28 Oct 2025 18:42:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ankan Biswas <spyjetfayed@gmail.com>
Cc: ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 somnath.kotur@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, khalid@kernel.org,
 david.hunter.linux@gmail.com, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3] net: ethernet: emulex: benet: fix
 adapter->fw_on_flash truncation warning
Message-ID: <20251028184254.1d902b50@kernel.org>
In-Reply-To: <20251024181541.5532-1-spyjetfayed@gmail.com>
References: <20251024181541.5532-1-spyjetfayed@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Oct 2025 23:45:41 +0530 Ankan Biswas wrote:
> The benet driver copies both fw_ver (32 bytes) and fw_on_flash (32 bytes)
> into ethtool_drvinfo->fw_version (32 bytes), leading to a potential
> string truncation warning when built with W=1.
> 
> Store fw_on_flash in ethtool_drvinfo->erom_version instead, which some
> drivers use to report secondary firmware information.

You are changing user-visible behavior to silence a W=1 warning.
I can't stress enough how bad of an idea this is.
Please find a better fix.. or leave this code be.

