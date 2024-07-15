Return-Path: <netdev+bounces-111498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3D3931632
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B895B21DE1
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB4D18E754;
	Mon, 15 Jul 2024 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+sA5FeK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B02D1741CF
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051839; cv=none; b=cYs0ljFu/ZbfMbKER4cU5P7zs/ckVl7vrHvQMN5gO/MQgZpM/iRVhxRWXdVj0Hxk8LXcUdJyJulOG8Zck9v1gLnk3nzMACsxRYUDXO611c1H+hfmv2yAOEh7Jzb4bYeGfx/+Uw+gSkYwnfyI90zD82OzjTlOGDvksyh8/dbefjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051839; c=relaxed/simple;
	bh=Msw2nenO9cIl2lcpSXqRDzEM/S1bHkn3CeGwZ7QAA/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E7/hQhfBB3v8sDYkSgSABV0zgFK6nuewNjAlPxGwD9Ex257ESBvBXv49Ya1k1S3mR7UG91av1gc8Mv+avidNaxd7Em75h9VwNeS6dVus0JgoMzAbUZUTL2S64n2RQAr9Fe/MRC7qsiqIgd1FDcKXCy1jlE9KiZBH+R9WcUhC5tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+sA5FeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4E5C4AF0D;
	Mon, 15 Jul 2024 13:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721051838;
	bh=Msw2nenO9cIl2lcpSXqRDzEM/S1bHkn3CeGwZ7QAA/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P+sA5FeKz6ReXixU0WCO9Md99oa777D3SKjtSH9Wd0F22fq6ZaQKueGr9dFl0Mhqn
	 /KiTjPIPMnjTMkm42dSwpJuxYaAva7n7huaItK2R7zpmubn6D7/7eW7CsjbgjcPz5G
	 Q5qD/PUQz92iWcr7LNw4k9J8f3VGBjNzVrT2o+OR+5VZJPYVIVxvz//T5ujHFzQFHo
	 XVGKXt7JU3aM0HSCwB8gFja5m10//LHzsveV8L5FIcucQe/qcN9x35l1+DPSULcyI8
	 FDCZLfThdJ+s3sLo61W8dVJ6GkJIM98faXVoLz9j+b6zAzEw3xmXTBLMo14qznodd9
	 X0B7b41E9JI6w==
Date: Mon, 15 Jul 2024 06:57:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: David Miller <davem@davemloft.net>, Herbert Xu
 <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 0/5] pull request (net-next): ipsec-next 2024-07-13
Message-ID: <20240715065717.1ad0ec12@kernel.org>
In-Reply-To: <20240713102416.3272997-1-steffen.klassert@secunet.com>
References: <20240713102416.3272997-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jul 2024 12:24:11 +0200 Steffen Klassert wrote:
> ipsec-next-2024-07-13

...this too. And I meant to say "pulled" rather than "applied"
in the previous email. Thanks!

