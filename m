Return-Path: <netdev+bounces-212710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC0AB21A48
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690601A24B70
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E0C2D3751;
	Tue, 12 Aug 2025 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVF+zLxP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0962CA8
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754962686; cv=none; b=Py+CsTTmfSrHgykr80IDTONA/LJEYPEAjDmTTEmRKUw2q2yAO07IzQ+T4rQzMU5KXNvmnDWZmfPY2QHaP6ynh2LXIRU3073/3Bkg0yRUg0kulMxaxfPfN+/uJprP3i9pCBX+zYjvS+OVeqr8Pb8IG4/8lxPfZBqeCsyjKLTrrlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754962686; c=relaxed/simple;
	bh=EwU541KORKCeZZ6Epvczjv8c3xIseuru9qhLfCQqkpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VDWSLvGaciH3uZ0+bUV3DzlUgCqxJmyMMsARWYOCyZC3VD6tSpRfzkW8yQ9ZNL0lvtGw1C87g+GzZouD8dcP2A2r0JVMnmRMYukEwCCEA63UcwcKpAYIjMOe676oCO4L6Z2XuTyJQX4auPuIKxGeT2s39E7XkxEFGU8LUKAKvyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVF+zLxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02D8C4CEED;
	Tue, 12 Aug 2025 01:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754962686;
	bh=EwU541KORKCeZZ6Epvczjv8c3xIseuru9qhLfCQqkpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HVF+zLxPBnoU9otuHMKLfHlmPJqSqqGUM2a4q2Fck60pBJ9Y6HsXoipjXMmONqkHm
	 PNJX1lKnsUgeJuHblfplUGpidep+z5ziOJtap1K0t8JiMMBftcLHQOZykx365grS8v
	 295hv8+g4/N6RJ+wx7fqn0nLMpZnO/UnNn2Qo5r09Qck2D3UagUV1hfK5W7qufu02V
	 XaxDeX3DL2T1Fqsnymew7zD1ZnVTQi+7Xg4yTAsSQbF2b6tw0ICjrvBgGnLKPxi2BT
	 BBrgS8hUHHemYUfczhuclQ7zMl1bTeXum3cjDmHWSE924J9lNVxlNz/dWQCR1EfjpB
	 kJmIVlDoAo+vA==
Date: Mon, 11 Aug 2025 18:38:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <joe@dama.to>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, willemdebruijn.kernel@gmail.com,
 ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v4 0/4] net: ethtool: support including Flow
 Label in the flow hash for RSS
Message-ID: <20250811183805.087014a6@kernel.org>
In-Reply-To: <aJqNeO36UpQ5KFI-@MacBook-Air.local>
References: <20250811234212.580748-1-kuba@kernel.org>
	<aJqNeO36UpQ5KFI-@MacBook-Air.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 17:40:24 -0700 Joe Damato wrote:
> Do you think that the docs (Documentation/networking/scaling.rst) should be
> updated to mention this setting and the side effects of using it?

I like writing docs but this feels a little too complicated to describe
in a paragraph in scaling.rst. The rest of the content in that file is
relatively noob-friendly. Dunno..

