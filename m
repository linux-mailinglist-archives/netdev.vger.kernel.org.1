Return-Path: <netdev+bounces-235350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42111C2EF7A
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 03:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B654434882B
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 02:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F66123F41A;
	Tue,  4 Nov 2025 02:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWSGvgvY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BAB1DB13A;
	Tue,  4 Nov 2025 02:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762223351; cv=none; b=uUDgvI/bm8FufgrsIBCR1FWUsPb4vL5hsVajyaHC1wm41Xi8G6yupIgWREKn4Y3h3viESKArdfRE8DpT2K3FAKeDUA7ImGkq1ziKJGIriDCO1X1tpbP0EBSb1TfnEWRvOIUpx7L8hGaZJHDgQDA0c5UODM8PbywipbWxGojHm3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762223351; c=relaxed/simple;
	bh=pUkGEvWXAMj1yK0a7+jPG2xq2wfG+aPJ063IaYqXpMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8kruINxxGHa7aXkqcTRGt0vQyt7q2rXbMGWASBnwyTCr4YxCl/JuxbkubgKR3ntfYjRfQL69+qpy/aMVJZ0cS/5U4PBdQ3MW/6zM6/rkOJ2YdeLYXS3xvN9MpdO+LParyDhbc+BxcC3ct7PkcclPWIyVoU8aeIq8TsrMZmKrOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWSGvgvY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172D7C4CEE7;
	Tue,  4 Nov 2025 02:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762223351;
	bh=pUkGEvWXAMj1yK0a7+jPG2xq2wfG+aPJ063IaYqXpMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GWSGvgvY32cJJtHK9PbAKOTMU+W7iuhRP0lQY4BlXbiqDf4nkk4jiqOSw5UUrGULe
	 qSHWnSZsU11bkr5VAO1e7BnFu8Vf5x8q9u4RgiJj2oHAC3XprvmF2wpwQveJFw4F3K
	 7hh5v9Hll3PwPlepoT4akoJ7EBlTKxdn6Kw/2IwVYqLuKezo30oSRA/eE2v5I8XNkH
	 6dHlE9ENueGBZgJtSXa0XsaGL3EB1cpcrI04ycf49DwRcqMmNeGOxRXizNNU2KE/NX
	 0JRZA4Lzho3PcmSmWe0696MXf7NGDKXJ5HfxfBdCsRB8zlXLr2DQh1zd4GNJ7R8AL1
	 mZqhwaljePpbA==
Date: Mon, 3 Nov 2025 18:29:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, <Markus.Elfring@web.de>,
 <pavan.chebbi@broadcom.com>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
 <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>, Meny Yossefi
 <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>
Subject: Re: [PATCH net-next v04 0/5] net: hinic3: PF initialization
Message-ID: <20251103182909.1706a5a4@kernel.org>
In-Reply-To: <cover.1761711549.git.zhuyikai1@h-partners.com>
References: <cover.1761711549.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Oct 2025 14:16:24 +0800 Fan Gong wrote:
> This is [1/3] part of hinic3 Ethernet driver second submission.
> With this patch hinic3 becomes a complete Ethernet driver with
> pf and vf.
> 
> The driver parts contained in this patch:
> Add support for PF framework based on the VF code.
> Add PF management interfaces to communicate with HW.
> Add ops to configure NIC features.
> Support mac filter to unicast and multicast.
> Add netdev notifier.

Please try to wrap the code at 80 characters.
checkpatch --max-line-length=80
almost all the violations in this series can be easily fixed.

For function definitions you can put the return type on separate line:

static struct hinic3_mac_filter *
hinic3_mac_filter_entry_clone(const struct hinic3_mac_filter *src)
-- 
pw-bot: cr

