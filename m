Return-Path: <netdev+bounces-134027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7893997AE8
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889B628740E
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B430518BBA9;
	Thu, 10 Oct 2024 02:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9CmaUFx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD16187560
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 02:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529115; cv=none; b=lgQuSA4v1k7I6dAbTT+XD1u7Dh+HC/YpafIx3hsC+UUBJhaLzCiLGgJ48lUgLPDlCkewNUrx0jBFLZZUJlI1dUMdTHyG5PH7XLjsNFtYVMBxx0FSIMQrYGykl23fvImTVI+xFJTh58efv3kG8jyV2ETvZIPEDMK31j6VnYksEPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529115; c=relaxed/simple;
	bh=e+5c2qgsB1omahYB/5ZGl6OgLx9rlor7z+cKJZ7E4Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J+GJlo0qM1wj7G9pw4Tlsj9vihDjLEYbQXhiciccOOulV4uSCMrTWWK9Hcq/sZ1yKXVNcyDKdV8DYNs7QxNVCQOxc15DhEMdEjcs8dfCC54MaXyI5E2ep7flFDZuOSn5LMH+FJk1mWPE9nDM3o8JWhQTtLMTaUNhXbWI3Cio5Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9CmaUFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD824C4CEC3;
	Thu, 10 Oct 2024 02:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728529115;
	bh=e+5c2qgsB1omahYB/5ZGl6OgLx9rlor7z+cKJZ7E4Hk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q9CmaUFxiPJ00Ppf98uiGwgJYQW2MigsdB6tWUmZkmB9mFnRdZRlDqFYNOf7tDtL2
	 Sb29DOstAIYL6WhvP4ndkPqBITd2KCVwxNbFLwty1Ul5LpmmkZbIBHi5DcZ4+QyXn/
	 liBoe9duORRI2u9FQEwdhPDQUD6a0GyVAiG+D5MvO5DKWXZGYv3jn6zSDcsMUQLx3e
	 G6MHscjsbdCEx3HMPnB3Khg2nTuGYwCvAOii8SldOBu96XWMlEHeQ0wlhrewwtYv6k
	 UPRl3MsuT2mpmzx7HZrYB4lJQGxBFaZ5QKU72q84LVwEg/981XKsZmQ0lEguYxH+KT
	 ZJleBxALjFVpA==
Date: Wed, 9 Oct 2024 19:58:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, Wei Wang
 <weiwan@google.com>, Coco Li <lixiaoyan@google.com>
Subject: Re: [PATCH net-next] tcp: move sysctl_tcp_l3mdev_accept to
 netns_ipv4_read_rx
Message-ID: <20241009195833.716cfc93@kernel.org>
In-Reply-To: <20241009150504.2871093-1-edumazet@google.com>
References: <20241009150504.2871093-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Oct 2024 15:05:04 +0000 Eric Dumazet wrote:
>  .../networking/net_cachelines/netns_ipv4_sysctl.rst          | 2 +-

This will need a respin, I applied the formatting changes from Donald.
-- 
pw-bot: cr

