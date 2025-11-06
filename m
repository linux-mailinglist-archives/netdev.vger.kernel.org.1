Return-Path: <netdev+bounces-236471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB48C3CB78
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 18:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271E3188DCAA
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 17:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14B430EF96;
	Thu,  6 Nov 2025 17:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="xCljxPQP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jusofg/7"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F271D18E1F;
	Thu,  6 Nov 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448869; cv=none; b=JDGH2sXXVbQNhuIiB16cpV0vJWnIrfTob49F/X5fGAh85yUVy66aljPBeAbD/jXEMZyv6DBXSk8AHOtN2MHPluNlNRuy7ISX085spwJwXnlAbZZd1ezza6J/lo8ZH+k6P60nXgVj2RHthZ5x3/Q0+GCEMFrwfgfcCWgmQNme/MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448869; c=relaxed/simple;
	bh=h1058CZvmcEAuS48xVbeNUx2rGhH6qDGWSw72hhAycE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDklGOmDTV5sAbigTSJnYwSxUVbaU/6OMzPkzC7BI8rJZ9w2D20n0FlaL5ZR0C4bzcr1eHVgcmPfUVATHHdlN50KAR/uspVpbAKkI6xqBqkxrVj3k6dUg8NcgZQqVFnL+m07d4GwoUUz15Tqi06ao7PFp4mfl2LcqdbmSpaJqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=xCljxPQP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jusofg/7; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E337FEC00D3;
	Thu,  6 Nov 2025 12:07:44 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 06 Nov 2025 12:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1762448864; x=
	1762535264; bh=yl1ymtp/RyH/pP2ToBzXQ5l7JFAI5bU3TI9lUfWo91A=; b=x
	CljxPQPmtP8HCoH/NjGaVIVMNq40uKF5CnEUWR+EitSz1d+B4/g3S8zhJfQHIWA+
	6iU0o5ZXunwfy/84RLbKUUrsEcLujEgPZM5iZHleB74I3wOE/8LEtOvUFL+4DQHo
	jmz4VNAORiGA71vxMZHOKQwwxSvJGqxf3Xi/9qI1U9xUpsTJUzOa8SxM5Bdl4cLe
	k0QEvxu5dPVgk1ZvBmdjdzgIcHimaVDh8w9A0VFdIieYc76utpm2AFpNbGQoALTH
	3XU4IVf2AdussfRLgsYAtGDggvr6Bpa/H7ykYydHdRn3+8F9/u17wlMuyCy+07wM
	vIP014n42f9TIRKdQXXTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762448864; x=1762535264; bh=yl1ymtp/RyH/pP2ToBzXQ5l7JFAI5bU3TI9
	lUfWo91A=; b=jusofg/7lKzEacMBsWUoUMmQPTeySJsx67J4JKfF3P9cCvt3C9N
	9oELAS2tuc5FtWQ1hf2VseMKNEJOfMOBFDkN5YkhF7jIEVZiib0JB8F5cd/vbRLQ
	MtR6dqC4DMA5gSd4bXey5rj0TaBbqpnbQLkDhStMcb2Z9idMUETKy0Npgi/tr5qt
	GPuN5DiNxxrCMKIokfYVE+WTKyYVZeO4YmwDrUzqsVKi8Bls4dZ33bN7xUjzrssw
	6T30dVCp7NCOE2KaDkJ4Z+rLfOPJCUHr4HfphD/emZNYr1TTJc3fZCj/iOGiMbKA
	kwT5mNVVmgoNpAr7OiItosxw3Cflx+OrbNA==
X-ME-Sender: <xms:3tUMaa31a3QL0xjs96vK7V1WrPyMK_4OzESfcBZfConYhKkrv1nAxQ>
    <xme:3tUMadh710VVUnPPGcuhFHlDYJLCy-XpqayVRm0AL-jkoxLJq7ccNjRZNbshOJuyV
    Kl3fy61_4Mjn_ow49sCUjHO90XUpYPI6nir9iDrNMoaE4V5hWp3ng>
X-ME-Received: <xmr:3tUMaSo7BzJccg1Ktt7ED5k6kzT1nLRNgXpX0yMK3GcyVLc28ERFukfZxE-B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeejfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttdejnecuhfhrohhmpefurggsrhhinhgrucffuhgsrhhotggruceoshgusehquhgvrghs
    hihsnhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhffhfffgfffhfeeuieduge
    dtfefhkeegteehgeehieffgfeuvdeuffefgfduffenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehsugesqhhuvggrshihshhnrghilhdrnhgvth
    dpnhgspghrtghpthhtohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegt
    lhhfjedttdefkeefsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdp
    rhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephh
    gvrhgsvghrthesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopehk
    uhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:3tUMaYO8hRnaUS-kr4eiWQPPvyG-yj7EuVNHrDE528RBxclT3P5ROQ>
    <xmx:3tUMaW0AvoI92bPUXANQYHOQaDGLzSX86dVHh_P8Qmz30t02b0XWOA>
    <xmx:3tUMaep7d_1FF6Tvm79ZI186rLqoby6DhKgH9Trpoxyjo_x31gi1Sw>
    <xmx:3tUMaYeGPYHBPH-W5IGtGo0P17-8c3vUnX7EjDtbWCnVriaAPfGNdA>
    <xmx:4NUMaeW3MTksGZ5dmESMcOQ3Vhc0_TAFhPABpul8o8TAnWegavp2DYuK>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Nov 2025 12:07:42 -0500 (EST)
Date: Thu, 6 Nov 2025 18:07:40 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: clingfei <clf700383@gmail.com>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
	herbert@gondor.apana.org.au, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, steffen.klassert@secunet.com, eadavis@qq.com,
	ssrane_b23@ee.vjti.ac.in,
	syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCHSET IPSec 0/3] net: key: Fix address family validation and
 integer overflow in set_ipsecrequest
Message-ID: <aQzV3KHoF4Kk6DGF@krikkit>
References: <20251106135658.866481-1-1599101385@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251106135658.866481-1-1599101385@qq.com>

2025-11-06, 21:56:55 +0800, clingfei wrote:
> From: Cheng Lingfei <clf700383@gmail.com>
> 
> Hi,
> 
> This patchset addresses a security issue in the PF_KEYv2 implementation where
> improper address family validation could lead to integer overflows and buffer
> calculation errors in the set_ipsecrequest() function.
> 
> The core problem stems from two interrelated issues:
> 
> 1. The `family` parameter in set_ipsecrequest() is declared as u8 but receives
>    a 16-bit value, causing truncation of the upper byte.
> 
> 2. pfkey_sockaddr_len() returns 0 for unsupported address families, but the
>    calling code doesn't properly validate this return value before using it in
>    size calculations, leading to potential integer overflows.
> 
> The patchset is structured as follows:
> 
> Patch 1/3: Corrects the type of the family argument from u8 to u16 to prevent
>            truncation of 16-bit address family values.
> 
> Patch 2/3: Adds proper validation for the return value of pfkey_sockaddr_len()
>            to catch unsupported address families early.
> 
> Patch 3/3: Enhances the error handling to ensure zero-length allocations are
>            properly rejected and adds appropriate error returns.
> 
> This series fixes the original issue introduced in:
> Fixes: 14ad6ed30a10 ("net: allow small head cache usage with large MAX_SKB_FRAGS values")

This doesn't seem right. It looks more like a mismatch between the
size computation done before allocating the skb and the space actually
needed, and commit 14ad6ed30a10 made the pre-existing bug more visible.

-- 
Sabrina

