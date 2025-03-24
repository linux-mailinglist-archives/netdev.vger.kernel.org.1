Return-Path: <netdev+bounces-177169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7B6A6E23F
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 19:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EAEE3A9545
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 18:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA07264A69;
	Mon, 24 Mar 2025 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iP2VTDwz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD99263F59;
	Mon, 24 Mar 2025 18:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742840779; cv=none; b=lfhC2GQIqlsU2LjJ2lQKlSifQtpryJqlEycaK7q3Fw+Kq8XdsthOut5Xzd4kZQyS9vZVyz3QItTzodi1Sz2C515ztvWbd9nfHCqKNbEGDtiITTlDUddqrZf3Bk2r8MN0MUSiiziCBguXKizN7xc+bxkwe4sQzLiXcCna5MwFms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742840779; c=relaxed/simple;
	bh=iwATA+Qn6Ifas2JD09TOZptJ0vS/eM5Ffuc+wJCxIvI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdP2YhVaTI37ljHZ0RgQJDAkaV+WtLRQvpLPmZhXfhQHYnK6wLgIPLg1cra7h6n81EXJFXAs4IatnKUku6S1zz2O9vfNV9jpvnZszOPmCCQHtEGqsNOL8EFhKtFeEMBtHj276QyNQZjt0ZjnYZ8fVzPEK1gUnp4rogGNLy5Njsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iP2VTDwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7B0C4CEDD;
	Mon, 24 Mar 2025 18:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742840778;
	bh=iwATA+Qn6Ifas2JD09TOZptJ0vS/eM5Ffuc+wJCxIvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iP2VTDwzmXqLWhG+ptlDEO7KWTJGwF7OJfyLAuSBPfEOOT6C0yv4lK0Vi6U6Twly3
	 8SqeJr+ZgB2BA/QkkjJbw73N0gbB39OJSsn7woEn5P2TL1RsGMn/LOfxiu5NoeCGxe
	 HcvWrwgZnbxZcGF/qDc5WMJ6SntjQOiz7/5C6CC7qmmJ92KCuLkK81alYCxuKB7YC+
	 5k0PGOJhu/61RuWeeEw6SscV5SBrG+BWNvhU6mxiMJg7f6kqmyXhCYOZ3CzhUBq2Ap
	 /7Z9qG25Hq3K3r/5YotV0eBJHt8QBAczbVt+GES7ffspQKX5YKRXtyXvT8icG8oNCa
	 m2iY/T/E4Sr0Q==
Date: Mon, 24 Mar 2025 11:26:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: linux-usb@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Eric Dumazet
 <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>
Subject: Re: [PATCH v2 net-next] rndis_host: Flag RNDIS modems as WWAN
 devices
Message-ID: <20250324112611.0eb6fdc3@kernel.org>
In-Reply-To: <20250317150739.2986057-1-lkundrak@v3.sk>
References: <20250317150739.2986057-1-lkundrak@v3.sk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 16:07:37 +0100 Lubomir Rintel wrote:
> Set FLAG_WWAN instead of FLAG_ETHERNET for RNDIS interfaces on Mobile
> Broadband Modems, as opposed to regular Ethernet adapters.
> 
> Otherwise NetworkManager gets confused, misjudges the device type,
> and wouldn't know it should connect a modem to get the device to work.
> What would be the result depends on ModemManager version -- older
> ModemManager would end up disconnecting a device after an unsuccessful
> probe attempt (if it connected without needing to unlock a SIM), while
> a newer one might spawn a separate PPP connection over a tty interface
> instead, resulting in a general confusion and no end of chaos.
> 
> The only way to get this work reliably is to fix the device type
> and have good enough version ModemManager (or equivalent).
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Fixes: 475ddf05ce2d ("rndis_host: Flag RNDIS modems as WWAN devices")

This should point to the commit you're fixing. Judging purely by the
touched lines perhaps 63ba395cd7a5 ("rndis_host: support Novatel Verizon
USB730L") ?
-- 
pw-bot: cr

