Return-Path: <netdev+bounces-240497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FA6C75C86
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D78734237F
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA3E28504D;
	Thu, 20 Nov 2025 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQf7pd1x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7457586353;
	Thu, 20 Nov 2025 17:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660537; cv=none; b=I6m+4XuFTGT1vhxHDePCFFmyTY+idAXOJVJtjFH2lx/0d+rKQJoL/bhqF+u0lDSl0zbZ4ETpRdbAYq3qFvhdgTCHZKmmwXTasW7M4ysjOVdm0JTswHhVm2SV4Y6ZRqXERgMTfGQv7TY2MT5Lag7DlpCQLXkvcC3OfClN9jxjJxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660537; c=relaxed/simple;
	bh=ZZFqjh0mnSMYCNm+2H2xGMrW2OYFTXLBH3fNMZZyrJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esS1EZYucaSg0wUsP4o6MM/2Ba3wK5/spqSdrTeCcVXBEgvFYv0feHsCo1Le9iREG+cow7J7oJwHNTMZ8XTTk8MG6uINGlRQCDy1tZpynbezrEF3PM3zQmGfLlFmCidUgf5fygZ64QX9ghdz67jTd4F2xEP2E8brb3F/Bir2fRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQf7pd1x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C584AC4CEF1;
	Thu, 20 Nov 2025 17:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763660537;
	bh=ZZFqjh0mnSMYCNm+2H2xGMrW2OYFTXLBH3fNMZZyrJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IQf7pd1xbXR4Tdhz3qBJz12Kl8R6j3MpFAS5jssEe8yQ+0bi/oQbfNO1Gz8eqBILu
	 E0CFp25jDFlbKPnwpgakSBgaHeXHBH75bndHmtYGFR2NKueOCBY6zw+BT1dCglOoHf
	 i1ofAN0MYiOuQDbvmPdiSQJSqliyHsigINHnsG3Enxovs8PRcUHdkXxjImxPOEfOJk
	 nsxD8FAzGctaWbtn99KYLw5MW7FzIMYF2YaKpog1BKPhbVdjEXJV+cwTZAim9oGxfL
	 HvcUXAzpkw4ervKzcec3RY0lWWds0/tFugpC2LgwLXi5756EtjzrAyrJpWko+HRpW0
	 mGjB7+hrgGjpA==
Date: Thu, 20 Nov 2025 09:42:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Cc: <netdev@vger.kernel.org>, Julian Vetter <julian@outer-limits.org>, Ido
 Schimmel <idosch@nvidia.com>, Eric Dumazet <edumazet@google.com>, Guillaume
 Nault <gnault@redhat.com>, Mahesh Bandewar <maheshb@google.com>, "David S.
 Miller" <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <andrey.bokhanko@huawei.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next] ipvlan: Fix sparse warning about __be32 ->
 u32
Message-ID: <20251120094215.3e156548@kernel.org>
In-Reply-To: <20251120172636.3818116-1-skorodumov.dmitry@huawei.com>
References: <20251120172636.3818116-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 20:26:32 +0300 Dmitry Skorodumov wrote:
> Fixed a sparse warning:
> 
> ipvlan_core.c:56: warning: incorrect type in argument 1
> (different base types) expected unsigned int [usertype] a
> got restricted __be32 const [usertype] s_addr
> 
> Force cast the s_addr to u32
> 
> Fixes: 2ad7bf363841 ("ipvlan: Initial check-in of the IPVLAN driver.")
> Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>

Read this please:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

v1 was fine, why are you adding a Fixes tag in a non-functional change
:| I can't dig out v1 now because k.org aggressively supersedes the
patches. Send a v3 *while following the rules*.
-- 
pw-bot: cr

