Return-Path: <netdev+bounces-157333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27939A09FDB
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 02:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C1A188F812
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 01:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244D0D299;
	Sat, 11 Jan 2025 01:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHR3hQKN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3530634
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 01:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736557845; cv=none; b=R24ya3c5QHF9itz16x0vf9+HQGRLk4q3K/jMPOLmZwPy7lznG5vFoiAUllWNmE1Ou59wwpYjmoxMJga+e+RrcGWSjdR9/a+Y8vjIQ3ht/pkg6skIV6qrNDwgvatsHQDb61d0nMv7QcXNxy7Xsoo3T+IzIZcOzhD4Ha+GAp5j7NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736557845; c=relaxed/simple;
	bh=MC8tln2+QfMq0uvVQEYkDgSSDC2hTizNanyVU96Kccw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sSyWaXMnsdpOHVsICRJRTrqZ8qygp4oap7MCvUrLC+W2PCSs6OyT+CsQ6HJjOVlAvBe50eCH63bxkiw+oUYHrBo3KTGlDefNHSq1GVokcVKoJP54be9AiEgCfZt7xvhxhdIJdHTrco7eVFtGdbOzlEZMoPFMVurPEF0PyaNW+5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHR3hQKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CA4C4CED6;
	Sat, 11 Jan 2025 01:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736557844;
	bh=MC8tln2+QfMq0uvVQEYkDgSSDC2hTizNanyVU96Kccw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nHR3hQKN2yWIQZkS6LhDELSFANe112E/YU9m/9qkqMfm5IJgIQc/DKmkSjwPjW2cX
	 Cr1+neDauHYAlIGNo0dLvD1NaZv7O7tgVIH6vA/FTZ65hqIPCOZ07R+mGIdTbnI3ei
	 TEoNvPW1bkhGYGADEY+2ywNdLiZZGXjA28fVAYgWIWazoQnRPw6+BsExhvyXDJw9Ie
	 eE1BC8i4tKjCXfxF/pSM76KciVM4GUZOMw9k94D6khB7mRj0LNv4WuzC/xfb4ge8NP
	 5hR5M32dsfLpnRBZnyPT+eE2XCvQxWZo3t6/hiMPX5/Zi42Ek49J4//bwkeVs6TCGn
	 kuCg5rv7/e7NQ==
Date: Fri, 10 Jan 2025 17:10:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/2] tools/net/ynl: ethtool: support spec
 load from install location
Message-ID: <20250110171043.6aa8901f@kernel.org>
In-Reply-To: <20250110144145.3493-2-donald.hunter@gmail.com>
References: <20250110144145.3493-1-donald.hunter@gmail.com>
	<20250110144145.3493-2-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 14:41:45 +0000 Donald Hunter wrote:
> Replace hard-coded paths for spec and schema with lookup functions so
> that ethtool.py will work in-tree or when installed.

Acked-by: Jakub Kicinski <kuba@kernel.org>

