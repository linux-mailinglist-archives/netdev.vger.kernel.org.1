Return-Path: <netdev+bounces-44035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F20BE7D5E79
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 00:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACAEB281844
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 22:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097B53C6AD;
	Tue, 24 Oct 2023 22:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9dL/gAw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C1B2D61E
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F98C433C7;
	Tue, 24 Oct 2023 22:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698187652;
	bh=HAxLdr6fOTWzBE+udGof8WEyotCVaBN7gbilsoGpd40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F9dL/gAwSaydT9QlsPmJnHMXWBid/YqNLEH+rJNjTeneWQVjjyrjS01I/ZB1GE6Ig
	 +2Xu9r95F1X2MYe8NLtIMrfCXxK/l7f9Sx3qiEJxBZbhc33ClplPer/ROsQWMpvHCu
	 d+025p+3qLkkD1dzJCQu97OAlnr/BVyFwHj+N+0N/slfSy/Tid3mfzIczOQIhVRa/G
	 a2t4y54mXhBreqseBjJr+7khxsqFtQ8ep5aD6sxttGsmhA/yCNu3w90JPHsyV1H62H
	 jlTykG/4IpV04FjX5TFhe4QUCqVVVMZW5MURvQJvgezosm0QXQbgPbLEKJ9boSokuS
	 xC0uO3F+DYB3A==
Date: Tue, 24 Oct 2023 15:47:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v6 05/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for NAPI
Message-ID: <20231024154731.32056d00@kernel.org>
In-Reply-To: <169811122484.59034.10508076727191737109.stgit@anambiarhost.jf.intel.com>
References: <169811096816.59034.13985871730113977096.stgit@anambiarhost.jf.intel.com>
	<169811122484.59034.10508076727191737109.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 18:33:44 -0700 Amritha Nambiar wrote:
> +    name: napi
> +    attributes:
> +      -
> +        name: ifindex
> +        doc: netdev ifindex

ifindex of the netdevice to which NAPI instance belongs.

> +        type: u32
> +        checks:
> +          min: 1
> +      -
> +        name: napi-id
> +        doc: napi id

ID of the NAPI instance.

> +        type: u32
>    -
>      name: queue
>      attributes:
> @@ -168,6 +181,23 @@ operations:
>            attributes:
>              - ifindex
>          reply: *queue-get-op
> +    -
> +      name: napi-get
> +      doc: napi information such as napi-id

Get information about NAPI instances configured on the system.

