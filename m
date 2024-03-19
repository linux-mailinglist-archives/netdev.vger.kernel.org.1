Return-Path: <netdev+bounces-80565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A4A87FCFC
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 12:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0D0281873
	for <lists+netdev@lfdr.de>; Tue, 19 Mar 2024 11:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C5C7EEF0;
	Tue, 19 Mar 2024 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLgs7Pek"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F268854FAB
	for <netdev@vger.kernel.org>; Tue, 19 Mar 2024 11:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848200; cv=none; b=odqZDlqY+7H+9suDt21VcjVudwJrVU7rQkHVsuyc0L6PqfRU5RBNQvNXNm3sNM2OA7AKKDJruHolGchVENq4ICzjz99dm4YcAgO3R3qA/oxSWTkmpUxvS4uYjrF0Fp/t9U0lxaIbvqDGiYxMiTjigqQFxVGwyMKnKZZbfX3H4nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848200; c=relaxed/simple;
	bh=6ARo1R91Z3X03YFtm+KdSQz7S43+x+fm/D5nUt8Jw3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1lf9B/cvBkOKO7ugdFNrOi1A+TCfIpEEukUlYPgzCLUpa2xINV9D6GguaJPGBIeRJiRm9zrNgnK7U+QHy3BDaLitCdCawpYfj7FpdwxLSQF90i4aCZxTN8tTvbGWJcnxZPMduH2SUQMc/Zo9coGvvArjIVLUtZWm2i8RuVoQKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLgs7Pek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8670CC433F1;
	Tue, 19 Mar 2024 11:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710848199;
	bh=6ARo1R91Z3X03YFtm+KdSQz7S43+x+fm/D5nUt8Jw3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mLgs7PekiPiooXZoJQR9B/WIaoMCj+14qxU7NpR+dchzcH6C/dRv8mkEKmjPXm+Wv
	 N5vm5U/g3jsVrbuv6XRDwdY+FzwX1nUYVCMpQ4hvmbBOUzoibBVUu25go3Rfpfho9F
	 SR+H8AQlBsL6tA0hfXMzEtGOkZZWEnn6q/RL8O3Kh67are959bhYdqCcP7Aj3/MHyd
	 N1XzZIHUj5F7OdgYGiZ/u8QpLi+9DRwSdnNnw9fXwM8O7Rbu49AD7IQ2afrCeDLOd7
	 Vk6+TyOaZJABlkLZAsD9kwTnW81/xGw0Q3esmT2aVC9HTfcBKE3megAD5bM3ysrnXb
	 i8rEKpJEgHJjg==
Date: Tue, 19 Mar 2024 11:36:36 +0000
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [iwl-net v1 2/2] ice: tc: allow zero flags in parsing tc flower
Message-ID: <20240319113636.GF185808@kernel.org>
References: <20240315110821.511321-1-michal.swiatkowski@linux.intel.com>
 <20240315110821.511321-3-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315110821.511321-3-michal.swiatkowski@linux.intel.com>

On Fri, Mar 15, 2024 at 12:08:21PM +0100, Michal Swiatkowski wrote:
> The check for flags is done to not pass empty lookups to adding switch
> rule functions. Since metadata is always added to lookups there is no
> need to check against the flag.
> 
> It is also fixing the problem with such rule:
> $ tc filter add dev gtp_dev ingress protocol ip prio 0 flower \
> 	enc_dst_port 2123 action drop
> Switch block in case of GTP can't parse the destination port, because it
> should always be set to GTP specific value. The same with ethertype. The
> result is that there is no other matching criteria than GTP tunnel. In
> this case flags is 0, rule can't be added only because of defensive
> check against flags.
> 
> Fixes: 9a225f81f540 ("ice: Support GTP-U and GTP-C offload in switchdev")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


