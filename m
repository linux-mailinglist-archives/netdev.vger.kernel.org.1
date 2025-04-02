Return-Path: <netdev+bounces-178709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ADDA785E3
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 02:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA4D57A23DB
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 00:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142E64400;
	Wed,  2 Apr 2025 00:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCsLNG9a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D391FBA4A;
	Wed,  2 Apr 2025 00:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743555261; cv=none; b=P8I4DADxqGQ3NbaMcKENhxE6UhKgdiomoOA+sin2keCpyDwalMTg16QkvrxZVZaz7rj6Rfr/KbVUFi7MTkxEKKZgAWCBCZpVpPvIdK2RRA8VxInH2OWm1B1qFL6powSD8l+pzFbsSkyDgoO+bcqhyszmHA/yZVB3b6698WohkDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743555261; c=relaxed/simple;
	bh=/0zz4PKfcfSmXN/45Xp1mSPvrRuJjBxRJOJ/lyfE7UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjBXbdtkqAA8SZn+KcKiyHagxURpIUuzJwTLlutzNTwLIHqyVOTb5bo47mrHSMCdVbncDpLSzt7JkaSSdPQ9vCaecieANA6SQDdEPrKd+75RLADAWTikMzXy3XTG2xIZsjxvdBwrb6C2EsrYf76MXi3EY4eTCBno6gF32aC2eJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCsLNG9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A460DC4CEE4;
	Wed,  2 Apr 2025 00:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743555258;
	bh=/0zz4PKfcfSmXN/45Xp1mSPvrRuJjBxRJOJ/lyfE7UQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RCsLNG9aVi3V82xZ/6oEZSNsQF3BjRuXv1neERksnDPnGCtMulh/64xNESG3RWsLl
	 yf30ngBuNOZsW+CbTIph1qQZBntJlB18XYzKzp5dyS1/AB7kBXnukbZviRs7IAECxw
	 ZNx6Y8FUXHYOd5lx3/UHBVueom3RJ8c4bKNyUCHJUXhbqQsIUmU6hgrCIaBvIMW9nk
	 jTENZXw45YJD8S3MXD7LQTYNs4QNntCXh61n7h0tI+qrlM3PAiQ5tujo51WezBgp5l
	 sc+mIgxrTiyPa6Jp9gXUUniAF6io3Au2Smjys6blKdV/JkBfCdwuI0cSoOVbDMjx8M
	 9ZUuwkPdBbcuA==
Date: Tue, 1 Apr 2025 17:54:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <Ryan.Wanner@microchip.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
 <claudiu.beznea@tuxon.dev>, <nicolas.ferre@microchip.com>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/6] dt-bindings: net: cdns,macb: add sama7d65 ethernet
 interface
Message-ID: <20250401175326.1b0ae7d5@kernel.org>
In-Reply-To: <392b078b38d15f6adf88771113043044f31e8cd6.1743523114.git.Ryan.Wanner@microchip.com>
References: <cover.1743523114.git.Ryan.Wanner@microchip.com>
	<392b078b38d15f6adf88771113043044f31e8cd6.1743523114.git.Ryan.Wanner@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Apr 2025 09:13:17 -0700 Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Add documentation for sama7d65 ethernet interface.

## Form letter - net-next-closed

Linus already pulled net-next material v6.15 and therefore net-next is closed
for new drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Apr 7th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed


