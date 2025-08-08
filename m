Return-Path: <netdev+bounces-212274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 287BCB1EE78
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 20:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E55418C4278
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 18:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D372921E0BB;
	Fri,  8 Aug 2025 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbIAef7r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498B1361;
	Fri,  8 Aug 2025 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754678891; cv=none; b=OyH/XavRrb6YvmVx4OTT7LjZib4VorH1FzJvP5EUiu1e/CPGZPLcK97OVpp7EIGboL4vJGijPJNrAcNy0B8XIZOj0qAGGWMfr4x3yTvgszZyhlO4kd/pH8fQxCJg0UUfBEjt3pdvblF2Tfp0KD0TjSjl+JMtdHRDM4fmRZ1BiEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754678891; c=relaxed/simple;
	bh=hyBvZwGcxhxV1L8C60kPaohAML2mGrY2ZK5limPy77A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SBukrKPsH3JujVdr7CQ4vR0OrffzWtjFlIdjoEpspsd0nfhNN54QHfD0BVQ6isE+lbb7E2Esk5OX2G6R6QKtSQ6oym+x8B64bi6DDZnX+u/odP4H8Rq8D2RD6SA5YOO+qxvDrg7gHn0MlutEhLeByP9zhpsr3DcYWmveLNDQaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbIAef7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5617C4CEED;
	Fri,  8 Aug 2025 18:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754678890;
	bh=hyBvZwGcxhxV1L8C60kPaohAML2mGrY2ZK5limPy77A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gbIAef7rOE+RfpOUvbgaPPfB2chDrtUcB85xtoDL1B6wmN2X3JKd5u+oyUxBzTgHx
	 7zAhsGp2w2tCcT8WGOpkhHp4BqHqe1yJODwvUawF06JPMTGREh/7OQhF72+sgP4flR
	 0NR8TKh/Rmu6pzOFRkkkihXHlEolyPzNKMEv9jW5vT/96au6aVT4lygp7B2vxCiMjC
	 wKr9+aNoMKWjf+GTR92TSJi5l4DJmusTckZoosP11Ha/K8Et2sPPQeusMReU3KvYTo
	 wXBsnNyCYWvttQv2mJ1GQfdN3CaFhkX28cVZ+hrO7JXGLRVuAyZF8xEoTn14k6sjiy
	 IEgOEckOi59ng==
Date: Fri, 8 Aug 2025 11:48:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Frank <Frank.Sae@motor-comm.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: motorcomm: make const array mac_addr_reg
 static
Message-ID: <20250808114809.1035a3a1@kernel.org>
In-Reply-To: <20250807131504.463704-1-colin.i.king@gmail.com>
References: <20250807131504.463704-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Aug 2025 14:15:04 +0100 Colin Ian King wrote:
> Don't populate the const read-only arrays mac_addr_reg on the stack at
> run time, instead make them static, this reduces the object code size.
> 
> Size before:
>    text	   data	    bss	    dec	    hex	filename
>   65066	  11352	      0	  76418	  12a82	drivers/net/phy/motorcomm.o
> 
> Size after:
>    text	   data	    bss	    dec	    hex	filename
>   64761	  11512	      0	  76273	  129f1	drivers/net/phy/motorcomm.o

## Form letter - net-next-closed

We have already submitted our pull request with net-next material for v6.17,
and therefore net-next is closed for new drivers, features, code refactoring
and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Aug 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


