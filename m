Return-Path: <netdev+bounces-133982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849DD9979B9
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96FE11C21B52
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 00:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F331CF9D6;
	Thu, 10 Oct 2024 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2ailaP0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6EFB663;
	Thu, 10 Oct 2024 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728520845; cv=none; b=ORxEsyuIMNNzk+nYs8yx1BRlPEHRNq1xkE6P+LfUbpBHO6uDvARtwfZUMeWg8/Ie5VtZbLFy5gOQ5g5+V2C1Fo//GZzAf5O65QlPkEtrCuzxFzryP9WoDL9TznIFDcz06lDg8RUwyWiJijJDqpJpfmF0qWnw/qAWx1MAbGkJ7OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728520845; c=relaxed/simple;
	bh=LGQQFAe4FHQHQplEGjQktv77dM+d2ZeVL9PVG4kD3UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uz3XoYOfDqowUxazW15XKI8FKflX04ymDByWbzMyHPYvTMk5qZ0DbsMyF7255O9M1i1zynQDIa9vAy/YWMTsa0p4P79aHTT+hDv8arRwkM8+inoHYJS98cBr+c+DiUFDCsnUoAUV7GJHC3+4KPHlMeKY3zEUo2Qnm5PVPUULQO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2ailaP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12007C4CEC3;
	Thu, 10 Oct 2024 00:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728520845;
	bh=LGQQFAe4FHQHQplEGjQktv77dM+d2ZeVL9PVG4kD3UQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d2ailaP0KLqR3VCE0dUQ3JN1ZGhbWnSPWmw7PkNmoAoBJIuKi98bir2R2/BUPXwR3
	 gncKiVUlSOCQjkzN4Of+sxvgPgiJea/vYhYxpub/OLUK7gT4Lw+Sjj256nyurHiM2M
	 m2Ze9vFI8lkWFWRXIlr7NNd97ZPQLb4TupeHIeIVb3vAKWlc/0XQHp+vIvw0Jc7X4E
	 C67br5aaU+/L+np/pUegyO9zzF7aF1StFZktFMQwABfj46Drw7s1EZ7n8gjuZn76J9
	 O6uH3aeMmxVPwnuJGDhzw1Ilr+lCjQYt0z775u/rgpbMwCNr2Kf3us4uuq+OfqcWrG
	 USEHWGY5k7ZhA==
Date: Wed, 9 Oct 2024 17:40:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shengyu Qu <wiagn233@outlook.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net: sfp: change quirks for Alcatel Lucent G-010S-P
Message-ID: <20241009174044.73e1fce0@kernel.org>
In-Reply-To: <TYCPR01MB843714CF627B46DFA06E471B98732@TYCPR01MB8437.jpnprd01.prod.outlook.com>
References: <TYCPR01MB843714CF627B46DFA06E471B98732@TYCPR01MB8437.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 6 Oct 2024 00:04:29 +0800 Shengyu Qu wrote:
> Seems Alcatel Lucent G-010S-P also have the same problem that it uses
> TX_FAULT pin for SOC uart. So apply sfp_fixup_ignore_tx_fault to it.

Looks like your email client (or server) has corrupted the patch.
Please try resending using git send-email?
-- 
pw-bot: cr

