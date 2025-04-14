Return-Path: <netdev+bounces-182320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E945FA887D3
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733F63A97B8
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E975C27F732;
	Mon, 14 Apr 2025 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="o+W4stEl"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC11F3D54;
	Mon, 14 Apr 2025 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646092; cv=none; b=oHoyOff6idIp7L9hVJ6cyLQz4Z+LhjqHTW/9RTd0YGSFEZhOq09mk9Eqdg324+c/dXhgEFgu6J3gIZL1MFuTmtnzC8S5CRki9JcozAva1WueAomnXrMSr7Y1CQlL4vwmREjycoaHvhXMEJsn4cCFavop+OugjXSkMIz9ZWNpHcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646092; c=relaxed/simple;
	bh=C9knOfhyNn7pBqhOZDqaRgO9Pi2Kzqbu/2YzRbqiu0E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SQeMww6rrT5/szVev2md2JuY8GTc8zaI8FEt5EOqLWgPiNiC0KfJr7gJezOmXTrlaoyOwcxTm7iHLxRZLZNFWzn9R6Fg5dOSsnKb5XXSUqBGUEVRJB3A7p23K0QoYRTqbwOmQ1aqB/Y+bz+GKaL8iP4W0g7mJqPhrXD0i0oEMek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=o+W4stEl; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 763B141062
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1744646090; bh=hpXdb6ga9QdFOjNmzZyes+BogiP51Z4H4avHqOOc2i0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=o+W4stElfcWSaIsG2fkOGPdkvRWbKtrjS3xMLkrkSsqNdMYrTmm8omoCCGkrIdChn
	 JWqmRtK15fPWtPS4BYNX3hIr0Ro94Ny5UDNI6OxxG8PxJROccm9Be0aFKx23Mki93f
	 Y4ngrXPYtGkq4rLzlViGycDlg2i99Rfq0FcQcSrZnOSyeVPnqZ8Q+zMSnaG7KXJK7z
	 BdjIEEmebgi1SybqtRA7KwlxD1/xd8uiKrGIFUc39Xjg3pvZBk6ZYjMq5nP4N80she
	 vVpVMBO59y53/VYCOUast+Hk3ZA/J6nwPulzWcFethQRQP6sHqy6KPuqnyncIoxIVw
	 nqwnhe69SxdYw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 763B141062;
	Mon, 14 Apr 2025 15:54:50 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, Russell
 King <linux@armlinux.org.uk>, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Implement kernel-doc in Python
In-Reply-To: <87mscibwm8.fsf@trenco.lwn.net>
References: <cover.1744106241.git.mchehab+huawei@kernel.org>
 <871pu1193r.fsf@trenco.lwn.net> <Z_zYXAJcTD-c3xTe@black.fi.intel.com>
 <87mscibwm8.fsf@trenco.lwn.net>
Date: Mon, 14 Apr 2025 09:54:49 -0600
Message-ID: <87ecxubuwm.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

> Andy Shevchenko <andriy.shevchenko@intel.com> writes:
>
>> On Wed, Apr 09, 2025 at 12:30:00PM -0600, Jonathan Corbet wrote:
>>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>>> 
>>> > This changeset contains the kernel-doc.py script to replace the verable
>>> > kernel-doc originally written in Perl. It replaces the first version and the
>>> > second series I sent on the top of it.
>>> 
>>> OK, I've applied it, looked at the (minimal) changes in output, and
>>> concluded that it's good - all this stuff is now in docs-next.  Many
>>> thanks for doing this!
>>> 
>>> I'm going to hold off on other documentation patches for a day or two
>>> just in case anything turns up.  But it looks awfully good.
>>
>> This started well, until it becomes a scripts/lib/kdoc.
>> So, it makes the `make O=...` builds dirty *). Please make sure this doesn't leave
>> "disgusting turd" )as said by Linus) in the clean tree.
>>
>> *) it creates that __pycache__ disaster. And no, .gitignore IS NOT a solution.

Actually, I find myself unable to reproduce this; can you tell me how
you get Python to create that directory on your system?  Which version
of Python?

Thanks,

jon

