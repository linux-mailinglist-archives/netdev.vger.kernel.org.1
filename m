Return-Path: <netdev+bounces-115836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94E3947F81
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 18:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68286284A24
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 16:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD4915DBBA;
	Mon,  5 Aug 2024 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKTeE3s0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49515D5D9
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722876018; cv=none; b=fCEPJ/CsBlRBCXDk/NkSgYcRKiTeNoLZL0uWtSIvwbBF2aMVYDk9Wt4aeOHf2nz86IaH8cAihL3VS6QJHLc/ZNZPdccYEd4exSnNvJM/0keOVz6nh1fpfgsJ94GjIrRSes2lDblh5sbWqcLboW0VZoxT2n4j09dv63iBKC3l1Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722876018; c=relaxed/simple;
	bh=D2OJdYw4N78p79wCAbLLNCrwucCs5Nyx4B8zLV9tEjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrHR3wNZpheoMl5RkAUEZ23969/1Q3BGovYYFJ/BwmvE2FuO1LrxUu8PAGoUnF1pt72dhdu3n3/wk6YW8EFJK+gNr3hoXlol/zjUuoyBcOI97PclSIil2wrM+1sP8ekRwbHA2mDpxGdJ4Q1Y5EZzq2XBFGWqWl0u/RsaH9GG4CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKTeE3s0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A87AC32782;
	Mon,  5 Aug 2024 16:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722876018;
	bh=D2OJdYw4N78p79wCAbLLNCrwucCs5Nyx4B8zLV9tEjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKTeE3s0ihxnAuh4FBbF550U91QQb5hWg35p/QgYrZM1kZoF/GZKqJjOMjIXEQTvp
	 JKymI2Ey7c+MlLpeq0sHaO6G4kELQPgoKd717j1s0QrXroEXBwUSSEX9JRNN7LpRC3
	 jq8eseYQqBx7mmciU5vKTEItj6j0yg4BPidG5XmLa8shqCBheiZlkB1PozcKw+VnS/
	 CRkf86MLg64/ZSWBs2RxeTGL4BP4oj2R5br0JhJd/g+vn89jQS5Bx3dB4f9i9ttsvx
	 3bLrdXWNL+xKmd7CAIHhV4etloClrMmQO4oX1tOPK5+jRrGrFJ6NOnJ61FCHzWkaXJ
	 mQ/BnE/zlhCpg==
Date: Mon, 5 Aug 2024 17:40:15 +0100
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v5 00/10] add sriov support for wangxun NICs
Message-ID: <20240805164015.GH2636630@kernel.org>
References: <598334BC407FB6F6+20240804124841.71177-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <598334BC407FB6F6+20240804124841.71177-1-mengyuanlou@net-swift.com>

On Sun, Aug 04, 2024 at 08:48:31PM +0800, Mengyuan Lou wrote:
> Add sriov_configure for ngbe and txgbe drivers.
> Reallocate queue and irq resources when sriov is enabled.
> Add wx_msg_task in interrupts handler, which is used to process the
> configuration sent by vfs.
> Add ping_vf for wx_pf to tell vfs about pf link change.
> Make devlink allocation function generic to use it for PF and for VF.
> Add PF/VF devlink port creation. It will be used to set/get VFs.

I think it would be good to summarise the overall status of SR-IOV support
with this patch, and what follow-up work is planned. As Jakub mentioned [1]
this does not seem complete as is.

[1] https://lore.kernel.org/netdev/988BFB51-32C8-499C-837D-91CC1C0FFE42@net-swift.com/

I mean, I understand the NDOs were removed from the patchset (see more on
that below) but there needs to be a plan to support users of this device
in a meaningful way.

> 
> v5:
> - Add devlink allocation which will be used to add uAPI.
> - Remove unused EXPORT_SYMBOL.
> - Unify some functions return styles in patch 1 and patch 4.
> - Make the code line less than 80 columns.
> v4:
> https://lore.kernel.org/netdev/3601E5DE87D2BC4F+20240604155850.51983-1-mengyuanlou@net-swift.com/
> - Move wx_ping_vf to patch 6.
> - Modify return section format in Kernel docs.
> v3:
> https://lore.kernel.org/netdev/587FAB7876D85676+20240415110225.75132-1-mengyuanlou@net-swift.com/
> - Do not accept any new implementations of the old SR-IOV API.
> - So remove ndo_vf_xxx in these patches. Switch mode ops will be added
> - in vf driver which will be submitted later.

FYI, this policy was recently significantly relaxed [2]:

[2] https://lore.kernel.org/netdev/20240620002741.1029936-1-kuba@kernel.org/

> v2:
> https://lore.kernel.org/netdev/EF19E603F7CCA7B9+20240403092714.3027-1-mengyuanlou@net-swift.com/
> - Fix some used uninitialised.
> - Use poll + yield with delay instead of busy poll of 10 times in
>  mbx_lock obtain.
> - Split msg_task and flow into separate patches.
> v1:
> https://lore.kernel.org/netdev/DA3033FE3CCBBB84+20240307095755.7130-1-mengyuanlou@net-swift.com/

...

