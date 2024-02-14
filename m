Return-Path: <netdev+bounces-71711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70939854D11
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 16:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39831C209B8
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 15:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966C65D47F;
	Wed, 14 Feb 2024 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkjQwjig"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735055D467
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925177; cv=none; b=hJe6v8d/9Kfj+89xTrUs6D3+DCpkV/sHdpTXmhih83oC6CKf8heCerpAqzZ5YHVxHJZ7CbyHjq4M+t/HUJIz4QXJasnFFGidiXDYNu/urvYUBFPoB1wX6YxLE/mtM1giFY5c7s9i+sQRW7ZmCyyFSc+5CN9tGMC0Ze/cKPWOvoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925177; c=relaxed/simple;
	bh=5/rbEtjdxjCps5lEv57kc1bRQ6dBxN9cO0t7A8aay8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PoIuUdloIdkhnYmafJ4IcDYSamJTfSpsn38/qjmoJDBlU0qV7ogt11ysARufVkMv3Si3N4gfwHy9uNl64Jbk+Qlgf9OrlqNIle9hspENrTbUbs042dvdy2Qn8m8lAibaxeFg6UM3qnYW2XrEASnjXTJIXMSeu1VXJ+IUeRyvuDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkjQwjig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AB9C433C7;
	Wed, 14 Feb 2024 15:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707925176;
	bh=5/rbEtjdxjCps5lEv57kc1bRQ6dBxN9cO0t7A8aay8Y=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=XkjQwjig59+kVe9/pOx0FGAP93ptgdelpjeCg+7eMkucrd7z7Xr5Iha8XV3htcq5S
	 7tYE/z2FJzJTvDEivBaBqGrOY8jUlP/N2BN5MCEhgtIFzAo+SSmPZEV5/9CT/uovsH
	 M33c00aFzDKf6DvUkDN65H6fS/IlY3a2HSLGQX0FeNx21QGO6rVbQkGU4NU7ImD+wU
	 xDEjdS1KbKG7UIGD6uth55EBO2F+ft2ejW9NzEbgxiNeS88asJBiYsVFQsyUswrlpg
	 Ey+a8LobYdEZHWAAA98EzDiUSb8nCyWhsrROuAvzraFnaOCwdhSew+MyWCy/OA31qR
	 Uu1ulMlbfYBNw==
Message-ID: <705cac76-dc97-4bfa-9340-1dbaa5de3b2b@kernel.org>
Date: Wed, 14 Feb 2024 08:39:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] net: ipv6/addrconf: introduce a
 regen_min_advance sysctl
Content-Language: en-US
To: Alex Henrie <alexhenrie24@gmail.com>, netdev@vger.kernel.org,
 dan@danm.net, bagasdotme@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jikos@kernel.org
References: <20240209061035.3757-1-alexhenrie24@gmail.com>
 <20240214062711.608363-1-alexhenrie24@gmail.com>
 <20240214062711.608363-3-alexhenrie24@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240214062711.608363-3-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/13/24 11:26 PM, Alex Henrie wrote:
> In RFC 8981, REGEN_ADVANCE cannot be less than 2 seconds, and the RFC
> does not permit the creation of temporary addresses with lifetimes
> shorter than that:
> 
>> When processing a Router Advertisement with a
>> Prefix Information option carrying a prefix for the purposes of
>> address autoconfiguration (i.e., the A bit is set), the host MUST
>> perform the following steps:
> 
>> 5.  A temporary address is created only if this calculated preferred
>>     lifetime is greater than REGEN_ADVANCE time units.
> 
> However, some users want to change their IPv6 address as frequently as
> possible regardless of the RFC's arbitrary minimum lifetime. For the
> benefit of those users, add a regen_min_advance sysctl parameter that
> can be set to below or above 2 seconds.
> 
> Link: https://datatracker.ietf.org/doc/html/rfc8981
> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  Documentation/networking/ip-sysctl.rst | 10 ++++++++++
>  include/linux/ipv6.h                   |  1 +
>  include/net/addrconf.h                 |  5 +++--
>  net/ipv6/addrconf.c                    | 11 ++++++++++-
>  4 files changed, 24 insertions(+), 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



