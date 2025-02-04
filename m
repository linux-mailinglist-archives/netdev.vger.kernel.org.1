Return-Path: <netdev+bounces-162576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ED7A27432
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC020161C62
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2047D20A5E0;
	Tue,  4 Feb 2025 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VbRtB60n"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD47182B4
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738678572; cv=none; b=okUtnTUdxXZSuvbqz6MkPvFOu1dxaFIqXIz84Bn6z2YNmvdmV5AfNsoWOmgmKXmLKWStqPVXD2Ixtwem6S+OVTgaV/pfnbEkTVeODQNc5aghd0+KPIUW5hgOKECWX5iDVq1OuccVStdYbgy5Y7F3AjHF6Ek+/C4WM9bA7DIjf+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738678572; c=relaxed/simple;
	bh=AV6+9IWF6FtgfhC8Xm1p8j/tHcOkfk369ICNT/3j8f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHS/reRIFHdZBj+G5jEeYKF+I9Ly8X/PJLq+5pFuGsEEGsyB5nyXMF6kPw3PLpB4mu/u6SThSOfp6TaxvzNb+4sNJtUHwkrbt4efDohlFTukq611eU8rNVciwZQSafFI/shvdmlNafTTM4Hj+9LGaaZ7TD9+m+R+3ZJjZN6JsrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VbRtB60n; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F40325401F0;
	Tue,  4 Feb 2025 09:16:09 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 04 Feb 2025 09:16:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738678568; x=1738764968; bh=9WOlv/Y8KzKs7MKB4BHJAJkMTs/Y8SoXaf8
	016qHiJY=; b=VbRtB60nWLZ1bOZ0Nv+MLxy8y09PZciuDZObn8CrfvD77Ac2G7j
	kdff5PFGQrg6cSyeMQJ7fiosaZUX7kNxwLTSRswrZIWleJypqYGEecBwgDZw1IaS
	rHMDm9I/LGVQalEFTZTn5MwD3YKV9lWcmGcO2mTrMqzQV3VRfOnwuWPd6VMC7qw0
	xQCg2p4T8uiEwdZCsqZhAhyocPrj6h3o8iWU2kA+TYanvOBwCdyseutDorncEtLp
	Tbehd0K5gynfO/qmIwKG++TZok3abJGF3p+ycBFupvTUCE12bGfTOAU28P506ZPo
	pcbeqVz3HXhRnpcNMbq5tSutLhVyRAQGEag==
X-ME-Sender: <xms:KCGiZ21kKY8sMnMVVFcrNTH_yXVvDIQ2ZW1Hh4tUUEvLaCXbWxDBZg>
    <xme:KCGiZ5HMS4fa22tsGhexT7Fk-k5yVq0F_voaI-csZG26Qg5dlyVLR1-Pgtfw_8CRv
    FNCGKB-j1ktgJ4>
X-ME-Received: <xmr:KCGiZ-63HAAkvtpcrXPrX9ATXagSVe7QdO3ixXKPxFxwmnxJXgLTKJf1q03N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiinhhstghntghhvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
    dprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KCGiZ32QxRG1lCGB9O-eeVVgViohwwnuJqG6-hNoBl2ECMlBXBF3MQ>
    <xmx:KCGiZ5GXbua5YpyNWkskUyIZQ5KAZi_e_7tFQt7O3BkUb1C37C69dg>
    <xmx:KCGiZw9r1XH9KhmBQTzoTGtL9yMrf2pszjw_AfkqArV1MUGXFq1bTQ>
    <xmx:KCGiZ-mgf1xvQELg7eg7Biw95jONYQfqoLGT1hyBNB0nooS3zUxbXQ>
    <xmx:KCGiZ-6-HLnTjjJNqh3kwHs1kSuXuuVO5FdWcuSredXT9IIfNiOUtGI6>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Feb 2025 09:16:07 -0500 (EST)
Date: Tue, 4 Feb 2025 16:16:05 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Ted Chen <znscnchen@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 1/3] vxlan: vxlan_vs_find_vni(): Find
 vxlan_dev according to vni and remote_ip
Message-ID: <Z6IhJZR8JacO8oHk@shredder>
References: <20250201113207.107798-1-znscnchen@gmail.com>
 <20250201113400.107815-1-znscnchen@gmail.com>
 <Z59ddOmNCCIlFwm9@shredder>
 <Z6IRbns62vv7eJIg@t-dallas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6IRbns62vv7eJIg@t-dallas>

On Tue, Feb 04, 2025 at 09:09:02PM +0800, Ted Chen wrote:
> I didn't see target addresses were appended into the FDB when an unicast
> remote_ip had been configured.
> 
> e.g.
> Usually when (2)(3) are invoked, (1) is not called to configure a unicast
> remote_ip to the VTEP (though it's allowed to call (1)).
> 
> (1) ip link add vxlan42 type vxlan id 42 \
>                 local 10.0.0.1 remote 10.0.0.2 dstport 4789
> (2) bridge fdb append to 00:00:00:00:00:00 dst 10.0.0.3 dev vxlan42
> (3) bridge fdb append to 00:00:00:00:00:00 dst 10.0.0.4 dev vxlan42
> 
> So, this patch just leverages the case when remote_ip is configured in the
> VTEP to stand for P2P.
> 
> Do you think there's a better way to identify P2P more precisely?

I think it will require a new uAPI (e.g., a new VXLAN netlink attribute)
as it's a behavior change, but I really prefer not to go there when the
problem can be solved in other ways (e.g., the tc solution I mentioned
or using multiple VNIs).

