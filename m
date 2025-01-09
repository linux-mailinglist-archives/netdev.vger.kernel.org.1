Return-Path: <netdev+bounces-156816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D33AA07E66
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830253A4013
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34F3188CA9;
	Thu,  9 Jan 2025 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uF6pHOMK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF3F510
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736442592; cv=none; b=Go5ucvx3MvTcDeyEUliaq3WYTh9GRdu0XtPT5zAOlsR+ig+c9qeshtVgy93zvjRvzbbGh5Bdu0JSxnNsE7WieVo7+YQ0pMFKrsGEQd+gwl0T7+gdowZfadLzb4gr9LRMzUHjjpSfxS1Ao6chOXRKl+0LPGfuhAOk8n7BrsZkXn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736442592; c=relaxed/simple;
	bh=wwFDKMBUMxEC71EwkHq1OW2a2WzTGGWJVcWciIlv4do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sUujXBeKVyT0RUVTRrfvbnhS3id4rZm6Byik3HEdKuhc9kIRhvZLOh1eVfrVqKL9JkNmxkIxpxoDrAnVR4aLiFOh5ayFbh9XPZmtXO0lkW0j9px8pnjcvT60ZnNbQ9tyTe2WRvqf2+4/R5VAdZJT/DzVKhe1z/wBjCwf46Bv94w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uF6pHOMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E3FC4CED2;
	Thu,  9 Jan 2025 17:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736442592;
	bh=wwFDKMBUMxEC71EwkHq1OW2a2WzTGGWJVcWciIlv4do=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uF6pHOMKuhj0JRLRBF40YmbeOFR52EwqqW85s/o47DR7nSk65wl/w9O9yPxJyviwm
	 aG+UPLTFGRHIlIpJSRhIaKaOVgB82/V+FQX9YPaV9l+VtTMHCWXqWix0Z/dyv8LeE2
	 VB7NNR2jZuPMrF9a3Loi3KHltJ+LB9mDE+BggYD9oUtQXHv+sFU8QiU0/v3dXsBKUH
	 3iHW/YAFLRJBUgPS1r4WNC8QBr5eeAi2XHySYVdUb7mq+KQLV2NWrOO+A0mlq0tQMS
	 MsR0REBh7bJ3HPrh22d/jArtY2zYFzaiWNNMUWbVltWiheE55pFbwGBedATG/T1yG1
	 TX/M93BPkj30A==
Message-ID: <1e01b76a-d785-4dd7-8892-504989bfd4ce@kernel.org>
Date: Thu, 9 Jan 2025 10:09:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next, v4] netlink: support dumping IPv4 multicast
 addresses
Content-Language: en-US
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org,
 =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
 Lorenzo Colitti <lorenzo@google.com>
References: <20250109072245.2928832-1-yuyanghuang@google.com>
 <d33c8463-e3ae-46a6-a34d-ced78228c2c2@kernel.org>
 <CADXeF1F7eXj5K+rvLmRCVbi7ZoqxE8Y0b_Baqawe5P-dF8eCdw@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CADXeF1F7eXj5K+rvLmRCVbi7ZoqxE8Y0b_Baqawe5P-dF8eCdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/25 8:52 AM, Yuyang Huang wrote:
>> my comment meant that this `type` should be removed and the wrappers
>> below just call the intended function. No need for the extra layers.
> 
> Sorry, I still do not fully understand the suggestions.
> 
> In the current inet_dump_ifaddr() function, there are two places where
> in_dev_dump_addr() is called.
> 

nevermind. I forgot how IPv6 address dumps are coded, and keeping the 2
protocols aligned is best. So, I guess you just need to resolve the
failures Paolo noted.

