Return-Path: <netdev+bounces-91835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF878B4278
	for <lists+netdev@lfdr.de>; Sat, 27 Apr 2024 01:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B74282EED
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 23:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7193A1C4;
	Fri, 26 Apr 2024 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFrGIeyx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B0F39FCE
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714172710; cv=none; b=H45dTVXuhIxCwiDM4cCnyK/EbnuzVroZ4q+SmIOwYKJ1VpjJ0FXBG83gTDMSOK0XXnTxFHddjeeAGsPclOq9pTMdIPk8vv6vhg4UayB2tTbwVDkfQEg7IPuyPDyBE7HZRDUUKaROlu/4Gp4tfv2DGq4BWHlLYhCqMK/AiV/rZfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714172710; c=relaxed/simple;
	bh=bPAOrx8VA9MQeQzzCZ7JlumKElBzGnkj0dGsoe1U1ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ufqTKKJ2jU3yNiWpZGa33KGylN0pq8k+QKpRgxCps470uePCd1alQZhQ7k8qOJiGyVuZ/HAF+nIlcdn+x4jmnID5FMrPnCcxhxy37EQFU3gIA+sRMFq9mZyZW6UAjJi+t8TJftdjRniMQzJchDN68bQHSBEbijzaaBNLtZMp+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFrGIeyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC7FC113CD;
	Fri, 26 Apr 2024 23:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714172709;
	bh=bPAOrx8VA9MQeQzzCZ7JlumKElBzGnkj0dGsoe1U1ik=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UFrGIeyx4u8FG/JJW9TokhUrklorj8fZ3+P6HOJlScjdlVjcVWJ11xc673b1DE7Y5
	 oFDpDseGYsWeY5tnuKTtwlz0eBFTgw9cU4ekNNCssrgdL+WycpbKr0bF02Kefb0FFl
	 /ULIqaDlC/aODMSRLwppfJxvIleLXIEX5iqUnH+SJ+k8y0D4lk4+k+2/Lz45sya8Xj
	 hK17ekQsFeF9tdAKuSB7lsqFU8jADxZdpAgYyLaapM5RqqT3aOsdDPrKYDjBKdtY40
	 EZhgUAgfL6AfVTb2qWpzuhMBdCWz8XUasyfim/nq3qa7nfqGIkgBmY1zEPdenG8ozV
	 IuqeJHiqJrw2Q==
Message-ID: <4c089edf-5c06-4120-a988-556a1f7acf58@kernel.org>
Date: Fri, 26 Apr 2024 17:05:08 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ip link: hsr: Add support for passing information
 about INTERLINK device
Content-Language: en-US
To: Lukasz Majewski <lukma@denx.de>, Andrew Lunn <andrew@lunn.ch>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20240402124908.251648-1-lukma@denx.de>
 <20240426171352.2460390f@wsk>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240426171352.2460390f@wsk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/26/24 9:13 AM, Lukasz Majewski wrote:
> Hi Stephen,
> 
>> The HSR capable device can operate in two modes of operations -
>> Doubly Attached Node for HSR (DANH) and RedBOX (HSR-SAN).
>>
>> The latter one allows connection of non-HSR aware device(s) to HSR
>> network.
>> This node is called SAN (Singly Attached Network) and is connected via
>> INTERLINK network device.
>>
>> This patch adds support for passing information about the INTERLINK
>> device, so the Linux driver can properly setup it.
>>
> 
> As the HSR-SAN support patches have been already pulled to next-next, I
> would like to gentle remind about this patch.
> 

You need to re-send. It took so long for the kernel side to merge, I
marked it as waiting upstream.


