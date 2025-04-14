Return-Path: <netdev+bounces-182503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 428CDA88E93
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B933ABE60
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288BD1F429C;
	Mon, 14 Apr 2025 21:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQ3yFx9K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D491F428F;
	Mon, 14 Apr 2025 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667567; cv=none; b=PeLOVR+rTy73e0t/WU7otbG5T6XrHUk/VSTIt9lnUJSb7c/NY6LwnyXIdbjbEG+40u5RAJGL+CpdRwlBVcF1xkMD77kKJNjPrfXo4sj164gggNcPP3uLHzwnPqORwmLaSfvA5+wm0USWJb5ZjPsazQdJH3L4e9OJWDo/6lcmb0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667567; c=relaxed/simple;
	bh=9Y6+16CTYHBYxtlREsuqFnCE62ervheulxQaRrmg184=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGPMMc7IGRgl2dEk2bH9frTuFb8FNv7/pEG8/g1Xwzr79YElR4C8dS9XtT3zSyiGBl+YdS+FfxEtoo/xtLGxKe3l6Wc179/3wRhhTl/kOBc5QePO7RPc0RqAnaubRYt2MU5J1Jqn3pOKpNm8SIjJ0a4qzm0SqmFRXLRxM/4griA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ3yFx9K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C63C4CEE2;
	Mon, 14 Apr 2025 21:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744667566;
	bh=9Y6+16CTYHBYxtlREsuqFnCE62ervheulxQaRrmg184=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BQ3yFx9KoWO3F7yJoP2HDSjq8ldn1TXrFhX2V5lkx1n9DBxHvLPr1jQohazn9k36F
	 tz6ABZzhq0DgOU8dO4nWTAPrl8wddbS6rjR2E9YwRjTHvhvDrjsb60wBYKogGwhGo8
	 V657+I2E4GaoZRVRNrjGg87s06Z40n1c/nMl+Va0GpkLVc9NzZIwCNTFFSSDGXySz0
	 1V6aLmIhn5LcFScBPaEaxECEOp6FB62nf1OEKfZUWx4TW3IMF2NfdF56/Dv5gLZgXk
	 WHS1maBHZGsz94qaFWEfXgAYZTdljy0KXMexlzdImtd2IfZQMiaEwU/54jaq1AawCn
	 dvIHrUJH5hxAw==
Date: Mon, 14 Apr 2025 14:52:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v1 11/11] net: pktgen: fix code style (WARNING:
 Prefer strscpy over strcpy)
Message-ID: <20250414145245.088ff483@kernel.org>
In-Reply-To: <20250410071749.30505-12-ps.report@gmx.net>
References: <20250410071749.30505-1-ps.report@gmx.net>
	<20250410071749.30505-12-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 09:17:48 +0200 Peter Seiderer wrote:
>  			memset(pkt_dev->dst_min, 0, sizeof(pkt_dev->dst_min));
> -			strcpy(pkt_dev->dst_min, buf);
> +			strscpy(pkt_dev->dst_min, buf);

these should probably be strcpy_pad()

