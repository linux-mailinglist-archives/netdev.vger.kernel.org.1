Return-Path: <netdev+bounces-222752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82185B55AAF
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 02:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4656CA04F6C
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 00:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF41E2745C;
	Sat, 13 Sep 2025 00:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jl8r/DQa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CA911185;
	Sat, 13 Sep 2025 00:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757723263; cv=none; b=L7LQQ8Ac22s1yFdJBrm7ggUNT1ylsYQ+3mdw67qoNSu6aulX1Z1weWe1tZQuQ4hiF8kdxgurcDXSG9ly98hHkWP1FgE/9jii/ubmnT1pEmM3GRomjMhxajdxQM7+hMwp9Du63QWQkGnV+AvCJNFaxM80FMpyYdrGBWfK4Az3Sns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757723263; c=relaxed/simple;
	bh=HrdxcHyCtTTpJcAiGydPfegXvya3mJ/jU4zuZbNMC1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ltI0qevkIS2b+gnhiiMbwbz+sL9/JdAlQLSQ5RzXM285wJH53k7hp/Woxw777THZ06nXYMVKx1Rqj9/jFA/rzUMkfi6u+LQvy442jyOCLrSVqU8SLEAlsItusMcXTlq4h9nsvhqTHm+bE1T2ZtTWxlb6IKIOtdLWU5+n2yMUun8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jl8r/DQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CCDC4CEF1;
	Sat, 13 Sep 2025 00:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757723263;
	bh=HrdxcHyCtTTpJcAiGydPfegXvya3mJ/jU4zuZbNMC1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jl8r/DQaPWLqwN59Ues0LAqaFmw1BsYEWwk6QoB/JaWfdLS0H1jTp347z+nrvefOK
	 6A8BuEy/INlx4poANaVVGdXnEcvBvERS/HS0V94TY/ozx+6snBsFFhV3tAp7X1WQp5
	 oS8B5X8c26FdRzOzpS7T9I2GxsHmZ7iN+/AjzjYVrYstLLy2eYQlCnU6etIqMzcGNg
	 3N8Ie/7RZQ2XgF3eJsvemrnL6Lwd9LTi/CcB7qPOLMLHadZNPViaGUit0tdSbYyO49
	 5BD+9o2M2D4sKptHi7c7NCZqYoeJOoR2jQlt9IiOJqKpc8ewoVabq4oFnzL3qw/HRD
	 t0Gov+OCRR/+A==
Date: Fri, 12 Sep 2025 17:27:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Sabrina
 Dubroca <sd@queasysnail.net>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 08/13] tools: ynl-gen: only validate nested
 array payload
Message-ID: <20250912172742.3a41b81e@kernel.org>
In-Reply-To: <20250911200508.79341-9-ast@fiberby.net>
References: <20250911200508.79341-1-ast@fiberby.net>
	<20250911200508.79341-9-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Sep 2025 20:05:01 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> +int ynl_attr_validate_payload(struct ynl_parse_arg *yarg,
> +			      const struct nlattr *attr, unsigned int type)
> +{
> +	return __ynl_attr_validate(yarg, attr, type);
> +}

Why not expose __ynl_attr_validate() to the callers?
I don't think the _payload() suffix is crystal clear, we're still
validating attr, _payload() makes it sound like we're validating
what's inside attr?

