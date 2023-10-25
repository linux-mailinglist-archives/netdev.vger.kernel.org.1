Return-Path: <netdev+bounces-44056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCA07D5F4F
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 03:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8051C20B18
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 01:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F45136D;
	Wed, 25 Oct 2023 01:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoIyZJ1A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721F71369
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 01:02:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EB9C433C7;
	Wed, 25 Oct 2023 01:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698195773;
	bh=GIyvabBFn7psWNjtXZ4yILB4fgfbnRBDIQF7WnSoa98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aoIyZJ1ANbU6Rpjbl8GZUjRbF5hOsRkBqD3Z6621zLTw8K40flyB6O9ByJAclGclL
	 P4L5O5ugxT6WIAvcM21I77WjOVOsnI7Jg1iSWKYK2z4EmC9mBONQGy+rlE3q6Dm4gU
	 Byi7pstXJMJI2B7bCYX5QElgej013DVZNjox9rbVANZPxSiNIjTnsAqhD91AG7kY7a
	 kp9zbxgIhflkD9498JAtE8S9zUN0/sTggG1iIFMUvVzxaoQ10lGd1FMSihm5CroVf+
	 iNftDM0tyTV7/Db94/JKDHoWljyz+74vZKROk9FR0aAHtQqZljuyfi0wrbwQcEXb52
	 3FmkQAUyNQFcg==
Date: Tue, 24 Oct 2023 18:02:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>
Subject: Re: [pull request][net-next V2 00/15] mlx5 updates 2023-10-19
Message-ID: <20231024180251.2cb78de4@kernel.org>
In-Reply-To: <20231021064620.87397-1-saeed@kernel.org>
References: <20231021064620.87397-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 23:46:05 -0700 Saeed Mahameed wrote:
>   - Add missing Fixes tags

Fixes for bugs present in net need to go to net..
We are pretty strict about that, is there any context I'm missing?

