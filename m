Return-Path: <netdev+bounces-233806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EFBC18BAA
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A49F81A23932
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 07:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E858B30FF25;
	Wed, 29 Oct 2025 07:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PseL/xc2"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E39930F803
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 07:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723556; cv=none; b=lhG0wdVf2d9Mp3DzgI1vo4/HjVMvOpFZrrAeuhzXCTUdflnQrb+V9nMVr/7WVlZt5KYzEGp4InzjPAgZ5xbDKfcBEkR94+D12t6M7kDyol1eQrAYrBwrMP2kJ3bp40dIf9v1NuGsGMlelpBNbYRH5S07GLxateodkJGQa5sjV+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723556; c=relaxed/simple;
	bh=LDCxUFs2Wb5l2tbf8t3vbu4Og2Gs5wy6yjjsqpMzZXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5DwMjNeR2wW60Eqmhz/DogBiqOCfpZ9ZepRCg9SHy41/3aiXuL1ci4QIGTxGHz3If5lJZc6TfztaD8HAv8uKdzFtChbpjWSTO5r2RC8Cl79fgGB06F33SwCn00VOzR9+DsGSFWP5r4KXYIxx82TnJZZbX/Ly7GeW8BkKDeMkrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PseL/xc2; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4082EEC037B;
	Wed, 29 Oct 2025 03:39:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 29 Oct 2025 03:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761723554; x=1761809954; bh=9W84WQ0iV7TU6/IodCkj3ymKS+1kDzInew+
	aFr//GYk=; b=PseL/xc2MHryQHplmgbKByYWapiiEYXfL3xgZBHJrhZSRJbtiNb
	GWZO2Bc7fovfuk5aELLfaIYm7dwdUZCP4jahl2BndZbif9W//flhAgJW4HZwSwn/
	E2aJxH/zKyX1M9CFF/wK4U2RCYBIVxeweczONB9KRMYVTz09W0zd+eaniPmNx+8G
	++40cK3nGBBc9uVbSxxa2tXolOeB2eHAaq+On0v4fhkyRBwVJHuqLhi0IR+mG0ld
	uLYxs4z1+vjdRJTn7D5IwvSizRPte862nrVUpp7O9IyAPrMgyRcHigZQFITEFL07
	rd8sgGwYDw+AldLYw4PYyviRxrEH1CXswZw==
X-ME-Sender: <xms:ocQBabzUMeo_q0Tp8Tnd-uGZ6j9nblmuhO0I8zpWbeeXOWr-2UcayQ>
    <xme:ocQBaV1cXNTeGRadrCndAydWGV3DLQ_zHA0FHlaO6ZTGmEikXFEEmzwF7bfRuRyV1
    nr-w1X2YkiuXcTZ7Wm__RJ3o6DelnDUnGcpVtRVYS3UlJ2gE5E>
X-ME-Received: <xmr:ocQBaY-2KLk8nX5HD6kUjlQ3DIzTyAcC3DaiizvgG_v14st9c5thUcfu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieefudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeggefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguoh
    hstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepledpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepthhonhhghhgrohessggrmhgrihgtlhhouhgurdgtohhmpd
    hrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvghrrghnsggvsehmvghllhgrnhhogidrtghomhdprhgtphhtthhopehjihhrihesmh
    gvlhhlrghnohigrdgtohhmpdhrtghpthhtohepgihihihouhdrfigrnhhgtghonhhgsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhm
    sheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtg
    homh
X-ME-Proxy: <xmx:ocQBaVrqusXXOhB3ReHhiFmYhf9vJSGRCyZTQVutB1wtN_emboRWKA>
    <xmx:ocQBaSTUmrdRy_BLnvjWV_SRAzPz0m_py8NDMHig8Qp3UVmnb-031w>
    <xmx:ocQBaYNhViKh0XDI8tqKGGyBeKjkFVKok0BJBUqpCKbE8y8whka-3Q>
    <xmx:ocQBaQgzLoLRRcnUnTAOuLEtVtOCHTA96cLqgW-HLXrKf3jMtm2dCg>
    <xmx:osQBadHjkvN9th27Ulcygsu8tqt9Ee37huncGajkuzn1YptPrq3xegjP>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Oct 2025 03:39:12 -0400 (EDT)
Date: Wed, 29 Oct 2025 09:39:11 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Eran Ben Elisha <eranbe@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: add net cookie for net device trace events
Message-ID: <aQHEn0Hrazq9aPWA@shredder>
References: <20251028043244.82288-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028043244.82288-1-tonghao@bamaicloud.com>

On Tue, Oct 28, 2025 at 12:32:44PM +0800, Tonghao Zhang wrote:
> In a multi-network card or container environment, this is needed in order
> to differentiate between trace events relating to net devices that exist
> in different network namespaces and share the same name.
> 
> for xmit_timeout trace events:
> [002] ..s1.  1838.311662: net_dev_xmit_timeout: dev=eth0 driver=virtio_net queue=10 net_cookie=3
> [007] ..s1.  1839.335650: net_dev_xmit_timeout: dev=eth0 driver=virtio_net queue=10 net_cookie=4100
> [007] ..s1.  1844.455659: net_dev_xmit_timeout: dev=eth0 driver=virtio_net queue=10 net_cookie=3
> [002] ..s1.  1850.087647: net_dev_xmit_timeout: dev=eth0 driver=virtio_net queue=10 net_cookie=3
> 
> Cc: Eran Ben Elisha <eranbe@mellanox.com>
> Cc: Jiri Pirko <jiri@mellanox.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

