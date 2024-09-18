Return-Path: <netdev+bounces-128759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C07B97B883
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 09:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334C52813BA
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 07:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BE3166F0C;
	Wed, 18 Sep 2024 07:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flGXxvow"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0572215B0F2
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726644125; cv=none; b=t8tduTdWwFQv4jip/+o4N4ZYrN3VNxMYOlE5DIaEDg2lzLko25KIkem7P6Du+sMRMEuEJRnzImRmsRPR7V4SD0kH4skwvM3dDTK3qd2Ly8SNRaLYcTCxqYewLaRrr2WZgEyzjorTtv/ey2/kOL16KUKjn+VPsGET+Af7D/TkApI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726644125; c=relaxed/simple;
	bh=py4Q2LNzFm5lAqV4H20wRDCsXnbvfAL/pdAH1Afpacw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2VDBvgqqdGbIU9/H9M8L91flq8DZnpBV5/4/gdXuk7luE9J7y0I9fEDpIQTptKOMv0t79SD3ufJIKizLX5coRRo5YlaeBJ4UiRIbjsEBxuPU6I/G1Ds0e46N7q2bCXZW4PYDMb/2f5kjZR7MfyXgSD3DWKEyj54ynS4Miw375Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flGXxvow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3643BC4CEC3;
	Wed, 18 Sep 2024 07:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726644124;
	bh=py4Q2LNzFm5lAqV4H20wRDCsXnbvfAL/pdAH1Afpacw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=flGXxvowV26OKKXhvPg/jVa3mfmVBYV+ZOFiEiE9p2j2uEDEI98Lg62iYt+1Pv4pX
	 ORk5symPMPodEcKB3ksWGAl+Mutmuh7eUnLNhO+OZYXOfTuJZym3ziEV+tG012I461
	 Lz9wDZvQDuvKho4tCpxjIzAcA62vxO/fzrfGEm0StFvLok7S8Lu3rxYcLUMIbBnbEd
	 TvN+lHB/PMuEVUUhyVy3ZY9BBftViKRUU2kmYCngig6s21q8Vsu22JspzVdJ6BSdMS
	 Bb/KTS8SOUo7dRWBqkjCFMhYCQCfvBxAi/W1t+NujF4NKcAI7kY4MJYbpzWW9PftSy
	 Eh0h4sSPDOlEw==
Date: Wed, 18 Sep 2024 08:22:00 +0100
From: Simon Horman <horms@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Realtek linux nic maintainers <nic_swsd@realtek.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] r8169: add tally counter fields added with RTL8125
Message-ID: <20240918072200.GS167971@kernel.org>
References: <741d26a9-2b2b-485d-91d9-ecb302e345b5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <741d26a9-2b2b-485d-91d9-ecb302e345b5@gmail.com>

On Tue, Sep 17, 2024 at 11:04:46PM +0200, Heiner Kallweit wrote:
> RTL8125 added fields to the tally counter, what may result in the chip
> dma'ing these new fields to unallocated memory. Therefore make sure
> that the allocated memory area is big enough to hold all of the
> tally counter values, even if we use only parts of it.
> 
> Fixes: f1bce4ad2f1c ("r8169: add support for RTL8125")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


