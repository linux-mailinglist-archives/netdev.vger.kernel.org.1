Return-Path: <netdev+bounces-210601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F9EB14064
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281923BF035
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 16:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2126C2741C6;
	Mon, 28 Jul 2025 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALnxJHcE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F122ABE4E
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 16:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753720506; cv=none; b=pc1/XSOvgnR7wemInnMHz/m1KKCIOnf19k/qbZdWQMEY2pmibaat+74wNVClsi3YMKpAY5zaJ1p7teMrqEgFFPDQk575NTgifr0l7Bln1dwz+eRH1yX8WeMovF424oH9MwgadMgXdIQ8A585SXJ1bj4SD2zNpcp9ertSWYOzp1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753720506; c=relaxed/simple;
	bh=PxuNXuChBXAEPAEMlrXqIRO3p30mHc0dhyRLDq4K/Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poZw6oPp9N+mSvgGZO08VbLfIVyLSGmN23IzWBuO9JsruswQFgDz+JzTxevycgH6pQL+kCuArh6cyV10wgRMn57qkJE3hhxVGrwY7liCEm7u48ReprvG+Ht20LhaHaaBBbbL2FEQ2Zd/tRDkVI6m1z7sj4+Zig+ojzuraF0MpBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALnxJHcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BAEC4CEE7;
	Mon, 28 Jul 2025 16:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753720505;
	bh=PxuNXuChBXAEPAEMlrXqIRO3p30mHc0dhyRLDq4K/Oc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ALnxJHcEUCfS+7OnIjOlEJLmDJfKNDFOjLV7G4vUBwpSJf6Hoj7ku1EY9ojtxUS6D
	 19AwhXUZtbsfX00t7dVY1TJAPSkwSWe2BXx9PPOxlmN9o5Yb70CSgbq7rW9+h2k+R0
	 W+ozZCPFYtPWwtN482SmRSmHVhbVLof6+LVcK+0yNzv2ycAqOQxY3HKkeYKQBN5Clu
	 fWMzAx0o6zWymu1IESr13qywXDuLV9f45BCJ2i2DTPW90PJIVjc/xN0ztXlaSzmH+s
	 Ow6Q1Lhv4qh7y3hxnm4T9CWId3BvHbetToOsEwB/3gsm4rMoAVQMZiFKsZqeJwDARA
	 YRbgGttTHlPQQ==
Date: Mon, 28 Jul 2025 09:35:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
 <petrm@nvidia.com>, <razor@blackwall.org>, <daniel@iogearbox.net>
Subject: Re: [PATCH net-next v2 2/2] selftests: net: Add a selftest for
 externally validated neighbor entries
Message-ID: <20250728093504.4ebbd73c@kernel.org>
In-Reply-To: <20250626073111.244534-3-idosch@nvidia.com>
References: <20250626073111.244534-1-idosch@nvidia.com>
	<20250626073111.244534-3-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Jun 2025 10:31:11 +0300 Ido Schimmel wrote:
> +TEST_PROGS += test_neigh.sh

Hi Ido!

This one is a bit flaky running on the normal/"non-debug" kernel:
https://netdev.bots.linux.dev/contest.html?executor=vmksft-net&test=test-neigh-sh
Looks like we get a flake for 1 in 10 runs :( Could you TAL?

