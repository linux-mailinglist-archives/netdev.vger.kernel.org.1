Return-Path: <netdev+bounces-106547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C95916CBE
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1118286D3F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2229B171E7D;
	Tue, 25 Jun 2024 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8XUzhoK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BF2171E64
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719328482; cv=none; b=FGjUEPDAC5sRMf/UJT0Bra9UQxR4qspWcwRWvVThXBnZo/VLEiQ1cTDy86BfPt6ce6ce0i1+n3t0G5xUrZTpESu1Za595njciTVJfJJckYb7VoLQBaFBqLLMuWiSleTF02a6B84LuHmrPIFZdgIPqtQFulS+f72qBleK0uBS2X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719328482; c=relaxed/simple;
	bh=xvCdQ9ygNmvXUXms60y0joo73iPNckia2zfej5s0X9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vr+7MmcFN9carrxVUCQSFwfdQhR+IH/HXUbkbh5UpfdYbc6B1OS638a4GXeS/V67bwc2sTi846XL/+H1prX7EN3qPA+BjnCS5rxOBHM5UD1cafKT126YXKJXo2XgY4YqM5LMOxjNI95Xj5AQayzCO1PXwLXhnlxR2F8otnJC+oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8XUzhoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C65C32786;
	Tue, 25 Jun 2024 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719328481;
	bh=xvCdQ9ygNmvXUXms60y0joo73iPNckia2zfej5s0X9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n8XUzhoKrSoKj8qUpnt0IJLwC6Grw3zPeKEUtDWPfor5WqE08eR2eBRpL/W3rMARh
	 4c4tEIVzQPkEyyLFCVOkMKoDGmSoBaXSsUDrjxyfJdVWqlUSfzO70VYtTSEWWBw+Qf
	 qekA2Kja1vlgHEaO1sEmEBDNxQvWgVhR/1rufXoBEy+/abs9OcO6O5+0/U1WfDS7Zj
	 zejdaSIN2ijQRXUsYNKVtsp5X/G4na0xpiq9msx7Q8o/1S/GbZIwXjyDSEICGu5Gv6
	 MmVUVCsgyCcKNI40pj0quCc7406PAoLy3fyrjgb7d9INacu3JLATP9pa/dAoYUGAl5
	 hKYcxi6RDtLCw==
Date: Tue, 25 Jun 2024 08:14:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, ryazanov.s.a@gmail.com, pabeni@redhat.com,
 edumazet@google.com, andrew@lunn.ch, sd@queasysnail.net
Subject: Re: [PATCH net-next v4 25/25] testing/selftest: add test tool and
 scripts for ovpn module
Message-ID: <20240625081440.7f65e069@kernel.org>
In-Reply-To: <20240624113122.12732-26-antonio@openvpn.net>
References: <20240624113122.12732-1-antonio@openvpn.net>
	<20240624113122.12732-26-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 13:31:22 +0200 Antonio Quartulli wrote:
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -67,6 +67,7 @@ TARGETS += net/openvswitch
>  TARGETS += net/tcp_ao
>  TARGETS += net/netfilter
>  TARGETS += nsfs
> +TARGETS += ovpn

why not net/ovpn ? I don't mind, but non-networking people will have
harder time placing ovpn on their mental map without it being under
net/.

>  TARGETS += perf_events
>  TARGETS += pidfd
>  TARGETS += pid_namespace
> diff --git a/tools/testing/selftests/ovpn/Makefile b/tools/testing/selftests/ovpn/Makefile
> new file mode 100644
> index 000000000000..edd0d7ff8a12
> --- /dev/null
> +++ b/tools/testing/selftests/ovpn/Makefile
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0+ OR MIT
> +# Copyright (C) 2020-2024 OpenVPN, Inc.
> +#
> +CFLAGS = -Wall -I../../../../usr/include
> +CFLAGS += $(shell pkg-config --cflags libnl-3.0 libnl-genl-3.0)
> +
> +LDFLAGS = -lmbedtls -lmbedcrypto
> +LDFLAGS += $(shell pkg-config --libs libnl-3.0 libnl-genl-3.0)
> +
> +ovpn-cli: ovpn-cli.c
> +
> +TEST_PROGS = run.sh

Could you list the scripts individually under TEST_PROGS?
Maybe add a wrapper for the script that needs to be run with an arg?
Doing so will integrate with kselftest better and let us track each
script individually in CI, rather than have one "ovpn / run" test case..
-- 
pw-bot: cr

