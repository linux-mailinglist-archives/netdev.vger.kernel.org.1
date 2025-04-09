Return-Path: <netdev+bounces-180916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9631A82EB5
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 20:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EB0B7AD78E
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091A02777FE;
	Wed,  9 Apr 2025 18:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="fK0d6nCx"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3371D5147;
	Wed,  9 Apr 2025 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744223413; cv=none; b=NyND5QJjx8bPSv3px7qP3s291xXs3gWI1qccjul/ms/ePPZvvcmlamBhA8ughUBnKqKkiVNSw24NIiwkfuszF73o09Z0NvcR0VDHbzlRC0UP+ezWOzlM8njiLwTlGpqXQPDd7s+ujIOuE52DEuCiYcbUu0hsHHcx4tzaVstzyLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744223413; c=relaxed/simple;
	bh=tGFsw14h5OeAVPFvddaRLvoSsBytpqgiiZL6EnjAReI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F1v2QgPdQVOl9+yL4s8/W7748RS97PLEOicUa2noo1v/AVbyWNUx1vY/X7WYFjy51n3ytpUCPfwuVrhCF+yh63kS+ugVB8JWCk3TxO5R53eeZEayxloW9Ojt5Yn85VCGNInbdQVQVJEKCL4c8ZUZZkNkkmy6unW3pLVcczm+1z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=fK0d6nCx; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7A4D941062
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1744223401; bh=YNhDsA6EC7tTNuxyu13gmMdxXJtGkKEH8Eh077Q3IuU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fK0d6nCxjR0dClz3TBGivw/S3vHppeH5H/vI2WJBnaEGTcwMO9ZZomxQ+gIv+djxz
	 kr7J3dc6Pf6WOv6CPOlDaxoL40xyyeo7htCPr5mOZW1mZGwlnR57jFY9yFkBdywDWU
	 MToPyOFQcS+KfxUvZaFG5Tsi5hv9oI8OEzU3iNG3c87wVpbyFgV+i+S3wcGl+amb/R
	 J85GtZfTip67TgHXfW+j7sUWi8RLDWCyJ15+bLgC+s3IB6TdWXesbYN5VlzWIqADxR
	 605K9QQMZQ7sbRGO325QLb1mPgx4Xb9UrOmIGLXcxHi1tol7AQa37sksBWPjtGKbOT
	 hbwhEHwKlTgsQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7A4D941062;
	Wed,  9 Apr 2025 18:30:01 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Kees Cook <kees@kernel.org>, Russell King
 <linux@armlinux.org.uk>, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 00/33] Implement kernel-doc in Python
In-Reply-To: <cover.1744106241.git.mchehab+huawei@kernel.org>
References: <cover.1744106241.git.mchehab+huawei@kernel.org>
Date: Wed, 09 Apr 2025 12:30:00 -0600
Message-ID: <871pu1193r.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> This changeset contains the kernel-doc.py script to replace the verable
> kernel-doc originally written in Perl. It replaces the first version and the
> second series I sent on the top of it.

OK, I've applied it, looked at the (minimal) changes in output, and
concluded that it's good - all this stuff is now in docs-next.  Many
thanks for doing this!

I'm going to hold off on other documentation patches for a day or two
just in case anything turns up.  But it looks awfully good.

Thanks,

jon

