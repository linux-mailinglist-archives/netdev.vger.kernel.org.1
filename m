Return-Path: <netdev+bounces-177131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7475A6E025
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE273AE880
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8C12620C3;
	Mon, 24 Mar 2025 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6w1RSJ0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0225D1E1;
	Mon, 24 Mar 2025 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834944; cv=none; b=NdecUSTp8QQnkZbxvX0wagIBLclK+U31cP9Qx/xofhm+2E+iH/aDwssmdNJKaN4PnvkWyZlYn9jv6/yDxfcz/qHnx/oHV5AXA2q4rh7V1Z8gfTlkgQHZE/apn7BrzWrJSJ5fLF/wKz8UTik/n7lZ/eEYnzeps8+6zlHfizEA54g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834944; c=relaxed/simple;
	bh=cU38QVxcBQ/AJwJD1vO4zW2xFxWmZt4D1zEAX/SsNZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHkD1dTQPpmJIa6LKa96x3IMOyoiyZqj9WST4ZmwaZBD6t1hwkgr4UyMd8fH/gtv0p+tCKjndivXVP82Ozit6Ee0l4WT+bXbQberPisTcR0kkpz97x3e70fWclBrwgJ9cfQtzu+a4IZW/y1BVwoWMKgVsf4q8yOHLCiXOaBnpxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6w1RSJ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4170BC4CEEA;
	Mon, 24 Mar 2025 16:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742834943;
	bh=cU38QVxcBQ/AJwJD1vO4zW2xFxWmZt4D1zEAX/SsNZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n6w1RSJ0b/Z4gqEfv2SS6EKKPq6mRtP5BQu8aDDSFKnK+tZfT8O8SDgSyOudOOP8Z
	 Q3wQgNVvIkFaDyI8cg+XzDy9N3+q40xgEa1wHElExFIwqapvmg/qAXj0XdRtPijxNz
	 YILDBBd61q817T6ype0o6h8gzh2S4Zsiiu63D8mT7fT2/lf7ByWkkTEEFs2O+k9NaO
	 +zsRAalkKzoIdH3d2rVQgEVoq8E8D1aCCnswGDpupDvs1js2BoxsVcvi/KCbMlU7eI
	 FNcdmEo3qAX7b82V31EuJTQVKWUuUAvBHkDoIte/f48qTmETmveIH37dhFKxLtJjkP
	 AwpgPmYWhm7mg==
Date: Mon, 24 Mar 2025 09:48:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, florian.fainelli@broadcom.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org,
 giulio.benetti+tekvox@benettiengineering.com,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [v2,net] net: phy: broadcom: Correct BCM5221 PHY model
 detection failure
Message-ID: <20250324094855.1ac39b2f@kernel.org>
In-Reply-To: <20250317063452.3072784-1-JJLIU0@nuvoton.com>
References: <20250317063452.3072784-1-JJLIU0@nuvoton.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Mar 2025 14:34:52 +0800 Jim Liu wrote:
> Use "BRCM_PHY_MODEL" can be applied to the entire 5221 family of PHYs.
> 
> Fixes: 3abbd0699b67 ("net: phy: broadcom: add support for BCM5221 phy")
> Signed-off-by: Jim Liu <jim.t90615@gmail.com>

Please post a series of patches, you can keep this fix as the first
patch and then the subsequent patches should address the issues pointed
out by Russell.
-- 
pw-bot: cr

