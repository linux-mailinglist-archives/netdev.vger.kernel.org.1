Return-Path: <netdev+bounces-63296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 099A182C2B5
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 16:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C4D286285
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 15:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FDB6E2D4;
	Fri, 12 Jan 2024 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ivr9tb81"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB766EB46
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 15:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A20C433C7;
	Fri, 12 Jan 2024 15:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705073346;
	bh=+PGOXU1iU8R8zyFuy9K1uwajcygvsc791Z2T3zLpXBE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ivr9tb817aF4GrRZJDSlDHAPFuFooCikv4sBHSayWfmyzpYZf2CimFoC76LShAxXm
	 uzRZhXk7UmfEMGbx5Gj5JvKcjJ1ITNcmQtOucoTUvsX+Nkk40H7JuZl6+wqZ+tMsiO
	 ERmmESWa1WcwYYeIioAXuheCVd9ZEACLB/YkWDfYUQ092gTeuKbI+dkCV3dkikY1X6
	 EJCHJMbTF+zdkKXe+J8aCPDKFo23pOyx/r4uRfmRh6yyvdvrXq/MuoU+Bp7kQsNpHI
	 IfUTmI00BO2jua1IzjyxzApKoRYHTGRmGdw+MMz8WYFEpVvTl5jhjP8ObMfCKqW0oq
	 8RpCJ3O6aRhuQ==
Message-ID: <25fa3854-927a-4040-9942-56f36141c39b@kernel.org>
Date: Fri, 12 Jan 2024 08:29:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel support for ipv4 route with ipv6 link local as nexthop.
Content-Language: en-US
To: "Udayshankar, Daksha" <daksha.udayshankar@hpe.com>,
 "davem@davemloft.net" <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "K, Praseetha" <praseetha.k@hpe.com>,
 "Natarajan, Venkatesh (HP-Networking)" <venkatesh.natarajan@hpe.com>
References: <SJ0PR84MB14838465E04EE1E2A5C1AF12976F2@SJ0PR84MB1483.NAMPRD84.PROD.OUTLOOK.COM>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <SJ0PR84MB14838465E04EE1E2A5C1AF12976F2@SJ0PR84MB1483.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/11/24 9:57 PM, Udayshankar, Daksha wrote:
> root@Ubuntu184368:~# ip route add 23.0.2.0/24 via
> fe80::98f2:b301:4c68:507e dev eth1

via inet6 fe80::98f2:b301:4c68:507e


