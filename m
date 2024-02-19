Return-Path: <netdev+bounces-73037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6B985AAC8
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 207C91C21964
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A16481B5;
	Mon, 19 Feb 2024 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DW+Ep0xK"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5B547F79
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366739; cv=none; b=NVyABTE+H2p7ZV4exYAX4z6zN7HctgLHxrCcrNDcVGdnmsRMb7EcnmF07ApOgBCENuG496hR4uLN7Wik285HvEjHRnRBg+p31POvJtZg+XLDIVfjR5vPa6MDt1zyu2b8tzOWTppTAVIazVuxqA0De5vZV+85wrkeXcLpsgyi9pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366739; c=relaxed/simple;
	bh=1BhJtg4sDYtqPXtXiTvYSE0Y9VY726o85DDNk1wTwGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gHGxrX9sV9MEjH+6P7plcJqkciYgMsourFfjiu29uwzkweRsEEVclYhdbQZ8Z9/AyanigxVoq2TI0YueyfDNPswzsO1QDmqSKZar69OYghdJpfFgSwVZmKjRmh8eYgTLy0R1ubcSQbenDTpSb+hIUo8nAc0ceCVq8MDHJ4NZ92M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DW+Ep0xK; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 02EC3C0004;
	Mon, 19 Feb 2024 18:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708366735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/LkTROhVnidSuXtjxnbZAbgzQvpAH2MK3H8e76cL8cY=;
	b=DW+Ep0xKBZY304KAbKeyV2R/NHY2LA1AStueKDXFmjGxSEi0BS8K4PscD2CdM82rG1kEbb
	GcWeN8I6mL44T6LU/bVOSU1Uz5HVvU9xOHOESXiWmlzQ0Vf3zxuO6uUU5s9T32SCZuykOq
	ApyhZEDhHeg15o0CZZQC8pFepOqlgqLy20Fbtg8qUsWVaocOqde6xDZf4PGCi5stGMI9DJ
	Gri4Vcpgnr7FLnVYsF7oAlidXP9xQAIBalDmn85Fc3kBhBE7fioEpNIvLGQ1LoCFa36pVE
	g8cGb8ZTvUm8EreYp7Y8FL9kRvhfUaCNzVCtz+F2V2479giwU1DNtjEePP+nDA==
Date: Mon, 19 Feb 2024 19:18:54 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, netdev@vger.kernel.org
Subject: Re: [PATCH net] MAINTAINERS: Add framer headers to NETWORKING
 [GENERAL]
Message-ID: <20240219191854.18ba0f8f@bootlin.com>
In-Reply-To: <20240219-framer-maintainer-v1-1-b95e92985c4d@kernel.org>
References: <20240219-framer-maintainer-v1-1-b95e92985c4d@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Simon,

On Mon, 19 Feb 2024 17:55:31 +0000
Simon Horman <horms@kernel.org> wrote:

> The cited commit [1] added framer support under drivers/net/wan,
> which is covered by NETWORKING [GENERAL]. And it is implied
> that framer-provider.h and framer.h, which were also added
> buy the same patch, are also maintained as part of NETWORKING [GENERAL].
> 
> Make this explicit by adding these files to the corresponding
> section in MAINTAINERS.
> 
> [1] 82c944d05b1a ("net: wan: Add framer framework support")
> 
> Signed-off-by: Simon Horman <horms@kernel.org>

Thanks for this patch.

Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

