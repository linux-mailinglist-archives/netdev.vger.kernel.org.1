Return-Path: <netdev+bounces-226127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2552B9CB68
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 01:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83F1176A59
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 23:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE9325742C;
	Wed, 24 Sep 2025 23:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6bcqTxG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560EE611E;
	Wed, 24 Sep 2025 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757694; cv=none; b=Gvs8F1RZwXW+pm8TP1CAIINKxnGy/F91GbB8stlYAmmQZ85RFbfNYIemqvp8TZ6R+APD+hvW2tyLr+R2hQ1HrP+xZJcKpIjltS6akw1s2md2XAnePGvipfdHnKm1UbKENIux0YB638xkwkHIWqh/8n0KPbtPEFh5mHpD+1OOYDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757694; c=relaxed/simple;
	bh=5X6qdcXYzNCPFMlnp7DLidSigMvUmD1M/KvUGEyjd+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7U5GN4L+1dPZOZWzS578upde2t003z4u0t1OPteErcotQu1QFNdrfH4NUkJ9T+moFq0quiawJJGt6tVah7JEM5/kjl/wgERlf8Bv5n5aKwPZ7ilkt0jZw+UG5QV16JkjZ/J1sVvh3r7gYJAYySGtoNFeKV5JpHk34NRCMVUXoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6bcqTxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E29C4CEE7;
	Wed, 24 Sep 2025 23:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758757692;
	bh=5X6qdcXYzNCPFMlnp7DLidSigMvUmD1M/KvUGEyjd+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l6bcqTxGyiiCIdp7m2DGULN0SQoeMg1Nfmzfo73Vs+a0GZiTM49d7WXvtVyQMv+Yc
	 egvHfVQZiqSHxcutWsPhC0vc4PH1XS5ql7XJ948OncpyFIH6OFuLjsOP47hPJxmp+2
	 GzHt6m2JyC4s2v9no3fPOobwRuvMVbizWrvjbw+mckNHtmWvDFiQ/vbZElSi0lM+JC
	 8n9henNnuk+JsopigjnOSOreRg1CxOkHJJrGfGjIbaBmFgh7SA0aHnDyDh/KzZbMXb
	 pG4G+G5atz3pZIjMNu6aesQqU7O4f+5aDGh+tQbmXKHPQSJjO/WOWxWH2PtQjLdGv0
	 msaf4+3nKRZOQ==
Date: Wed, 24 Sep 2025 16:48:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Herve Codina <herve.codina@bootlin.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3] net: wan: framer: Add version sysfs attribute for
 the Lantiq PEF2256 framer
Message-ID: <20250924164811.3952a2d7@kernel.org>
In-Reply-To: <77a27941d6924b1009df0162ed9f0fa07ed6e431.1758726302.git.christophe.leroy@csgroup.eu>
References: <77a27941d6924b1009df0162ed9f0fa07ed6e431.1758726302.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 17:06:47 +0200 Christophe Leroy wrote:
> Lantiq PEF2256 framer has some little differences in behaviour
> depending on its version.
> 
> Add a sysfs attribute to allow user applications to know the
> version.

Outsider question perhaps but what is the version of?
It sounds like a HW revision but point releases for ASICs are quite
uncommon. So I suspect it's some SW/FW version?

We generally recommend using devlink dev info for reporting all sort 
of versions...
-- 
pw-bot: cr

