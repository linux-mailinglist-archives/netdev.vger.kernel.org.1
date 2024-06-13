Return-Path: <netdev+bounces-103408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8843A907E8D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 00:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2481C21E69
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 22:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A13214C5A7;
	Thu, 13 Jun 2024 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMVj/nNv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0542214C591
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718316327; cv=none; b=nd+uKp7IR2YMiZoeuCmnVhOLp1DceT/1euNFh9LIDUP5g07EZMTUhuQKi+52rfHo3/DRfTuj181UEMsl+EmA7AX7r/bgpWPI/xZlyi5J0vWIzVpjk/TLhHxen4uPSQtULdH++wyrcpKgH5+tXbkOPGOI6TD9yecO9a5PNXY8g0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718316327; c=relaxed/simple;
	bh=DHcwGpKZjl/w/8+Rp0fwwca8FGIv0sj/nq1wsPaiRnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/th77hMa4pddvBoPamRgoqIMwxzEU88HrZVpEGqzulRiD/fH/fd7vbW6qd9batibqTpH6l3WOctHIfGju6FFvsf9r5t0yMBljcuukmOEC4zWmF+hh0lPw4SiA5XNcZ3EzTK+wGAxKdYjouGTXqw06XkVwZAdkHCxaGE5i6YOFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMVj/nNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EBE9C4AF1A;
	Thu, 13 Jun 2024 22:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718316326;
	bh=DHcwGpKZjl/w/8+Rp0fwwca8FGIv0sj/nq1wsPaiRnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OMVj/nNvM+5Nd9JruMuNDcg8mNRINOu5zUg9fLdQBetNvMVQnaio7x+y9SQgILUSm
	 l+8h099PjVhQWWoc7TgMT8cXB7RDzkR5EIZtzdbLA+3IwqPmcVy5oF6Vvj1pgsegmY
	 KQtuZ0TVoeT2ffXEP8f0cLndxHRv2BB+o4typ4oNcj0eCpp+SPtSxPnVMER8ePg5c9
	 da4Ad+ONLakJsoxIPAUmbJFIebsbVzdfJVYMJqRG7eJGROGEyV49laZ1rG/Qn2ltDz
	 n3nJy2d/za7E85LvGB/75c8MCdnZxvd7TG9Mz/MNkNM+EAyJZeG2N81sZxYZHbBnev
	 IrASjK3i1u0kA==
Date: Thu, 13 Jun 2024 15:05:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH net-next 0/6] mlx5 misc patches 2023-06-13
Message-ID: <20240613150525.1e553d10@kernel.org>
In-Reply-To: <20240613210036.1125203-1-tariqt@nvidia.com>
References: <20240613210036.1125203-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Jun 2024 00:00:30 +0300 Tariq Toukan wrote:
> This patchset contains small code cleanups and enhancements from the
> team to the mlx5 core and Eth drivers.

Looks small indeed, but fair warning - please prioritize helping Joe get
the queue stats merged. After this one we will not be taking any mlx5
-next material after qstats are in :(

