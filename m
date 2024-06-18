Return-Path: <netdev+bounces-104656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2900290DD68
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 22:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888C628318B
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 20:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF4A16CD01;
	Tue, 18 Jun 2024 20:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HAhOwNNM"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C6739AEC;
	Tue, 18 Jun 2024 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718742319; cv=none; b=M0Y0GjwDTTU4HocxPvHyf4E8VjopoEArk0NIlcLTgf5GOnxcD0FMtzOETBQI4f1GVlMsoA4CalimWO+5LQ3ldHtgyHLMnI94Wcd/Ply4LqXdK8fLDRA2mKa96rhGzDqwnoMHoF3E4GJoNRgBK9SWoPKC48ctMMnjbaSR9BE8BV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718742319; c=relaxed/simple;
	bh=IZxDIoZGqUuy/Feqj9OJb9N0fRY1+9HWs5FNiI0ZFx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sjQJcFmq2eWKxWcMeJj3/32rm4IjHY5I+i4xdfVQZaOpBaxM9FPtA7Coo4mB+/vNuFSm4RkkI9eI2Pesm7ikonu+e/mQ+g5BWWarrcwIJxwvGY8XX9k50CIM+G4f0pG7aO0gd/xrx7E9BecH4NlpY1VgdDeR7G/bs19dopy7Dbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HAhOwNNM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=XVZG62Pc4c/mIAk0SUpARaQrk+PaEMrKlt8enmJ4Xwg=; b=HAhOwNNMonJ4x9qo6InCoNvRLL
	P2G0SHV71eeBYGIVImcMxb8ekDnPLN+zVwBI9/7lSgW1GiT2mtxUvUoh3a5xBqntX65lznBMRS7Ui
	5oY+ObH2dsP+n2/cGyb9LBcdSw5DVbs80ybhoLv2UUfuAMctwOv+H9y+M53T3DBKHjRD9TS60Be2/
	vr6QjOAiEZHl8UiMfA5UizwzrkWjtshd5uNxzbfUp31lQ1enwE9omEH7TatcoJ0uYAED3aexqegpe
	df4pgPQZfYg3VCbFo6BtNcLWvGd1W/ltLGKmidWBeiKmrZLaItY4jsevoJOARUSyLZEGgdywmDw4L
	sEQxILiA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJfOE-0000000GUkG-2ATt;
	Tue, 18 Jun 2024 20:25:14 +0000
Message-ID: <5202d7c9-69fa-4192-a196-7032a2c9abd2@infradead.org>
Date: Tue, 18 Jun 2024 13:25:13 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] docs: net: document guidance of implementing the
 SR-IOV NDOs
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 netdev-driver-reviewers@vger.kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org
References: <20240618192818.554646-1-kuba@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240618192818.554646-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

some nit editing below:

On 6/18/24 12:28 PM, Jakub Kicinski wrote:
> New drivers were prevented from adding ndo_set_vf_* callbacks
> over the last few years. This was expected to result in broader
> switchdev adoption, but seems to have had little effect.
> 
> Based on recent netdev meeting there is broad support for allowing
> adding those ops.
> 
> There is a problem with the current API supporting a limited number
> of VFs (100+, which is less than some modern HW supports).
> We can try to solve it by adding similar functionality on devlink
> ports, but that'd be another API variation to maintain.
> So a netlink attribute reshuffling is a more likely outcome.
> 
> Document the guidance, make it clear that the API is frozen.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: corbet@lwn.net
> CC: linux-doc@vger.kernel.org
> ---
>  Documentation/networking/index.rst |  1 +
>  Documentation/networking/sriov.rst | 25 +++++++++++++++++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 Documentation/networking/sriov.rst
> 
> diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
> index a6443851a142..b4b2a002f183 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -105,6 +105,7 @@ Refer to :ref:`netdev-FAQ` for a guide on netdev development process specifics.
>     seg6-sysctl
>     skbuff
>     smc-sysctl
> +   sriov
>     statistics
>     strparser
>     switchdev
> diff --git a/Documentation/networking/sriov.rst b/Documentation/networking/sriov.rst
> new file mode 100644
> index 000000000000..652ffb501e6b
> --- /dev/null
> +++ b/Documentation/networking/sriov.rst
> @@ -0,0 +1,25 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============
> +NIC SR-IOV APIs
> +===============
> +
> +Modern NICs are strongly encouraged to focus on implementing the ``switchdev``
> +model (see :ref:`switchdev`) to configure forwarding and security of SR-IOV
> +functionality.
> +
> +Legacy API
> +==========
> +
> +The old SR-IOV API is implemented in ``rtnetlink`` Netlink family as part of
> +the ``RTM_GETLINK`` and ``RTM_SETLINK`` commands. On the driver side
> +it consists of a number of ``ndo_set_vf_*`` and ``ndo_get_vf_*`` callbacks.
> +
> +Since the legacy APIs does not integrate well with the rest of the stack

                         do not

> +the API is considered frozen, no new functionality or extensions

                         frozen; no

> +will be accepted. New drivers should not implement the uncommon callbacks,

                                                                   callbacks;

> +namely the following callbacks are off limits:
> +
> + - ``ndo_get_vf_port``
> + - ``ndo_set_vf_port``
> + - ``ndo_set_vf_rss_query_en``

-- 
~Randy

