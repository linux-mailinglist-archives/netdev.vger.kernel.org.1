Return-Path: <netdev+bounces-176213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5478A695C0
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C779C7AEA83
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 17:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6D21E22FD;
	Wed, 19 Mar 2025 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yut+R08n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56481E0DD9;
	Wed, 19 Mar 2025 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403816; cv=none; b=F7GM9AsgFoS5i/zwstp2/9eaIP8dGGy5y5qJbOogd//ooKK0BfF8jRjbd3F5ep8sNvA4ewG0QhScjsRDAva9o8tAonz3LtKmw61+6s7/OiZHdTWfmufgT8ZykNVkkkHIRWSnayoUpSkFhZI7FHJi2h/hqNSnFOC0NhW1zxhEo9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403816; c=relaxed/simple;
	bh=nXBrgWd0Xygp0P242xJ+bYNDpxOf3koAAgL/VO1bdHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoFl6CrXN9WOSLJzzQwGZQJ8UQK43MLCgoxSnLeAhjb2D7efm2JHrzkwU14B19hXyGCO+R5UDUGSWb0AEmSCUP2pKooJ0i9/LPHoWq3B8+hrLw/zEpCpxNElYbmcnwLFWUph3r4wJke0KH8xjY6XbVue1ggmNPycGsfHCgxEHGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yut+R08n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24B4C4CEE4;
	Wed, 19 Mar 2025 17:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742403815;
	bh=nXBrgWd0Xygp0P242xJ+bYNDpxOf3koAAgL/VO1bdHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yut+R08nBb0f/BRmAghbaVM8caoDxNH85saD8HzBfB9m+OkUfy2QqDHLBigGaZNIE
	 rVA1037GX047bdNKWJkM8v/w6/4qEsL0cEqT0vljGV8W33CPhKpEcztAnj+zxyH26D
	 WORrvEcbI9ZocflHebYybl+2TsNvL/73hGjA7Tbxo8TxVJK9SCx20OuVbN1X0oVTV8
	 lDmMIWynFp61OBdBqQ04NbYm4qTJxiKhQCvrY3f79wbePfMdZnpb0/3wOs3mP4/Diy
	 N8ppFWgkDvTN2tW16rsgPEwhqWPOaNSlUtYtrPTjlHNYk8mE+EcVtAo9vo52YqnqP6
	 idL43PHU02uhg==
Date: Wed, 19 Mar 2025 17:03:31 +0000
From: Simon Horman <horms@kernel.org>
To: xie.ludan@zte.com.cn
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] net: atm: use sysfs_emit() instead of
 scnprintf().
Message-ID: <20250319170331.GG280585@kernel.org>
References: <20250315141249338P9_QqSBAnqEi-DZYDTtR5@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315141249338P9_QqSBAnqEi-DZYDTtR5@zte.com.cn>

On Sat, Mar 15, 2025 at 02:12:49PM +0800, xie.ludan@zte.com.cn wrote:
> From: XieLudan <xie.ludan@zte.com.cn>
> 
> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: XieLudan <xie.ludan@zte.com.cn>

FTR, this appears to be superseded by:

- [PATCH linux-next] net: atm: use sysfs_emit()/sysfs_emit_at() instead of scnprintf().
  https://lore.kernel.org/all/20250317152933756kWrF1Y_e-2EKtrR_GGegq@zte.com.cn/

-- 
pw-bot: superseded



