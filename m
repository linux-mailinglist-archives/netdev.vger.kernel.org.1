Return-Path: <netdev+bounces-149973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCC39E85BA
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 16:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 920361882CA4
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 15:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C0F43AB9;
	Sun,  8 Dec 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fztLzeQ2"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C79B1E515;
	Sun,  8 Dec 2024 15:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733670557; cv=none; b=PcAmw3uWIUc9nHuXjKG6w0xse2jCb39hhGl8IJES+F+x7rPR4lufssQQzrJajAKeTOFaZbDEc8n9Fhg3FdurCR0ZLs0GxeFeZ0ua3v0P/7/KJAD6i85YjoglDVZneJ1DDysJb7Sw5llYIrnF8szQO6Zhh9I1eSIEJ5p91TwbDf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733670557; c=relaxed/simple;
	bh=0/24tb5J5ZhpVmnerobC8TCw5uPq4OQXR25zSLmdD70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LdVnxUM//3Zg7yXzVuFR5+FrFAJx/Gm5Af3iM+wsVNtjWNR7AQ0QYQMbkVH4xM7xRjKclYLj+TofrvnAAOBZZvZDH9Pn/n72ZPck9X61XUEcK/GSvEhSvXhcuY4pmQ679diPNkFO0Cx38iCf5gCFFU2adzgr3QlAw5syxwcCeHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fztLzeQ2; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 59B7C13838E6;
	Sun,  8 Dec 2024 10:09:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Sun, 08 Dec 2024 10:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733670554; x=1733756954; bh=vQ0fUrvfmSwHGUIm0t5bIdaTbvcjvBrQHDH
	gjP/z5gk=; b=fztLzeQ2iSEguxwlTQL/dO/rjzZP/vvUPzkj5Nbkkz+xnFQEdFq
	dnG7NlgVuX7kEG7ilKdgJYoiKi5VDqE1HJgiMGvAIx8fUPIBUAWbjKOVcfa71OPW
	qM3z28yWapYWrKF0ThLhHtzswjhYFIj+WZ1xplhgnWPSUQX56oSTZNttF0UqkKjs
	N6kfcYDEzr2TLs14G6DfdPoK8cSbAkQThP1u2yaGA6QKWAzP4MSS6wRgD7bHwAUi
	+omGafcnJtXDFg940oNb99HxTbcP+rWUBxEDgtu36MGFRYwVtQXvbxVpDhmMxb6L
	CfjV6Gbo+dsn27ziCdiAMgH7bOtMgN7DtPw==
X-ME-Sender: <xms:mbZVZ3KH4ZNlr4KszFswctL3fgmLCXDUdf7I0wSWPZlBSWfwKCZ52Q>
    <xme:mbZVZ7IzxZcajYx5V8J1tTrsE_xCXAygPKucCLV_2Dg3uQ577FH5UO_KTEh311zOG
    nHBgfnHdOatsHw>
X-ME-Received: <xmr:mbZVZ_tG4ca5F1cSJwNsZ6tSufoajT5sYH12gomO1IcweRVymdsNlvq6TIRO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeefgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorh
    hgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefg
    leekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthho
    pedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepfigvihdrfhgrnhhgsehngi
    hprdgtohhmpdhrtghpthhtoheptghlrghuughiuhdrmhgrnhhoihhlsehngihprdgtohhm
    pdhrtghpthhtohepvhhlrgguihhmihhrrdholhhtvggrnhesnhigphdrtghomhdprhgtph
    htthhopeigihgrohhnihhnghdrfigrnhhgsehngihprdgtohhmpdhrtghpthhtoheprghn
    ughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurg
    hvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepph
    grsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:mbZVZwYn-HGtpe1O8smjfG7xkg6J03zuegDBlLehaEYI6xUXYtAK2A>
    <xmx:mbZVZ-bFg-ODKBTwYAKxb5WJ4jSzQMYqDXL6QIzsxQL-eUmcTksNXA>
    <xmx:mbZVZ0CD1qe1jNVxGrungQpdB1EJYkKOy5MPbRLKIjr81OMccvwZRg>
    <xmx:mbZVZ8bz3iFu7bzIm87LOAZY_SmioxlqOBC2Xa_5lNR8WZXKoi-KzQ>
    <xmx:mrZVZ6Rx57OgYC9GcsEeSLG9_W910dgH0uZ99qYqrQ1_EZO6vyBO20ZX>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Dec 2024 10:09:13 -0500 (EST)
Date: Sun, 8 Dec 2024 17:09:10 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, frank.li@nxp.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v6 RESEND net-next 5/5] net: enetc: add UDP segmentation
 offload support
Message-ID: <Z1W2lp5jNPqJZi4C@shredder>
References: <20241204052932.112446-1-wei.fang@nxp.com>
 <20241204052932.112446-6-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204052932.112446-6-wei.fang@nxp.com>

On Wed, Dec 04, 2024 at 01:29:32PM +0800, Wei Fang wrote:
> Set NETIF_F_GSO_UDP_L4 bit of hw_features and features because i.MX95
> enetc and LS1028A driver implements UDP segmentation.
> 
> - i.MX95 ENETC supports UDP segmentation via LSO.
> - LS1028A ENETC supports UDP segmentation since the commit 3d5b459ba0e3
> ("net: tso: add UDP segmentation support").
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
> v2: rephrase the commit message
> v3: no changes
> v4: fix typo in commit message
> v5: no changes
> v6: no changes
> ---
>  drivers/net/ethernet/freescale/enetc/enetc_pf_common.c | 6 ++++--
>  drivers/net/ethernet/freescale/enetc/enetc_vf.c        | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> index 82a67356abe4..76fc3c6fdec1 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> @@ -110,11 +110,13 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
>  			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
>  			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
> -			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> +			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
> +			    NETIF_F_GSO_UDP_L4;
>  	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
>  			 NETIF_F_HW_VLAN_CTAG_TX |
>  			 NETIF_F_HW_VLAN_CTAG_RX |
> -			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> +			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
> +			 NETIF_F_GSO_UDP_L4;
>  	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
>  			      NETIF_F_TSO | NETIF_F_TSO6;

I didn't see any wording about it in the commit message / cover letter
so I will ask: Any reason not to enable UDP segmentation offload on
upper VLAN devices by setting the feature in 'ndev->vlan_features'?

>  
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> index 63d78b2b8670..3768752b6008 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
> @@ -145,11 +145,13 @@ static void enetc_vf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
>  	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
>  			    NETIF_F_HW_VLAN_CTAG_TX |
>  			    NETIF_F_HW_VLAN_CTAG_RX |
> -			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> +			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
> +			    NETIF_F_GSO_UDP_L4;
>  	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
>  			 NETIF_F_HW_VLAN_CTAG_TX |
>  			 NETIF_F_HW_VLAN_CTAG_RX |
> -			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> +			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6 |
> +			 NETIF_F_GSO_UDP_L4;
>  	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
>  			      NETIF_F_TSO | NETIF_F_TSO6;
>  
> -- 
> 2.34.1
> 
> 

