Return-Path: <netdev+bounces-79572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B64C5879E8C
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 23:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2ECF1C22447
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 22:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509D7144044;
	Tue, 12 Mar 2024 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9xD7oys"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28390143753;
	Tue, 12 Mar 2024 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282265; cv=none; b=OqgSwRY73dutxkEAyAu2q8+uuO0ZG+PZixSZBxXIBM3kVOuuvvpgwvGOcJsW9wbUKTLicrxUEPfCoOzkTJJ4cuVVDdrz3reL6jIamvVmB/w5lu4VLQb/Dm3BIESx6JuUbTvreLaMFdqKfSl43r57nTqoFt/RqQdWNtcx+K1uZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282265; c=relaxed/simple;
	bh=QoZtiTsoV3GqgCkr21ApQbAdascsDI0tSqfwInYGGOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KU5iFcFJXOqjoKFjTA+IKvtzzGNz9BoauKslvVitT7LfbVnNVwPJl+ov8MG4hRW2IoOlUITp6x/ruaiqCL5YJ3FdQQeuuKVbBd2Z6xjgGGajLb3FgxZCMG0Fs+/PSfJiGj4qi96dUqnF1DydiK2zsQ1EssDA7t0XXFK79rnjD/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9xD7oys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEC0C433F1;
	Tue, 12 Mar 2024 22:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710282264;
	bh=QoZtiTsoV3GqgCkr21ApQbAdascsDI0tSqfwInYGGOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o9xD7oysCdRmT+6vHjk9jfYfhWzfNFsD7mHA/s0smcyKowHiUYtBv++CiuCt+iKqa
	 7san10UxmxBu4B2iGQOTEOoHarJakcZArvis9uEkQVv46Ieyc7pHeJ+ONEfyWQRzho
	 3tSIYPk6kLQjkZDDqoUACtM3JZtW9IyhRD505Jao6M8N4Tm2opN7NBA6hKwo5UZlCj
	 vdRVss8eyyZY95fHOEzkRlqBqhInNR9kEl3UcuxHrv/5f8X9JxZWwuwctfMah8nb2x
	 D/z/t7fkZETCUYdhSBz4gseujxqlyOBCa1gZfl7F4sJdyOwvE9JhT5OvbjI0ZCbAhu
	 8SsGgsG5QLl5Q==
Date: Tue, 12 Mar 2024 15:24:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, bpf@vger.kernel.org
Subject: Re: [GIT PULL] Networking for v6.9
Message-ID: <20240312152423.2bc2ec97@kernel.org>
In-Reply-To: <20240312042504.1835743-1-kuba@kernel.org>
References: <20240312042504.1835743-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 21:25:04 -0700 Jakub Kicinski wrote:
> I get what looks like blk-iocost deadlock when I try to run
> your current tree on real Meta servers :( So tested the PR
> merged with your tree only on QEMU and on real HW pure net-next
> without pulling in your tree.

Tested on real servers now and it looks good.

