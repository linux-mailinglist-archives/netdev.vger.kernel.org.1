Return-Path: <netdev+bounces-109589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79927928FD5
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 02:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C1BB2171E
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 00:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412DE5258;
	Sat,  6 Jul 2024 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2qYL/x+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C553D68;
	Sat,  6 Jul 2024 00:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720227229; cv=none; b=tr9LdkAWd1ihMxRgZdCel6zjpGi2pBGziJhf27n2P++2q6NM3540jlhGbF2IkiV2gh1M6ft7QqH7ksC+JenTogdpA1oonpNkbTt/vZtYZYgh6ZkWrkTt3zcOzR5/gVuEHPgEziGEcuit94/Y2wRgmKs7/hSKy0wIdj4myUHjZpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720227229; c=relaxed/simple;
	bh=+bhRs6l/CzlBuDKVzbcHGyvGGEpftGuNjbqAMIbVjTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJr4bZxKYNHTs8qh7Kyo2bbvK3sMoRSjBFjIEOmgkaZ/8gL3cOU9EEADao0WcQU6rtYzfvYQN8DFQW96QWadu/30aUhR2qamqGI055lVjmsyEvwm+m0/683+UcwmrDAEssOWI93I2sb//4Xx4LW4X+7vtJRkbw9VgkrxWLI3x7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2qYL/x+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543E6C116B1;
	Sat,  6 Jul 2024 00:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720227228;
	bh=+bhRs6l/CzlBuDKVzbcHGyvGGEpftGuNjbqAMIbVjTI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c2qYL/x+gGpVltd9Hb57ry4OKDQ0Rgyvm/3EJyKkphbeX/d5BGpPqKfirRleyZr0B
	 mNnaEgUiBr/y4Ehdot8rGhzvR6fO1cW4ozLR+06jSFJc0SoOjXY10A9JrOMCAR8/Xj
	 ix4cozmyt8XqdPIFOOLF/3+0+6glrjUBq6yfIdoaPTGyGUBDpwbQjnMaHZyUB9SFa0
	 zXfLaPaVpYFuQDfSEGUaRt9fEKJ5FFbpLF17k1D2yjtkDeDmNl6iWFIarozHkS9uR7
	 zCRXE47Tqc5Bc/7Sl4m3nQ8B4mp1CcZHoByRskH2h3CcV0yNTT3Y0KLR4YFVRG0ljx
	 Ho8plEzpx2KfQ==
Message-ID: <d6e8ce6e-53f4-4f69-951e-e300477f1ebe@kernel.org>
Date: Fri, 5 Jul 2024 18:53:47 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 iproute2 0/4] Multiple Spanning Tree (MST) Support
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: roopa@nvidia.com, razor@blackwall.org, bridge@lists.linux.dev,
 netdev@vger.kernel.org, liuhangbin@gmail.com,
 Tobias Waldekranz <tobias@waldekranz.com>
References: <20240702120805.2391594-1-tobias@waldekranz.com>
 <172020068352.8177.8028215256014256151.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <172020068352.8177.8028215256014256151.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/5/24 11:31 AM, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to iproute2/iproute2.git (main)
> by Stephen Hemminger <stephen@networkplumber.org>:
> 

Why was this merged to the main repro? As a new feature to iproute2 this
should be committed to next and only put in main on the next dev cycle.

