Return-Path: <netdev+bounces-22932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B12F76A15A
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 21:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B8E2814CA
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 19:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91CB1DDD6;
	Mon, 31 Jul 2023 19:36:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7801D30C
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 19:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC79C433C7;
	Mon, 31 Jul 2023 19:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690832213;
	bh=QHremozRgras0jBGVE8EI63R/anSr3lXh+72wRtF/Ew=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T2oJKwPTIrEoFDSCZxrVjjmRv/Y0IifkHBkL0PJ2T7ZsMGV4JaK2nL97YypUeErI2
	 6DcK+f4+9dLtgpp/RkFN7e275PmTr7di67GC/iWSrzigGsJwcsnW4S3XJK4+ys6Stc
	 kyy9g3q1ZMNTYzEyMUwZL4lSnCdZ9uQ8sd8Vod7+/pZyGglFmH56jzWeQpg1qd1KYZ
	 yPopvAC5pe8FV2Cfr0rMRkYH4OLt9rXkRi2h67lqDICA52a/p1nO6onPBD2pAdtDrL
	 wdecsVb8+hbM2Btk0Foi8rhheS44nx8yAG3VMnZBgDFaHndbz9PaWTNq6gHRJeE2Sm
	 2f2zjT8O5llqA==
Date: Mon, 31 Jul 2023 12:36:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v1 3/9] netdev-genl: spec: Extend netdev
 netlink spec in YAML for NAPI
Message-ID: <20230731123651.45b33c89@kernel.org>
In-Reply-To: <169059162756.3736.16797255590375805440.stgit@anambiarhost.jf.intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
	<169059162756.3736.16797255590375805440.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Jul 2023 17:47:07 -0700 Amritha Nambiar wrote:
> +  -
> +    name: napi
> +    attributes:
> +      -
> +        name: ifindex
> +        doc: netdev ifindex
> +        type: u32
> +        checks:
> +          min: 1
> +      -
> +        name: napi-info
> +        doc: napi information such as napi-id, napi queues etc.
> +        type: nest
> +        multi-attr: true
> +        nested-attributes: napi-info-entry

Every NAPI instance should be dumped as a separate object. We can
implemented filtered dump to get NAPIs of a single netdev.

