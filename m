Return-Path: <netdev+bounces-159536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D83CA15B4C
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 04:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBA73A9200
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 03:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9855513C809;
	Sat, 18 Jan 2025 03:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFgHe2IY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B6213B791
	for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 03:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737172227; cv=none; b=AuV1PYQ4V1EP0mo8yoMflZfKxzD5y1wz6Xs94xo2gvzelr4GDx9YFdryYcR3VGc33SpHvH1XVj49Qv2LU7ng/gkmN4aV0f8JtUUHd8PjLfwSxsPCinYMBQZxL0dM082jo3XbiCea+pBbFVWT25JWv8hoTdNIWySrhelzjhGWzNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737172227; c=relaxed/simple;
	bh=bE2z+xcvhL06HGPVRIP1ZXbLvXQiiLud1zQnvIN8UKk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nGrIm2Bbkv7Ww3gxA/evBjnd4BRdM9dt8oa/RdhcKl8HgAqWx7miCu6ZKrKgILEZfbil+OzQQBrBtooFVy4n5dRNSBjSpyICXftL0C13IhkqbHG4Jv21NbO/VdYLu/MtSjL6fGSGeFYTYLMHbi3h/wp1wBm2L9V/RaSqlUQpl6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFgHe2IY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486FCC4CEE7;
	Sat, 18 Jan 2025 03:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737172227;
	bh=bE2z+xcvhL06HGPVRIP1ZXbLvXQiiLud1zQnvIN8UKk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fFgHe2IYMiQn1iuEXczQkX0WGDhc5b68RdvFdHI6+cPcN/7oKbRUE68Z35NJSsHt3
	 64/l8lwbDlr8WHtRo7qqJ1EHjEI7e49XTMnHaWtBOobQM8+F33PvswhtqlLm8MauTD
	 GXoEWa0tkUEDJroOjXhM7UkO85KO2TkC8UMMOXGC4gndiCskanmOt5T9JLLkgaM7Aw
	 3FNrOiIzydz++Gv0SWLGDl6ABT9c8BxXHB7GxV8P4ZIHakDXuT0ntH4WmmG/OLKtI7
	 UVORkFRx4MUTx+Vh/lemluel4oppfJ91cXOdzBOjWa/EUnXR8T9vTdjYszBXKb+yN4
	 MxqeeRpL/EP7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD8F380AA62;
	Sat, 18 Jan 2025 03:50:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] gtp: Prepare ip4_route_output_gtp() to
 .flowi4_tos conversion.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173717225074.2330660.3713240080176094788.git-patchwork-notify@kernel.org>
Date: Sat, 18 Jan 2025 03:50:50 +0000
References: <06bdb310a075355ff059cd32da2efc29a63981c9.1737034675.git.gnault@redhat.com>
In-Reply-To: <06bdb310a075355ff059cd32da2efc29a63981c9.1737034675.git.gnault@redhat.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, horms@kernel.org,
 pablo@netfilter.org, laforge@gnumonks.org, andrew+netdev@lunn.ch,
 osmocom-net-gprs@lists.osmocom.org, idosch@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Jan 2025 14:39:38 +0100 you wrote:
> Use inet_sk_dscp() to get the socket DSCP value as dscp_t, instead of
> ip_sock_rt_tos() which returns a __u8. This will ease the conversion
> of fl4->flowi4_tos to dscp_t, which now just becomes a matter of
> dropping the inet_dscp_to_dsfield() call.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] gtp: Prepare ip4_route_output_gtp() to .flowi4_tos conversion.
    https://git.kernel.org/netdev/net-next/c/2ce7289f180d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



