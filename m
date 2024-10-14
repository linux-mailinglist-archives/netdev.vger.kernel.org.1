Return-Path: <netdev+bounces-135177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A6999CA26
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 14:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 359B4B21183
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 12:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEF8158DD1;
	Mon, 14 Oct 2024 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGnAFLrJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820BD13A3F3;
	Mon, 14 Oct 2024 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728909054; cv=none; b=a4UsSaEX4Hj3Y3FieQUFF8WZWJjDAIovh2VEIRX65lc7YAEslEmwDo4i2OwsbCJaJ+YrkEyawDguPyXa/SYNaH7FH/kcCrEmNINFaq1r0Vql47yDc3BlvPnwFlI+QQJ168msS9PYRV+/EU3ZuP1CHVhFolpiPXK4is6EUS9mAAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728909054; c=relaxed/simple;
	bh=1w2lXMaNjPUZjj0BggGaU2E2DAW80+wEucUfAkKlySo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uROGhU6SvGZz4LBpCfCA6MslIutBZK/wjxCYd57RV3imjvS8ICQLHzW/yEy1ceb08mUAzKTxXIK9V85xPHkdVCBPTd5PX27I/JKzDgUT0kVNalBMBPxms5NIIo0ACioWe2Qq94TvPV/N6sQLdaTH1AJ+IisQpAg3gqZm9f8y+yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGnAFLrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A536C4CEC3;
	Mon, 14 Oct 2024 12:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728909054;
	bh=1w2lXMaNjPUZjj0BggGaU2E2DAW80+wEucUfAkKlySo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZGnAFLrJ0+Rd2qguSCsdDc4MQ6NEul2rDcUGYZTfYQDujr3LblDhP8vAlXCtLu2Fc
	 8SMUAu1D6pjNUsObg0cl6TyJDdaet9dSRgNnQnDpbxiywPbb7dLeKurLk/4dfXmZkm
	 WPm4e4delqXXnRGBNZEELeGgZVIqmNI4Ij/fkL6vdDcGOdaEh4nmSFbUxktB1r4Ix/
	 z/pSAaScT7rjKYwfgKgeBe2HkesW6AWt0AmNk1n5KwrZtjbE6yabC9DnvfvenB8fwj
	 tMXqUh239MHV1CA7YuuhURDg4e1fm+eFD/Ae1tj+eieUKcAMXViD2YPIz6Y2fTCXZL
	 9oAOpRIgkSlxQ==
Date: Mon, 14 Oct 2024 13:30:50 +0100
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] tg3: Increase buffer size for IRQ label
Message-ID: <20241014123050.GU77519@kernel.org>
References: <20241014103810.4015718-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014103810.4015718-1-andriy.shevchenko@linux.intel.com>

On Mon, Oct 14, 2024 at 01:38:10PM +0300, Andy Shevchenko wrote:
> GCC is not happy with the current code, e.g.:
> 
> .../tg3.c:11313:37: error: ‘-txrx-’ directive output may be truncated writing 6 bytes into a region of size between 1 and 16 [-Werror=format-truncation=]
> 11313 |                                  "%s-txrx-%d", tp->dev->name, irq_num);
>       |                                     ^~~~~~
> .../tg3.c:11313:34: note: using the range [-2147483648, 2147483647] for directive argument
> 11313 |                                  "%s-txrx-%d", tp->dev->name, irq_num);
> 
> When `make W=1` is supplied, this prevents kernel building. Fix it by
> increasing the buffer size for IRQ label and use sizeoF() instead of
> hard coded constants.
> 
> While at it, move the respective buffer out from the structure as
> it's used only in one caller. This also improves memory footprint
> of struct tg3_napi.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Very nice to see this addressed :)

Reviewed-by: Simon Horman <horms@kernel.org>

