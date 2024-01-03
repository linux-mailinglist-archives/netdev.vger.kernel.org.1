Return-Path: <netdev+bounces-61331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A32182370B
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 22:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0724E1F24795
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 21:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812771D697;
	Wed,  3 Jan 2024 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNz1J5y6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6854C1D692
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 21:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1C8C433C8;
	Wed,  3 Jan 2024 21:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704316881;
	bh=j2GsGYKWsaSxhYuoTam9MNoYKfLDI3BcLk4yzdf4Ke8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WNz1J5y67YCxZwqC7tNYuL+uG+DCO+w0qNvDnM1CPf9IF3EQiBMtourds2xXyQ5Na
	 +iTemWeg7Ikq+zXU1ojg7Syxw1VAu3v76faUA8ahoPc/Je6iAND+4OD6E42oeVfe+W
	 0YhDxJlB6H6Y6UH4V1AXhyyhuHX14muudQfWilfr9E/oCyl5PC98PWHbxDBHGckaw+
	 ml0oMrINUdTAtDloVEuRRoafGnwzekr+UcS6havFNrmY0d+L3eusQoKvKTxWWDtJ71
	 LenP8/sDucfjjfIZisdpEyuLcsFGT5iJRKYvfAUp82llk+ITFX/GIliOcBKwIpg9Z1
	 39CHvue1p0CHw==
Date: Wed, 3 Jan 2024 13:21:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Phil Sutter <phil@nwl.cc>, David Ahern
 <dsahern@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] selftests: rtnetlink: check enslaving iface
 in a bond
Message-ID: <20240103132120.2cace255@kernel.org>
In-Reply-To: <0aa87eb2-b50d-4ae8-81ce-af7a52813e6a@6wind.com>
References: <20240103094846.2397083-1-nicolas.dichtel@6wind.com>
	<20240103094846.2397083-3-nicolas.dichtel@6wind.com>
	<ZZVaVloICZPf8jiK@Laptop-X1>
	<0aa87eb2-b50d-4ae8-81ce-af7a52813e6a@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jan 2024 15:15:33 +0100 Nicolas Dichtel wrote:
> > The net-next added new function setup_ns in lib.sh and converted all hard code
> > netns setup. I think It may be good to post this patch set to net-next
> > to reduce future merge conflicts.  
> 
> The first patch is for net. I can post the second one to net-next if it eases
> the merge.
> 
> > Jakub, Paolo, please correct me if we can't post fixes to net-next.  
>
> Please, let me know if I should target net-next for the second patch.

Looks like the patch applies to net-next, so hopefully there won't 
be any actual conflicts. But it'd be good to follow up and refactor
it in net-next once net gets merged in. As long as I'm not missing
anything - up to you - I'm fine with either sending the test to
net-next like Hangbin suggests, or following up in net-next to use
setup_ns.

