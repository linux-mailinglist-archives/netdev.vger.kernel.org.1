Return-Path: <netdev+bounces-42610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3467CF8B5
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 14:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291D01C20AD9
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EB4210FC;
	Thu, 19 Oct 2023 12:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNsTLVhE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F3F1DFC3;
	Thu, 19 Oct 2023 12:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67101C433C8;
	Thu, 19 Oct 2023 12:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697718464;
	bh=6pLtasYutjsQq5OHpq4USMERf4M+2OpzADP2WRftPh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TNsTLVhE1DiIT6iCpLU2mPTrlzxXXXgtBTRQP0L7NT0GtwPwo5O7WH9heGe5EDkqc
	 0G4zqWNDK4j4tYb5y5BWSgiIm36j2sGOUDSaoHE74Yk8SahZoGuEZySMsorGVLO5bG
	 kvLZhP8c0bK41Io+r/mHQwsfyDWR1MouHiRp/gPgSHH4cJ2lPrdp2vWT7K8GpFLLsc
	 ZbwcTt6gFL5Y1rFW/IqzugorVTlbxnNJn+l3XiEKQ4bxISw9F6/bOKI0rXRWvWhhJq
	 kNkJdIuEv+sTLdD6P3UeJJVahYJS0y3AZx0ffiBfavr+V4TXvRUl1goN/Cr8wahjtY
	 3RuyAvXpnu9QQ==
Date: Thu, 19 Oct 2023 14:27:40 +0200
From: Simon Horman <horms@kernel.org>
To: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc: Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Coiby Xu <coiby.xu@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kumaran.4353@gmail.com
Subject: Re: [PATCH v2 1/2] staging: qlge: Fix coding style in qlge.h
Message-ID: <20231019122740.GG2100445@kernel.org>
References: <cover.1697657604.git.nandhakumar.singaram@gmail.com>
 <cec5ab120f3c110a4699757c8b364f4be1575ad7.1697657604.git.nandhakumar.singaram@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cec5ab120f3c110a4699757c8b364f4be1575ad7.1697657604.git.nandhakumar.singaram@gmail.com>

On Wed, Oct 18, 2023 at 12:46:00PM -0700, Nandha Kumar Singaram wrote:
> Replace all occurrnces of (1<<x) by BIT(x) to get rid of checkpatch.pl
> "CHECK" output "Prefer using the BIT macro"
> 
> Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>

Thanks Nandha,

these changes look good to me.
But I would like to ask if not updating
Q_LEN_V and LEN_V is intentional.

