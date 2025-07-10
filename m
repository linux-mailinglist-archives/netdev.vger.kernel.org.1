Return-Path: <netdev+bounces-205618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5274AFF6CA
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 04:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53A71C24DCA
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 02:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFB527F16F;
	Thu, 10 Jul 2025 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phXhXZCW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD2919D065
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752114533; cv=none; b=bVnOfUeH4FhfQi9VPqTLVDZtBVzNyBcoMbnv6Dagq9l20XTIyqWgLyvNxX/n1kvHBKC4sm5WHX6S3K+MqhQvinLRHBIkmuy+k0j6whThrKguo0z6MGuQ85ZVyhHclZRbpB04/EY1xyjsBk4BU1vqM7gRce9Ioazp5Z/8f6Fs3+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752114533; c=relaxed/simple;
	bh=rFJkzvAEzoaHDdHmXl0SB+0JJZ8E4IKKgdiHy9E4eUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KMxs9PCmy5tc4Jw18zVzFOMR8YYSprdgyEoYRgHQLAIfQBJTy1jAAnGtBxuP4BwY7mo+XuJnqm+Y3bujzk/Ib4F9Vhjnf+4cixVk6Rl97ys6OGFGnt1UReWFNduUhZ7a1enjXKJ/y2jFi1fkGUhG69kvEBHDriaD4ywTgU0PQGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phXhXZCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D21C4CEEF;
	Thu, 10 Jul 2025 02:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752114532;
	bh=rFJkzvAEzoaHDdHmXl0SB+0JJZ8E4IKKgdiHy9E4eUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=phXhXZCWtes8qvTsiwoSOKTJw3FyC635pQSNpcEWQ3kYzkfgNYIXoP3YY+9Ksyz9J
	 rMfP/JtHFjxPW2TC5aZOrLpC8BRMUOzaz26nNROsMEqb+51+joMaSJWr8fi+sJxF3n
	 vpN7z/CFFCvL/Im66iA7c0B5Ki/hJVE/r5weZC8d88Xtzq+yFWN2OetgoJ/N/eSHeb
	 GqiYuQ0P/3cUwlC+BjybpM/AJ/RhoBRETd3SNCW6t1v2F+wPxm6oh/QBr34kBU+5Ok
	 1SpZQLRDJ8nMrICa/hzF5JXUIT4lcvohRGE7yTji3EpbXr+Tj+/jJhJFGb5QMQSyOq
	 zUTT7CJCaUioQ==
Date: Wed, 9 Jul 2025 19:28:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <Shyam-sundar.S-k@amd.com>
Subject: Re: [net-next] amd-xgbe: add ethtool counters for error and dropped
 packets
Message-ID: <20250709192851.5830305f@kernel.org>
In-Reply-To: <20250708041041.56787-1-Raju.Rangoju@amd.com>
References: <20250708041041.56787-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Jul 2025 09:40:41 +0530 Raju Rangoju wrote:
> add the ethtool counters for tx/rx dropped packets and tx/rx error
> packets

Standard stats from struct rtnl_link_stats64 must not be duplicated by
ethtool -S. ethtool -S is for non-standard stats the device may have.
-- 
pw-bot: reject

