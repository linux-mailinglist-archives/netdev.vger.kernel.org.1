Return-Path: <netdev+bounces-69611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19E884BD8E
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 19:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E01C291B94
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 18:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965CD134BA;
	Tue,  6 Feb 2024 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0rw0Cyw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719A313FE0
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245859; cv=none; b=A5oBY9buCEMCD5IFzqti5kPvDm6Zy+wKJY1tMCNuAvm8+594YaSaX8oZISH9Ir42YwSFpMG7IA/BqOZ8WP7vgX+q/sLhJdeOS4eQg3ka7wEIQS6UymYGyi+lnGMvgFuobxHy/UNQqr/EXkKsAuZQj0IN1dMcdxENnFC6th4aESs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245859; c=relaxed/simple;
	bh=yze97PLevIR5v5XRlpkb6itN7k0C+IJTA+1uqBGxofg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gl73joL8G5n/m4CLAnejAtXj4Yh9g5IHkAYrRLkoBncRk7s1FrOMA0N8z5+8J6sobuyH8ZlWrYCpGFec9Vq92LR6gnKcXJehHiKX0NlbLfv3ebZaM5NoWwP9OE5zHrQx5KBVKxjsZQ+GaL+TU7Ucwl04kONlXQAUOiXtaj1VDqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0rw0Cyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF973C433C7;
	Tue,  6 Feb 2024 18:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707245859;
	bh=yze97PLevIR5v5XRlpkb6itN7k0C+IJTA+1uqBGxofg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F0rw0CywJvwA3cBGlQfIHZFVlwvZN+QeuP4XY56WqASoW6FGkpR8t4Wl4mqQde3Di
	 z8R91edHgliluDlQJjeoLt6uVgNwJ+AG64sAkTxDJekYm5IzTN7eBzUj2vvetaFUWH
	 YUhmWhTAyNEe5bHxULEt+CYkOSykLxDYlO/RWALcDzdJr+KgXEKZ3ILHBwW17YH/zG
	 csfCzRaxTlzjPAVRoIHIxn16QAdntibW1cCmQ0xFZhyUJwxhhL+bfUuao0k1otlJwe
	 B0Uchxiw4UaxRiGwIBo9rbZ7ZGLq4uo46hEl+7ukQEbL2QF1xSTDaLaXQEmfRv/WZq
	 qVi0tcVOzp9ZQ==
Date: Tue, 6 Feb 2024 10:57:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alan Brady <alan.brady@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 willemdebruijn.kernel@gmail.com, przemyslaw.kitszel@intel.com,
 igor.bagnucki@intel.com, aleksander.lobakin@intel.com
Subject: Re: [PATCH v4 00/10 iwl-next] idpf: refactor virtchnl messages
Message-ID: <20240206105737.50149937@kernel.org>
In-Reply-To: <20240206033804.1198416-1-alan.brady@intel.com>
References: <20240206033804.1198416-1-alan.brady@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Feb 2024 19:37:54 -0800 Alan Brady wrote:
> The motivation for this series has two primary goals. We want to enable
> support of multiple simultaneous messages and make the channel more
> robust. The way it works right now, the driver can only send and receive
> a single message at a time and if something goes really wrong, it can
> lead to data corruption and strange bugs.

Coccinelle points out some potential places to use min()

testing/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:1956:17-18: WARNING opportunity for min()
testing/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:1271:17-18: WARNING opportunity for min()
testing/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:1319:17-18: WARNING opportunity for min()
testing/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:2640:17-18: WARNING opportunity for min()
testing/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:1295:17-18: WARNING opportunity for min()
testing/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:2157:17-18: WARNING opportunity for min()
testing/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c:3582:17-18: WARNING opportunity for min()
-- 
pw-bot: au

