Return-Path: <netdev+bounces-14454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C9A7419F3
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 22:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181D31C20852
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 20:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87AF10976;
	Wed, 28 Jun 2023 20:59:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF23D532
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 20:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5E3C433C8;
	Wed, 28 Jun 2023 20:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687985964;
	bh=268wM+miOtbHzesFJqGulFJ5OyYug6qB6rPqiW9YoLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kPPPe1cfJMGqhi/vyBh+K0owLAs735YaFlrv2pmMJj480m12deFoOlsE5Z5kAgYbd
	 P9nXH4jOjxE+NW3MWnCVLJMyAIo98BC1tiIsBcf4hHahgGYsT61YJ0PolVTScUQUWC
	 EO6heteS4+3oYi3JL2/4UMKYtDp/vWMTS8K+3oiapIVtJyAckoFyGgE9SHnSa0lUgv
	 THHAgg3drNPqYmbx8+UeqXgz/nU/+ThoUfR0ImyfTLZR2kbEmS0OT2Of5KmESvLBjv
	 z8XomYvTpfEA0aelk1XOALPv2HU9mqzGoE1hMh4H8oUHFtaewvW3x+IyDTNCzyX8S5
	 xCo+sN9fewowQ==
Date: Wed, 28 Jun 2023 13:59:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <simon.horman@corigine.com>, Yinjun Zhang
 <yinjun.zhang@corigine.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net] nfp: clean mc addresses in application firmware
 when driver exits
Message-ID: <20230628135922.2e01db94@kernel.org>
In-Reply-To: <20230628093228.12388-1-louis.peens@corigine.com>
References: <20230628093228.12388-1-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jun 2023 11:32:28 +0200 Louis Peens wrote:
> The configured mc addresses are not removed from application firmware
> when driver exits. This will cause resource leak when repeatedly
> creating and destroying VFs.

I think the justification is somewhat questionable, too.
VF is by definition not trusted. Does FLR not clean up the resources?

