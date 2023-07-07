Return-Path: <netdev+bounces-15946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B41474A8D3
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 04:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17745280DD9
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 02:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B3A1114;
	Fri,  7 Jul 2023 02:17:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FFD7F
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 02:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C49C433C7;
	Fri,  7 Jul 2023 02:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688696232;
	bh=JnxhhM1caNPNzvpuk3DMvL0aLRLKS2KlkCHyZiudBO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vqay8oFiTH0Ojp3oVDNTOMv6XuO+B8YQhtFb8ejQ+ry9IUyvIC2jhYPQ4RgnsEy/m
	 mqlLbd5+27Z4Pw2GYhXqdTLOD4vZy8kTZgO1yn6AYqIezWM7I0XUVzzQK1k0HpR2XG
	 DpJW6Rixb5aEaWd6MWvVaScd7BEz6DJRmG08SeZlcQD8sC/bqYhzhT3jr0p+pNTkZ5
	 97ksk5nEk8YvKSX5pHM0PMi9nvQzkXYS8jsu8OXS4bhw5VYfqF4+FgighSbHNEavND
	 KLkdEVqegiQltcw7YfqqcQb1q59LPSKSRxaYthDpdWpfG478QOCHwW7HPOk3e2zYFI
	 jqvN0hUyCEDKg==
Date: Thu, 6 Jul 2023 19:17:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Babrou <ivan@cloudflare.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, Satoru
 Moriya <satoru.moriya@hds.com>
Subject: Re: [PATCH] udp6: add a missing call into udp_fail_queue_rcv_skb
 tracepoint
Message-ID: <20230706191710.5f071724@kernel.org>
In-Reply-To: <20230706172237.28341-1-ivan@cloudflare.com>
References: <20230706172237.28341-1-ivan@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jul 2023 10:22:36 -0700 Ivan Babrou wrote:
> The tracepoint has existed for 12 years, but it only covered udp
> over the legacy IPv4 protocol. Having it enabled for udp6 removes
> the unnecessary difference in error visibility.
> 
> Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
> Fixes: 296f7ea75b45 ("udp: add tracepoints for queueing skb to rcvbuf")

Doesn't build when IPv6=m, you need to export the tp?
-- 
pw-bot: cr

