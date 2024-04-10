Return-Path: <netdev+bounces-86578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A053789F3A2
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 15:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F181C26FEF
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 13:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF47159571;
	Wed, 10 Apr 2024 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N6lr7Zu5"
X-Original-To: netdev@vger.kernel.org
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95186158D6B
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712754425; cv=none; b=KPhjlc5Lz6QyxEVdHEwSIoGOJ26lrCZTAvcLQLHGkq7c6LvSKMEBSRB+bELHadzhTmKNqTkNo89PXzZuo6VYviQr/w7h91/FVjKIdWL094J7OJ2556TknujGeplk4wOWFXvQ7zrzoENiV+q17mFa6kQYG1L3584YTgfLV62gaDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712754425; c=relaxed/simple;
	bh=1RdXe49Nr0BUfBhxAxoB7xhhanmGSXEwgJBE/pVPfQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8hu7aG75n3rNe2qY8f0cxQ6vrRw7Fy2AEM3IwAD20H7DMGGbvk51bnhYAclbRsgtuEcKAsTbznHJdo2KvWjNgj1fJShbZVpMgkZPiRo9hep22e38pEMGl9//pxYfeSLCy8Xrwfe8EfJOOzMdOdug5ooVlLqBMYKeo4BX5Evfy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N6lr7Zu5; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id DB3E0180007F;
	Wed, 10 Apr 2024 09:07:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 Apr 2024 09:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712754421; x=1712840821; bh=q9OoP9Jwkq14R8q4sz0FIVc+xvHD
	l0XslUKBvsyra+I=; b=N6lr7Zu5AP1q/o+4KpXhcOWBvzFIzc3t0uaPWhHwXJxi
	S0z0sJSg+Wkh4iKw0FwtkAYCQrUy32AleaZcoUWRI3YeVIEbG1Rmrw/VHjL0lNg3
	FMQTCwf+aGzZnI+UKq3plFcb1tI57HAOEz020KlI5snT+gVpRn4LT1UEbzRulDMC
	vi4aLyUBjbih2GSFdZT9c85GrFqJrzChRWbYWYenv+LZcVoFHgVtHIsah3ZXqj2n
	8rdd5BYxqukwTllDk9rdt6MdjSTJ0REPxjFwulYQe035cr1EDT2S34HW3WvesJ6q
	zhcAkeZCHvanWNw/5GU/fv+cmby2n84s/JBw0KF6Pw==
X-ME-Sender: <xms:9I4WZqyaAPHxFb3i9aK4SNzVmRvk2dILR3XdwlAHX5brop0k9Tpg0w>
    <xme:9I4WZmR_vi6y0n_yBUEyhunJeYqNF6iRXRGei3QWGIJ0hNV57R3dh-oTnVUECE-1b
    y8aIWqIMDDKXJk>
X-ME-Received: <xmr:9I4WZsVtIC2D94DexU559jaw9wMszel1PLSmGXFJJzdEwQaEeS2OU8CRGXfF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehiedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihgu
    ohhstghhrdhorhhgqeenucggtffrrghtthgvrhhnpefhffejgefhjeehjeevheevhfetve
    evfefgueduueeivdeijeeihfegheeljefgueenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:9I4WZggn7aWeG8vb7iia-m4baa0be4l2AJ2NwwK7mcAos1LH9yH9VA>
    <xmx:9I4WZsCSrt5wRxMmciQ5vnqs0au4bZ95MWFQFf2tHF-FR5efaeqJpg>
    <xmx:9I4WZhKYE_JktiR6hFxyfb8yMAiDrpmov7SgTf6UyXwrdgOJgUQR6Q>
    <xmx:9I4WZjB9LeypsXvCmeVbmRIWkZ6Jyd33AbDJC72nFDLErrFXlxhLlA>
    <xmx:9Y4WZssZOsi0EL5NxAyfqifc4pjhMNbOx0G9qNXV26tKtq9-0zDBVkkO>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Apr 2024 09:06:59 -0400 (EDT)
Date: Wed, 10 Apr 2024 16:06:57 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
	cmi@nvidia.com, yotam.gi@gmail.com, i.maximets@ovn.org,
	aconole@redhat.com, echaudro@redhat.com, horms@kernel.org
Subject: Re: [RFC net-next v2 2/5] net: psample: add multicast filtering on
 group_id
Message-ID: <ZhaO8bOQ6Bm0Uh1H@shredder>
References: <20240408125753.470419-1-amorenoz@redhat.com>
 <20240408125753.470419-3-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408125753.470419-3-amorenoz@redhat.com>

On Mon, Apr 08, 2024 at 02:57:41PM +0200, Adrian Moreno wrote:
> Packet samples can come from several places (e.g: different tc sample
> actions), typically using the sample group (PSAMPLE_ATTR_SAMPLE_GROUP)
> to differentiate them.
> 
> Likewise, sample consumers that listen on the multicast group may only
> be interested on a single group. However, they are currently forced to
> receive all samples and discard the ones that are not relevant, causing
> unnecessary overhead.
> 
> Allow users to filter on the desired group_id by adding a new command
> SAMPLE_FILTER_SET that can be used to pass the desired group id.
> Store this filter on the per-socket private pointer and use it for
> filtering multicasted samples.

Did you consider using BPF for this type of filtering instead of new
uAPI?

See example here:
https://github.com/Mellanox/libpsample/blob/master/src/psample.c#L290

