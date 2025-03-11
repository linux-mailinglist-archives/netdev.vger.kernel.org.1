Return-Path: <netdev+bounces-173880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59030A5C17A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F009F3AE2E5
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D1252913;
	Tue, 11 Mar 2025 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1PofRFf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A753925525A
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696665; cv=none; b=noQbPxoPyIOqNtWmWQfF3nfDRK4muipV+DmJrPJujZoPU2KZvZiyIyQuIA15WJP7zsVUG4q2f4qJJL7sPV3z1muU//jY9G8xE9b39pCYspeLmra3/IRUMYse91z2MvQAbUVYft93UJwSlhAEnLVxgb+t6cpTJfjHBblshNuUi2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696665; c=relaxed/simple;
	bh=fsXUdqSJiXijPnTTzLeAUdedbONCGGFdaA0s1XiyQKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwf/Fu/w6lfKGY//20878gSos99pDNVV8/DDk/95FQJBJVS291+aMxgXHHtoueZ6865047FWuRBx+J6+42EPnKM5UKPPnoFoZ3jBkGo51lfqFcOFz4QxNtt4gn7qXEA+J03y0wkU2JApXXezJzMz6FlFGHlE+mbqS0NKZJNfONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1PofRFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F72C4CEE9;
	Tue, 11 Mar 2025 12:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741696664;
	bh=fsXUdqSJiXijPnTTzLeAUdedbONCGGFdaA0s1XiyQKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s1PofRFfZwWMlk+3Dz5RXM5z/MpzgS0ckvG5gvMfRjuBDdFa6iH1uL/NTxK7kjU8D
	 ErYwZa1GO4EQWrprVSo+rj8YJNVe36jVnjJ/EweQliBVDRHfHwu0jOsOCmXXwLizGL
	 I3jTM/P48a+ZVnGQvh6BYTPSCC4um4s4VvJ53bVeEeudQ89r/TFaHuqhtV49lZ6a0G
	 Q2Rv39zBN5cWesCFYZ0oh2L1cdTZy3dY3R26g91pd4Xl6W3uZbTQkgNsl+z6376QLB
	 2zNyUjGQWTUJIUUXPNI78KD1jT1/3m7Q4jk6u3fdpCm/4w3DYtP5BebbO9kFGHdYXT
	 cOewnmDV+WY5Q==
Message-ID: <d7bef5f0-699a-4995-ae45-1a7cc9cd840f@kernel.org>
Date: Tue, 11 Mar 2025 13:37:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] MAINTAINERS: Add Andrea Mayer as a maintainer of
 SRv6
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: andrea.mayer@uniroma2.it
References: <20250311082606.43717-1-dsahern@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20250311082606.43717-1-dsahern@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 9:26 AM, David Ahern wrote:
> Andrea has made significant contributions to SRv6 support in Linux.
> Add a maintainers entry for these files so hopefully he is included
> on patches going forward.
> 
> Signed-off-by: David Ahern <dsahern@kernel.org>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ffbcd072fb14..cfac67dc66de 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16649,6 +16649,15 @@ F:	net/mptcp/
>  F:	tools/testing/selftests/bpf/*/*mptcp*.[ch]
>  F:	tools/testing/selftests/net/mptcp/
>  
> +NETWORKING [SRv6]
> +M:	Andrea Mayer <andrea.mayer@uniroma2.it>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
> +F:	include/uapi/linux/seg6*
> +F:	net/ipv6/seg6*
> +F:	tools/testing/selftests/net/srv6*
> +

I missed include/net/seg6* and include/linux/seg6*; will send a v2 tomorrow.

--
pw-bot: cr


