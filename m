Return-Path: <netdev+bounces-23403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B7B76BD16
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 20:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92191C21000
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 18:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC31A235BF;
	Tue,  1 Aug 2023 18:56:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD14200AC
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 18:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0EFC433C8;
	Tue,  1 Aug 2023 18:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690916217;
	bh=/woh+fpgzpYP23nOcfCiiFS95fpdJHnVCbp/LzuFDyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gs4NY7IxervyPq04k/qxc7d4ZJZW2PCeTzxca3KF6EESXgC7bpNVCe09+K9ce/6RA
	 wiAoKHB+MtjgtnI7r80V5CceNugT/7OSOBpSqwky2AivCqX4INGjwU0Zp7o0iwv/J2
	 g/ygksWbz7glFvIDPg47oeqhAvc85hbpYGlNJE5+MbKe/ePyba0CfDHAdDLtC853yk
	 m4KiDmhxNyDD8s+xsHhDn2sAlIJcWPi1SQ/lxMqRd7aIbyDC1npPcmzHf2YbNolPFT
	 dmWA3JLI2wXnK8G0YuAuZx+c8dCpRQctc++wafkYHzX1J4aK1+KpFNbUNFiurbDze+
	 ospp+imcP9VUQ==
Date: Tue, 1 Aug 2023 11:56:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
 idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next 4/8] devlink: add split ops generated according
 to spec
Message-ID: <20230801115655.296b3d28@kernel.org>
In-Reply-To: <20230801141907.816280-5-jiri@resnulli.us>
References: <20230801141907.816280-1-jiri@resnulli.us>
	<20230801141907.816280-5-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Aug 2023 16:19:03 +0200 Jiri Pirko wrote:
> Improve the existing devlink spec in order to serve as a source fot

s/fot/for/

> generation of valid devlink split ops for the existing commands.
> Add the generated sources.

> +/* DEVLINK_CMD_GET - do */
> +const struct nla_policy devlink_get_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
> +	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
> +	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
> +};

What's the impact of narrowing down the policies? Could you describe it
in the commit message?

