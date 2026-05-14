Return-Path: <netdev+bounces-288034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMe/Olb2BWpVdwIAu9opvQ
	(envelope-from <netdev+bounces-288034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:20:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E469544905
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C85D3062C3B
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 16:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541DE335555;
	Thu, 14 May 2026 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEs2oPpi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291F01DFDAF;
	Thu, 14 May 2026 16:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775475; cv=none; b=UKbG1Qhacu11aQqY4xodr18JyW+W/UjPTFAn9+TQkMZJeoZl73LBttu5DtueCwEZPay3y6KF7MrhB9WxVkm9oteoXwP1GgXHq3GRU3OCAlu5103AFlU9YHbyyhAEAWRsbmvE2VB8tA+GmuDMBDSSz73L326/FnItxZ4GyXFRC08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775475; c=relaxed/simple;
	bh=BYqQQ29yfh1mseNE/GSkBWUVdDHRIVpP+Q4sT3Vda9U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bdrxjwTsc/D8RDYBJOitXcKm/x70IYaaW0jUYSz6lQN+gPz8jv58+nIvunRq6pfhBbz/s5dbQmuOCRZWKn4dTAnDDK8/HWI08bAGN6uAe8eQaDb10UWgWeElIAs/xr5rsoqnAPzp88KG44UJUFpBMpt166InX9PiYsGrWBCYUBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEs2oPpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF02C2BCB7;
	Thu, 14 May 2026 16:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778775475;
	bh=BYqQQ29yfh1mseNE/GSkBWUVdDHRIVpP+Q4sT3Vda9U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=eEs2oPpizkwcFs6WNmiNuMMDcwxIpzLbjsv0kBkJnrsm4bKwS3mwklHwyg11Y7v8C
	 sTDn8yT0FLvv+dH4qJ0US4qPWwtYoGOnX/qGaCF7e8/Sadd6rS529AKGt4a7rMriWg
	 UldR6XUe6q2qF7kHF0JCpBZuMpiy0FVpOn2fr43+6PMSp02AVy0DRqSWbs6YGwp61E
	 J6/0Qvy7IZNCFSirTGNhH6+A7kddPXIO8V6N3WBwPY3cW/+fP65TsGX0dxy1dg/RzG
	 uQVPaS723FrXQX2G2FMcjp3s4/F3HnYOw5bXo5NYovZAUHPHJ05mf11lEOvapCc9yw
	 Rg9tjifKR26RA==
From: Vinod Koul <vkoul@kernel.org>
To: linux-phy@lists.infradead.org, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Josua Mayer <josua@solid-run.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
References: <20260511150023.1903577-1-vladimir.oltean@nxp.com>
Subject: Re: [PATCH phy-next 0/5] Lynx 28G SerDes: 25GbE support
Message-Id: <177877547268.1092446.15204675916496337123.b4-ty@kernel.org>
Date: Thu, 14 May 2026 21:47:52 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: 3E469544905
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288034-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Mon, 11 May 2026 18:00:18 +0300, Vladimir Oltean wrote:
> This is the remainder of "Lynx 28G improvements part 2", previously
> submitted here:
> https://lore.kernel.org/linux-phy/176850672122.1082429.444623229961712368.robh@kernel.org/
> 
> but split up into smaller portions (merged separately):
> - https://lore.kernel.org/linux-phy/20260226182853.1103616-1-vladimir.oltean@nxp.com/
> - https://lore.kernel.org/linux-phy/20260321011451.1557091-1-vladimir.oltean@nxp.com/
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: phy: lynx-28g: add compatible strings per SerDes and instantiation
      commit: 1561f12db08b1da1fe47ce9a5beff11adfd90ac8
[2/5] dt-bindings: phy: lynx-28g: add constraint on LX2162A lane indices
      commit: 37056ea140242681ccf706f63ad8c7366d89f5e3
[3/5] phy: lynx-28g: require an OF node to probe
      commit: c9d80e861034e2f3618065dc02b1de828aed24f6
[4/5] phy: lynx-28g: probe on per-SoC and per-instance compatible strings
      commit: 8c57247f5d9734d617862d320bd3894eec898298
[5/5] phy: lynx-28g: add support for 25GBASER
      commit: 1cab8fba5073962712fae3b763417af95ccf476a

Best regards,
-- 
~Vinod



