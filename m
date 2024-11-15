Return-Path: <netdev+bounces-145511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD0A9CFB32
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 00:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94595B25AA8
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7D919E982;
	Fri, 15 Nov 2024 23:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngBBDJaS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA918DF8D;
	Fri, 15 Nov 2024 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731713322; cv=none; b=RcNlYOGzPSIGZL8GZoNlf1k3ZYNYznjrLVGoiNUOjUNtiNqEvXkYGErCzveUnk5QviJaRtIdI+p/2eLP9tRNPoL5A+0Gbm4tDg/nQQ7wAoKZ5LdqAqNmqlekllLIHILaRMBjadJLHmr+RYVDGVz87a6dPGBIXHTIdn5SSM8mfFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731713322; c=relaxed/simple;
	bh=48cNqeNILbOU+3UGrjHRKNNyLK0z81k5tiDiZiVH1NU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/MhcNSe9rhcu3V8RV94jm5GI5K9i8RVNxg/UEZEWofSO0vqT/CKkaJ760eipL6xdOuUkl9Oiw6HZUlfJvh3X8YfGc2byNzd623EOq66I75O7ABp7zX+mHZTvCetNnwm6cqcW9S8Uedj+2+DGxsE/hseVy5lQy3IKbqfMee9RbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngBBDJaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F454C4CECF;
	Fri, 15 Nov 2024 23:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731713321;
	bh=48cNqeNILbOU+3UGrjHRKNNyLK0z81k5tiDiZiVH1NU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ngBBDJaSV1FBLxDKemVskCphAz49K2OA3i/14mTTYOlf1gnYDQpFb2ARv/UE5yQJ2
	 PfKh0RPtwuFDYWwEPcB3CG70ylGgVICnHX2BLrCyDJMvchcFPCZHHP8U+aflRn0oQj
	 HFlvgDTO70QSPL2l2jBk6AW8gWSW2BpgHnYYp22rqvmcud/LAiC83UqkhrWrcvNSXu
	 Hf/9FgLooQb230VoT6YAyKAd9cteydIceNHvoybBzOCaAYG5Lpyc8KyOBEna1gdV1/
	 ZM1zn/qieGOaISrcOng515u8kaXkS5S7Fd7YcNMLS3WKsIzlCKKalxXWPNzOPW0/E1
	 6NFsDCtRHBGUA==
Date: Fri, 15 Nov 2024 15:28:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 donald.hunter@gmail.com, horms@kernel.org, corbet@lwn.net,
 andrew+netdev@lunn.ch, kory.maincent@bootlin.com
Subject: Re: [PATCH net-next v2 7/8] ethtool: remove the comments that are
 not gonna be generated
Message-ID: <20241115152840.2153afb7@kernel.org>
In-Reply-To: <ZzfTVtxjgXR-L8my@mini-arch>
References: <20241115193646.1340825-1-sdf@fomichev.me>
	<20241115193646.1340825-8-sdf@fomichev.me>
	<20241115134023.6b451c18@kernel.org>
	<ZzfDIjiVxUbHsIUg@mini-arch>
	<20241115143759.4915be82@kernel.org>
	<ZzfTVtxjgXR-L8my@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 15:03:50 -0800 Stanislav Fomichev wrote:
> > > Absolutely, I did port these (and the rest of the comments that I removed)
> > > over as doc: (see patch 4).  
> > 
> > Ah, I was looking for them re-appearing in patch 8. All good then.  
> 
> AFAICT, only enum docs are rendered. We don't have support for the rest.
> I can try to follow up separately..

Right but they will get rendered as HTML in
https://docs.kernel.org/next/networking/netlink_spec/ethtool.html

Up to you if you want to follow up, I think I mostly added 
the inline enum docs for the benefit of DPLL, because those
guys were adding a family at the same time the specs were
first merged, and I wanted to match what they had.
No strong opinion if uAPI headers need to duplicate doc info 
or HTML + reading YAML directly is enough.

