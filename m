Return-Path: <netdev+bounces-70075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B186684D83D
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 04:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1201F22563
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 03:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1131CFA8;
	Thu,  8 Feb 2024 03:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iXPXgbew"
X-Original-To: netdev@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC731D524
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 03:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707361965; cv=none; b=AdJDZtPrNMb/7PnMCUN/nGCmAHFQmW3X7N/cC64YdtKBaCzvs6MypQzsnl7R5k3oY7ivGgPUEZjkDVk6qpAXA3DLRTcl/GUPz0rgasZ7HFwv9Md8qZbE9v4jUtpUEWdoBYDwUSuZyEapwjPZMM3V7faEGOQFLlWshZoT7CPPKpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707361965; c=relaxed/simple;
	bh=z+yo0zt5voSp6a5q/mULSaHI+w/FG367rykyGd8aHuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+PyTQAUj1Ya6D81YVhA1bTL1N2FGoI5Chq1GtsFT54m17HkvsGRPwUJhGsZ8VrA1HISntv59BzvhXQbsA4reVEw2kkddyme3wsBRGnq33gC1ubb2ZVWSckQgwYUNXwYlzWWGwckuYAPrl3LEVlHyulbL54oZzPanl093SIHtzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iXPXgbew; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=iU1A+s+OmFRbU5C/InSCU5YgziqsTudEBOy5rIwpCXQ=;
	b=iXPXgbewrNXJ7UCdfRQM6cB/TKoRQsOCE2xPz759WXozzKZ+azWnzPJjlwL+pj
	LBmdM2u9/JIN+bo3mz0kS6whWjEAA7MgtWjKWeM7/F9iAk4wfedk2c8Yass2PYqv
	0wFbQlAShVbChYxBAj+GD2Zw6n2DHcF+C+7C6NsmCehHA=
Received: from localhost (unknown [210.12.126.226])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wC3D_iXRsRlR3i2AQ--.27861S3;
	Thu, 08 Feb 2024 11:12:24 +0800 (CST)
Date: Thu, 8 Feb 2024 11:12:23 +0800
From: Tao Liu <taoliu828@163.com>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: roid@nvidia.com, paulb@nvidia.com, vladbu@nvidia.com,
	dchumak@nvidia.com, saeedm@nvidia.com, taoliu828@163.com,
	netdev@vger.kernel.org
Subject: Re: Report mlx5_core crash
Message-ID: <ZcRGl758ek_at4Ha@liutao02-mac.local>
References: <3016cbe9-57e9-4ef4-a979-ac0db1b3ef31@163.com>
 <ea5264d6-6b55-4449-a602-214c6f509c1e@163.com>
 <ZcHZYbTGHm7vkkpt@liutao02-mac.local>
 <055cc6cbe8521fdfd753612d6d6d76857550e731.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <055cc6cbe8521fdfd753612d6d6d76857550e731.camel@nvidia.com>
X-CM-TRANSID:_____wC3D_iXRsRlR3i2AQ--.27861S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar1UGw43ZrW8tr4kuF4DJwb_yoW8JF4kpF
	WxKa9FkFZYyayUtF10q3WrXa1Ut395Za43WFy5Ww1jvFsYgr93ZF1rK3y3uryDur1DJFyq
	vw47uw1DZFyDuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUvApbUUUUU=
X-CM-SenderInfo: xwdrzxbxysmqqrwthudrp/1tbivg59FGV4HuRD7AACsT

On 02/07  , Cosmin Ratiu wrote:
> On Tue, 2024-02-06 at 15:01 +0800, Tao Liu wrote:
> > On 01/31  , Tao Liu wrote:
> > > Hi Mellanox team,
> > > 
> > >    We hit a crash in mlx5_core which is similar with commit
> > >    de31854ece17 ("net/mlx5e: Fix nullptr on deleting mirroring rule").
> > >    But they are different cases, our case is:
> > >    in_port(...),eth(...) \
> > > actions:set(tunnel(...)),vxlan_sys_4789,set(tunnel(...)),vxlan_sys_4789,...
> > > 
> > >      BUG: kernel NULL pointer dereference, address: 0000000000000270
> > >      RIP: 0010:del_sw_hw_rule+0x29/0x190 [mlx5_core]
> 
> Hello,
> 
> I'll help you find and fix the problem.
> Your core dump analysis was very useful, but not sufficient to find the
> cause of the crash. Would you mind sharing a set of reproduction steps
> so we can debug this further?
> 
> Thank you,
> Cosmin.

Hi Cosmin,

Thanks for your reply.

It's hard to reproduce the crash directly.  In our case the rule forwards ip
broadcast traffic to 5 vxlan remotes. And driver creates 6 mlx5_flow_rule
which include 5 mlx5_pkt_reformat and 1 counter.
It triggers only when two *dr_action in struct mlx5_pkt_reformat have same
lower 32 bits, which determined by memory allocation.

Is it possible that we do some fault injection in unit test to reproduce?

Best regards,
Tao


