Return-Path: <netdev+bounces-245395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D71CCCB68
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 17:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30DCF3063F42
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 16:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EA0382595;
	Thu, 18 Dec 2025 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPSeDCB7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C266B34AB03;
	Thu, 18 Dec 2025 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766074833; cv=none; b=Zy/j5RMs1OT7ny6Kb48Yw7JDq9gOHiWyUqAiHIVkiyMZ1tT/JfrZj0g+IkaAUWWJgDwEmgscF2fltTSejynkikJEODTZqn77T2L+Vm8MncfWSlT2eovF70fqqTYNq9y0DQuU0jHhBNoRbqbq84KNjQUwHlvE4UiyVmFmHLliJnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766074833; c=relaxed/simple;
	bh=BX/JgLfItM5DH13AXi54yxN1jrob7p0TJlz3ygHtJs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtccew9Znjcqu977RLBDlYMNq4s8r3f0M+uzcoGuhiYnpgC3q7+yIw5irGgD8gKitJxb5ZAK+L8GKXFC+4tK4Q8fGtRyfARE3dKNqWTbcquM0OHwKJi7GV5QNM19O7o6v61g5phwZ+hVLsARiQUpc199W0om5YbU3S3I1KnihvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPSeDCB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F80C116C6;
	Thu, 18 Dec 2025 16:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766074833;
	bh=BX/JgLfItM5DH13AXi54yxN1jrob7p0TJlz3ygHtJs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tPSeDCB7Md09//bnpdr6/lq+Yaq0urjSazpHXg6SaAwrDWSxpA2CuZrA+IVKGnhC9
	 PM/IEO1Plj4J4JR3MMAkbLcdlBzUiqq0uOlWX4JZH21GK3W+xrmu0bQ8a08ZOKtxme
	 mK06KCOUjdw0qjvNoGvZM7xJG96U+c7xgSlcst9MZtRoTQyaCNzhBM0zItIhw2sEZF
	 qWWeo5GElS3NT0ZeyOaQqS1pVOv5igj3JP9C+v0H/IJzF+Kv5isGjJVvCaOBmEo2NA
	 c8eHzfBtObhO8p92MqB7xBxOjjmTFl7ZeK8a+sqtagv2JwING3FTKBdoRhh1eeOHTv
	 dGg9Od6Dmv7hQ==
Date: Thu, 18 Dec 2025 18:20:28 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Xiong Weimin <15927021679@163.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: Implement initial driver for virtio-RDMA devices(kernel),
 virtio-rdma device model(qemu) and vhost-user-RDMA backend device(dpdk)
Message-ID: <20251218162028.GG400630@unreal>
References: <20251217085044.5432-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217085044.5432-1-15927021679@163.com>

On Wed, Dec 17, 2025 at 04:49:47PM +0800, Xiong Weimin wrote:
> Hi all,
> 
> This testing instructions aims to introduce an emulating a soft ROCE 
> device with normal NIC(no RDMA).

What is it? We already have one soft RoCE device implemented in the
kernel (drivers/infiniband/sw/rxe), which doesn't require any QEMU
changes at all.

Thanks

