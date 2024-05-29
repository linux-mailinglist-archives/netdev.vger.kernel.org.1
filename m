Return-Path: <netdev+bounces-99121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4028D3C2D
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 18:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C271F287BF2
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B7F1836FA;
	Wed, 29 May 2024 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifUw8N9z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655FF1836F7
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 16:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716999819; cv=none; b=DsLZCcjyVzj7e/fHA7L4SJfONYk67cn7BKiOleSlGmsvIvr5o5cMLWeSePzX00w71zNC3CRQN4AXS6MEhRV7bScB4ztb/rukGpM8Y5qrTPdQbi6AVX1Fidh6rugnciPnOQmj6Kj6kKB7OJiAV73e8OhRaWyD8HYIAsUa3X92k3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716999819; c=relaxed/simple;
	bh=MAo/RtDbAPubySLxRz8L4XClT1s5l342iQrh+2yM7eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SbMS2/MAncWlHCxZ/8+auors6ga3Yg6FW4dvWGNQXXXZ023wcx5SeHPUfpOu0UnJAAOzH3cc8ZAj3bxo2T5F6V18fGveqrBkVs5Uq5iGEBVYZg15uSKy81ssJ4UmAVvb5jYHD5n82FqeZcNEbxWksAOW23cnNPEDSDunmQ2H3L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifUw8N9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2190C113CC;
	Wed, 29 May 2024 16:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716999818;
	bh=MAo/RtDbAPubySLxRz8L4XClT1s5l342iQrh+2yM7eM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ifUw8N9zMj6YQf5ds/sNe4HbY//Rfh2m+IJJggaCxFXUifwzKjFmaaf+G3SusnUwJ
	 LRjDrbgmxkTIcslG0ySLAk3W6xbttwaAB+OEqA1dQQrtMrQyTbQ1VKKFgI+KlMAAIL
	 Ln5uI/lOE2JSAmB1BXeiXAz1KYomVGuvZd7SPdTSiyA3d8vDE4nGpSqi5dsivdvyNE
	 afcyCrCJTUcI1Eq4XZP5QuzAQqoeYMCUKaAiNxouhitelCUGSRDew5pUK/ntA028fB
	 9lv1m0hTPAjeuC13Mn47ZgHYHJG48Az9rNrvDP4anGeqTH47mTqYOfETUCuWeWFkDn
	 oAoYv7mJSfIYQ==
Message-ID: <f8dc2692-6a17-431c-95de-ed32c0b82d59@kernel.org>
Date: Wed, 29 May 2024 10:23:37 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iproute2: color: default to dark background
Content-Language: en-US
To: Gedalya Nie <gedalya@gedalya.net>, netdev@vger.kernel.org
References: <E1s9tE4-00000006L4I-46tH@ws2.gedalya.net>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <E1s9tE4-00000006L4I-46tH@ws2.gedalya.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/24 12:43 PM, Gedalya Nie wrote:
> Since the COLORFGBG environment variable isn't always there, and
> anyway it seems that terminals and consoles more commonly default
> to dark backgrounds, make that assumption here.

Huge assumption. For example, I have one setup that defaults to dark
mode and another that defaults to light mode.

> 
> Currently the iproute2 tools produce output that is hard to read
> when color is enabled and the background is dark.

I agree with that statement, but the tools need to figure out the dark
vs light and adjust. We can't play games and guess what the right
default is.



--
pw-bot: reject

