Return-Path: <netdev+bounces-40101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3217C5C54
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 20:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8031C209A4
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DE122301;
	Wed, 11 Oct 2023 18:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HasVr1m3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883321D54E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 18:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06861C433C7;
	Wed, 11 Oct 2023 18:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697050252;
	bh=UTCJ1j77RuDBtnV4MCOBXYUf1NV64XfcqaKiT9tsfcU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HasVr1m3rievP5O80exQ54SWlnPhjun+rzRSvHrDiMkaICdi7S6gPDI33ZOm8ZObq
	 +YIjdryv8NI+Ln7u/mqhE5qfBCxPVBa/pM2L45QLXJOVvKrgYAM/TNGTYiiEft3HEs
	 36EyynFja0KI0mlE2QDuTah4D4fbiI8Wn5EScgXWX3PaAZmLcsZVhgxAtRYNMJTy/z
	 HGNREPozNv4+iWiqE9QegMUm/tGIbKRPMWOyufdQoxv4UdRonWf/rwkjP7SiHDFfEY
	 ka4vNHQ7Y94zqZgkGU1MQVdMUZtbeofMDHkJn3HU8WRFE7gnPrfJmV2Ibj5MyrxnqG
	 FyEYO7yATGepQ==
Message-ID: <e175ed90-ac45-bae0-b04c-9603c8ac795d@kernel.org>
Date: Wed, 11 Oct 2023 12:50:51 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 1/7] ipv4: rename and move
 ip_route_output_tunnel()
Content-Language: en-US
To: Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Guillaume Nault <gnault@redhat.com>, linux-kernel@vger.kernel.org
References: <20231009082059.2500217-1-b.galvani@gmail.com>
 <20231009082059.2500217-2-b.galvani@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231009082059.2500217-2-b.galvani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/23 2:20 AM, Beniamino Galvani wrote:
> At the moment ip_route_output_tunnel() is used only by bareudp.
> Ideally, other UDP tunnel implementations should use it, but to do so
> the function needs to accept new parameters that are specific for UDP
> tunnels, such as the ports.
> 
> Prepare for these changes by renaming the function to
> udp_tunnel_dst_lookup() and move it to file
> net/ipv4/udp_tunnel_core.c.
> 
> Suggested-by: Guillaume Nault <gnault@redhat.com>
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>  drivers/net/bareudp.c      |  8 +++----
>  include/net/route.h        |  6 -----
>  include/net/udp_tunnel.h   |  6 +++++
>  net/ipv4/route.c           | 48 --------------------------------------
>  net/ipv4/udp_tunnel_core.c | 48 ++++++++++++++++++++++++++++++++++++++
>  5 files changed, 58 insertions(+), 58 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



