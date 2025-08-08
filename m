Return-Path: <netdev+bounces-212180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED65EB1E965
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF8984E018F
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1A127C842;
	Fri,  8 Aug 2025 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSCxEr+t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F31273D76
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754660662; cv=none; b=YcItgIIMgjMLtp7V2ZrqMnyFeSh+mXiTlkf1xPIghWOqxOxDA6q2/72Ku8GdmasFXRDDbF+cO448Vej7XSV/YFhrZ4DXrhqE3ZBlImgiZRjhqIOoOeGrrJ2BOZq8gRjoeWSgqUgqDJOo4mQbQQm2hERYfDdidJ1sPyi5Fy1L9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754660662; c=relaxed/simple;
	bh=UE+WfyQP8dXhzeE53Lj+W1t+g6MjoTdQM6znfZUVi9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hV5drqn0xLSrT6dQ8rTYOYZ4PpmPKLgQ5T94aJIA9aE8IwJwpgi9IhzjhhG7iazLui8+DPOJnvMcWbSAx+hHhcqPYOZs+Ncl6MURt8Y1ZJzbVVOxRtsiZtTOD8qZiiGyK5uLprryWH+TvZ/hQjF2KlTGEYeqeN0ckad1n0fT3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSCxEr+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C90C4CEED;
	Fri,  8 Aug 2025 13:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754660660;
	bh=UE+WfyQP8dXhzeE53Lj+W1t+g6MjoTdQM6znfZUVi9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jSCxEr+t6VsjFiCREmn1P7Lz9745oS6kEpPEeelTsuwoeMzuACA0IfPkH6YplZxZ4
	 JaEdvPoeui1rdllGx0ETBjC7iwu5GbE/mnD9kOeY+JzYt9zTIonX4dKgHuX/8cT9of
	 I+zttJz+3/UHMXZ62lVxEc9wq3e7bK7gc8ymTOYROsjBwG0R+ud9r7qstMUL0lf35N
	 Xoy4hVb2aVdC5yplPgkRkoJpMZaggPACRgegVoD8A3GD/cVkUYKx2P96QMZCnYccgF
	 MPMtK9HyjY1RIDIfK8ZHNi2qZxtHuX2SJIhqCHkNJNeQQcvpjtashRD/yFW4nqrNJG
	 KvqT/tERqxQwA==
Date: Fri, 8 Aug 2025 14:44:16 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v3 2/5] e1000e: drop unnecessary constant casts
 to u16
Message-ID: <20250808134416.GB4654@horms.kernel.org>
References: <2f87d6e9-9eb6-4532-8a1d-c88e91aac563@jacekk.info>
 <6d05300d-e5d7-409e-8b78-a7c3da21ed32@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d05300d-e5d7-409e-8b78-a7c3da21ed32@jacekk.info>

On Wed, Jul 23, 2025 at 10:54:35AM +0200, Jacek Kowalski wrote:
> Remove unnecessary casts of constant values to u16.
> C's integer promotion rules make them ints no matter what.
> 
> Additionally replace E1000_MNG_VLAN_NONE with resulting value
> rather than casting -1 to u16.
> 
> Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
> Suggested-by: Simon Horman <horms@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


