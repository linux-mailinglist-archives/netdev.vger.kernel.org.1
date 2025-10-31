Return-Path: <netdev+bounces-234770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 220D8C27126
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 22:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB6474E2295
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 21:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94612311C05;
	Fri, 31 Oct 2025 21:46:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E2311969;
	Fri, 31 Oct 2025 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761947182; cv=none; b=UlC61vL4/cHTMCsx7Oj+dlRa/j2gcImGW5Ue4E0L/xUKBi6T4R5pSMIBncJAI1DWwqmr90tlOs3814ZeCpo1D96fSFxCVvOlOvEZ0Vvn4mlDa/nr1m+j34pdTO8JpS2WX8IxqOZWytAlAh+Js2IPruwpjrWn5a1oBcyMNmq+1kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761947182; c=relaxed/simple;
	bh=kGRCeCTwBu75yr3tcWy7SGS5hUJuS9Kx8L7XTs320cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdsA6xSyZIqcJzD48lN83ttfNUMQkCMZEFqqBUxEt1uISBto2rJ+h0Uz0ygo0X+sLOAnFB5Ku9qX8Z1aFUZWE99fLMyZueioUTIeGd/du4Fx5sNrZLBAe3D/6o3EUQRw8TK9xQ1UtBYXap6J4DdQAjj5D5TGH9esIR5mVLwoLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vEwwo-000000006TW-0Tkg;
	Fri, 31 Oct 2025 21:46:14 +0000
Date: Fri, 31 Oct 2025 21:46:06 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "olteanv@gmail.com" <olteanv@gmail.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"robh@kernel.org" <robh@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"horms@kernel.org" <horms@kernel.org>,
	"hauke@hauke-m.de" <hauke@hauke-m.de>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"lxu@maxlinear.com" <lxu@maxlinear.com>,
	"john@phrozen.org" <john@phrozen.org>,
	"yweng@maxlinear.com" <yweng@maxlinear.com>,
	"bxu@maxlinear.com" <bxu@maxlinear.com>,
	"fchan@maxlinear.com" <fchan@maxlinear.com>,
	"ajayaraman@maxlinear.com" <ajayaraman@maxlinear.com>,
	"jpovazanec@maxlinear.com" <jpovazanec@maxlinear.com>
Subject: Re: [PATCH net-next v5 12/12] net: dsa: add driver for MaxLinear
 GSW1xx switch family
Message-ID: <aQUuHjhWSJgYsTEn@makrotopia.org>
References: <cover.1761823194.git.daniel@makrotopia.org>
 <229278f2a02ac2b145f425f282f5a84d07475021.1761823194.git.daniel@makrotopia.org>
 <3945b89128c71d2d0c9bda3a2d927f3c53b50c87.camel@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3945b89128c71d2d0c9bda3a2d927f3c53b50c87.camel@siemens.com>

On Thu, Oct 30, 2025 at 11:11:38PM +0000, Sverdlin, Alexander wrote:
> [...]
> For some reason with both v4 and v5 I can reliably reproduce the following
> warning (ASSERT_RTNL()) at the very beginning of
> drivers/net/dsa/local_termination.sh selftest:
> 
> RTNL: assertion failed at git/net/core/dev.c (9480)
> WARNING: CPU: 1 PID: 529 at git/net/core/dev.c:9480 __dev_set_promiscuity+0x174/0x188
> CPU: 1 UID: 996 PID: 529 Comm: systemd-resolve Tainted: G           O        6.18.0-rc2+gite9079300094d #1 PREEMPT 
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __dev_set_promiscuity+0x174/0x188
> lr : __dev_set_promiscuity+0x174/0x188
> Call trace:
>  __dev_set_promiscuity+0x174/0x188 (P)
>  __dev_set_rx_mode+0xa0/0xb0
>  dev_mc_del+0x94/0xc0
>  igmp6_group_dropped+0x124/0x410
>  __ipv6_dev_mc_dec+0x108/0x168
>  __ipv6_sock_mc_drop+0x64/0x188
>  ipv6_sock_mc_drop+0x140/0x170
>  do_ipv6_setsockopt+0x1408/0x1828
>  ipv6_setsockopt+0x64/0xf8
>  udpv6_setsockopt+0x28/0x58
>  sock_common_setsockopt+0x24/0x38
>  do_sock_setsockopt+0x78/0x158
>  __sys_setsockopt+0x88/0x110
>  __arm64_sys_setsockopt+0x30/0x48
>  invoke_syscall+0x50/0x120
>  el0_svc_common.constprop.0+0xc8/0xf0
>  do_el0_svc+0x24/0x38
>  el0_svc+0x50/0x2b0
>  el0t_64_sync_handler+0xa0/0xe8
>  el0t_64_sync+0x198/0x1a0
> 
> (testing with GSW145)
> I'm not sure though, if it's related to the gsw1xx code, am65-cpsw-nuss driver
> on my CPU port or if it's a fresh regression in net-next...
> 
> I can see the above splat if I apply the patchset onto bfe62db5422b1a5f25752bd0877a097d436d876d
> but not with older patchset on top of e90576829ce47a46838685153494bc12cd1bc333.
> 
> I'll try to bisect the underlying net-next...

Did you try to rebase the patches necessary for the GSW145 on top of the
last known-to-work net-next commit?

Also note that I've successfully tested local_termination.sh on top
of ea7d0d60ebc9bddf3ad768557dfa1495bc032bf6, but using the modified
RaspberryPi 4B provided by MaxLinear, so there obviously is a different
Ethernet driver on the CPU port...

