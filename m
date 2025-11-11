Return-Path: <netdev+bounces-237429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE50C4B3E8
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DBC18908C3
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E750348468;
	Tue, 11 Nov 2025 02:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL+OPki3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10E732E14A;
	Tue, 11 Nov 2025 02:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762829267; cv=none; b=LSbSXIOXuScwBPm7L8FpAYyNZtch2XvNumOGhep/4DVksfRyJD3mXhLQz+2qhm00s+SZSZfigimFmVzkZK3L1sAsRMMEy9Lew/yP/diG24gitiEI3faFBQE4TuSm0jW5m0afa1giRHK2zisdmZYXKp2o40WwWl2S9nIEvd8Pu+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762829267; c=relaxed/simple;
	bh=kb0U3gFuLG9ebZpEvZgiRVBGfMo6nVWwuyrudqfGv0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=orxJsAeVl5S8f0zdNom5AnMl57cYFsbFalucsu4G7M0lNMBZG/ifQmZ0ICQRfOGGmf/7BCQWHPwGC8dNDu9XppLPRzEvT0McmtWiC1lY8+bWT5GLfvv5KsqkA7K3XPj+bKDoo/pxFLyuaGFNwEm0y1mSBuupOZi4M82I8VNa79w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL+OPki3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D242C4CEF5;
	Tue, 11 Nov 2025 02:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762829265;
	bh=kb0U3gFuLG9ebZpEvZgiRVBGfMo6nVWwuyrudqfGv0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CL+OPki34UVIhGzekeTPxheEDkeQvSp5/4jpb4qMsYbN6Sf2r4x8bHT2WxS0EumhH
	 WsFcd4RDuYsmGBxoASEPDFmRj1cImURIfjvverSYcHdgUPcHztVkOZkQq9Q1W7Eocl
	 lcTjQq3OcTiJAgsNnB55q0AcstEv9n7H5SZWJWAKpU7L6GYnHbY4H3Frfia+frrHMK
	 9BDsdT6h2aAq04wcchRJFXQ5SO7UHKiyMOI1gOklA0xGQUKaJ1X92Yf7zYBxZJG0ct
	 hwSh7hNc8v8+Cm9osoiHB66+DTERKIIpPGFJsvS3nHo3wix88OCXK2wv6UeQk4wbLB
	 JnpPODhCFkrJA==
Date: Mon, 10 Nov 2025 18:47:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, <netdev@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan
 Chebbi <pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
 <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
 <shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
 <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Luo Yang
 <luoyang82@h-partners.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur
 Stavi <gur.stavi@huawei.com>
Subject: Re: [PATCH net-next v06 2/5] hinic3: Add PF management interfaces
Message-ID: <20251110184743.72f0fe8d@kernel.org>
In-Reply-To: <c344db0c471b6b1321994958727df1c005a65daa.1762581665.git.zhuyikai1@h-partners.com>
References: <cover.1762581665.git.zhuyikai1@h-partners.com>
	<c344db0c471b6b1321994958727df1c005a65daa.1762581665.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Nov 2025 14:41:37 +0800 Fan Gong wrote:
> +	struct semaphore                port_state_sem;

You seem to init this semaphore to 1, could you not use a mutex?
Mutexes are faster and have better debugging. If you have a reason
for a semaphore please document.

