Return-Path: <netdev+bounces-165784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92581A33623
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 04:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46962167CF9
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 03:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B417F204F7D;
	Thu, 13 Feb 2025 03:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sr7uodwV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB34204F63
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 03:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739417789; cv=none; b=JTfXlGV1KvLIU5T6WDDvPakaAmNQmB2OCheFvm1fz9EXXMsQwTaMxN4jeQOEEmurnSYQeaxMH4hteN4U0Yk5f+YtAyKoDRRaF74TSGTFUqQ785YNKrYdKuDl927PPnpVqF1bydfo31HC04H/QEJombKqmSmvgXuTB8D2B131iPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739417789; c=relaxed/simple;
	bh=yyN9J1HaUvEhQMHIe2y5rUPP39WjLf/ANTAmCPHjD/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzb5MP++lLIE8aXfXKPS0fpaSwFMojyuxu+DWH5I3z0MkT2UNuqNVLZ2+tWn9ZxJgmcoFuTJPDiwK1zbQgvCfb00wl2cjmEijKAuMcxCBOfPcH5Na4hh1c1DB9Pse8SOsqQmhsSVcxwJjupwVE542RRoSriY1rvdMeAZaBrzda8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sr7uodwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D8EC4CEE4;
	Thu, 13 Feb 2025 03:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739417789;
	bh=yyN9J1HaUvEhQMHIe2y5rUPP39WjLf/ANTAmCPHjD/M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sr7uodwVEIjwA/pUxS1OyRXUXm3XnSXd5Jt/JnPwUyRX+Qa/Yov3GpkVydG1t7n0D
	 sXs4Qgwvn7QworpHVjna5Va46hpxXclRq3TRv4pqY5atBFX+rGvmsfTax76zTd+g7U
	 LzM6gZgiLcnZuJLddkJLPlY/+t5PaGJPhnbi8HeZFg/Bf3C1NBPzhASr1VvatWqK9F
	 glg2EIYqyXFbveLUDmtlyLHVyVZTm5dX7yNsrSEOpYFNqqyG5MFf6/7HZdGGo4Kq8F
	 1GbH5xMPLOtjnkRswPaAFkQASiHSfISei75GDx8EIthhGUFZyV9HFWZfcCfUrZldIq
	 mWdKJgzf1+IXw==
Date: Wed, 12 Feb 2025 19:36:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jeroen de Borst <jeroendb@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 willemb@google.com
Subject: Re: [PATCH NET] gve: Update MAINTAINERS
Message-ID: <20250212193627.630284ac@kernel.org>
In-Reply-To: <20250211194726.1593170-1-jeroendb@google.com>
References: <20250211194726.1593170-1-jeroendb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 11:47:26 -0800 Jeroen de Borst wrote:
>  GOOGLE ETHERNET DRIVERS
>  M:	Jeroen de Borst <jeroendb@google.com>
> -M:	Catherine Sullivan <csully@google.com>
> -R:	Shailend Chand <shailend@google.com>
> +M:	Joshua Washington <joshwash@google.com>
> +M:	Harshitha Ramamurthy <hramamurthy@google.com>

Hm, your base tree has got to be really old, upstream we have Praveen
instead of Catherine:

GOOGLE ETHERNET DRIVERS
M:	Jeroen de Borst <jeroendb@google.com>
M:	Praveen Kaligineedi <pkaligineedi@google.com>
R:	Shailend Chand <shailend@google.com>
L:	netdev@vger.kernel.org
S:	Maintained
F:	Documentation/networking/device_drivers/ethernet/google/gve.rst
F:	drivers/net/ethernet/google

please respin
-- 
pw-bot: cr

