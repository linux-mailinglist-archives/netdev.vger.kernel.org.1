Return-Path: <netdev+bounces-247537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5915FCFB932
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 02:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE57430DB4BD
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 01:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C2C24293C;
	Wed,  7 Jan 2026 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouq+1QpP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6456823E342
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767748229; cv=none; b=lgX0ph5AENmgCVPO3T01tXngf/na9rY3Kg5kyLWeQY2e68eM7Vvw/3qwWpeMnqlWEj/jlzevHA0BG3tGcspaTSlK4uHSQFo/Ktb1NiTKgnKRWFqy9I5k5ZBq5j9j166IrXs3Y3K54ylCOiYXLq91ZNkJN/i5IfsW0d4zRubmr2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767748229; c=relaxed/simple;
	bh=OoZH+fpqJ0cgwkA5l9s/Sp64c83kpzyoBJgWGj34zUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HtDDUsIC9v+o9bFleOmxFXWXPBYDsSknkd5a1SpMmPHG6AhqmeSGSUBIf3Bg3MtKuXzkbo6kCQEJZYJiZvlu1AoND7ui6HFturhXrcJUzzQQY99t9QpvHz9Em0QwSwXdeMzTkLQy2nIcwkvSYbFvG8pqu59f3gg2tiP1tGQEWDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouq+1QpP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C40DC116C6;
	Wed,  7 Jan 2026 01:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767748228;
	bh=OoZH+fpqJ0cgwkA5l9s/Sp64c83kpzyoBJgWGj34zUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ouq+1QpPi7ktAt3k1KgclWjEMDUOJTW1MEfCkGU82iLEciCWEmmc0q0tXnU3g8JJc
	 P5md9DSCoHJiELcNu6gjAkAkmNxVY3WghFsMBqDSwQmvB9FzHTjM6LEjUt8bkXba+j
	 feK0K7+En/0uJKiO2OYePkMUB2VF+d2Vf8YpQfSfOPs4AtvYRtcV8mbJ9fA6V+ofZ1
	 Ab9CliCoz60HiPTvFsJvxWPXBXchqF+UPRWD8EGq9V8GQR+Nj1E7YSyvVFuJOfwiPI
	 Pd6puBLzeFbsvkYpv7niy7lD51Qy5co28jB+B17DvwMsOsBBq3vX8ImliYRKjQdWdT
	 ttqVnoLI8zmHQ==
Date: Tue, 6 Jan 2026 17:10:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: <netdev@vger.kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Dragos
 Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next] macsec: Support VLAN-filtering lower devices
Message-ID: <20260106171027.57a7757f@kernel.org>
In-Reply-To: <20260105101858.2627743-1-cratiu@nvidia.com>
References: <20260105101858.2627743-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Jan 2026 12:18:58 +0200 Cosmin Ratiu wrote:
> Before commit [1] this used to accidentally work because the macsec
> device (and thus the lower device) was put in promiscuous mode and the
> VLAN filter was not used. But after commit [1] correctly made the macsec
> driver expose the IFF_UNICAST_FLT flag, promiscuous mode was no longer
> used and VLAN filters on dev 1 kicked in. Without support in dev 2 for
> propagating VLAN filters down, the register_vlan_dev -> vlan_vid_add ->
> __vlan_vid_add -> vlan_add_rx_filter_info call from dev 3 is silently
> eaten (because vlan_hw_filter_capable returns false and
> vlan_add_rx_filter_info silently succeeds).
> 
> [1] commit 0349659fd72f ("macsec: set IFF_UNICAST_FLT priv flag")

It used to work and now it doesn't sounds like a description of a fix.
Whether the working state was by design or accidental doesn't really
matter, I think? Please explain or resend for net with a Fixes..
-- 
pw-bot: cr

