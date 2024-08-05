Return-Path: <netdev+bounces-115875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC93A9483BE
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 22:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC18283FC9
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 20:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5370514E2E8;
	Mon,  5 Aug 2024 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oz6GlXX/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FABD1684B9
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722891297; cv=none; b=GM1ppQU+5DehGXoMH372rDa9dRrLbk076GhELM7HOfJ79mtlEp0QSuCOXmC4ePjrzyHFCml7vY8mm/+gaFjekShAjnrIwhVv1hIwGLPi8DRIePPONdsdvpr+zzBVD7KGW8Xejy5RW3VZH+sJLfKIamtloceY99VuyImEOreEyLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722891297; c=relaxed/simple;
	bh=GxZ2czJs3+sMc+NvjhuzVUPDLvNKRaTE5kEYsOO02f0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gne3RsDMdhvhuL1v4bOlUT5mS7GvvwQZOLG7meZ//E1eB7GVmZmBaBx9SYJ4kTQ127mgio0YCi/xNKdo8Ut6tt/ObEZO33JYPyt2XGGTLIzpknB2ne9v/Fcb7AfGy3vCyPsmwNYYGOA/K7WbR6IpNECxIEXoMVS+M6b8lKHXOHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oz6GlXX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864AFC32782;
	Mon,  5 Aug 2024 20:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722891296;
	bh=GxZ2czJs3+sMc+NvjhuzVUPDLvNKRaTE5kEYsOO02f0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oz6GlXX/F0COCaikRLtDSityjOfLXGKg0bQG8P/bwaBn4vSIEsvyNSmytH/7khLwK
	 5dj09rG0aVPtiKO3PhL/qHRAa2qnXc+oKKDbPeqxXZu5G23kn/EHHLuSPjN7zcdO/F
	 JxHV4F28R74p471cTy9eyDKmpXFUVhl+7D78IpMREhEMH+Hg4NqNkmU+Z3dLFkp4a7
	 xGt29Wcw1yvs7WmPvPWI1XtGoZ7ZtdRgcoM7Ge60vggnctTYQNLqBT9oE9RRkAVAL4
	 nENxum1HQnl35QqBUF8BzXqFslBnjaOkXLX8o+jgEuh47hwzxKc5eeevGSH8l1dvfd
	 iWSN2sYUJKhyQ==
Date: Mon, 5 Aug 2024 13:54:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: o.rempel@pengutronix.de, lukma@denx.de
Cc: Martin Whitaker <foss@martin-whitaker.me.uk>, woojung.huh@microchip.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org
Subject: Re: Regression in KSZ9477 dsa driver - KSZ9567 et al. do not
 support EEE
Message-ID: <20240805135455.389c906b@kernel.org>
In-Reply-To: <137ce1ee-0b68-4c96-a717-c8164b514eec@martin-whitaker.me.uk>
References: <137ce1ee-0b68-4c96-a717-c8164b514eec@martin-whitaker.me.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Aug 2024 13:15:49 +0100 Martin Whitaker wrote:
> I have an embedded processor board running Linux that incorporates a
> KSZ9567 ethernet switch. When using Linux 6.1 I can establish a stable
> connection between two of these boards. When using Linux 6.6, the link
> repeatedly drops and reconnects every few seconds.
> 
>  From bisection, this bug was introduced in the patch series "net: add
> EEE support for KSZ9477 switch family" which was merged in commit
> 9b0bf4f77162.
> 
> As noted in the errata for these devices, EEE support is not fully
> operational in the KSZ9477, KSZ9567, KSZ9896, and KSZ9897 devices,
> causing link drops when connected to another device that supports EEE.
> 
> A fix for this regression was merged in commit 08c6d8bae48c2, but only
> for the KSZ9477. This fix should be extended to the other affected
> devices as follows:

Thanks for the analysis, adding to CC the folks who wrote the commits
you mention.

> diff --git a/drivers/net/dsa/microchip/ksz_common.c
> b/drivers/net/dsa/microchip/ksz_common.c
> index 419476d07fa2..091dae6ac921 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -2346,6 +2346,9 @@ static u32 ksz_get_phy_flags(struct dsa_switch
> *ds, int port)
>                          return MICREL_KSZ8_P1_ERRATA;
>                  break;
>          case KSZ9477_CHIP_ID:
> +       case KSZ9567_CHIP_ID:
> +       case KSZ9896_CHIP_ID:
> +       case KSZ9897_CHIP_ID:
>                  /* KSZ9477 Errata DS80000754C
>                   *
>                   * Module 4: Energy Efficient Ethernet (EEE) feature
> select must
> 
> I have verified this fixes the bug for the KSZ9567 on my board.
> 


