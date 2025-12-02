Return-Path: <netdev+bounces-243138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23927C99E81
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 03:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE2393463EE
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 02:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321F244C63;
	Tue,  2 Dec 2025 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/cmTdIZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC273597B
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 02:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764643696; cv=none; b=c+Ie47FhQKqYXTWnmg/gCdxPYIoPKoTmn90tP/Qlx4E+DqyLHYVrY4k6aQFuBuk6SYtHa8r2Cnn/yCxciyYDPSBper5MMTggK96f1h8IL7ry7po/eJs9aiZmO3pBWNSZWKc+Q4kva6TobUkb3U7GijftN0cbdHeTC4FfbMxOhyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764643696; c=relaxed/simple;
	bh=+fdnCkBjyCVLP7/+2qIQaStOyvT4Nthf3dLbytL+WMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwPeuqCZi0rbrzZzIwLyVzZLtttyC7SaG/8TbEMELPjTO82NeUC7vVbhmhEfvaBjiIHNEcVmQOuzCPQ5LvyQLXDzjyjDYm4zjNrArZJJLhoXXGYOefwYfrBsAMJP2+sKUWGhwmkBVm2nHD2+k/HFzbuPvH2b3euikXW4N0xUjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/cmTdIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D027C4CEF1;
	Tue,  2 Dec 2025 02:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764643695;
	bh=+fdnCkBjyCVLP7/+2qIQaStOyvT4Nthf3dLbytL+WMo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E/cmTdIZxWNyok+PFdxAo+TeYRTMjB3Hybe2avnTViEu6FGYlIZOoZh6vEe9xB3TF
	 O3h0I5Ft/YdCEPz/9e+Zht580Mi44J/K39IfGmXUDL8uzIBtZ39/gw07VYsXpGQsM7
	 TWNM8eSQr3BdEPRx23FZxEcME/5GeqHqdcZt1nDXatOUquE+b+3wq06P4bzLalUOGx
	 GDDTaZYTSsnbSAMjIOkGnFF/lILjqJA47qikKBRC4u/C37fM1b2Ord4PGFc2EHplWq
	 bZS2JdHNr8VXptiNHS6l8owZxFZDKSqmJVfbbGpDEA0RrK3vMSO05jDTwGs2Q5PYmW
	 wBXkqdTBpk9Eg==
Message-ID: <e70fc28d-c6f6-422f-9678-64999aaf1514@kernel.org>
Date: Mon, 1 Dec 2025 19:48:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 1/3] helper funcs for ipvlan_mode <-> string
 conversion
Content-Language: en-US
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org
References: <20251121155212.4182474-1-skorodumov.dmitry@huawei.com>
 <20251121155212.4182474-2-skorodumov.dmitry@huawei.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20251121155212.4182474-2-skorodumov.dmitry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/25 8:52 AM, Dmitry Skorodumov wrote:
> +static int get_ipvlan_mode(const char *mode)
> +{
> +	if (strcmp(mode, "l2") == 0)
> +		return IPVLAN_MODE_L2;
> +	if (strcmp(mode, "l3") == 0)
> +		return IPVLAN_MODE_L3;
> +	if (strcmp(mode, "l3s") == 0)
> +		return IPVLAN_MODE_L3S;
> +	return -1;
> +}
> +
> +static const char *get_ipvlan_mode_name(__u16 mode)
> +{
> +	switch (mode) {
> +	case IPVLAN_MODE_L2:
> +		return "l2";
> +	case IPVLAN_MODE_L3:
> +		return "l3";
> +	case IPVLAN_MODE_L3S:
> +		return "l3s";
> +	default:
> +		return "unknown";
> +	}
> +}
> +

I like the direction, but let's use a table for both so the same strings
are used and add another function for the help usage.

