Return-Path: <netdev+bounces-152818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 810809F5D71
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 04:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F5416F523
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 03:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C2E148838;
	Wed, 18 Dec 2024 03:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uq2/eRxU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E24A146D57;
	Wed, 18 Dec 2024 03:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734492337; cv=none; b=FMOJHVQDAe1C6GWyT1iAs494FT0MhWhfzbGCkF1rd3MSb48JjMbRfru2kdzDcZUc4h0HyGF3//SdbH9V4iGuYNYzeC9JSSWm6C0dlG1tOei4sx0e0DkbvdlhZ+akN8nsQze6ywe4x74dU9C66FHMCMzTtgxtjP9rdgWrZaGi6y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734492337; c=relaxed/simple;
	bh=R6sKzPUFux/WKOU4+e9FeEdQoKw6mkbNgr2gjXM2eyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SArzY59+DzyE2MsYKHBFQDYxvijqx8bdrk9E1zG8YKEWGwdsHd/44L+PjWwl1j3L+M4JB2e6/K/ynFWQysBKgakyWfpYBB1kJySgBx8rtvwvlbodvrRXrSj2ToVJoDRm4cYnXy1Ebt65AspuChe9LGcBidAGSMI7WRkRmdyK52A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uq2/eRxU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F35C4CECE;
	Wed, 18 Dec 2024 03:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734492337;
	bh=R6sKzPUFux/WKOU4+e9FeEdQoKw6mkbNgr2gjXM2eyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uq2/eRxU08XmelXeDt1NJQUcr4qIEd7ly7b/wWo0sf5+dHo9yuP1ypkP6ozOqbSns
	 0JuaTf9xeJbwF09wKAhz+IUDBEAvyb1WU2bo8yaPAB4lz0W9XUu9Nw4BO8XIUSWUEV
	 uZB1Va28Sf+skwlh0PitQcuk8Hj/nWwkV4PjvchoWf4TDdi+yyBcjO8uzaGuRHxVCR
	 0Jb5Qebbs9urwz8gUDiP8LdN37Tt7hoOrOVRKH/+Fv6iUuJjzQDkPagnhK6doig3LZ
	 RR/4ERLq7fA65Lt+iIGGKcb55dHu8tMtG6YeKOLXqzItKr/u6JJNznK823q+bUfNDp
	 FAUHqb9N+vIOg==
Date: Tue, 17 Dec 2024 19:25:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Divya Koppera <divya.koppera@microchip.com>
Cc: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
 <UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
 <linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next v7 2/5] net: phy: microchip_rds_ptp : Add rds
 ptp library for Microchip phys
Message-ID: <20241217192535.4892fb1a@kernel.org>
In-Reply-To: <20241213121403.29687-3-divya.koppera@microchip.com>
References: <20241213121403.29687-1-divya.koppera@microchip.com>
	<20241213121403.29687-3-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 17:44:00 +0530 Divya Koppera wrote:
> +	rc = phy_write_mmd(phydev, PTP_MMD(clock),
> +			   MCHP_RDS_PTP_TX_PARSE_CONFIG(BASE_PORT(clock)),
> +			   txcfg);

You should probably wrap phy_{read,write}_mmd() into small helpers
which do the BASE_PORT() thing, and PTP_MMD() thing.
Just pass the offset (like MCHP_RDS_PTP_TX_PARSE_CONFIG).

