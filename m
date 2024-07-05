Return-Path: <netdev+bounces-109558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4474C928D0C
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 19:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8E21F21749
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 17:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D98116A948;
	Fri,  5 Jul 2024 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBdH3WuX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2535DA955;
	Fri,  5 Jul 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720200684; cv=none; b=WBKCWkGlFonONA7Uuw4U+33jikfDOCsO8XmV9Dm4x4FroYy4g7b8VtFjqckS9MAIz5GjlynxMd5pEz1EBL6Ab/liOt+lR1XnaYz5yENkYdWeR4XTVr9PY8fmojKlLQepLi2BlRE4HmyYG9z9mmwVaMyCN0SdwW/PQCRdS5Vv2EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720200684; c=relaxed/simple;
	bh=lWso3CknD6ujVoU48OlVNceQpnURAJ6uiG/8MRDzDv4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nt+jc5qdzcAuNrsPmSMCtgRZyVWRZeCX0OnJIqEuN+2X8yEAfF/w9Bu+dIHrbBCpc7kt+jBIKvZ6RvbP9qSWXKmFKfD+nqhWuGianKvnoheDLxdSTsFPE1WopjTMS2gqDiRip1PyxW19dXtXOSTFOUD7htvcFSE28IVbCKqu4rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBdH3WuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EEAEC116B1;
	Fri,  5 Jul 2024 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720200683;
	bh=lWso3CknD6ujVoU48OlVNceQpnURAJ6uiG/8MRDzDv4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RBdH3WuXDp4aK1rJpG1Q6Dd3BKLBfOX6O8g6R+6kdAJblTLV9L3muUNXWq+4t0YXP
	 dtm3SjiXfLQ0fMZuw68vfEtBVvUw1eNb3cXachDShxH1qg6bswqPY40q5PZQ9Vpv/+
	 gRDIPrM29gOrsGKNX3VMHvHEERjJNuAR5QdXbLkJaDtWRayw2OKs/Ji1MrIkDksIJm
	 AqecoRviD+hgkfCTldW/HJ20XBss/EYAl4HWGfpy7LrnzmlzKb//855k/dZ1f/BS4A
	 r+KEa+GisqrbN8i10Gm4dYmHoxLlW+LnGjlJb4dwNeSgY8wDIDMbIYEN9Y0Yqiwoeg
	 3z3QEab9TvBXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82701C433A2;
	Fri,  5 Jul 2024 17:31:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 iproute2 0/4] Multiple Spanning Tree (MST) Support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172020068352.8177.8028215256014256151.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jul 2024 17:31:23 +0000
References: <20240702120805.2391594-1-tobias@waldekranz.com>
In-Reply-To: <20240702120805.2391594-1-tobias@waldekranz.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, roopa@nvidia.com,
 razor@blackwall.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
 liuhangbin@gmail.com

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue,  2 Jul 2024 14:08:01 +0200 you wrote:
> This series adds support for:
> 
> - Enabling MST on a bridge:
> 
>       ip link set dev <BR> type bridge mst_enable 1
> 
> - (Re)associating VLANs with an MSTI:
> 
> [...]

Here is the summary with links:
  - [v3,iproute2,1/4] ip: bridge: add support for mst_enabled
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=3018ea24f388
  - [v3,iproute2,2/4] bridge: Remove duplicated textification macros
    (no matching commit)
  - [v3,iproute2,3/4] bridge: vlan: Add support for setting a VLANs MSTI
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=151db40f1d3d
  - [v3,iproute2,4/4] bridge: mst: Add get/set support for MST states
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



