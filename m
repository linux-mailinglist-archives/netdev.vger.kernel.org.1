Return-Path: <netdev+bounces-109014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE3D92684B
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B09B286AC6
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0336B18509A;
	Wed,  3 Jul 2024 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWmK/3WQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125E181D0A;
	Wed,  3 Jul 2024 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720031599; cv=none; b=fzn324Dur7soXQOgn59/uPD2o897gsAqga2zIuumbbPBk9aqT+1CagDwC2L3ePiGNvtoTIDo7Fq4+m20GGqtRl4+6rXrDvLD5SdQSna5Og6pp8G6RPqAr/m7biLI7/OQWSPLHCXIS+W1ZeI3HOviBHEIy/IU8oDgUCJZZtSWe1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720031599; c=relaxed/simple;
	bh=2G8QuZo3WKRyZvD6uPftXexQrffRyT9fTM1TGPo7g3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoK1a1veyPaVZ90dyRTaO26JPXUIJN4UTOH2mcVDcsZRYvwaSYRrRBmM+i1PlmCxzj1LdYFh7rzXWYvnfpxMG2W7Sjr9ZvEhWWdIk1h12mud65p9xAhZ2qKg3xJdqlcGDj87Q5tjyRriZude9D2PFckjXNgnXGs3b5nmMhv4EOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWmK/3WQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE9AC2BD10;
	Wed,  3 Jul 2024 18:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720031599;
	bh=2G8QuZo3WKRyZvD6uPftXexQrffRyT9fTM1TGPo7g3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GWmK/3WQ2WK+XnCye91xmPHaGjdcne4RSc0ZuqElh2j6KKM/kfvLBnlrnlS933pBd
	 VtGHhRpJCA+NMbC+0BwzW1JszGx8PjfWYzhMjCN+UjKK7ekg/mRqNYAIcDpRux1DKX
	 jvBk8FeQaCJx1x8uIRDS+sYZ20WFU+YOk77pqXhYJq/mRkkdztVJupPjUlsgvjSCJF
	 KjIifVH5UTcFXN81SZj+W+XGFqfpxW/9oIPYuJGoZzdM9j0+VfdxSEhrSNjOhhPEmH
	 Ih+mYE50Lk9W5tO8kaigqRCk+QoLMSiZyzXLSBhV5ehq9zM+qhPdln1oF14nCztbyv
	 WXYae4TPOtdbg==
Date: Wed, 3 Jul 2024 11:33:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geethasowjanya Akula <gakula@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>, Sunil
 Kovvuri Goutham <sgoutham@marvell.com>, Subbaraya Sundeep Bhatta
 <sbhatta@marvell.com>, Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [EXTERNAL] Re: [net-next PATCH v7 06/10] octeontx2-pf: Get VF
 stats via representor
Message-ID: <20240703113318.63d39ac4@kernel.org>
In-Reply-To: <CH0PR18MB4339BC156F808A319D1C8461CDDD2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240628133517.8591-1-gakula@marvell.com>
	<20240628133517.8591-7-gakula@marvell.com>
	<20240701201333.317a7129@kernel.org>
	<CH0PR18MB43395FC444126B30525846DDCDDC2@CH0PR18MB4339.namprd18.prod.outlook.com>
	<20240702065647.4b3b59f3@kernel.org>
	<CH0PR18MB4339BC156F808A319D1C8461CDDD2@CH0PR18MB4339.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 09:08:13 +0000 Geethasowjanya Akula wrote:
>> Could you implement IFLA_OFFLOAD_XSTATS_CPU_HIT as well, to indicate
>> how much of the traffic wasn't offloaded?  
> 
> Will implement while adding TC hw offload support for the representor,
> which will be submitted as different patch series.

I don't see why we need to wait. Offload is the opposite of the stats
we're talking about here.

