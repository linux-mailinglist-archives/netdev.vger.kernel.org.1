Return-Path: <netdev+bounces-199534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A0FAE0A37
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318CD3B52E0
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9221E7C1C;
	Thu, 19 Jun 2025 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRoG6PT3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75573085DB
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346238; cv=none; b=llwBsgQM0e3FogZ5GZfBbXegAvSoWv0CYYZL7LvGfhMvxVtAUqyGKRTq5LYxeugofSSkA5gUOQ5xoXtR9lR6a0l+vfwZ3ZzbAZMRRnukXvUX0drx0XoZnpkKQSV9L6SLleIhwZeaCuXGbUSgPKl2GpNhFPN4cTgDrEKGNvugNA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346238; c=relaxed/simple;
	bh=xetA+YdWZpczGkjIiKzxB0unVgHFeI/5HlEWT0HQ4fc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGcQpeGEp3BDXju7fuikw9IN6gExwX6vCQQE38k2OQeKrVUfOcXkx+brTWJXTZbYoPJ7P+Mzo6KkrUHxFtJtTw8Wdy5W5o5S+z9sGm78AxUObh+7DNxcVajgHKpJtx81RkOOnbXcnRydYIL9BDe5I7cm2vw4AfO2BDvxO5RN3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRoG6PT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28C0C4CEEF;
	Thu, 19 Jun 2025 15:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750346238;
	bh=xetA+YdWZpczGkjIiKzxB0unVgHFeI/5HlEWT0HQ4fc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pRoG6PT3zCm5BDNsfEhRaoZrbStPgfXn2EXRhRKGEzqvzDLP3JVd4hCJO2n2GZXoK
	 oWz6UusPonRY5tQPbvSFD3VivtxiFX8ohHXxcfrKxXL5htwjaCR2+TMGZpg+yHmldF
	 M/vRfKIdCIo2wP841gONLq1vfglY3zVzIHQZICRWublft3BqW0Q93xgMXbX37DlrcO
	 nIlwmNOSkg2QFeT0rbSDumakYYiALmCLs9VxSL5rcxuZVjy3FPCLRvgSejL4ObJu3a
	 SEizcUATCTJvLWmFKVjtIbknC7+1UEMQh3DNwrEdxSJAbtJEaaerztd/tyDsViqCH4
	 3nAnuMKKpviNw==
Date: Thu, 19 Jun 2025 08:17:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
 linux@armlinux.org.uk, hkallweit1@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kernel-team@meta.com, edumazet@google.com
Subject: Re: [net-next PATCH v3 0/8] Add support for 25G, 50G, and 100G to
 fbnic
Message-ID: <20250619081717.0b2f5f87@kernel.org>
In-Reply-To: <5ce8c769-6c36-4d0a-831d-e8edab830beb@redhat.com>
References: <175028434031.625704.17964815932031774402.stgit@ahduyck-xeon-server.home.arpa>
	<5ce8c769-6c36-4d0a-831d-e8edab830beb@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Jun 2025 10:44:41 +0200 Paolo Abeni wrote:
> I'm tentatively/blindly removing this from the PW queue to double check
> the assumption.

Hmm yes that test has been wobbly, I'll keep a close eye.
Unfortunately the test doesn't work on virtio due to lack of the "device
stats" in QEMU so fbnic is the only runner that exercises it :(

