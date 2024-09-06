Return-Path: <netdev+bounces-125787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9660396E8FC
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 07:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CA30284087
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 05:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A97160DCF;
	Fri,  6 Sep 2024 05:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTWDlF/b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742BC28370
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 05:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725599437; cv=none; b=gXmxRYDpNae+vSYnI2DdItwIHLPzTlOi6VwPMxYw9c8UKSghAYK3I+joQ25S6YJrGqdrB2piBlxej2wI+p1sYzCxgfXeh5PWNQ4jqZ5fpMuF9iE64Zd4wQ4VbbS9WxCCeh2GoFIONVc+CB6qImHu464AOFfld5pW+aVB+chQzbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725599437; c=relaxed/simple;
	bh=rOJT2HdnpUPNQcgIFTZw1pH2+w8oEG01t0xLfV7spp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOi3Hsk/PPY8MXf8jxA/tDmm5boeXSOlN9pFb1SM/ichEvwGUtFlb0iuGudSeTOT7TOc6slBvmZS08vVZZTUULVsFJCSnaNNh3R47A9f6wEB8NdZrkWiXzP5p9hEUvUHxRgHK09dgONm6H0S/ROed96tQPZafIT9UsLM5kkSKEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTWDlF/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D782EC4CEC6;
	Fri,  6 Sep 2024 05:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725599436;
	bh=rOJT2HdnpUPNQcgIFTZw1pH2+w8oEG01t0xLfV7spp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LTWDlF/byP5oLZcl8ojk+mvNs2oYCHJTVO58zKumUtdYrEyH1J2g1x7jR2u+D8wm8
	 +8XRY0fik+sPmJ6DSYYxFto+98Hjud7mPqHD0nIEzOg0qP0uBdYR6cc/VDT40Dl+Ff
	 5HPAo3dhZIVzszNh2NoleHBqL3qeLluLJwPVlSQQz+jwFYz/8lve4owhGbQ5bIfHJd
	 ztI7IOygn/XheEEca2gnZjyejvGnnMhH1fgL/a5TxNUmVWRFC7Xp5h/lYeXIQHjBf8
	 bwtgTrPl2lDRHCmJ8o7+MN596WRP9SMkCbqXrUtW8YrSP6qwr+n0ENXbLA4SToHk+t
	 EXkla+f8i6sUA==
Date: Thu, 5 Sep 2024 22:10:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>
Subject: Re: [pull request][net-next V2 00/15] mlx5 updates 2024-09-02
Message-ID: <20240905221034.235c7ef8@kernel.org>
In-Reply-To: <20240905062752.10883-1-saeed@kernel.org>
References: <20240905062752.10883-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 23:27:35 -0700 Saeed Mahameed wrote:
>  - Fix sparse and checkpatch issue.

coccicheck also:

mellanox/mlx5/core/steering/hws/mlx5hws_pat_arg.c:179:2-9: WARNING opportunity for kmemdup
mellanox/mlx5/core/steering/hws/mlx5hws_definer.c:2053:11-18: WARNING opportunity for kmemdup

