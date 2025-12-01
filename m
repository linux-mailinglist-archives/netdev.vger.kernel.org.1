Return-Path: <netdev+bounces-243061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EB2C9920B
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 22:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 960424E403F
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 21:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA28221D92;
	Mon,  1 Dec 2025 21:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="fwxxCeFh"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF22620E5
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764622943; cv=none; b=Szpud0rUuIjF1jnpJDFUULBhEQyE3iatEU62RnuBGMNFEquqqfCMaKVrSfv7546Ltmodbp1jdJCgxXw8uq9MKkiBXsYYyZ2a2jtP8XVT7gAdUYoPiRLpcfom34GJhgJAzK2j4fOabBEJd/4Mc5XE7vE+4pHjIgySnzkQ3mPQ4yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764622943; c=relaxed/simple;
	bh=9cUDLSkPdyDaC/BrK1O399X9jDOfZM7Q7QWdbcnPRdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PUfAgEziSQIQAvB1Z8OFZFn/YFxh1UBhaMo+UGFoNwOWM4tPwsIMIdSJR1mmn2jVxG+RUzKG79y4A4p1Pnih5bRaevUe0JF8JnVJKk/Cv5EekGEWzISt7yOEVVRDrURI3CLxiFcvsPBOW1113Hun2yfrAsU5fwzVbTijJVeETDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=fwxxCeFh; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1764622932;
	bh=9cUDLSkPdyDaC/BrK1O399X9jDOfZM7Q7QWdbcnPRdo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=fwxxCeFh+G9IE9JQrGLxpd/PNBWqEukilLECtKkdPXOfXHFLTSwOXOaKrreq374zh
	 pyDaNPT9o97pFMVfrlivB4se/tMXqXBFbX7fdQNZ6ilSly6ghVp/LgweBVKSLgAOev
	 4hSvVuGiMJxj5lOrNDwkcjijbvrDUE9gxptnQnUuY101MfF1Heh0Sm4pOCI5dEoRAq
	 3+fOQscbuzADlzfAZxotyGlitOFICIHyuLKl/vMU52x8qvJZGCk4o2V/mV/iyoa1Xc
	 zGVVtzfyV+YccPqt1ee9xBS0JjHZL/otsn2FyWmLwL8PpTOKF5zSFZTg1g3ynDgjdn
	 xXxQn7HcQve+A==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 73A0A60075;
	Mon,  1 Dec 2025 21:02:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 740A8200C91;
	Mon, 01 Dec 2025 21:00:42 +0000 (UTC)
Message-ID: <21cf5582-61b7-469b-a235-3d44be898e7e@fiberby.net>
Date: Mon, 1 Dec 2025 21:00:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/11] tools: ynl: add sample for wireguard
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, netdev@vger.kernel.org,
 kuba@kernel.org, pabeni@redhat.com
References: <20251201022849.418666-1-Jason@zx2c4.com>
 <20251201022849.418666-11-Jason@zx2c4.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20251201022849.418666-11-Jason@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/25 2:28 AM, Jason A. Donenfeld wrote:
> [..]
> +
> +	req = wireguard_get_device_req_alloc();
> +	build_request(req, argv[1]);
> +
> +	ys = ynl_sock_create(&ynl_wireguard_family, NULL);
> +	if (!ys)
> +		return 2;

I will send a patch for fixing up the error patch here, and call
wireguard_get_device_req_free() before returning here, after rc1.

The broken error path here was pointed out by the AI reviewer.

