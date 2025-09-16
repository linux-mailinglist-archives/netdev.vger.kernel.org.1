Return-Path: <netdev+bounces-223322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5243B58B61
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B7D27AC383
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9793721E091;
	Tue, 16 Sep 2025 01:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+P7br1A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705C5CA6B;
	Tue, 16 Sep 2025 01:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986980; cv=none; b=fs+LuyqqxsNXkpfwakPb0p1jQN/EmOkDJdduI+29VLBDAszIaAgPP7T4monwJzKIC/QuLCbfxFr81eeUyUP9+Uhpkn+OIfE87t6ulm+NxhmdUEPfx8G+xzQv18IYON/TJ47bXGCt0dU6juW30gfbWXX5AwM0auklz1fQ6pkPaO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986980; c=relaxed/simple;
	bh=uICLBO8F09RNi9f9lCi24w0PN+7wUc8Y6ggmXOrN3oc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCrt3sKwVAfj51Qm3g2Zl1Tupyvu3YXiHPKUZqLQx+qh++0DEcXo/80m4HjgSoMbJK9Jtf7mhG6bkY+9y5gZ2oFoyi6rx7KlA+w505KlkYfhvj0ya1J25oU+T/RdyK5st23uCikuCmEXiM8S4q/+ejYWlm3YcYolldx7Pjn7d04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+P7br1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB62C4CEF1;
	Tue, 16 Sep 2025 01:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757986980;
	bh=uICLBO8F09RNi9f9lCi24w0PN+7wUc8Y6ggmXOrN3oc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q+P7br1AMn+bKWLu6FGc9GlDDD87Yi9VxmtyMlyMnSjE1bmUf8Xq0ebdXkeBYeDB2
	 d3h3xNL4ACntoxjmU2i3Bia6Ld3PK+wVKhM+En11Colpvf53XFWrCboxSXn/vkn17a
	 /1xadkI1ZX9+1F2IVCaYeiQNwNSeeMSFRcnNjwCOAi3Uv6cl1mi23a1H1n5pLVvB7V
	 E/m+3xpsSG16DeBwW63LfPxZB4GrHyXROrNYMNMadBgqP174MRXES0JCz2j5aslgiZ
	 /bv5C+C8LbS+kHACk5h2OXblAYxbB7+0hmaWgvLPHTr77Doat7Ugk34X7y4rYhfF7B
	 5oJiUjtl1idMw==
Date: Mon, 15 Sep 2025 18:42:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Sabrina
 Dubroca <sd@queasysnail.net>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 06/11] tools: ynl-gen: validate nested
 arrays
Message-ID: <20250915184258.14e04716@kernel.org>
In-Reply-To: <20250915144301.725949-7-ast@fiberby.net>
References: <20250915144301.725949-1-ast@fiberby.net>
	<20250915144301.725949-7-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Sep 2025 14:42:51 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> This patch renames the old nl_attr_validate() to
> __nl_attr_validate(), and creates a new inline function
> nl_attr_validate() to mimic the old one.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

