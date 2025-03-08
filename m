Return-Path: <netdev+bounces-173127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C671CA577C1
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C53CA3B2235
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 02:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3756214D2B7;
	Sat,  8 Mar 2025 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhLr56rB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5B014A0A8;
	Sat,  8 Mar 2025 02:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741402744; cv=none; b=WwsL7/lzfE4VC0iAkNJp0gITMv1LUkAryF9m+MC9tWYahY2k76NHn0CazujDE/6VZTrkEAGRMyELBEhgnyfQatgMTE3mtABbpAjcJmF8v94M7FwVhVIy0unCAUI1McpKe3km7H4/FSvei0Ey3ncPERWElzynU4yzMFvWmOVgpTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741402744; c=relaxed/simple;
	bh=VpVgfZqL5pCD8VMIpfO//WgO/NgRuraRLNPhr0ucINg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdsCFdGH5Bpz1feYBVEygphUoUireUTX9+AtDVMym7ARmNxk6hkPcRRXx5xjSqxf0V/LB9C5i3hpR3JhKUXm5NtDagzO+3ksR/1VJilY6r1Dfm2b8a0Qp33i92oDC468e+EX8r1Nw47MhrppfDy00VQR/Uk6+v8tGX/w0p85Ts4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhLr56rB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FD8C4CED1;
	Sat,  8 Mar 2025 02:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741402743;
	bh=VpVgfZqL5pCD8VMIpfO//WgO/NgRuraRLNPhr0ucINg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qhLr56rB5CiqISw9E8FY/8/pkE4H1Kap65yRwfrQjaXE4GKKw5lv7TVmR7y+ppdkm
	 FgOanKxGp4MTHSc8nfMzxrj6FLlgMjFc2zmOP5u6k77tZ36jQXVlHuH0+kNKbrZLfC
	 FJR8HNf8CAITOfIhUkXaq0mew8fo9S9YWEYHqZ4CeqJTprTWbcrDJeaSJRM59zgk/r
	 vIxYIJEmmRa6q2zdHVf3YHpw13tHVbdXOlBEasZOTRC/Tk1IvrpbCaT3ivLydXsyzR
	 R5ZfprFRxepAtpOL/2gAobeDmgCHGOoi8aO1hfPbExbp2yxoKEPpLUF6reTwcbK5HC
	 /ozmbhctbWRPA==
Date: Fri, 7 Mar 2025 18:59:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "christophe.leroy@csgroup.eu"
 <christophe.leroy@csgroup.eu>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "imx@lists.linux.dev"
 <imx@lists.linux.dev>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 net-next 01/13] net: enetc: add initial netc-lib
 driver to support NTMP
Message-ID: <20250307185902.384554a5@kernel.org>
In-Reply-To: <PAXPR04MB8510771650890E8B7395B2DA88D42@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250304072201.1332603-1-wei.fang@nxp.com>
	<20250304072201.1332603-2-wei.fang@nxp.com>
	<20250306142842.476db52c@kernel.org>
	<PAXPR04MB85107A1E5990FBB63F12C3B888D52@PAXPR04MB8510.eurprd04.prod.outlook.com>
	<PAXPR04MB8510771650890E8B7395B2DA88D42@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Mar 2025 02:05:35 +0000 Wei Fang wrote:
> > > On Tue,  4 Mar 2025 15:21:49 +0800 Wei Fang wrote:  
> > hm..., there are some interfaces of netc-lib are used in common .c files
> > in downstream, so I used "ifdef" in downstream. Now for the upstream,
> > I'm going to separate them from the common .c files. So yes, we can
> > remove it now.  
> 
> Sorry, I misread the header file. The ifdef in ntmp.h is needed because
> the interfaces in this header file will be used by the enetc-core and
> enetc-vf drivers. For the ENETC v1 (LS1028A platform), it will not select
> NXP_NETC_LIB.

Meaning FSL_ENETC ? And the calls are in FSL_ENETC_CORE ?

