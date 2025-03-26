Return-Path: <netdev+bounces-177705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E69A7158B
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 12:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4501178EFF
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B4E1D8E01;
	Wed, 26 Mar 2025 11:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kazc2gzS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6429C1D7E54;
	Wed, 26 Mar 2025 11:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742987520; cv=none; b=U2/jx6asl10t1bZasypDj/nJzpep8sm5lBv6RdXETrAj+6IMJ/XvLV59w+MRn+dNqRz4X2puRhks8wf1Geqb0S8OWPVGddpJzQzFKGmhUOqGZ4y4r+iJcJuENvNoEV4JuyRT0EdghHUJ9+ibbtPAIJCBRpPKPouydsCYP4xR4zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742987520; c=relaxed/simple;
	bh=6lQDo1/++4c07P+ppiti/8QbofnLGa9D66WvR/soQ2U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YW6Aq+Na5FRhc/YRBBdO8UOThZra9dAScHNOI5alc81mvfHWJpnolu88PZ8z/Mr6nMZ2hB3Y4kI87XtUFsZEIv+5mZCcMfc7xBLObfWMsy70lsNs9nRksD+xWf2OSbrdM1I7PPj4uLPsaP1ChjO/C3VEBf6WHsIiXy3/PpeEj1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kazc2gzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B457C4CEE2;
	Wed, 26 Mar 2025 11:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742987519;
	bh=6lQDo1/++4c07P+ppiti/8QbofnLGa9D66WvR/soQ2U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kazc2gzSVEB9R3GGAgma8lXuZrUCQ1K2PmcvD3yrOVBRv7MVOfdvl6gs+l4cZyAGm
	 vWlzcbizjvG+IRk0QOuXBq+GpZGdFGmofqh6BgOT618G275mXl4Gb1wxo74+ZwY06c
	 T0l9CQsaVe9dXlhwbqoP9Uggw0a8TUVnSt1pmyeF6yIsi2PPA3sE4P/QeUZ8YjrjEd
	 hJyam2AQL+hovJb6FrTYTO+UVyXRRv6km2T8Drtpk9L7RMZk6Ibm2/LJVcKiOipeuI
	 Np68xy5lje/Cy8WmHnSZr37pbrptKJsCH/nbyUPx7QBQxg6WNGiapuE3oDcPk2/RCp
	 922z+UvD6lXyA==
Date: Wed, 26 Mar 2025 04:11:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Naseef <naseefkm@gmail.com>
Cc: asmadeus@codewreck.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 dominique.martinet@atmark-techno.com, edumazet@google.com,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com
Subject: Re: [PATCH] net: usb: usbnet: restore usb%d name exception for
 local mac addresses
Message-ID: <20250326041158.630cfdf7@kernel.org>
In-Reply-To: <20250326072726.1138-1-naseefkm@gmail.com>
References: <20241203130457.904325-1-asmadeus@codewreck.org>
	<20250326072726.1138-1-naseefkm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Mar 2025 11:27:26 +0400 Ahmed Naseef wrote:
> Hello,  
> 
> I have tested this patch and can confirm that it works as expected with at least three models
> of Quectel LTE modems.  
> 
> 
> Tested-by: Ahmed Naseef <naseefkm@gmail.com> 
> 
> This issue affects many users of OpenWrt, where USB LTE modems are widely used. The device
> name change has caused significant inconvenience, and as a result, this patch has already been
> accepted in OpenWrt:
> 
> https://github.com/openwrt/openwrt/commit/ecd609f509f29ed1f75db5c7a623f359c64efb72  
> 
> Restoring the previous naming convention at the kernel level would greatly help in maintaining 
> consistency and avoiding unnecessary workarounds in userspace which is not straightforward in openwrt.  
> 
> I hope this feedback helps in reconsidering the patch for mainline inclusion.  

It needs to be reposted to be reconsidered, FWIW

