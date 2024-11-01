Return-Path: <netdev+bounces-140876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6593D9B8883
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DD128228B
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D2C3CF73;
	Fri,  1 Nov 2024 01:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XO3mynuh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596731A28C;
	Fri,  1 Nov 2024 01:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730424749; cv=none; b=V6k300dB/z4nplnOWslred9DrCGb4m8CMUm+VGInaAcVDk8Z8rDaQ2cbfwaKYv6SDyDikvh4VuoBGISxXP4836Vcl0k5MmbbXA9fiTFRb6mXldFSE7Ffn7LVNyXehNtG5qnzUyPBgZvF3FwhQn6znTAHM1C3JAsiKQIsZ4DA5sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730424749; c=relaxed/simple;
	bh=9w/a/KZVkh9kSiOD5aHkwB10CgeF406ZgvetA8UoLNY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMpbB4NnheeBJCHTUgMT4xX0mgpeSqWpFKbEkYXPiHO/mLqlRzTJDnaR0Dpdz8QZhZFlhKiC1TXVxaOMY9YifGk6M+gfkx08XrC2jfEUD6h8/hKjyqZKTGLXRHzxtYh9HPpwUZrXE5eviy2Oh0Gr42Ds+e9DA698LC6mUZK6ZQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XO3mynuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579D8C4CEC3;
	Fri,  1 Nov 2024 01:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730424748;
	bh=9w/a/KZVkh9kSiOD5aHkwB10CgeF406ZgvetA8UoLNY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XO3mynuhfzQiKT2eJ92oTcmBKM2UEAB4VJ64T5/bBiABHf6uIGDt+4DfeMbwVmppj
	 0GjB21YZJRMVSuY3+HOAENcDa3LBjFAmpGX54tHhImgCsAvftTkbF0DW1I1Sc+b0Px
	 ZM2rUIl1I6lsFg7Gbyfi8I/XMElpXCsyep8f/F7fwXpnI0AKo4GOKROqLMJK6yHMq5
	 O4Sr6pa3x4JB8PemlvErJl7plVOU0mb1IcypQvrkEnMdJtb438iPH8bhF6mJy47f1I
	 ST85Ijmfk/PCd6KG1KnLxg0fqMGqTLg3bcDyeRALnmK9miBFPlZaZEAOq3acqEyOCR
	 DxX5Te6RZ+XcA==
Date: Thu, 31 Oct 2024 18:32:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: Sudarsana Kalluru <skalluru@marvell.com>, Manish Chopra
 <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH net-next v2] bnx2x: remove redundant NULL-pointer check
Message-ID: <20241031183227.457cd1e5@kernel.org>
In-Reply-To: <20241025174209.500712-1-kiryushin@ancud.ru>
References: <20241025174209.500712-1-kiryushin@ancud.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 20:42:03 +0300 Nikita Kiryushin wrote:
> bnx2x_get_vf_config() contains NULL-pointer checks for
> mac_obj and vlan_obj.
> 
> The fields checked are assigned to (after macro expansions):
> 
> mac_obj = &((vf)->vfqs[0].mac_obj);
> vlan_obj = &((vf)->vfqs[0].vlan_obj);
> 
> It is impossible to get NULL for those.
> 
> Remove superfluous NULL-pointer check and associated
> unreachable code to improve readability.

this is an old driver and the 4 saved LoC on the control path
don't seem to justify the review effort needed, anyway, sorry.
-- 
pw-bot: reject

