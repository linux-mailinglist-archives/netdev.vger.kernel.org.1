Return-Path: <netdev+bounces-240637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A23C7724C
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 04:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C476F35C6F3
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 03:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2F42D481F;
	Fri, 21 Nov 2025 03:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPYcEC1c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483192BF3CC
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 03:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763695105; cv=none; b=jaREIKmU2Lrm0gqOuJ69J/V95FCCBYMYTVcAMF8w7KfwXFOIfJtDMkWZLbSVPcUrroEou6sKY4fEkdojIjJ71wf1/tFSAwfUTfAirAFNTzaRMj0p3e3KdXK3QY/5DLMgt4m1vujxTx74SfkS5I3ZVJsnLXeLJvAwj3R3f3hzvAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763695105; c=relaxed/simple;
	bh=YNx5BrHnRZIBwFkc+eJnnKo3rcv4JdlpM+JMf0qwAro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJ5R3b6zNrZyHRGuhTul6AExSmA2mdzMxHj4AJYxW90dxS4MQi7lUvRM/ojDVjFKuctq7JMrmR2qM5CE+hzi83BoG93gzD1EChkVBEK67iZA6jmAJrCd4T2B0fVLcw/QCkF4970DLkgkbOYy3CGWZhS0ZfwGjSfb+yZayYwrEHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPYcEC1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B690C4CEF1;
	Fri, 21 Nov 2025 03:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763695104;
	bh=YNx5BrHnRZIBwFkc+eJnnKo3rcv4JdlpM+JMf0qwAro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NPYcEC1cirldjG4dd7giPvme8Ta2JMiUiWUXwAN0BkCgXDZ+bOzT7RGGxorLg5foI
	 Wapjvy0aehodpO5S0HFNg/CbikhzWNZ7SJ6xny7Rfc9K1lrJva4EdZSRS116YLodk1
	 vSY3ddUShRownAXvLZ/C2T/268BG2y+d8F6f4HGE7Dgz0Sxmn9rzR9ueTSlMP8Z62V
	 bK50LJk1VZ+pBhQcZRtqgbRjgKBEUY167efESKyTKfjqtCdW4V6WAKODYQghEJyaMm
	 nGEJch9xTpvzojG+uAQNAVzMwFt4mRVRO7XzZaGNaByNZ9zDDT+wpf4k7NmfhC22Qv
	 LF0lLnCG2AlxQ==
Date: Thu, 20 Nov 2025 19:18:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH net-next v1 2/7] selftests/net: add MemPrvEnv env
Message-ID: <20251120191823.368addb5@kernel.org>
In-Reply-To: <20251120033016.3809474-3-dw@davidwei.uk>
References: <20251120033016.3809474-1-dw@davidwei.uk>
	<20251120033016.3809474-3-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Nov 2025 19:30:11 -0800 David Wei wrote:
> Memory provider HW selftests (i.e. zcrx, devmem) require setting up a
> netdev with e.g. flow steering rules. Add a new MemPrvEnv that sets up
> the test env, restoring it to the original state prior to the test. This
> also speeds up tests since each individual test case don't need to
> repeat the setup/teardown.

Hm, this feels a bit too specific to the particular use case.
I think we have a gap in terms of the Env classes for setting up
"a container" tests. Meaning - NetDrvEpEnv + an extra NetNs with
a netkit / veth.  init net gets set up to forward traffic to and
from the netkit / veth with BPF or routing. And the container
needs its own IP address from a new set of params.

I think that's the extent of the setup provided by the env.
We can then reuse the env for all "container+offload" cases.
The rest belongs in each test module.

