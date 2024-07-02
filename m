Return-Path: <netdev+bounces-108615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691C6924990
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 22:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4801C22AE3
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 20:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7B8200134;
	Tue,  2 Jul 2024 20:47:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3B41E531;
	Tue,  2 Jul 2024 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953271; cv=none; b=d0oYQBEDYLZXQCYXy7pS/hTlAJ/zgCPBA+fFz+gBad0n8prePuq1WRv4R2zVLMFrIzTMyJ+xNuhYHkEIXK0eDmp6hHOK46pTz2iICIm1Bp5ZNQ+AU25gac7LiH+gg2r+HErYUQs1dzb15Yl+7iWw2OulSJdwhTmF8JAsm07LaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953271; c=relaxed/simple;
	bh=0mfKML5YdAAG2tBLmjBtcbFJBQL1ZJApZDKstbioGaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uz6eOL6TigmJCdk6d2Pwm0w7KmMxd/jKVYE6RAcVhnqTrCZmjGuaxD/7lFYxGjZLYV4Fa82X4+lMinBvAGbNIiNWwoACOpkvhBgWRLPPXQ37hbzCGMllI5N818ijYIlS/l+MMS22i2/5WcEfPINq/cKh1oCN/YUk+8Vo9KEpavs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047C4C116B1;
	Tue,  2 Jul 2024 20:47:48 +0000 (UTC)
Date: Tue, 2 Jul 2024 16:47:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Carlos Bilbao
 <carlos.bilbao.osdev@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 ksummit@lists.linux.dev
Subject: Re: [PATCH v2 0/2] Documentation: update information for mailing
 lists
Message-ID: <20240702164747.2e45ce66@rorschach.local.home>
In-Reply-To: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
References: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 14:24:05 -0400
Konstantin Ryabitsev <konstantin@linuxfoundation.org> wrote:

> - drops the recommendation to use /r/ subpaths in lore.kernel.org links
> (it has been unnecessary for a number of years)
> - adds some detail on how to reference specific Link trailers from
> inside the commit message
> 
> Some of these changes are the result of discussions on the ksummit
> mailing list [2].
> 
> Link: https://subspace.kernel.org # [1]
> Link: https://lore.kernel.org/20240617-arboreal-industrious-hedgehog-5b84ae@meerkat/ # [2]
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> ---
> Changes in v2:
> - Minor wording changes to text and commit messages based on feedback.
> - Link to v1: https://lore.kernel.org/r/20240618-docs-patch-msgid-link-v1-0-30555f3f5ad4@linuxfoundation.org

Should drop the '/r' ;-)

-- Steve

