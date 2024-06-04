Return-Path: <netdev+bounces-100723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241B98FBB6C
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 20:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26C42840BD
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 18:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDFD14A09A;
	Tue,  4 Jun 2024 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQfXZ7qA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8064149009;
	Tue,  4 Jun 2024 18:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717525145; cv=none; b=k1tISUBGBLQQz6aroYSldscJ6QHRnwciEnUWVMy02hxHT/5RVzzjYeVc1O92fa7yo5ZkHX0hAJmAEbPI9SwlOwQPFpB3M8E33YN9DMerTyl+DfEcyXGw+D1HYR6/jhFIVDjOQq0CO/PhPdc0Nu6ObDLxgYtl9Xl+j3v44PtdauE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717525145; c=relaxed/simple;
	bh=Fj2iv3w04YP3vwjFljiCyn/pZZfn1H3lpJDW7soKt1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4xYQAnm7pIB7IFEaonaU4AY2NblEyYcXs9gOvWvptWaeVsjfYFYylSNfXkuHtecr7zebztQyG0Zu58dAsEer+as1NU+76Md7bmHVmpRzV2xWRxl+iKy82kBLWxmh3m3m3Q3YqRCxl1xBtYNCGGsmT0OT53Tqj1F4I7ZnRrXrG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQfXZ7qA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B135CC2BBFC;
	Tue,  4 Jun 2024 18:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717525144;
	bh=Fj2iv3w04YP3vwjFljiCyn/pZZfn1H3lpJDW7soKt1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQfXZ7qAEwiL2AlMpVQpMU2RxUuNigU3AM7Iakr6rTtcSCkuHId3Af1Q65rLy8ZJ6
	 NbnklDEEiB3KI9WffSVVGYXxfSFpPvKjUyUyTiYdYqqym/x+E9rT5q7h5pSo2wGkFf
	 A4OkPk3aB6K4dJqidvLZzrojdjVrp06jv4Aeo7WgnKew9ILOMwU+Iz9zUEhb6/UIFC
	 ddjs0+20sl6yGd/1ArYQjHkPC88GbhB/+QcKitPCICeiXBl9E+jDgZV/5n8wusZcY4
	 U6vaxfldHAp03E7Mdtgw0dmw2bbL7ozvjFHY+I6TJ/S9NImETdh25vmHaKCxTbVNgf
	 bYDAl/eCZELRg==
Date: Tue, 4 Jun 2024 19:18:59 +0100
From: Simon Horman <horms@kernel.org>
To: Anshumali Gaur <agaur@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [net-next PATCH v3] octeontx2-af: Add debugfs support to dump
 NIX TM topology
Message-ID: <20240604181859.GD791188@kernel.org>
References: <20240603112249.6403-1-agaur@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603112249.6403-1-agaur@marvell.com>

On Mon, Jun 03, 2024 at 04:52:48PM +0530, Anshumali Gaur wrote:
> This patch adds support to dump NIX transmit queue topology.
> There are multiple levels of scheduling/shaping supported by
> NIX and a packet traverses through multiple levels before sending
> the packet out. At each level, there are set of scheduling/shaping
> rules applied to a packet flow.
> 
> Each packet traverses through multiple levels
> SQ->SMQ->TL4->TL3->TL2->TL1 and these levels are mapped in a parent-child
> relationship.
> 
> This patch dumps the debug information related to all TM Levels in
> the following way.
> 
> Example:
> $ echo <nixlf> > /sys/kernel/debug/octeontx2/nix/tm_tree
> $ cat /sys/kernel/debug/octeontx2/nix/tm_tree
> 
> A more desriptive set of registers at each level can be dumped
> in the following way.
> 
> Example:
> $ echo <nixlf> > /sys/kernel/debug/octeontx2/nix/tm_topo
> $ cat /sys/kernel/debug/octeontx2/nix/tm_topo
> 
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>
> ---
> v3:
>     - Addressed review comments given by Wojciech Drewek
> 	1. Removed unnecessary goto statement
> 	2. Moved valid SQ check before AF mbox
> v2:
>     - Addressed review comments given by Simon Horman
> 	1. Resolved indentation issues

Hi Anshumali,

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>


