Return-Path: <netdev+bounces-231489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FC0BF99B4
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 03:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF5F4606F7
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522781DE4E1;
	Wed, 22 Oct 2025 01:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NcGbjYMe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3E93F9D2
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 01:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761096482; cv=none; b=niPX5ck9Xi1kACMJFgsiLWXc8VRKfTnxJwWvamOmNAMPtSEmnSyXG+DqUBmDtvJ4MESuLeGfONgaapC6ZhzOaoMy/N26x3KfCiDmqlQVFCftJiYk1DnN+I2AYtUgh3JsHV4/tqPnG5mN8RGX6rIjRIte298+cYOnOT6wEX1EUTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761096482; c=relaxed/simple;
	bh=JkJxzunFFLK1PDhtMOu5+1FjV6q7aUqZM+HmmciG9aM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJtlAOotOjxYmiuRSrsGV8Ib9m36Kc1M/+aE6c3rR9GQ6A4irB/QJVhldEQSpkGU369cGy6aSjeiRU07/h6K1PvsXMszM9WyazM4RTdxn70hR9g7ArfoW1HbaW3g9LEah+/sdlMiOMWor++08z6fGw4nl37ru1WEfiaXlmF2kN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NcGbjYMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495BFC4CEF1;
	Wed, 22 Oct 2025 01:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761096481;
	bh=JkJxzunFFLK1PDhtMOu5+1FjV6q7aUqZM+HmmciG9aM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NcGbjYMetmbJQiq34aqtxvWSN2rGx+aX7rrvqRZqOw+Xvay1TCp7detb7iC6hR2+g
	 xmOY3+Od7PxuNI+6bP5EJ9I5fR9yuytG3CElSyoStLURi5nYBdiSYLsmCwe5dl4yvL
	 8oUcydhLyJOF4om8Z2ggO+cQ1U2XecW9o4MBJYBrKz93io/r1QTckG0EsLUpDWUeSy
	 KpPUIGOtshKxQHq+9wXldNHO97/E2EkgNoeQA6RQgKF8h+gzY/H3vR5O0wShZycci6
	 9Pj9kBTvAwZ8dOTHUWdSTeufq6zIlV/ogTCMkMF1zf2Bar+kxSUsEBN9tjUEP2YXfE
	 AhxLMDarMdmFw==
Date: Tue, 21 Oct 2025 18:28:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Remove code duplication in
 airoha_regs.h
Message-ID: <20251021182800.2c736d21@kernel.org>
In-Reply-To: <20251018-airoha-regs-cosmetics-v1-1-bbf6295c45fd@kernel.org>
References: <20251018-airoha-regs-cosmetics-v1-1-bbf6295c45fd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Oct 2025 11:21:47 +0200 Lorenzo Bianconi wrote:
> This patch does not introduce any logical change, it just removes
> duplicated code in airoha_regs.h.
> Fix naming conventions in airoha_regs.h.

Appears not to apply
-- 
pw-bot: cr

