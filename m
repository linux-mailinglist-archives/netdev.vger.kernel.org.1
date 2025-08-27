Return-Path: <netdev+bounces-217381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A68D3B3880E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66ACE9813E8
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2222C3242;
	Wed, 27 Aug 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0nzE+WO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388A82BFC8F
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313666; cv=none; b=kqS/nhhZj4IUmSkjohh+3be35Eome2duYD560DuWij0UfzHe2C6AaVyM9YxOS4GVq+PpEdJCaD2mPZ98DjsgetdBL8wrfOpx++ZopH5ov7EWA4dA08YQKVfHQnGrHfK4kfkf/S1dqw5Qh+lYmciCny2b/yUZJvssN4XEaGODWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313666; c=relaxed/simple;
	bh=/9E5s6RtxDXBVD0HjtDwknJgpgUOWPledU0aHm6J+co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaDMeY0JMH6wumUuwyUKmDH687d6CiZG5URoLZ+2oVI3PRCh6MsPTqHDnZNVnFmY/EGNqa59yhCcj15rjctyqd+w/8RuErcxVyZL41I1UNwABPusl8gLGWv7BdGlTehflaVBEEZah3SDd/vbevFA7qq5SPboSmHFCKW4rENQrUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0nzE+WO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E722C4CEF0;
	Wed, 27 Aug 2025 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756313666;
	bh=/9E5s6RtxDXBVD0HjtDwknJgpgUOWPledU0aHm6J+co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B0nzE+WOlKi8EL/cLLrgD/0M3uGElWWjnwWr938RT/X4/xos9tbWfwHdvzUrjgWkX
	 ARxzveg9TXATtA/IzbIpqfrvWgYZ44v+QnUv+2xcD2VqlI36GrpmlrDRdMvx+XIypm
	 2d5acSLBxSLlpDYqx83M2WZ3+ZLO/0//yMX/sWH5dBXLTFnKziPbcxtciHh/zicohb
	 XK4Qh919yCK4CVqtWYXhqbSEgwS+pByeiCtumynPZOvlrzOg3syKRXMHx00T0F/tzk
	 sqP7ZDYKfy7AxXaiHXPzJq/Iue3f9EEztd4JB3X0jyESUwlCj13sxpO+Z22dtwhr73
	 G+joz7WhYj4lA==
Date: Wed, 27 Aug 2025 17:54:23 +0100
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 04/13] macsec: replace custom checks on
 MACSEC_SA_ATTR_KEYID with NLA_POLICY_EXACT_LEN
Message-ID: <20250827165423.GF10519@horms.kernel.org>
References: <cover.1756202772.git.sd@queasysnail.net>
 <c4c113328962aae4146183e7a27854e854c796fb.1756202772.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4c113328962aae4146183e7a27854e854c796fb.1756202772.git.sd@queasysnail.net>

On Tue, Aug 26, 2025 at 03:16:22PM +0200, Sabrina Dubroca wrote:
> The existing checks already specify that MACSEC_SA_ATTR_KEYID must
> have length MACSEC_KEYID_LEN.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


