Return-Path: <netdev+bounces-95707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7C38C3276
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 18:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3682E2822ED
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 16:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F52C56B99;
	Sat, 11 May 2024 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udbpOMaY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF8456772
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715444722; cv=none; b=nvnwrfLtD7viqD5HErrF8tV+UdTorTqPnBtt9c7hbpgA31VKuYQ4OX7zGXdyCVBmYw6nrLbAFtXboL6Jqv9JYGSyvlVlqXnqimQP94z/bkfTFyS/E3Q9UsTbaf5BXpv37irTKlhDugyud435irepUlsIdxHKNCpbXf10Pq/4lK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715444722; c=relaxed/simple;
	bh=fKdFT3AbR/QLZETAmsnySnRWYTZDDbmIcyaO7hcFTV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBE8cnN8RlFr5nARY9WuW6kbXj8xR86kR8iBZIvKmSsMV8vtO5A/5NzKuULlmxvaO7O5lOU2KL4et1sOeQz2ErZMLZ8+/VlaDkaUDnSLKeGZ5lddJCmwnkOlk+pI2DfAi1lkSQoVoBywpVE3ieY3CzvguHhUIDM5cFRraCy6/gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udbpOMaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C9EC2BBFC;
	Sat, 11 May 2024 16:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715444721;
	bh=fKdFT3AbR/QLZETAmsnySnRWYTZDDbmIcyaO7hcFTV4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=udbpOMaY3wmfOx7CLvSqn7DJbKlIecZFTAaTv09C5vuqQsuWT+qww26+qrjFv1UZm
	 7DcRCfVZRfxdRlMlcxMqoFXE8T0f5YcVvvJeRjS7EINbUdtkgn7TD189d4wre3Al6B
	 sSb663rjIJRz5/sL96RO0a/24DOOyS8Fgg9PTxcvBe9mo5Kza8dPCTPVRiF2EpX9lh
	 eB6uqBcgCZnoprLECXPPvZVKmKRAf+JawFW2SZ7h2T9PaZYR7dwcJbt/GdLFBV9cjk
	 F0dxAiLXUNku2sK8SrG7UzVeII6baQbUFIdVvzDp0r6t2AQnkYJpsWAk4UQimgTrVR
	 N07BtA46nXQTA==
Message-ID: <a3ba49da-ad76-40cf-89ed-fbd40da79140@kernel.org>
Date: Sat, 11 May 2024 10:25:19 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 01/15] psp: add documentation
Content-Language: en-US
To: Vadim Fedorenko <vfedorenko@novek.ru>, Jakub Kicinski <kuba@kernel.org>,
 Saeed Mahameed <saeed@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com,
 willemdebruijn.kernel@gmail.com, borisp@nvidia.com, gal@nvidia.com,
 cratiu@nvidia.com, rrameshbabu@nvidia.com, steffen.klassert@secunet.com,
 tariqt@nvidia.com, mingtao@meta.com, knekritz@meta.com
References: <20240510030435.120935-1-kuba@kernel.org>
 <20240510030435.120935-2-kuba@kernel.org> <Zj6da1nANulG5cb5@x130.lan>
 <20240510171132.557ba47e@kernel.org>
 <225228d7-5c4c-4e8c-99d3-77aed6432887@novek.ru>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <225228d7-5c4c-4e8c-99d3-77aed6432887@novek.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/11/24 3:41 AM, Vadim Fedorenko wrote:
> But I agree, there is no easy way to start coding user-space lib without
> initial
> support from kernel.


The 2 sides should be co-developed; it is the only way to merge a sane uapi.

