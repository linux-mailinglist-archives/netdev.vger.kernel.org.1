Return-Path: <netdev+bounces-40114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6967C5D0F
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 20:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F56E1C20DFA
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A134A3A26B;
	Wed, 11 Oct 2023 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OghFLr2J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3C3A265
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 18:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA65C433C8;
	Wed, 11 Oct 2023 18:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697050354;
	bh=v0JEp1Ts/zuN8xlWxWz2EnmwAxvgi36+m6P6P4BehQk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OghFLr2Jkqc+FgNmt4OaSjrmOI2qZ7CAWVltzpzfPEy4jzjerwstjCAkSe81ieRB0
	 wxQT7MFTQxTdK8xgEv45jZ5i5qVb9wfRkFmpCfmxs81lkfFXoO5+EVBVBitoQuzbpG
	 GZuJzCG5QNQ+fUhQUtQmL1dQ/oUeLj/0X5qHGPzeqDVLGpMc/wrufGG4d5Z3fJUqSk
	 YaOMX6MHhAcUV0Zb5dPA+tUMJRV5rV8ExZiT6CReNOgEcdQKL/PgEooArPxeTYSkel
	 eSmiTJp0OPNuT6qqIS3eUfhZTM0u03zjdtmbWQ/VEiiV8H18l530eq8B0paYL3b/IK
	 CFrjTgIiu/qCw==
Message-ID: <a1840176-2ed6-33b4-dc6e-0bc98055910b@kernel.org>
Date: Wed, 11 Oct 2023 12:52:34 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 4/7] ipv4: use tunnel flow flags for tunnel route
 lookups
Content-Language: en-US
To: Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Guillaume Nault <gnault@redhat.com>, linux-kernel@vger.kernel.org
References: <20231009082059.2500217-1-b.galvani@gmail.com>
 <20231009082059.2500217-5-b.galvani@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231009082059.2500217-5-b.galvani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/23 2:20 AM, Beniamino Galvani wrote:
> Commit 451ef36bd229 ("ip_tunnels: Add new flow flags field to
> ip_tunnel_key") added a new field to struct ip_tunnel_key to control
> route lookups. Currently the flag is used by vxlan and geneve tunnels;
> use it also in udp_tunnel_dst_lookup() so that it affects all tunnel
> types relying on this function.
> 
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  net/ipv4/udp_tunnel_core.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



