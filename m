Return-Path: <netdev+bounces-106776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3D491797F
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 09:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD09E1C22E41
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 07:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F56315885E;
	Wed, 26 Jun 2024 07:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WryU+a+W"
X-Original-To: netdev@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180811847;
	Wed, 26 Jun 2024 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719386335; cv=none; b=XxcW3P7YnuvYRSNZGDPk3YA79Z7mlHrK1BWGauJPvYQEYXecBHRjJ6CNYP4uT0JSK/T6kivZW2BgnNjC5+CXcwm5jm2LA0ePBn5KZp6upKpy5f+/yjdey2jhRNrFWHhmVqlaxIIHKfkSiGJcKv4Wy/YoubyHsuqjWMmjZJpJJYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719386335; c=relaxed/simple;
	bh=cauOnyM3mpccR9Az33iL6akTiJwxBz1ku8JnGIBQNmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jz0XKVuqkeNqVikM89Oke697nCqXrBdN+uXjt5VdhxcJsJOzgy7uqUmy57eCtCtzpfcVu73g8NGHqHGbFYxOlXAOQBZbjOoMZtMQGqyDIAzqlitZZXnUb4CabflWjrANdIQNneA5RIhqxD/SQWsltEZOIANdim5EjVpzFTQLtOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WryU+a+W; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2CF1A13804AE;
	Wed, 26 Jun 2024 03:18:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 26 Jun 2024 03:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719386333; x=1719472733; bh=ZsR3tgejZcL3NaXPKlRQyIwBUNWp
	BvYb1BlpFjaZRXQ=; b=WryU+a+WdSr3DYn2QqXQAiHG69v/E8ylE5fwCb3E3Dqo
	tMmxjxrzp/+VeQvz8iDmWBBCldMRdkuQFNuq8j/7uR/cZMSl52OoFg9W+pBNY/KA
	O5rdR7f/ynKERaiqZ0dRA+4J+fGW5uKoOqBM9jmoPZb2lyXqlqzlPx9z+Kxf39Th
	2jlS8Id+cHJwTfAxCrX48u8ozZrSPxOe8wsXSu5cHZIIFKa+MQbH+iBI6FN8mDra
	KpzaK3MaqBMCsuBb1OOCWOBiW2YGCyP2g+/3LyitpaitqJY2qDfAfc5jgFyH4Kg+
	h415sqqfkJGl4MVdoVWVom4pHsqpgbvVmEnp53sBCQ==
X-ME-Sender: <xms:3MB7Zs-6-24omK1BBa_HCJ2Et5_Lym5wo5SU8lBvEdeI_NeUfpW9_A>
    <xme:3MB7ZkugzmsJ5IJtM2Ozzp1sAElRA_miKxAfO_9utHRIiqWf26Pmmue1CZBnCiy8e
    N3r4h-cMY88aeU>
X-ME-Received: <xmr:3MB7ZiD6gVGcbstuyD7hGPDVH2t3LMm5BfRhJs9_wOv_gEjM9sgspS5Pjsnt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddugdduudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:3MB7ZsercxXZWRnm1yXLKcVTJChTBzuVNdt8SVz62q3YdidvvQwFMg>
    <xmx:3MB7ZhOyTDgMrABpo8YzVOaGgH8nxz5ejkPkgQCFjOHrP32Bw6758A>
    <xmx:3MB7ZmmADwWGU6ZCoE86ahJSz9iBxo5JxHp7x_acYF9ONWtU7t8SJw>
    <xmx:3MB7ZjuUYfbBu7nFjY5KXIBUgHpdVhR7pfKelKIVbk-HhukRwHYLXw>
    <xmx:3cB7ZlkZV0NfaTyEbb9TZpA7uflEk1eCIK_IjyOMEV66-aL64EDpDA1H>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Jun 2024 03:18:52 -0400 (EDT)
Date: Wed, 26 Jun 2024 10:18:46 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
	horms@kernel.org, i.maximets@ovn.org, dev@openvswitch.org,
	Yotam Gigi <yotam.gi@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 03/10] net: psample: skip packet copy if no
 listeners
Message-ID: <ZnvA1l3dhtj9MP6X@shredder.mtl.com>
References: <20240625205204.3199050-1-amorenoz@redhat.com>
 <20240625205204.3199050-4-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625205204.3199050-4-amorenoz@redhat.com>

On Tue, Jun 25, 2024 at 10:51:46PM +0200, Adrian Moreno wrote:
> If nobody is listening on the multicast group, generating the sample,
> which involves copying packet data, seems completely unnecessary.
> 
> Return fast in this case.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

