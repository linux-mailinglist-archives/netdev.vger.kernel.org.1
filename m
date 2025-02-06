Return-Path: <netdev+bounces-163636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4271DA2B146
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FE31649B9
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9DC1A4E98;
	Thu,  6 Feb 2025 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfo58gQD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE691A3A8A;
	Thu,  6 Feb 2025 18:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866753; cv=none; b=nFf4FgLa90i3fZdwVdVEF3Qyf/1ber6sSBLfvU/W1RnOQy3tkKRDTeGVYhBQxnRU1pLe3DCLqVfmKhUh/a5Vib/s4HiSETKBwylH/0hRvVVolOEn4Ymc6dSlIBhGJgzxKiUlgplbJCldnU488JaSJM0URgmV3B+n6agIx/S1WoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866753; c=relaxed/simple;
	bh=Ht7xKiNp/Nyp9T9IXKM5aPZlYL6dEYS/1bZUTOSnor8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udP+n6R1ocf8os9ry6EOu8clK7FP51NZxmDRq3PnrdwkGiOQDvFJVyf2GwtYvQYO7njnEykpzOG0r99OIepKnDe3rhsTZsRXqzx1yubWGdNrjTB23gQKAh3wF2VCJBWGGLPjV58WphaYZDSOG4Ep4FzxSfk4oJs5c4Ac87/GPmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfo58gQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4826C4CEE0;
	Thu,  6 Feb 2025 18:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738866752;
	bh=Ht7xKiNp/Nyp9T9IXKM5aPZlYL6dEYS/1bZUTOSnor8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jfo58gQDdYrRZdLQ6RtYwT9eUYTIBxK+KjOq5iKAA8DKudwLxXpAWeNcw05T0vooz
	 v5ouVqyCjsf75Ik4SuIjDhKg7fXGHg3giNxXgcicCJ6ERkeP3JZFJS4fSS/qIlClIl
	 V0cXXfyqq45XCjVoTvJBO2AafpiYHc82PZlg54rftRDIa0b/MPnYvqew1mm5aPrYXy
	 +6Z1G+/QJWFpq5IiFyg+/RzYffezB2U740wJf96k1HQ4Wc1j+ITqaAsqBl6SPoImPJ
	 tVtMJl9XchULSQKDDLKzVpBLN9CrwErU+nQLqM6C6Vw+8YtvVQvr5oO/r8Rg/aw8Hf
	 Thrl90GnN0IMA==
Date: Thu, 6 Feb 2025 18:32:27 +0000
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>
Cc: Laurent Badel <laurentbadel@eaton.com>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: fec: Refactor MAC reset to function
Message-ID: <20250206183227.GB554665@kernel.org>
References: <20250204093604.253436-2-csokas.bence@prolan.hu>
 <20250205132832.GC554665@kernel.org>
 <20250205134824.GF554665@kernel.org>
 <299a1239-7149-42f1-b3fb-ba538ae2a30a@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <299a1239-7149-42f1-b3fb-ba538ae2a30a@prolan.hu>

On Thu, Feb 06, 2025 at 02:02:50PM +0100, Csókás Bence wrote:
> Hi,
> sorry for the confusion. I accidentally sent that one while editing the
> headers.
> 
> On 2025. 02. 05. 14:48, Simon Horman wrote:
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > Sorry, I think I have to take that back for now.
> 
> Would you keep it if I retargeted to net-next without the Fixes: tags?

Yes, I think that would address my concerns.

