Return-Path: <netdev+bounces-136630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631379A27C2
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E451A2892A9
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC1C1DF27A;
	Thu, 17 Oct 2024 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F75v5BLN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435821DF278
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 16:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180805; cv=none; b=OR3e980kbPrO3MtFkcWanBYzx0FnQI2DGPRnVWlZPgwkwJTpJkQaBcTuVJmB8nU6DrU4BNBpq0pttf3xSoJx7WkwIxqIKov3WUl8HwGgbpKepRH2TmtHEplOWjYRW8ZoXd78aKd28WvJmkep/One3LGqtxJtwqMNwHOdz7P/TMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180805; c=relaxed/simple;
	bh=GuiT0Bn/55UaBT8unpdU0R5t9co4HaB5yPS+9Wd7HXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMUkJ2eIjb6QibNVKYWJNzeyJ6rqZX4BTu/ZHtWEMOsUxGz2/3iG19YIYAz0gJK5Ru5YXt/YEHX/ISZXRb7FLxJRiBKDhfMTipJbcwAOzK83uBO7374z/SU9i3i3mi012xjduamUtnEJfqwhTAG/WN0jH9rdPcFsCJA+cdvi0Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F75v5BLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF73C4CEC3;
	Thu, 17 Oct 2024 16:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729180804;
	bh=GuiT0Bn/55UaBT8unpdU0R5t9co4HaB5yPS+9Wd7HXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F75v5BLNN9KlOC4oy31I1K2Z9kK3c74NbycXRmjOsw2vKZkx/57q6gt/hq1JihMl+
	 nJNkKkFfgufXK5CtPhhjHaLkyWnziEzfsBCVl6dtd1v8Ya6Z7GV0IClUlaKut7NH0W
	 ITJUNoLKNLXiG8vdLhoFdzNldcQEu6aZk5RGiNBsqCCaFuIGmm1mXnp/gsrD/brt4P
	 AuXaryUulIXCSfdIdo8gNayUarS/0XBevBv+1SVQhS/D8crKrIamBf2GfeVhKUIfQj
	 oqaiaCesiZKJVXV/o8nCvEzbBaBMHnr0xSh/yDi6RriidrxS9J+KChvwTTOg2KPI3I
	 e/R+/q6BmUsWQ==
Date: Thu, 17 Oct 2024 17:00:00 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: remove rtl_dash_loop_wait_high/low
Message-ID: <20241017160000.GX1697@kernel.org>
References: <fb8c490c-2d92-48f5-8bbf-1fc1f2ee1649@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb8c490c-2d92-48f5-8bbf-1fc1f2ee1649@gmail.com>

On Wed, Oct 16, 2024 at 10:31:10PM +0200, Heiner Kallweit wrote:
> Remove rtl_dash_loop_wait_high/low to simplify the code.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

