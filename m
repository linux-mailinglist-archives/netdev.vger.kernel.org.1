Return-Path: <netdev+bounces-224490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D317DB857CD
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BA518993A0
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 15:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BD523AB81;
	Thu, 18 Sep 2025 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTYcExKb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C12231A21
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 15:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208097; cv=none; b=bfo56bDYFniDLRRhaLxJcz+OOmY+kjgaW0Kb77Dt8huLavztJjHqiCLqr/htym84y8aMQ+ryhwiqmoKZJACQvvh0T/auWz7IF1qhhtzIw7taK84/7PURp0NjjZWPq0iJZdKya8nim+ULM+dDLiqAzRzQjzW8Q0pOKHyOgYh0OVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208097; c=relaxed/simple;
	bh=y4r1E6ftEBebSjqdI6igg664AKLnPqmGRtERP5t5AIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqV9pK7mIxefG51MiYWkdxyCHcKwyUoLVTVC0RMWHacTXTMBnM3OMkXyzebFrwiNZDFpO6QxePYPXSo8pDyC6yUzZ97w0FhOxMRnUDvgmG59bFrXQwerixTcAJNvGsaSc2Ab4PilGAMXHwquwabg5bad41ZUZDZ6WaDoVwV7Z0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTYcExKb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A7FC4CEE7;
	Thu, 18 Sep 2025 15:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758208097;
	bh=y4r1E6ftEBebSjqdI6igg664AKLnPqmGRtERP5t5AIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iTYcExKbouzZ9464iyzH8crdU51WIskA38446lCfn7YtaaHWRFZV90PP8vBWfCzx6
	 YwBViTfjnVfze7t4eAl8pAFBkVnCj+RJ8DYaw6pfoytSV4Yf4mYaHV1+UbE59SBl8J
	 nM/Clzhit16Tds7Xu+TWx0uHtd3ZqAhjDhV/wRMC2dUOT/ISatRglzGYFknbAOHqC2
	 hcYk0fkU7LcuJiKQw3QDqNOTpqlO/Dy3kFy9o/ImO7q/QzCx+T84Ieie8vW61DQss5
	 H9yJ+2MVZE+iwcDhTSe/uare6GkDgvP4IAfZdKHNal+ECcXF86/rUxR2hK/erTHcQ4
	 3zAqCt7l+FqBA==
Date: Thu, 18 Sep 2025 16:08:13 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Miller <davem@davemloft.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dsa: dsa_loop: remove duplicated
 definition of NUM_FIXED_PHYS
Message-ID: <20250918150813.GY394836@horms.kernel.org>
References: <67a3b7df-c967-4431-86b6-a836dc46a4ef@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67a3b7df-c967-4431-86b6-a836dc46a4ef@gmail.com>

On Thu, Sep 18, 2025 at 07:54:00AM +0200, Heiner Kallweit wrote:
> Remove duplicated definition of NUM_FIXED_PHYS. This was a leftover from
> 41357bc7b94b ("net: dsa: dsa_loop: remove usage of mdio_board_info").
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


