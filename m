Return-Path: <netdev+bounces-13516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC7D73BEBE
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 21:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453A8281CBB
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 19:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959B6101EB;
	Fri, 23 Jun 2023 19:22:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D3C10780
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 19:22:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02BF6C433B8;
	Fri, 23 Jun 2023 19:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687548148;
	bh=4Id7Bv2w/qFPvn6FOLKQUaMxFRILqN6OHRKKfEwvPSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zy8jkqoLJmphVNqw6nWvN8SqVHA6G4xkT7O3PxP34HT+TY5uWLfq7zEwjyAJ+DDcl
	 hH34msTQwLNqG7FSIj8v/WFQWdaJcV8ZIyrIDcq0BYXBBT90Z4Pv1S2B1j8B2uakGw
	 cMMB1wbBHyIqEHgfMF8E2tDLzgjXLGS8kmex/pkxvFs+h9XHkWJxhQWk5KcKW4ZP0X
	 WfpZZmzcn0/YgcalFusldIjvb8DSYtiBef3wHakD2P9F9DQYd92LThORPDPActL+5v
	 w/cwE+lxEaarfJ+ivUT1bR25bW6ar3K75xlq0jTeec+rtG5AzvFG+Fucd7vai1Eg89
	 Orfb2Am2fz8dg==
Date: Fri, 23 Jun 2023 12:22:26 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Roi Dayan <roid@nvidia.com>,
	Shay Drory <shayd@nvidia.com>
Subject: Re: [net-next 11/15] net/mlx5e: E-Switch, Fix shared fdb error flow
Message-ID: <ZJXw8qzQOajjP2Sk@x130>
References: <20230622054735.46790-1-saeed@kernel.org>
 <20230622054735.46790-12-saeed@kernel.org>
 <20230622201708.12574a23@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230622201708.12574a23@kernel.org>

On 22 Jun 20:17, Jakub Kicinski wrote:
>On Wed, 21 Jun 2023 22:47:31 -0700 Saeed Mahameed wrote:
>> Fixes: 6704fef92002 ("net/mlx5: E-switch, Handle multiple master egress rules")
>
>hash should be 5e0202eb49ed on this one, could you fix that up?
>patches themselves LG

Ack, let me handle this..

Thanks!

