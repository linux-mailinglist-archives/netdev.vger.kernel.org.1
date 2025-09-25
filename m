Return-Path: <netdev+bounces-226229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12066B9E4D4
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA441BC4D20
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D30E2E975A;
	Thu, 25 Sep 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOEVHNlj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120AB287267;
	Thu, 25 Sep 2025 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792320; cv=none; b=LfHpNjq6ZNTKg3oW/9O7xYSmMy8I7SHGf1R2TKvo2UBO8RYyVoGo4PU130hFHXblEi9abNsfi7dVZRWz2PV8gc+1sQYXVRXrYtL2ymZ/H5IMKaTfuwIrtCo2VYPcfh0qTC45h7kmLT5SHvy9QnDj75d7z8jwazLw1DAKVbYWNzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792320; c=relaxed/simple;
	bh=+FS/vDY3SFKVh48LZ/mCYxlR6p+3WqZ1ah6TvY7QPug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nG/4OXix0bORhwfO65OdEklOIqpi35/Nw4qswcaNAJyZP/N5VWDvOHKLvD61jyBTsJgvV9jGdCscfY5GHGH7zqOe0yBSCo3VkEQ4Sm12tnHYsYYB3Yn7ax8MIQoipNEANujojl1csyU6qZjsWd7qVhYzc6nK08wm+eACTacrLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOEVHNlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB60C4CEF4;
	Thu, 25 Sep 2025 09:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758792319;
	bh=+FS/vDY3SFKVh48LZ/mCYxlR6p+3WqZ1ah6TvY7QPug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tOEVHNlj4madfq9sJWC4AetSV63qPO/QEOYlKs0+edHhDXIv34nyLvzFB9gTHXXez
	 r02qHBGPWPHtczg1YaOP0UgJ30kh6VyW+/IcQx+GoVyYnUdHqaoq91X03UbE+2TDul
	 UTQlJH6WV3zbQDaPAT9jOZ5nfdDYeo1GkoUbiqJyDmmkcMTs/kWPdhv48EQXoGgiMT
	 Tkx/DhJqbeCPRPg3zp5GPeDI4KqMPObO4TVP6SwfnASWH6xtmdMSYBPF3Rz2ACLOKy
	 CItgXpeRbzwKDm/iq2usb3OKbMaPksN1edSkSrhdrAwxI5/71PGpzNEPGhksiDQTnt
	 L3p/h2BP6o+UA==
Date: Thu, 25 Sep 2025 10:25:15 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, Frank.Li@nxp.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: enetc: Fix probing error message typo for the
 ENETCv4 PF driver
Message-ID: <20250925092515.GB836419@horms.kernel.org>
References: <20250924082755.1984798-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924082755.1984798-1-wei.fang@nxp.com>

On Wed, Sep 24, 2025 at 04:27:55PM +0800, Wei Fang wrote:
> From: Claudiu Manoil <claudiu.manoil@nxp.com>
> 
> Blamed commit wrongly indicates VF error in case of PF probing error.
> 
> Fixes: 99100d0d9922 ("net: enetc: add preliminary support for i.MX95 ENETC PF")
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>

