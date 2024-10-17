Return-Path: <netdev+bounces-136643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDA19A28C9
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E725E1F2387A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AF71DF267;
	Thu, 17 Oct 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bySwgfS0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005ED1DF265;
	Thu, 17 Oct 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182531; cv=none; b=u1DBMJhPKmeKQSkTTF6QkdCXFj05r4ho8UT/36I2cSBFx93Y4n/BXMqKR6na0uT07BQJv/PWCZ5LudKnebT6NWLYwqnorSbnWZoVCOHzHIrytUM/NuyuanGja2gB0+oCYC9DNHkroQmqzZdzcoRhxl17rqGh/em66i2w4hH2L4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182531; c=relaxed/simple;
	bh=VMjkYuouW6fQHKv9GjDurF71j5LqLcT+eVL3E77K7rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkNcbQj8uYsaCtEoY4KdpUHxDr3kc7rR1N+kPwIzE1wX4qAA4MBGDDSbcZYHVm6MI6bCU6Xq1+jkHTkLmChr5nR8XVIPnHxshcuHKRbHQS5j89UP9220qkGuuZ/1bo1Yryc9PWHvufDNanUfdHSsxG2oKeSsOB62gtPMYg7jcHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bySwgfS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBE0C4CEC3;
	Thu, 17 Oct 2024 16:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729182530;
	bh=VMjkYuouW6fQHKv9GjDurF71j5LqLcT+eVL3E77K7rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bySwgfS0aTL3OpUO2eB07JVO4hUDflMBjVi6NDcgNigXG+cHuv1Jj82+K7xWo/yjl
	 NVVe78leYAMzjnps2cKvDqGFtZWj06IVQM+zY49Pv7xSA4sB04pZyKqGOdVZuW7yzt
	 aQacKkIi6699eXj9zwea7CP2pPIEYwYbkwY7ND7nM9irUzJTrYGXgwfK4kSfmkiGa8
	 /liWoLuV5i9fw4EQewmZpg+X+UtAvt7LJmlqotqu0/Vf1D7fRJ/jgBrKeyC2jEzaxV
	 YUUGbI35ubgBlQOT5zU7TpMOFX1iQJDB+0yjDob0LARxL0Z/E3EzpFSE1T8EAAIQID
	 n7W2/G52b2A1A==
Date: Thu, 17 Oct 2024 17:28:46 +0100
From: Simon Horman <horms@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: michael.chan@broadcom.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eth: bnxt: Fix typo "accelaration"
Message-ID: <20241017162846.GA51712@kernel.org>
References: <68544638693B0D11+20241017092747.366918-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68544638693B0D11+20241017092747.366918-1-wangyuli@uniontech.com>

On Thu, Oct 17, 2024 at 05:27:47PM +0800, WangYuli wrote:
> There is a spelling mistake of 'accelaration' in comments which
> should be 'acceleration'.
> 
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi WangYuli.

Sorry if this is a duplicate, I typed this before but it seems to have got lost.

While you are fixing spelling errors in this file please also address
the following, which are flagged by codespell.

 exprienced ==> experienced
 rewritting ==> rewriting

Addressing other problems flagged by codspell in this directory
would also be nice IMHO.

-- 
pw-bot: changes-requested

