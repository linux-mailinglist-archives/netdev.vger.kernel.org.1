Return-Path: <netdev+bounces-199456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7787AAE0601
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF57B174C3F
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E978A22A4EA;
	Thu, 19 Jun 2025 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZE3VroGC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF43123B632;
	Thu, 19 Jun 2025 12:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750336528; cv=none; b=WCfBcR58BEWDafSvQb9JqEYEOeBQZLpgz4o5dSbhHlIKzheCtsrQQMHsd/lx5aVFoT+TgW7Cqxp7Hj9Ae6M0IygBx6WtAU216Bvr/Mu9rOdqE6JgpWLtneO/S2UzfTpXDB/4+sAB+PmPmjVi1Oc49g7vdj5CGhUSKQg5BAsAal8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750336528; c=relaxed/simple;
	bh=Bn9+J3djp6e6zzB94LZaGwEGJMlBp1bLCzZlmgXL2z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgMpUhDSHzrIsQFYZvPVe08aZXLney/vE6NTfJS/wte7aYxQ6mSrOGOF3iSfN16/wcyC2ubValVaf+MV5cUSaYVZNaTkeOsIe32gZmZsPNUh+tYG6uMgoPoPHiL1OmdZef2qsJYhSDobMzsuOrjlzWlz45tBy6s2JroHZG1sTCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZE3VroGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE1BC4CEEA;
	Thu, 19 Jun 2025 12:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750336528;
	bh=Bn9+J3djp6e6zzB94LZaGwEGJMlBp1bLCzZlmgXL2z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZE3VroGCyWOwTQiIJccS1qlSCnEpdHiNFzXETZYq8qb7W4mOHM/OWmUJ2/XXUdPvU
	 qdbnH7DyXO7G630qbNyhpj+o+DxtTO/5UHNf6Hx9EJCllhoRA+r9vpP4nbXeygwKGH
	 7BtO2nQ/UVeUGZuudpZTJJ6xnkjgJxlrO5dtNmeQKncq3e2CfQ0gCwgSgqGnsomDny
	 NAYZAiEJFWsn40wavJZhe1DQgTowzvHbTH2Ymed1qX7WTB7vGmAAcll/FWmaN0Zhro
	 szcFc7vMeBYwIsBAFroub548LxZGsjnpjnke77de8D8ZWJfEqRXb17Kac4nRaen8Nf
	 S2GDNz5oY2CNw==
Date: Thu, 19 Jun 2025 13:35:23 +0100
From: Simon Horman <horms@kernel.org>
To: jiang.peng9@zte.com.cn
Cc: pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, jiri@resnulli.us, linux@treblig.org,
	oscmaes92@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xu.xin16@zte.com.cn,
	yang.yang29@zte.com.cn
Subject: Re: [PATCH net] net: vlan: fix format-truncation warnings in?
 register_vlan_device
Message-ID: <20250619123523.GK1699@horms.kernel.org>
References: <20250619144934348-KObAuS33g0yI9ulIjMjE@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619144934348-KObAuS33g0yI9ulIjMjE@zte.com.cn>

On Thu, Jun 19, 2025 at 02:49:34PM +0800, jiang.peng9@zte.com.cn wrote:
> From: Peng Jiang <jiang.peng9@zte.com.cn>
> 
> Building with W=1 triggers format-truncation warnings in the
> register_vlan_device function when compiled with GCC 12.3.0.
> These warnings occur due to the use of %i and %.4i format
> specifiers with a buffer size that might be insufficient
> for the formatted string, potentially causing truncation.
> 
> The original warning trace:
> net/8021q/vlan.c:247:17: note: 'snprintf' output between 3 and 22 bytes into a destination of size 16
> 247 | snprintf(name, IFNAMSIZ, "%s.%i", real_dev->name, vlan_id);
> 
> Signed-off-by: Peng Jiang <jiang.peng9@zte.com.cn>

Hi Peng Jiang,

name is passed to alloc_netdev(). Which is a wrapper around alloc_netdev_mqs()
which includes the following check:

	BUG_ON(strlen(name) >= sizeof(dev->name)); 

And the size of dev->name is IFNAMSIZ.

So while I am very pleased to see efforts to address format-truncation
warning - indeed I have made efforts elsewhere to this end myself - I don't
think we can solve this problem the way you propose.


Also, I suspect any work in this area will not be a bug fix, and
thus more appropriate to target at net-next rather than net.

	Subject; [PATCH net-next]

And please make sure patches for net or next-next apply against
their target tree: this patch applies to cleanly to neither.

For more information on process for networking patches please see
https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: changes-requested


...


