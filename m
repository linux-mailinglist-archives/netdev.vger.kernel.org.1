Return-Path: <netdev+bounces-235185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC28C2D382
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 17:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6B3BF34435F
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 16:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B99A3148D5;
	Mon,  3 Nov 2025 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOXpDgOl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056EE189F43
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188431; cv=none; b=LG6JNjeDltrvlYm7MqN8fsZ2kBR3S2C9hto5k0LSMYBP1G8OfdPazj6jT/Xz0f1d5WkQ6BFvaM7cuBYp1hqDuB3sPx2ntQLRQGTGOut0GQVPBM+bFsPVQdYSuKfH7VpNYlzMG5UKr2QR83WFedZwWCCv1skAyrEazQpOaNbWhj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188431; c=relaxed/simple;
	bh=pgK0JqnEHPpqDCFPUa1lA+PAcI7qxvNypvA2Rg7MNG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qaFtLOxUMSUV4PPh9cw+1nlwjizdvSKBbi7uTGUkTQe+P1E9qTflM7r/VfQ86pwWyw1ORgN15xuZKyToZT6tfDoeBJrp+pf3KOLxUkD8PmP7eQTbe5hojm9U2K7iQqAT3K3oniIFJA6X8Tfp66jz3bWJSfCyWLPPBirx78koRTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOXpDgOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4491CC113D0;
	Mon,  3 Nov 2025 16:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188430;
	bh=pgK0JqnEHPpqDCFPUa1lA+PAcI7qxvNypvA2Rg7MNG4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fOXpDgOlSJQ3qV/PC6G+F+5CBdVwm0RgShU/bKoF/2ZFS/r6uNg/juloWs9gnlwJe
	 sO+fK60CmxQfWYJWiIA2vp/kcpzWuSQCaSMIElI+1T6xFgqzbAFQGvisy+/VRCZvZO
	 j7rJCt9TWjwz8awHJCa+73CbfEqzRjAo4JVSglpTS7NWAt/FFEJiSJRBLmRh59i8eM
	 +NQH1xv2VNDy6ejINRwT0LYAlyOC5yXbYub9IzyiA88qx62yQJ8DMmdO24lC4LKRqI
	 4+Yjfb4ehoKCBq2/p3Joqc1RIOlE0vfeGQpkJy3J6PSGM6wq8OvQLwBLL/7TnIPUGp
	 aSKjzp4PrPWFw==
Message-ID: <cb6455d7-a6d5-4a1d-940e-31cb9a4fc486@kernel.org>
Date: Mon, 3 Nov 2025 09:47:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ip-xfrm: add pcpu-num support
Content-Language: en-US
To: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 David Ahern <dsahern@kernel.org>
References: <2623d62913de4f0e5e1d6a8b8cbcab4a9508c324.1761735750.git.sd@queasysnail.net>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <2623d62913de4f0e5e1d6a8b8cbcab4a9508c324.1761735750.git.sd@queasysnail.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/25 5:06 AM, Sabrina Dubroca wrote:
> The kernel supports passing the XFRMA_SA_PCPU attribute when creating
> a state (via NEWSA or ALLOCSPI). Add a "pcpu-num" argument, and print
> XFRMA_SA_PCPU when the kernel provides it.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
>  ip/ipxfrm.c        |  6 ++++++
>  ip/xfrm_state.c    | 20 ++++++++++++++++++--
>  man/man8/ip-xfrm.8 |  4 ++++
>  3 files changed, 28 insertions(+), 2 deletions(-)
> 

...

> @@ -309,6 +309,7 @@ static int xfrm_state_modify(int cmd, unsigned int flags, int argc, char **argv)
>  	bool is_if_id_set = false;
>  	__u32 if_id = 0;
>  	__u32 tfcpad = 0;
> +	__u32 pcpu_num = -1;
>  
>  	while (argc > 0) {
>  		if (strcmp(*argv, "mode") == 0) {

...

> @@ -797,6 +805,7 @@ static int xfrm_state_allocspi(int argc, char **argv)
>  	struct xfrm_mark mark = {0, 0};
>  	struct nlmsghdr *answer;
>  	__u8 dir = 0;
> +	__u32 pcpu_num = -1;


iproute2 follows net-next with reverse xmas tree ordering. I realize
that is a bit hard for some of the code -- like ipxfrm.c.

I fixed up these 2 to that ordering at least in the local scope and
applied to iproute2-next

