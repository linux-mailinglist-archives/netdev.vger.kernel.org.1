Return-Path: <netdev+bounces-140051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1700C9B5202
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4906C1C22CB8
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06132201003;
	Tue, 29 Oct 2024 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mD7Xr6IL"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2215200BBB
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730227360; cv=none; b=SWTYSERqEcjvaYa3m5YlfJGBg0uJcGujSPddNYaN2wahxjUOpuSaaAOuDXYdIn5Ra5y3lRdacWl/hzlRd/g2nl+Y5z6Q+8PovkDweoBDxyIXgQ+4z9TZkegCiafmqaV3WRgFZmGazXtg3CnPpSTudlt2jKBR4rO+TjxziQ8+w3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730227360; c=relaxed/simple;
	bh=W62NwbbxHFpx/e0gfC1hhAVIv/tq2t+PSrNQBKUVOek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oE7tkK1ack8vc+hxqoqgyicTcI5KUTvpCmI+z9dZngKUA0ECZtWsKnP4kEZMLFwNpbhA8wy04zPjJedEPMGgE0DjGVduts8LkgRsbz4i1LkglrAhbDYAUp107pk9oIFyVRwElUMIXRlQ//I6txUjEWoWcuLp92scti9Obrd5ztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mD7Xr6IL; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c6a30471-46f2-4cf9-b94c-c0a9119a77ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730227356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W62NwbbxHFpx/e0gfC1hhAVIv/tq2t+PSrNQBKUVOek=;
	b=mD7Xr6ILQrwtHa22g+tlCUXYJ+suX8290TAXKmF0al4s+b4siYh1KNJCTNDQylPUpdM6mg
	rPxRW+gJq7cFDrf+VsfSSdKZ99cJmAWqDTNwOYjqFK5Mk1xrajJPbOP/DR9lvVFVqnd4Rh
	O/ZfPIBCGoBQ5yIqeeZL088zrSQg6hQ=
Date: Tue, 29 Oct 2024 11:42:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] net: tcp: replace the document for "lsndtime" in
 tcp_sock
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: edumazet@google.com, lixiaoyan@google.com, dsahern@kernel.org,
 kuba@kernel.org, weiwan@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>
References: <20241026065422.2820134-1-dongml2@chinatelecom.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241026065422.2820134-1-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/25/24 11:54 PM, Menglong Dong wrote:
> The document for "lsndtime" in struct tcp_sock is placed in the wrong
> place, so let's replace it in the proper place.

The patch lgtm but this should be tagged for net-next material.


