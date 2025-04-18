Return-Path: <netdev+bounces-184064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384C1A93028
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5541C463E87
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D56D267B90;
	Fri, 18 Apr 2025 02:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eobEPyyI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431FA24B26;
	Fri, 18 Apr 2025 02:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744944896; cv=none; b=Lm6nKyNYe5eqG8eBSEpZC94SPp1Lq6fbU9F5EJC5LUiOl3M17hdJ7bOsUl2U1pHMlj4d9qH+gucKT8FT/c3JLibArOLbsLhGAINd6n2f2ZDv8+Oh8HAs8RTibIj3I8aLWlxvycQE23FvkIoZ7usUuCMPfNCngHFqek2ud5yr4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744944896; c=relaxed/simple;
	bh=g/kMSNs0W96pUlukfgjzq6ACoBQrnvaOuupqBqlXjjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMhfpzsSUE4+84ph2BY1K1jhXgWNPqgcjGoz6HBsLvk4s+z+AkycA2mkALo/rzE+BbC83ehMae5Plmc5PMz0TwJ7WACy3KUc23Dmj6M9kDn2qyL5vKGfIdDl+7RkTEgqSbY8/m2fozCD4YR/lvWTy9TSK8+ctrtwzQf0c51ufW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eobEPyyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAA7C4CEE4;
	Fri, 18 Apr 2025 02:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744944894;
	bh=g/kMSNs0W96pUlukfgjzq6ACoBQrnvaOuupqBqlXjjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eobEPyyIYMXCBFXy72Wv/ryZJ4NG6ny/+YA3kxRKW187Wwu7iEAcmPAqMzTPHGtcy
	 WuMWlS0eLlEn4Kv4BpGBgZPqWEiSTiQGcdHwaFN//T2jzR3qll+dIgNgmUSYPcQ2Cf
	 MUEhBVzi/0IdKX+jXFJykFpo/BCAZJVTArLFGSIsMtsWnXVCBy9RvcGHjYGPWEoinX
	 y/7AaQUPmF+tAUv0hh1Wez1qFITf88e43NCjtHJbsMBL0DD35dUS19jSkztRJgV/wU
	 dsgJF2jFyUiU5uwObrrJCUJ9F68/iP8AkcEo/ufAGWk+//YhcOPveOw/1OcrqgT3xg
	 vK8q2118C0EZg==
Date: Thu, 17 Apr 2025 19:54:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: =?UTF-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
 <a.vatoropin@crpt.ru>, Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Padmanabh Ratnakar
 <padmanabh.ratnakar@emulex.com>, Mammatha Edhala
 <mammatha.edhala@emulex.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
 <lvc-project@linuxtesting.org>
Subject: Re: [PATCH] be2net: Remove potential access to the zero address
Message-ID: <20250417195453.2f3260aa@kernel.org>
In-Reply-To: <Z/+VTcHpQMJ3ioCM@mev-dev.igk.intel.com>
References: <20250416105542.118371-1-a.vatoropin@crpt.ru>
	<Z/+VTcHpQMJ3ioCM@mev-dev.igk.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 13:32:29 +0200 Michal Swiatkowski wrote:
> > At the moment of calling the function be_cmd_get_mac_from_list() with the
> > following parameters:
> > be_cmd_get_mac_from_list(adapter, mac, &pmac_valid, NULL, 
> > 					adapter->if_handle, 0);  
> 
> Looks like pmac_valid needs to be false to reach *pmac_id assign.

Right, it is for this caller and there is a check which skip this logic
if pmac_id_valid is false, line 3738.

