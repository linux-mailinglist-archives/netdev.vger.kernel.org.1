Return-Path: <netdev+bounces-230426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF342BE7CD9
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 11:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 813205014AF
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A803128AC;
	Fri, 17 Oct 2025 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlfdAgIB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C43128C6;
	Fri, 17 Oct 2025 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692848; cv=none; b=SENNUIbsLFDujkTzw035K5wrRLVtp0yI1waY3UUWL02vitztGbCh42EGyUY2aQ6QCL0/24jXYrVWRykeUANlVnDExRBcPcRbiiweMdf0D58RzrcJGV2IC2186kd6iIhfF7gxZ5B1Yldwk14UR1A0ouRq02TSZJbVAkyx5kRnrXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692848; c=relaxed/simple;
	bh=cUXKQ9hwxrDbmBsLxaD1j1NDO0r2m0zfIuHlpw2KaKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbSaMP1ifUBN4whDUHgtJxPVdz0yasl3sMxkQco5Nf4lqgQeoeusesWE464UWVmXLipExoAuZRw5m0R7CKA5hjxo1fFeC3brHIZWCfVQ7iLciJypGPhITHZyTIP99nXKnIXEjdrDTwD25enbtaVwImQ1cWCFick5G8BoZOd9qp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlfdAgIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14069C4CEE7;
	Fri, 17 Oct 2025 09:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760692848;
	bh=cUXKQ9hwxrDbmBsLxaD1j1NDO0r2m0zfIuHlpw2KaKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TlfdAgIBbhHI20wzQeg3KLqSb6yF/3p+41nDjU4EIfCD0J+7otz/0Q5U7P5o3JatE
	 acv+RMM0F2C8i5QGwDXLF8Bh9kShwKaVqYpr3QEN1fJPUdcmbu+QdWm2n1Pl8eMlDW
	 GSY0IK9flFEWrwdwSSEtmzthnoAi8M0V4tbBOPbI8RgSdtJYZN3eQejqpUPcBpDP2Z
	 HbozVOoBX+aeYAwV9nhwrt25ZQVeQRQGcTXfgm5fm/kWD2bNv5sXKYzbcs1FXp7ZzW
	 Z6hLZ+UyKuVrSqoKDVy8aRCX5eU5HSn9QzwTmux+SJYuLxpTihOL0wUPKktcAV9BcB
	 zE91GDT++inrg==
Date: Fri, 17 Oct 2025 10:20:42 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, michael@fossekall.de, daniel@makrotopia.org,
	rmk+kernel@armlinux.org.uk, kabel@kernel.org, ericwouds@gmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: realtek: fix rtl8221b-vm-cg name
Message-ID: <aPIKajg5XbfrGgNP@horms.kernel.org>
References: <20251016192325.2306757-1-olek2@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016192325.2306757-1-olek2@wp.pl>

On Thu, Oct 16, 2025 at 09:22:52PM +0200, Aleksander Jan Bajkowski wrote:
> When splitting the RTL8221B-VM-CG into C22 and C45 variants, the name was
> accidentally changed to RTL8221B-VN-CG. This patch brings back the previous
> part number.
> 
> Fixes: ad5ce743a6b0 ("net: phy: realtek: Add driver instances for rtl8221b via Clause 45")
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Reviewed-by: Simon Horman <horms@kernel.org>


