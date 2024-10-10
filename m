Return-Path: <netdev+bounces-134003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E543997A82
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2A5B28249D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A84B224CF;
	Thu, 10 Oct 2024 02:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NhKOugEW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563693E479
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728526748; cv=none; b=n5rWG4j1y+BXGJF3p+4ugNWai1vP8ZTUbuC/qmmNXwXSGnGFpVOtKRzSzLf2OCxxDkep+iuaiaAyjsVKtknwiA/tKtI4BDA9uSAQxuNFEbGw5LvTWieo/rOlHn/3BZWB8MqX1vZuAbyRcOlM6E+Dp6TSgKvm2luh17JbbWSQi0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728526748; c=relaxed/simple;
	bh=8L2Dam+nuTdeRNR+fhUyj3IdxaGQkDapBb2RuReIbQI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZdeT4plILCfDHAS3I8cQkjDblYkVYYM6bG6gKMwUAuIK1sHEjzRlYWnSUmonELPeUuRu6m8J/Pa3t6ucGFas6lmsqJamNKDCeNdNfIbLL0Fs0i2UA7xV8vXomYPwb/taGbRuzChVkIgKBDolWzrQUdafPnOe5Wh/1KB69DonHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NhKOugEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E6E6C4CEC3;
	Thu, 10 Oct 2024 02:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728526747;
	bh=8L2Dam+nuTdeRNR+fhUyj3IdxaGQkDapBb2RuReIbQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NhKOugEWP/60MtWhuTLEPVZYPlxOBIS+HhEbYIqyQTeGT3IfpmCGVhVz24ggUxq+O
	 93tKxNEIqowNGKULBDIwxb0k71WPEY7PvMYiTh90ymeu1C0bMlYB9g5QXXh/2YCWc2
	 Vac61BrJwI7fEkyICn2kQar554h+/U0vujbkt9bKJc0Mgt3Qt45N7srQM8gKLbgzzB
	 fmrHN5mDlRVbHnU8+D66YA700xgVlDsy1tjMmguppCa1af5eAr+V1XEVkmhb2onsnN
	 xlbPH4OsX2+thtn7cZfoGWLEE2FXQHqnMK12id1SQY0GwnxnltByr8p0qSQlN5dfpx
	 UH0XdnDhqPIsw==
Date: Wed, 9 Oct 2024 19:19:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <a@unstable.cc>
Cc: netdev@vger.kernel.org, donald.hunter@gmail.com, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com
Subject: Re: [PATCH] tools: ynl-gen: include auto-generated uAPI header only
 once
Message-ID: <20241009191906.573136e8@kernel.org>
In-Reply-To: <20241009121235.4967-1-a@unstable.cc>
References: <20241009121235.4967-1-a@unstable.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Oct 2024 14:12:35 +0200 Antonio Quartulli wrote:
> The auto-generated uAPI file is currently included in both the
> .h and .c netlink stub files.
> However, the .c file already includes its .h counterpart, thus
> leading to a double inclusion of the uAPI header.
> 
> Prevent the double inclusion by including the uAPI header in the
> .h stub file only.

FWIW I don't have a strong opinion either way.
Since both files are auto-generated there is no risk of getting it
wrong. Then again the win is fairly minor if any.
But if we want to do this why only remove the uapi header?
Netlink headers are also included twice.

