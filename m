Return-Path: <netdev+bounces-110075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D17292AE76
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 05:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27CBF1F21C6E
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 03:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA7440858;
	Tue,  9 Jul 2024 03:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4sFpxCd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DB03D966
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 03:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720494608; cv=none; b=A/rwGQRFRMzSgT1i8hJDMxFBGTSVGOMOmCLgCUk3ejbovUyyDnEkHl1XqCNAIetMR8HpiE1fe0Dbc5CTrT3+DSuRXzAAwnO0575Rqn5EFnB4c8qbw3g+g+gFp75nJL8+t62duHuFxMe8CoIikergZwgplZMlt0hUyinMQyTD9Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720494608; c=relaxed/simple;
	bh=rKNbz0Jp2W4pLp3WImvSq7Xa7/4sZptltIv/wBqH410=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JseH8iY9aYFx2iYjN22HKIB00bp8us/x/kjNDLF39eCnWeESJ7NF57PP432LBeLjfgfxlgpXESLDJN/bUzKkPqTi15hqyBzRtXl8GWbN0n/cAjj6GC4FE8dSACmg5COLKepc7u0ctunoQ3zPUuRplVkigp9WbMCZKBYxWLGvdnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4sFpxCd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F35CC116B1;
	Tue,  9 Jul 2024 03:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720494608;
	bh=rKNbz0Jp2W4pLp3WImvSq7Xa7/4sZptltIv/wBqH410=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c4sFpxCdFPgH19CPOkDuh7SE7WvSnsOIEXtphA+W9nWg6itw+/QddRMksb30lqkYq
	 9zPQUYrudhA3q/E0yqqgQiQvh3LTkvJFq0eeZw4DtINghoaciH7WeVY+fkKIjFycwj
	 WDRoht5z4asTP+zsrrTAz7El3Mio/FV4dxZRgKTJdIfzT82pT7xAT4eiHg80+FOE+z
	 vsRg+J0dtkJa6RufO7XpumW5qzzveeyMiGEh3r65JDLHFy2wykkm/JnV/kFho0Xg/A
	 R6rAW/dpshIlFxmiiWnFTKhKcjZb33WfVA26ZWSsaonPsqZm5nk55hYaspsCJOpnTv
	 rmpN1VRXQysuw==
Message-ID: <46225808-f16a-4095-bbc9-72aea6aad02b@kernel.org>
Date: Mon, 8 Jul 2024 21:10:07 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 4/4] selftests: vrf_route_leaking: add local test
Content-Language: en-US
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
References: <20240708181554.4134673-1-nicolas.dichtel@6wind.com>
 <20240708181554.4134673-5-nicolas.dichtel@6wind.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240708181554.4134673-5-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/24 12:15 PM, Nicolas Dichtel wrote:
> The goal is to check that the source address selected by the kernel is
> routable when a leaking route is used. ICMP, TCP and UDP connections are
> tested.
> The symmetric topology is enough for this test.
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  .../selftests/net/vrf_route_leaking.sh        | 93 ++++++++++++++++++-
>  1 file changed, 91 insertions(+), 2 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



