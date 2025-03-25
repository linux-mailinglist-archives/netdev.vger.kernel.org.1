Return-Path: <netdev+bounces-177604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89083A70BA7
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87BA518822C2
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 20:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2CB266573;
	Tue, 25 Mar 2025 20:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQasTJbp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF591A5B88
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 20:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935139; cv=none; b=qpAyoEhT3V5Kv/okKjWYjAsO91ZyqtAiY1AD1EqqRo8x7SPcIhdVfT8EJ7SSxjsl/VWubOy89NUywlHNiPle/x1neEOgC9c/j7zmpeVBMRa0laeVDBMQsDjGaHfzly/MIBX4pqg96MXKfmMI8gwmR88LLtOFytT05gmpLdWSJO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935139; c=relaxed/simple;
	bh=n7hOs3NUyUcxE+kb1aen8wl/Vnqi9Y7JTl5lzFFbmPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BT52VQMlg8bk8vDizrO61i8zycA6nrhiCjpWIB8dR5nNGSkcCP1HpkThf3rxussQHO6rL5KLn1h0xaIj47W5QVgyodqGu0vdSvEqFVqm1BnnLBjdXpabT/4gU8wNgNG+6+L1KCY6Lajhu1szoPpa3xYJbC5k0NyQOZeU9Z3VTgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQasTJbp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0944C4CEE4;
	Tue, 25 Mar 2025 20:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742935138;
	bh=n7hOs3NUyUcxE+kb1aen8wl/Vnqi9Y7JTl5lzFFbmPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NQasTJbpQoBv77XAmu3tUZ20EiHOgSm2iq9ju8Ohta0Z5BqxWeLVojLdy1GUQpfVA
	 olef95aLY9tPf9sqUZNhp762uSkb2hueWV5h2r4nTItIhUHNpIPW5J9Wi5xf/4HZb5
	 7218DpE3qydvIpaiPZScYHe6Q9xdmFgo2ROyZelPonOGMD1X5a+li9HM4aexqpY3Tf
	 hZat3srKx8Ych4+f2Qz2oJ+gnAWqPnhY0dHW2e7ALXr41Jo/LS47EL/2tXBmpedubE
	 PetULiFiEAan0D18Vt4AuP0CwtcAAPMYcKfQoJ/xreB2tTF3v9j/21baSB1Y6qDBVw
	 9c7nWcJZ4TJ+w==
Date: Tue, 25 Mar 2025 13:38:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pablo Martin Medrano <pablmart@redhat.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Petr Machata
 <petrm@nvidia.com>, Filippo Storniolo <fstornio@redhat.com>
Subject: Re: [PATCH net v4] selftests/net: big_tcp: return xfail on slow
 machines
Message-ID: <20250325133850.1d503348@kernel.org>
In-Reply-To: <aee7724405df4516494d687a5cb1835aeb309bd3.1742841907.git.pablmart@redhat.com>
References: <aee7724405df4516494d687a5cb1835aeb309bd3.1742841907.git.pablmart@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 19:54:02 +0100 Pablo Martin Medrano wrote:
> After debugging the following output for big_tcp.sh on a board:
> 
> CLI GSO | GW GRO | GW GSO | SER GRO
> on        on       on       on      : [PASS]
> on        off      on       off     : [PASS]
> off       on       on       on      : [FAIL_on_link1]
> on        on       off      on      : [FAIL_on_link1]
> 
> Davide Caratti found that by default the test duration 1s is too short
> in slow systems to reach the correct cwd size necessary for tcp/ip to
> generate at least one packet bigger than 65536 (matching the iptables
> match on length rule the test evaluates)
> 
> This skips (with xfail) the aforementioned failing combinations when
> KSFT_MACHINE_SLOW is set. For that the test has been modified to use
> facilities from net/lib.sh.
> 
> The new output for the test will look like this (example with a forced
> XFAIL)

Sorry I was AFK for 2 weeks, what happened to my suggestions of using
byte count rather than time ?

