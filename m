Return-Path: <netdev+bounces-18760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23397588E9
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 01:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82ACB280FCB
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 23:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D5F17AC0;
	Tue, 18 Jul 2023 23:08:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377BFF51D
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 23:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62D3C433C8;
	Tue, 18 Jul 2023 23:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689721714;
	bh=bn5ijRiJG4Y2YvWuXD6EsMht/MZOEwbYYFnf9n9S7xA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uvUqI0BjoodLVKm5XsBD6O06YmsrwP79yoKAfinlw+xq4zwdrqzdGR1mfbN0TnSSB
	 Y2r/x6BanylDn3IXU1O92ARYl0m57YVrBO6K9VlHuWHylF31Z73VkUPnXIqjnWQAaf
	 XrQPmd1UL2DlNQXp8+vZoRH6cx6Y8NhXhj7UdSJQ076oUbZYAVvX1FHxVq6x/STZ1z
	 NpJUiNARcm6k0fKwUR1B+/BqKXanMnpv1WnkTyGN6v43b2E4yC0RyL3cLrOt59evdr
	 NtUaHjLcWnXeSSMMa5+M78leaK+c5yp5OcQt3EYtuZz4Iot657fcM7b4rOXa+pmaJz
	 66lqN50evUu1w==
Date: Tue, 18 Jul 2023 16:08:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: David Ahern <dsahern@kernel.org>, Maciej =?UTF-8?B?xbtlbmN6eWtvd3Nr?=
 =?UTF-8?B?aQ==?= <maze@google.com>, Linux Network Development Mailing List
 <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH net] ipv6 addrconf: fix bug where deleting a mngtmpaddr
 can create a new temporary address
Message-ID: <20230718160832.0caea152@kernel.org>
In-Reply-To: <7f295784-b833-479a-daf4-84e4f89ec694@kernel.org>
References: <20230712135520.743211-1-maze@google.com>
	<ca044aea-e9ee-788c-f06d-5f148382452d@kernel.org>
	<CANP3RGeR8oKQ=JfRWofb47zt9YF3FRqtemjg63C_Mn4i8R79Dg@mail.gmail.com>
	<7f295784-b833-479a-daf4-84e4f89ec694@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jul 2023 08:49:55 -0600 David Ahern wrote:
> > I did consider that and I couldn't quite convince myself that simply
> > removing "|| list_empty()" from the if statement is necessarily correct
> > (thus I went with the more obviously correct change).
> > 
> > Are you convinced dropping the || list_empty would work?
> > I assume it's there for some reason...  
> 
> I am hoping Jiri can recall why that part was added since it has the
> side effect of adding an address on a delete which should not happen.

Did we get stuck here? Jiri are you around to answer?

