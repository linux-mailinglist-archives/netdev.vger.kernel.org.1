Return-Path: <netdev+bounces-156038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C99CFA04B7F
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DCD63A1EE6
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3A61F4E47;
	Tue,  7 Jan 2025 21:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfGCwon5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B541F3D47
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285067; cv=none; b=QOAcsuId0kQlmAO0ln9XYpq4UnF6mUHAvKrpFqsZp8bUNMcOUhODMxI9WbfPWMb+Px6TSsivMKPEMY/9peNouzvBRLu9kXt46C1Dvb0EvFOvix/GyAdALDFg/RZlBqrJ6rfNw+9NNIKEe7I85DE1hzYECF+P1Z4hYuypbUak/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285067; c=relaxed/simple;
	bh=cetbXROKBMOEnlx+JP/9zv7fblwiV0U7xN5mU7xd2m0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JvKCMte+Fbpf+5OmL53YZ1sHrXjrwiZ/hXo/X7jozncgPpf7g5MBtkhDRfhfZoC7Mjuga9gezgbyv1EnvdGIMd85bsttietBZ127go4q/sx18cmB8xtvNLLTULR39e3yJwHS5d9G41jSGBUM9cRPWOR668Rl39kyCthRhIk8pj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfGCwon5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4AFC4CED6;
	Tue,  7 Jan 2025 21:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736285066;
	bh=cetbXROKBMOEnlx+JP/9zv7fblwiV0U7xN5mU7xd2m0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WfGCwon5z9WPLDTaMnumorUavPEssp3vmKrKmdkcj9KS+G8kSLbYJhVDr1cEN+pVt
	 SSNWsTdNonZDLTVO8erFr9ubTYUkgsomoxHAEUT6Ocm4c0WIPW3cw1Fo6aalDemQD1
	 Vkn3K9FXH9RMzrUapOEhZD9p1CftdoFRvnVsTTNigre8/RFk1m/oL4UiuZHWjqZuk0
	 UpEGs9jdHoqloq93YQEK6jA8bIfn6OO+0Hdl7nsb8Tbzs7UWiV6zJuY3SSmgpkyUpl
	 ++d9VOeqloCcul2/v/LyiGKKOumkr4OsM+zf8fqtDVv4g3XIbcNX0fSqbqB+5ugedt
	 bSxtHkIl7Q7AQ==
Date: Tue, 7 Jan 2025 13:24:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net-next v5 06/12] net: homa: create homa_peer.h and
 homa_peer.c
Message-ID: <20250107132425.27a32652@kernel.org>
In-Reply-To: <CANn89iJKq=ArBwcKTGb0VcxexvA3d96hm39e75LJLvDhBaXiTw@mail.gmail.com>
References: <20250106181219.1075-1-ouster@cs.stanford.edu>
	<20250106181219.1075-7-ouster@cs.stanford.edu>
	<20250107061510.0adcf6c6@kernel.org>
	<CAGXJAmz+FVRHXh=CrBcp-T-cLX3+s6BRH7DtBzaoFrpQb1zf9w@mail.gmail.com>
	<CANn89iJKq=ArBwcKTGb0VcxexvA3d96hm39e75LJLvDhBaXiTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 22:02:25 +0100 Eric Dumazet wrote:
> While you are at it, I suggest you test your patch with LOCKDEP enabled,
> and CONFIG_DEBUG_ATOMIC_SLEEP=y
> 
> Using GFP_KERNEL while BH are blocked is not good.

In fact splice all of kernel/configs/debug.config into your
testing config.

