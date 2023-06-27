Return-Path: <netdev+bounces-14272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AA673FDB3
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 16:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6ADD1C20AA0
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 14:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A839C18B0D;
	Tue, 27 Jun 2023 14:21:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C3816429
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 14:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7783EC433C8;
	Tue, 27 Jun 2023 14:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687875710;
	bh=Rjb5KzOvEcNBlqAldIGXkJCYs3UeaI83KJEb4omLbqI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Yd52Vi9wTQRfvLzc71xv6C1LtVQs9bTGLIY0pzXRZuDEde0vAbr0hzSvYY//u3DGl
	 AQ6re97HPS6VK2XoYTCO2cG5sa1GWhAVrd1j1glWdt9ChbjMQIUSZZOqH3wK9cfYi0
	 P4kKpaK1/QjezOknCPlHyp/NSvRAyxzmCEV0hSsoadYA2PB4KoVn7srxZuY7p2T3ad
	 Og+AX2Nz6BAPc5LE6GNV62YX8kBkANZtwLiibjL0oco8/mnroSyxjPkCBR5bsARRXZ
	 k/106BUiYQEwg1hrfn3hfTSwNVTeHj7dv0JQ4td3j151K/S33HwefGY1s7R0O0SPgS
	 VyzKYW5434Wkg==
Message-ID: <fe5c86d1-1fd5-c717-e40c-c9cc102624ed@kernel.org>
Date: Tue, 27 Jun 2023 08:21:48 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/1] gro: decrease size of CB
Content-Language: en-US
To: Gal Pressman <gal@nvidia.com>, Richard Gobert <richardbgobert@gmail.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, aleksander.lobakin@intel.com, lixiaoyan@google.com,
 lucien.xin@gmail.com, alexanderduyck@fb.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230601160924.GA9194@debian> <20230601161407.GA9253@debian>
 <f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <f83d79d6-f8d7-a229-941a-7d7427975160@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/26/23 2:55 AM, Gal Pressman wrote:
> I believe this commit broke gro over udp tunnels.
> I'm running iperf tcp traffic over geneve interfaces and the bandwidth
> is pretty much zero.
> 

Could you add a test script to tools/testing/selftests/net? It will help
catch future regressions.


