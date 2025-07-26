Return-Path: <netdev+bounces-210262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 855C2B1282F
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 02:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42005AE2716
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29235129E6E;
	Sat, 26 Jul 2025 00:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDONR0yB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057021D555
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 00:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490401; cv=none; b=GEDqwHIHgcGDvuwe+HdTDjx/DrV8Y6H9pEr4wda+pwmgXb5oN34mhvXtB3LcMwT8MsK7m3wO2kiipDTO7/eeHRUn5SVVgZ9bs+9d7wP/k9ir8lkkufYIZ+pdCwuTbNDdoohTG6l6QCbE3w21JqUkSJpNclwH2MH8oBokFkG1/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490401; c=relaxed/simple;
	bh=RYCornZK1EAZaGriNAR+2VTeO0+3c3oHi2eLlCZLrnc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUwCyZWT/anycIpgG8vE19qmlA3TyW2d/EohksKS5mvb6G2Ft4RuTZZSoehDFVw12LFlQRPSqWW7TAm7eE4fr1B66hLNAy6+xI988T642vvpzpXIMMQa7cIAs8ChpIewpvPgqu6zetgq1TDKILEx1bu4M0DTWYSJwe4r6Xuf20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDONR0yB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AB8C4CEE7;
	Sat, 26 Jul 2025 00:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753490399;
	bh=RYCornZK1EAZaGriNAR+2VTeO0+3c3oHi2eLlCZLrnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HDONR0yBCcypmjYtmAtMVpQ2bjIM2C0rtIsRIH0pUuNEYfhQKiUx4xiWb+PYlPzyV
	 B1wvT6e4xOjPQzKFcpziN9wBLOiejwXy783yHOPETxivOfaZm9HPLPySm/Lxo3trMS
	 LpKBWGUy2lt+DA5dXfVA+ESQSP701XywgQ1AbSSCgpdTqcZk2yBTHEtOQejxPEKcU5
	 wHG7tKFfSl/X6jVEMGVbl3+6ER7SpGwX40g1Vv+fl95F6NSjjQ6vGtAgg/WZxQpGfJ
	 GxkWNCapQOGwLJd8Pgz5Ep/jc/vw5QB/wvfeUrClHXBEhDjzAfP0UQ4t3iXhgWYaEk
	 G5GJUJkEQ4dVQ==
Date: Fri, 25 Jul 2025 17:39:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Lamparter <equinox@diac24.net>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Lorenzo Colitti <lorenzo@google.com>,
 Patrick Rohr <prohr@google.com>
Subject: Re: [PATCH net-next v2 0/4] net/ipv6: RFC6724 rule 5.5 preparations
Message-ID: <20250725173958.4d77792d@kernel.org>
In-Reply-To: <20250724150042.6361-1-equinox@diac24.net>
References: <20250724150042.6361-1-equinox@diac24.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 17:00:37 +0200 David Lamparter wrote:
> let's try this again, this time without accidentally shadowing the 'err'
> variable.  Sigh.  (Apologies for the immediate v2.)
> 
> following 4 patches are preparations for RFC6724 (IPv6 source address
> selection) rule 5.5, which says "prefer addresses announced by the
> router you're using".  The changes here just pass down the route into
> the source address selection code, it's not used for anything yet.
> (Any change of behavior from these patches is a mistake on my end.)

Would you mind reposting after the merge window (>= Aug 11th)?
I'm trying to wrap up our net-next PR for 6.17 today and 
these changes don't look obvious enough for me to tackle
after 6 hours of staring at diffs.. ;$
-- 
pw-bot: defer

