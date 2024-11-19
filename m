Return-Path: <netdev+bounces-146083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC8E9D1E9A
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B1EB20AAD
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F394013C9A4;
	Tue, 19 Nov 2024 03:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgfqhXwp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97E4C2C9;
	Tue, 19 Nov 2024 03:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731985580; cv=none; b=P7pVwqxOuGt5y020IBP9mTCcIKb3gzcUDyQB7SJ0qM5KP/GY0t+2dXxaelXweNEOgK/8y4wReQuI07D0f0C8+LGKQsig8tLF9Icp0jMojsYbgR25T3wOzNrhTxDoGZPPqJTGq78K/U5wQkwCKuIvA1JtFytS6s7rAuTgAAPhRYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731985580; c=relaxed/simple;
	bh=ZFh8d7e1KJXfSxhw1u6k7njlwVEal78ah60HtzMn0fs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUFPeNy+HKmFSK4uIVTBMmygcl81SSLkTx/EJobDzykJ4Op27uxHahPfGUDN1tioYOQ55DFfBmiDR1svsWKyyykwnPOUM1XZdy7s/TgVE6haNfqSvEU9mHyjKDNtv4adMhm0YKMFkdyPEQO/TTCcORELAgtAh9iSfGBsT14WhNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgfqhXwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBB3C4CECF;
	Tue, 19 Nov 2024 03:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731985577;
	bh=ZFh8d7e1KJXfSxhw1u6k7njlwVEal78ah60HtzMn0fs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SgfqhXwprt9DoJrZEk/vD0l84p1yH4uOa2IrWPQylZhZuPI7LSz8PcDZJVDuWIaRq
	 GJxR8d3ZKYCuZQYfKHPtVX46Fgz+YI4XUxiZHTMcxSq6uzds/BCy1rUM2EpZ1uISDF
	 wOVC603adkZghCq1J4QP31wkBiAiNTaj74ySu0tF9nlJGRcAG2HFkHLfPYqMz0//gp
	 Jh0ZAofrrTBBkiPFal+pykB0KB6WgZNp1ZnplMzB3m0ga29hiZ9XRYQcsmLfV7D5Aq
	 uE5eqOmGAma+Orv3uZAzoyvDDy2xWecmcTeZCMzulBclEj5gwbRw/MCICgCLP47VRU
	 u33WqamQ3xu8g==
Date: Mon, 18 Nov 2024 19:06:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Manas via B4 Relay <devnull+manas18244.iiitd.ac.in@kernel.org>
Cc: manas18244@iiitd.ac.in, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Trevor Gross <tmgross@umich.edu>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Anup Sharma <anupnewsmail@gmail.com>,
 netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH net-next v2] net: phy: qt2025: simplify Result<()> in
 probe return
Message-ID: <20241118190615.350072d5@kernel.org>
In-Reply-To: <20241118-simplify-result-qt2025-v2-1-af1bcff5d101@iiitd.ac.in>
References: <20241118-simplify-result-qt2025-v2-1-af1bcff5d101@iiitd.ac.in>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Nov 2024 20:00:36 +0530 Manas via B4 Relay wrote:
> Signed-off-by: Manas <manas18244@iiitd.ac.in>

The Signed-off-by tag has legal implications, please use your full
name.
-- 
pw-bot: cr

