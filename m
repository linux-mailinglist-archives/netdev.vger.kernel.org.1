Return-Path: <netdev+bounces-77126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5CA8704A7
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F6F1C213F1
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 14:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622FE46450;
	Mon,  4 Mar 2024 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrxPaknA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF0745C1C
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709564342; cv=none; b=P85SP29u3PaiVQa14t002edD5V8k9Jh7Xe0PYMu0fDV5C1SlIpcH2DSrKoy/R5i3Vz2pIY4SgxAbJa4L3xTLxpxMdu/RNolWvEypyY8V5J8Z6atVRLCCcmb3lw7dUjhTuSf+vaSlR+wfOBpd134+n5AZNfrd7xhRsj0qrMNHm6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709564342; c=relaxed/simple;
	bh=tVFT3TrnqHX9lW5+fw7e3D8o6EuakegBHKHM4GChSkw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2imuQOqZBkhJdAk74AIKvHCMGgVyF0yC886M+Uf1u2x/gj6w1WgZRsVaEb1cbAir5m3oYGiNlOtFHdTpfcAhFH8GEQQKo8KuiY8hsBbp0ytTkb4CectL/MA6AR2X4dOTr436eigYn+JB3u98i6tMpPNSlSQwDnSoFqnMM0bBJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrxPaknA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782A7C433C7;
	Mon,  4 Mar 2024 14:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709564341;
	bh=tVFT3TrnqHX9lW5+fw7e3D8o6EuakegBHKHM4GChSkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LrxPaknAIi6SL8DkNccH/2luiXMwQJ+g9UWYH3w0PUbwfQdxcKLFVM9htE69YiRgq
	 0jD0IWJ7e2TreJqqjvh2EdHwbLDNDt0DXhncyOlsYzFZizVcvSECBcjQAGJnZkOf3l
	 H/OL66yhetHWIpTayz/MH+ezsXgay4+3AXXFnLqrp4yI3V9VQLyOdR6E9rwMjDS0Tb
	 ea5KM1n7oGjE6gogdclBkGvnhfq0YwmDUluYT1rWS8yk9+UpIa4xX+L1IOggAyhmIG
	 kFfwx584Uqb5lQXxhrMxmucrEfen4beaVuHvVcVOy0zHxbIpNUkTpu4ceBwpygjfMz
	 +Dsv6whM7fKhA==
Date: Mon, 4 Mar 2024 06:59:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us
Subject: Re: [PATCH net-next 4/4] tools: ynl: add --dbg-small-recv for
 easier kernel testing
Message-ID: <20240304065900.60d3670d@kernel.org>
In-Reply-To: <m2wmqijkzn.fsf@gmail.com>
References: <20240301230542.116823-1-kuba@kernel.org>
	<20240301230542.116823-5-kuba@kernel.org>
	<m2wmqijkzn.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 Mar 2024 11:26:52 +0000 Donald Hunter wrote:
> > +    parser.add_argument('--dbg-small-recv', default=0, const=4000,
> > +                        action='store', nargs='?', type=int)  
> 
> This breaks ynl if you don't use '--dbg-small-recv', it passes 0 which
> fails the _recv_size check.

Good catch, one too many refactorings..

