Return-Path: <netdev+bounces-70677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7A984FF71
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 23:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5461C20DBF
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 22:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BA21B7E9;
	Fri,  9 Feb 2024 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KF7K6gU3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447B168A3
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 22:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516577; cv=none; b=c55c8TZDOLhqPj2a9Hem41G8OrJNaEMhe0IHdfGRcvFP5b2MDJy7uybTVlaP98egjpbLwHcsBefWAzxPbnf5pQ5R+6I+NnwdjDccQA/8QyUgHPOJDu+w99soRAT6uLvvIHPcK6JRIBKKfHxXLLbShVtyJ5JAkziGeg0SobnWvBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516577; c=relaxed/simple;
	bh=benR162QH1kRE1vYJOWumqFog4zf09YUTyw6sRsjNx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nN4yRXlOaB0fiOHRPx4fCInFkmZR8j2k0c4UHUZujauA00OlU4PRAOJJhn+PXmOFYiCLeeq4bMB56Q48C5xDKBzcJkdDdCH+H6IYZPpPC3AG0IUwTkLZX4MG+/PT0D9u9tawQVocXr8YJZGPIjzw7d9CdewrccXqu72HCfmEj2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KF7K6gU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF80C433F1;
	Fri,  9 Feb 2024 22:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707516576;
	bh=benR162QH1kRE1vYJOWumqFog4zf09YUTyw6sRsjNx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KF7K6gU3XWnYzqqXqRIKgDGMXdQPLMB5b2271r/tHzE62dnZGGOvWDgsjLBSbgXyt
	 qsbBUonxZrWzLktzTpV0MAHo0JuCCi2NEOPyXZR4ACwB5cDBj2odUxA+SOlZVoY9sU
	 1d0hCLlRrVbllvjeTr+MX2GcARo7ckM7KoH0u/wTKDY17lV4DX5zWITsU5cgsSqVeb
	 D8I9GB4YBwogvDn6lRGcZMCpuw/cZ8uMrvaq126jyZp3JTcabLvQklT+VJ0ix0baI7
	 pmOpLfdC8BBxJtRJ31X7+uOt/3d1+8N7+0SUUbOzpUcafxtFx0XfrPOm2U9Az9qeY5
	 ese59uqXUhGVw==
Date: Fri, 9 Feb 2024 14:09:35 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <brett.creeley@amd.com>, <drivers@pensando.io>
Subject: Re: [PATCH v2 net-next 01/10] ionic: minimal work with 0 budget
Message-ID: <20240209140935.4230d626@kernel.org>
In-Reply-To: <20240208005725.65134-2-shannon.nelson@amd.com>
References: <20240208005725.65134-1-shannon.nelson@amd.com>
	<20240208005725.65134-2-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 16:57:16 -0800 Shannon Nelson wrote:
> We should be doing as little as possible besides freeing Tx
> space when our napi routines are called with budget of 0, so
> jump out before doing anything besides Tx cleaning.
> 
> See commit afbed3f74830 ("net/mlx5e: do as little as possible in napi
> poll when budget is 0") for more info.

Unfortunately to commit you quote proves that this is a real bug which
can crash a non trivial number of machines if kernel printks meet an XDP
workload :( This really should go to net.

