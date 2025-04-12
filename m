Return-Path: <netdev+bounces-181935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F98FA8703D
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 01:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0058A51B6
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 23:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604301A254E;
	Sat, 12 Apr 2025 23:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBJUPixK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3874919E83C
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 23:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744500330; cv=none; b=qrbRB4e/jppaFS9hyEVqqe+mlVdLTSB54zE/h7DhNnVAKzelGAujRHaM6sGtpccSSy0ZccuAjh248xcY3qKoLLrzmxRR6ibKMDbMrU05eXXpt08iMgTGqD07uEBCXDA8CVIuIBD2KVZI7ovadSJAjbIc6Lj2eDWeiTOfSZuXiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744500330; c=relaxed/simple;
	bh=BwuKiZoeunVgG1Xzj/dOR6jAvEvgOpPV286TVPSCvCY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfjsXkToW52eabMqFyTClhCpqXzY8romIf+SZg8BRWApzWD2iOcI0NsKH5aqurJT879qYhVMgCiGmiKR/ium/LZRa2/7RqOu00js4HKs0RbRodPIiz0FqF/Hg0bOm0qlYYNYnv2aylX5m4kgle84qh1llSjJoXEmBsqGQSeNVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBJUPixK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EB2C4CEE3;
	Sat, 12 Apr 2025 23:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744500329;
	bh=BwuKiZoeunVgG1Xzj/dOR6jAvEvgOpPV286TVPSCvCY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gBJUPixKKEqivDPRifiaPgHBBvm0ZAM5Fm+XUPyotJt2ejM/ObET4AzChfGqhd6pZ
	 PZcG0HX34QdrUE0eulHLoxADGEMvlEkyhkQ529q8DToCYZXV/rTq+tkFFkq1RZF0gy
	 xWsE11lbCD/e0WUJVHjkd3UjNuBYVrkr+CVCb9OXBmq/vwHu4d3mm19VS908l2i06v
	 EYgwazCc7TzoneInNJABpsGfRSv36/QNLiwMy82aW27glFQx2EYWrCBRI+IQW1fwZP
	 4vi8lQ93pP5rohNWKyoVM2ATmauw2aB6XgLu5+d6g1Oh4HDmNh4sFLmkkHXnLeu0KE
	 xpk8dV0453dIA==
Date: Sat, 12 Apr 2025 16:25:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: hanhuihui <hanhuihui5@huawei.com>
Cc: <idosch@idosch.org>, <dsahern@kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH] resume oif rule match l3mdev in fib_lookup
Message-ID: <20250412162528.24dc5105@kernel.org>
In-Reply-To: <20250412131910.15559-1-hanhuihui5@huawei.com>
References: <Z_V--XONvQZaFCJ8@shredder>
	<20250412131910.15559-1-hanhuihui5@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Apr 2025 21:19:10 +0800 hanhuihui wrote:
> flowi_oif will be reset if flowi_oif set to a l3mdev (e.g., VRF) device.
> This causes the oif rule to fail to match the l3mdev device in fib_lookup.
> Let's get back to previous behavior.
> 
> Fixes: 40867d74c374 ("net: Add l3mdev index to flow struct and avoid oif reset for port devices")
> Signed-off-by: hanhuihui hanhuihui5@huawei.com

If you'd like to go ahead with this approach you need to at the very
least adjust the fib_rule_tests.sh selftest..

