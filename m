Return-Path: <netdev+bounces-64522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A849D835909
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 01:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37E4EB21710
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 00:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD56215C9;
	Mon, 22 Jan 2024 00:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUWn6CdI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899315CB
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 00:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705885038; cv=none; b=YcYUle6IV9DOlkb/Uq6LmFINAysR1j7gClnVRcvKdEgG/p0e+w64AOGanak5tc7GLJSDFKqD5ZflC92cAsT6oKiDtEo5Vpwd5AoorqOukjimYy2WWG5dk000O6Nm6ndpIxWHvrWKeuQ2jSjrRGW/mypfaDH22MXLD0oRCaSOiX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705885038; c=relaxed/simple;
	bh=cPSgfK3ULvDPq0l4oEX5B4xA1SRA34w3BqL5rO5NHu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pbqwzFGDunVEHmwhjqU11alFjj7kTCdRuUZ5WRN294OjeGzbainPA4+lsoyXKPjSjnnuQ0qNfBOfFkTK42/zU9dhffWajI3pZcKWmvDAcvPE+6pdV8lhq85+pgq8pCExw0H+unGGfXFU1MQF07IYnH1cdd8o0l00JOpQl7DHyAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUWn6CdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D773BC433C7;
	Mon, 22 Jan 2024 00:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705885038;
	bh=cPSgfK3ULvDPq0l4oEX5B4xA1SRA34w3BqL5rO5NHu0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=WUWn6CdI3fs7jeuLEZ6QUbZExf+xMSFjZCRtJZceixpGH49m3SfWgMxNwKd+m3/d+
	 5RkgEXibvzC+wmmHxS1TBoTuVrtNt7wxibK/fxR3T61Hxg76VX87ANReQSHlMNypJs
	 zfZtgQ4Bq6q28Ejb3vZH9XxszeBaDpcFmbzcEGejKW64b3PFKBzk1Y4bvzYrxyFTB6
	 CCuKy9dfKjsZYaAmMvjEVleYwNUF7CHi9ZZqTflMh7j+ywcakj+LmcRsTPAHf0Vbth
	 gP1YEzFLXu/A9CM1l3YWk5I5Joe6Q9yrxvyeyEH2RJLy+CikIlUBuf3bx5oEkruOqk
	 arkj4BJXpnL5A==
Message-ID: <c618b31f-00e4-4e93-8448-c5dc9a3ce179@kernel.org>
Date: Sun, 21 Jan 2024 17:57:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Having trouble with VRF and ping link local ipv6 address.
Content-Language: en-US
To: Ben Greear <greearb@candelatech.com>, David Ahern <dsahern@kernel.org>,
 netdev <netdev@vger.kernel.org>
References: <6f0c873e-8062-4148-74c2-50f47c75565f@candelatech.com>
 <9c01855e-fc0b-4bad-8522-232b71617121@kernel.org>
 <fc260731-3fcb-1681-f4a4-20820387e265@candelatech.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <fc260731-3fcb-1681-f4a4-20820387e265@candelatech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/21/24 5:49 PM, Ben Greear wrote:
> And, since it is bound to VRF, and there is exactly one netdevice in
> that VRF, shouldn't it
> be able to figure out the device name?

I believe this should help reveal why %dev is best for LLAs:

perf record -e fib6:* -- <run test>
perf script



