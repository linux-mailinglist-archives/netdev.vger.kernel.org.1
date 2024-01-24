Return-Path: <netdev+bounces-65523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F265983AE79
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 17:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38B10B254A5
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868D87CF34;
	Wed, 24 Jan 2024 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekzX3CfW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3681869;
	Wed, 24 Jan 2024 16:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706114111; cv=none; b=cHVCenzR6JP06b8FHPV+9w551h2jcFJegkJpybrKDCtooCkgpICSmSw3IwU5GpVjvR1+Mht+XRiH9rxm2A2p0aIeYxGhKghiICBG6xN7YkFCCNjC9h6GW2NTs9BVgV3wchWwuw1Nf6byVMz5FSediDLT7CQgmapgTHCITSqUMtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706114111; c=relaxed/simple;
	bh=Kq/5x+fMP1G2L0TmFEfIbl8Ym+J/+oEgZUaVLt8itUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFjibdob/Imu6IDMaE5mwD0yPZNVSCDzOqB32gfOFi3Hg+RBAB/J81kelqop2/nz13VSGRtZbVQa2ZtsrfOj7mhPxSfiYTDBbptBfkYc3jgy+7hmqHDNDOt8F/ffrNX41XOpCjxVf3dsuv5Rsk9bQUQNHKwZmpfruYSwkcZjhfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekzX3CfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EA7C433F1;
	Wed, 24 Jan 2024 16:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706114110;
	bh=Kq/5x+fMP1G2L0TmFEfIbl8Ym+J/+oEgZUaVLt8itUE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ekzX3CfW1b7N6bpLF7WO557NsrbDuVAowKzok1uxLKPWXwaVq095dxD7bH5gwvX9v
	 9hzsYXvwnGmijY0ouCNYq98PCkxESC7V+IHk6b/992srHTA9hKTbsrD2LzNPnFJ9Lz
	 Jj5WHA+wQ/snCYjCuqIUbM8c8grdM4SA8nbA/0e0s7vExbX1WJ06Yhq7QDUkkmjfmN
	 uKieg57dN6LsC6V3p1TcR7pwq3dkmGlEwfInM+iSkK4LIsB3ulYGOrjZcg++BFHXcC
	 DhMZYxXKx13ln35pIxWdnNJbitVqa3gZqyfH0a13y64QYk0jHTQoEBt8Wtov8kLCbv
	 34t5eBC6UCzhQ==
Message-ID: <aae9edba-e354-44fe-938b-57f5a9dd2718@kernel.org>
Date: Wed, 24 Jan 2024 09:35:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANN] net-next is OPEN
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Hangbin Liu <liuhangbin@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
References: <20240122091612.3f1a3e3d@kernel.org> <Za98C_rCH8iO_yaK@Laptop-X1>
 <20240123072010.7be8fb83@kernel.org>
 <d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
 <20240123133925.4b8babdc@kernel.org>
 <256ae085-bf8f-419b-bcea-8cdce1b64dce@kernel.org>
 <7ae6317ee2797c659e2f14b336554a9e5694858e.camel@redhat.com>
 <20240124070755.1c8ef2a4@kernel.org> <20240124081919.4c79a07e@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240124081919.4c79a07e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 9:19 AM, Jakub Kicinski wrote:
> On Wed, 24 Jan 2024 07:07:55 -0800 Jakub Kicinski wrote:
>> David, I applied your diff locally, hopefully I did it in time for the
>> 7am Pacific run to have it included :)
> 
> This is the latest run:
> 
> https://netdev-2.bots.linux.dev/vmksft-net-mp/results/435141/1-fcnal-test-sh/stdout
> 
> the nettest warning is indeed gone, but the failures are the same:

yep, I will send a formal patch. I see the timeout is high enough, so
good there.


> 
> $ grep FAIL stdout 
> # TEST: ping local, VRF bind - VRF IP                                           [FAIL]
> # TEST: ping local, device bind - ns-A IP                                       [FAIL]
> # TEST: ping local, VRF bind - VRF IP                                           [FAIL]
> # TEST: ping local, device bind - ns-A IP                                       [FAIL]
> 
> :(

known problems. I can disable the tests for now so we avoid regressions,
and add to the TO-DO list for someone with time.

