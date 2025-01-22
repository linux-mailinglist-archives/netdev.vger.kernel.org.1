Return-Path: <netdev+bounces-160365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 683ACA1963B
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 17:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33046188D1A9
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 16:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3345214A94;
	Wed, 22 Jan 2025 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4zjrl1D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CCA2135B9;
	Wed, 22 Jan 2025 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737562392; cv=none; b=kcb59OQrt96cBTmFocTJD9WWsY2Otpe1d0ayDCq4mFMUsHG4x6HMJ9fn3sZiyTby1OCUuVXHmUsL1OGmX5tZIMaJrR/yfhbBJijeGaO8k5reFYO2xJ+vnecp0p/qkd5cJ5J1JP/R+DuNcSJttT+S9bb1KwQVAuvnYAgLHd6aGD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737562392; c=relaxed/simple;
	bh=KEHUtoFcLh0Y6fZkBHgDbgYvVSc8J+FGSw1+WhZ9jnk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YA5kRAavsSWcHhNVwD+6zqUPptgzRXK9oxyS9RO52Bl/sx0+6REGWNVl1akbi21xXIaIdfeaFp0p9uzBfcsuySj/T1Ddt84V6C/tQCmiOJ/FwGZEqsDD/0izDXjf8Du8nKy0ienrKb8r89LMfBAYlC2jRzGor5Gm4xttNpAhLsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4zjrl1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1868C4CED2;
	Wed, 22 Jan 2025 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737562392;
	bh=KEHUtoFcLh0Y6fZkBHgDbgYvVSc8J+FGSw1+WhZ9jnk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Z4zjrl1D9Xf9zpSQt5kUEmGecUYPvJWCDj8b0Kqe4xYAtMXGhaDZVdlAJldptOVDz
	 zCPBWHskx4uf1ryynW0hcc40+wIUnMnA/FVeizaV5MWv5VcFcU6GVylFMWlOledeUu
	 osyFqyT3TrbkpiJ2oIeMwrmG2wkFOLwpno0NtmF9M2ED4l0NWNaohdP55efoYq7Iz+
	 85X00laTODUyWUy2FK1iJ9DAZe/TvztpqNa9QBJt1M2Q+ZcQb7bpIFkgtBPZ/wdYw8
	 dPCoB1UB3Wst8mbXvTr7eJpxuhyJ9DIyuIxgPMR4z/LFemWtwI3w9jF9qdTNvRz1Xe
	 8Nt9WFoGqnzow==
Message-ID: <81a09216-37a0-4362-8ed7-0a38a4cc5980@kernel.org>
Date: Wed, 22 Jan 2025 09:13:10 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] seg6: inherit inner IPv4 TTL on ip4ip6 encapsulation
Content-Language: en-US
To: Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Yonglong Li <liyonglong@chinatelecom.cn>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com
References: <1736995236-23063-1-git-send-email-liyonglong@chinatelecom.cn>
 <20250120145144.3e072efe@kernel.org>
 <CAAvhMUmdse_8GJtn_dD0psRmSA_BCy-fv6eYj9CorpaeVm-H3g@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAAvhMUmdse_8GJtn_dD0psRmSA_BCy-fv6eYj9CorpaeVm-H3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/22/25 3:20 AM, Ahmed Abdelsalam wrote:
> Copying hop limit from inner packet can be added via a new sysctl.
> Where the default is to use the node default hop limit, But you can set
> the sysctl value to enable copying from inner packet. 
> 

not a sysctl. vxlan, geneve, mpls have netlink attributes that allow the
TTL to be inherited or propagated. I think that model should apply to seg6.

