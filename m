Return-Path: <netdev+bounces-187572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5296CAA7DEF
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 03:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C0A467054
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 01:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2650941C7F;
	Sat,  3 May 2025 01:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTzzJxBJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0223A134AC
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 01:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746236242; cv=none; b=qvPCY+r9+DdKTYb0QtV2y3RweQ+aF+rW/pA9Tk81j7/1z1GMbWBf+27s3FdGVBTursaLvvzkrxLIe8teGmSUDRBSLBE3zs9vsSn8m2XGVtB0Fti+T4WjKQWkLhc/lzdbWlG4SbZ60clKIUqY/FzxNCkY4JQnUaOBFBiEPbgWLQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746236242; c=relaxed/simple;
	bh=csJ5rCdsmxOhF/KJF162wkmTFqyOHIAFeKcVQNtXjkk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvuBfHH/VCviYVIdDa0rGla0zyDL8zEbICBBrPI1GC4zif86szaiGDhyHBfdC8H83E39v0PzoW2T3be0aV5F+7kQhyKvviJhJDBX2WUiU+kxKWqZkJM7gi3LZbFaLlFqRNxIGW9pyR5l9pXfGFQ/caiaZqhfnJ7pxMJq78SPyj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTzzJxBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27512C4CEE4;
	Sat,  3 May 2025 01:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746236241;
	bh=csJ5rCdsmxOhF/KJF162wkmTFqyOHIAFeKcVQNtXjkk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jTzzJxBJpkm9z1eb2Z/h8MoFaHF6k2csGpFB+LzUR00FEAu2mFq60FE+ZlsXq5Js8
	 x9gs9+J9ZfsPxv4dvaOUENM0d/se4kC2HCrgJ8Giax44u0novdUTH2jrsgge4I1Ggl
	 Y+hti6WxHzwoD5rr0UZb9LcfhI4R9gEgE9e6vT0BICAUCOgeJtUZ/6x6tA0zl+eJtB
	 tPiqoZSAGw0gyIkb9c6ciODehL03i/iy9kSDIyw6hrQRwIEnCRDjSUFcgVycDj63FC
	 W5mFflqUwbURMNX/qQIeBXUzPXnBC4VYdeJVc1mwUWpuD5jHpn3C0MDdmjsNiYJwp0
	 JCuOwb6J/9ToQ==
Date: Fri, 2 May 2025 18:37:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, saeedm@nvidia.com, horms@kernel.org,
 donald.hunter@gmail.com
Subject: Re: [PATCH net-next 1/5] tools: ynl-gen: extend block_start/end by
 noind arg
Message-ID: <20250502183720.15a82e29@kernel.org>
In-Reply-To: <20250502113821.889-2-jiri@resnulli.us>
References: <20250502113821.889-1-jiri@resnulli.us>
	<20250502113821.889-2-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 May 2025 13:38:17 +0200 Jiri Pirko wrote:
> -    def block_start(self, line=''):
> +    def block_start(self, line='', noind=False):
>          if line:
>              line = line + ' '
>          self.p(line + '{')
> -        self._ind += 1
> +        if not noind:
> +            self._ind += 1
>  
> -    def block_end(self, line=''):
> +    def block_end(self, line='', noind=False):
>          if line and line[0] not in {';', ','}:
>              line = ' ' + line
> -        self._ind -= 1
> +        if not noind:
> +            self._ind -= 1

Should not be necessary, CodeWriter already automatically "unindents"
lines which end with : as all switch cases should.

