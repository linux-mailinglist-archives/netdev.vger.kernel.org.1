Return-Path: <netdev+bounces-216056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD03B31C62
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 723E9606E75
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF923126D2;
	Fri, 22 Aug 2025 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/o4d2lQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB39B3126CC
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873520; cv=none; b=s7EIv2EE4y2ZW1wlrqVCaRDNZq000UudN12p6fWum/2E+gg7UU5DkOagsTiMtwcoaQ1C+FCFM6soo8ADONHKmFX6w/1kXMptPFUjNEwsQh2Z4Y4oERpYtEzHCt44nEKUcf/HB1O+i2oTYfoeyjFPtoslOM8WNg44Q4J83Tg3NZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873520; c=relaxed/simple;
	bh=0ohbEUcDQtMZ8LIN1dVF0ofMoZ/hGdLyI2kAkLh7ZKA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlQ0VQ3aEI58XlyQdw9I7TMg3RFkWa1++aIduWVOqbu1XKjOyiTUcfwxQF2C2eEMvysFY8ZC2LgMEIvrMHwCwcFzoStUPh6nRqs0XJnQNuGA/2tUC7znrxgylm4TyDWXsd6fCTAQEdnzIWRoaFEIZtSMrye8oFfWIRS3Syr47IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/o4d2lQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E83C113CF;
	Fri, 22 Aug 2025 14:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755873519;
	bh=0ohbEUcDQtMZ8LIN1dVF0ofMoZ/hGdLyI2kAkLh7ZKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V/o4d2lQpWluTRU64SKjomir38I8NJi6S9ntSkoEbKRY6tqm/4BPvkiVX5b8wSp3H
	 +CarlZrKKN46utWL+/QSTCo1IXlBGvkLMHYHOZErae2Z3VlxJoYXn8sQnjlvdoz0x9
	 6cJ17jsyLDY69OMlZJTFrw2aBaa75ACZI0OzNe3DGktGuzAddCX1Mc1mEnomi3XDN/
	 l+03Fiw9Az8B2Kuv73xg6F8CGQLujZBdr4EusRr2d6oyE+mAIm79qatpEcUceo7B9b
	 Z5dDy6ck95qOJc9iMv7sscc40h1F+T+AYsyhBxFarpl1Py5S8YLEZaLr95urPyCgpe
	 62NWVl87KI1lg==
Date: Fri, 22 Aug 2025 07:38:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: airoha: Add airoha_ppe_dev struct
 definition
Message-ID: <20250822073838.7da185f9@kernel.org>
In-Reply-To: <aKh9_g7mgvFxMdAz@lore-rh-laptop>
References: <20250819-airoha-en7581-wlan-rx-offload-v1-0-71a097e0e2a1@kernel.org>
	<20250819-airoha-en7581-wlan-rx-offload-v1-2-71a097e0e2a1@kernel.org>
	<20250821183453.4136c5d3@kernel.org>
	<aKgVEYMftYgdynxw@lore-rh-laptop>
	<20250822070440.71bdd804@kernel.org>
	<aKh9_g7mgvFxMdAz@lore-rh-laptop>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Aug 2025 16:26:06 +0200 Lorenzo Bianconi wrote:
> > > I moved the of_node_put() here (and in the if branch) in order to fix a similar
> > > issue fixed by Alok for airoha_npu.  
> > 
> > Ah, didn't notice it in the print..
> > maybe remove the empty line between the of_find_device.. and the null
> > check on pdev then?  
> 
> I am fine with it. I did it this way just to be consistent with NPU code:
> https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/airoha/airoha_npu.c#L403
> Do you want me to post v3?

Nah, it's fine.

