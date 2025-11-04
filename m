Return-Path: <netdev+bounces-235396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB72AC2FD7C
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 09:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5492E34D64B
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 08:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345B7313E03;
	Tue,  4 Nov 2025 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EX3qRrcN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079C8306B0D;
	Tue,  4 Nov 2025 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244345; cv=none; b=H0zZrZp2/pHNiYIS0H3kMuzggPXKndThBcvPTF2LP7E5UHJu7z8snA18OWxZ6W3S6JojRw4dZW/45KNcj00Te4vR2dYW+MZWyiUT0CWQ2f7hAdkHkvzbFii6EK44yQ+AnJKve1FXl+3QaZ4MrCYdKL2SIxnAsLdXr6r4cbPzEcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244345; c=relaxed/simple;
	bh=i4i2ZezZUkHgyxzI36i1jgZxCZSfy03Oaa0uCLjqanU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELzHgAwE/DTkBudC6/rMrFU4OjluVKT7q1q9QBGCGTGrEDeRCYjfQGvR7bRORyP5rJ62Hg5dgCcQaXW6Fpzo5kz48v3j0EWztp076WhKdPAlvVuDvTuoIgkdSgd5LVNvDh9ZCljuibn4d76a/QTzL9RxiwJpK/z+phuRQpterKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EX3qRrcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927A6C4CEF7;
	Tue,  4 Nov 2025 08:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762244344;
	bh=i4i2ZezZUkHgyxzI36i1jgZxCZSfy03Oaa0uCLjqanU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EX3qRrcNsxISHXHS3gzCD3Q+b90CC4lAcftjm0w3Ite6R4rXomGsnm4tqFBqYOBbO
	 NT29rRKutGn8d1BWvXZgSzWx3d0eHPCSjDk7iwpkP6I3hRZcYj1SSmMV1gcI4dPsMb
	 c6hu+ZgxWlSPmfFbBJa3+qMDKfRPtD/AlDjzqa+yHRsd8j1EmMaEk9urXUYFt975k+
	 vlSNOV9xLf5+DpkPy3nNQwce5lq7Kro2PnzI3gbusASkI3Z6aOfpw3ldRE+ittBwZQ
	 mQoC/OQxInggfVu74SM/X/Pxt3FfzYcBUYcqCX0EAud0fx+rVJIAnQV1ihGgW7oFi2
	 9oeKFf88+901w==
Date: Tue, 4 Nov 2025 09:19:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v3 1/4] dt-bindings: net: ftgmac100: Add delay
 properties for AST2600
Message-ID: <20251104-victorious-crab-of-recreation-d10bf4@kuoka>
References: <20251103-rgmii_delay_2600-v3-0-e2af2656f7d7@aspeedtech.com>
 <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103-rgmii_delay_2600-v3-1-e2af2656f7d7@aspeedtech.com>

On Mon, Nov 03, 2025 at 03:39:16PM +0800, Jacky Chou wrote:
> Create the new compatibles to identify AST2600 MAC0/1 and MAC3/4.
> Add conditional schema constraints for Aspeed AST2600 MAC controllers:
> - For "aspeed,ast2600-mac01", require rx/tx-internal-delay-ps properties
>   with 45ps step.
> - For "aspeed,ast2600-mac23", require rx/tx-internal-delay-ps properties
>   with 250ps step.

That difference does not justify different compatibles. Basically you
said they have same programming model, just different hardware
characteristics, so same compatible.

Best regards,
Krzysztof


