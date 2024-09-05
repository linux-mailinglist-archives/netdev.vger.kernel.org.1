Return-Path: <netdev+bounces-125334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D0E96CC14
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 03:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210A81C21777
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 01:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF40A802;
	Thu,  5 Sep 2024 01:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvkP3rNm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9754A1A
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 01:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498692; cv=none; b=ThvYYjDf2SCo90gIKYxmcvsPPsI82bVxOsHD91zQbVBmD9e6kPL3aoYaCUy+3ihQMuaWOs2D1ZbSs/aq7bG2cLC1i7tDRV1aQ+G3mhNSI0gRvGMPY9A+7nXVF88tIuVUbKOuq8kVvFwtHrGJCiX6WTtRMFH+gKfpUKjHUwbVR14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498692; c=relaxed/simple;
	bh=X3xofw5D6OUKfcb85NM7gRl7w7eY+mtsaWBkTppeYWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBQUYJxmYYz00S/3mh8CnUBA0e4Mv4Xxj+WNsg9A0XS3E8qWSzz+aVyuOC2HR6Oh+cH5mCZWD87QVcaY1Lt+ezJjpZBJO3rCpIAXdnk8aMYM6EOiFLNrzq2kixWgNuK5iPO7kB45HrxjctIQSWb7lO1kb4pqMF2Ztt+G+WjJmlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvkP3rNm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BDFC4CEC2;
	Thu,  5 Sep 2024 01:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725498690;
	bh=X3xofw5D6OUKfcb85NM7gRl7w7eY+mtsaWBkTppeYWE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GvkP3rNmfXXqLl5rJzteESsBJUpAN6GAxnP8FhYm15t0zP1qgeBIJnvLtiZYFkEYG
	 1CYwKwTZh5cfAS+U7UeGizvM6JETrM45HGH3z/Mk7Xrss9PgRiRoOT7xb1olyWuN5o
	 5DZcCTYH9dAjupmsHuFYVfQITSYwIiAT7+N4mim4xeVNhwHVJS7sFvHD9K4bcbrvB6
	 hx+qS3ZxBy48QWIMoNejFvvIMsJiryRysWckRsi46njqPnPqi6HS4zn3EUL0IkutYX
	 3F2AGyJ0MMIITyZOdoEy/TQqpFqEW08d4F+rGA80Qj55FixIteXYqVjV731YHjuna9
	 BjB+N5ySVtD7g==
Date: Wed, 4 Sep 2024 18:11:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, edumazet@google.com
Subject: Re: [PATCH v6 net-next 03/15] net-shapers: implement NL get
 operation
Message-ID: <20240904181129.05a55528@kernel.org>
In-Reply-To: <faecb06c4f40a2ce822cb14817879aa98dfd715d.1725457317.git.pabeni@redhat.com>
References: <cover.1725457317.git.pabeni@redhat.com>
	<faecb06c4f40a2ce822cb14817879aa98dfd715d.1725457317.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 15:53:35 +0200 Paolo Abeni wrote:
> +static int net_shaper_ctx_setup(const struct genl_info *info, int type,
> +				struct net_shaper_nl_ctx *ctx)
> +{
> +	struct net *ns = genl_info_net(info);
> +	struct net_device *dev;
> +	int ifindex;
> +
> +	memset(ctx, 0, sizeof(*ctx));

Don't think you need to memset() this?
Patch 1 touches the relevant memset()s in the core.

> +static int net_shaper_generic_pre(struct genl_info *info, int type)
> +{
> +	struct net_shaper_nl_ctx *ctx = (struct net_shaper_nl_ctx *)info->ctx;
> +	int ret;
> +
> +	BUILD_BUG_ON(sizeof(*ctx) > sizeof(info->ctx));
> +
> +	ret = net_shaper_ctx_setup(info, type, ctx);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

There seems to be no extra code here at the end of the series so:

	return net_shaper_ctx_setup(info, type, ctx);

With those nits addressed:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

