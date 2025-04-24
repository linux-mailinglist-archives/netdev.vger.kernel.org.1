Return-Path: <netdev+bounces-185753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68445A9BA69
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 00:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A40189273F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 22:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD2121C160;
	Thu, 24 Apr 2025 22:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSy+o7lE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0742A19F471
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 22:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745532391; cv=none; b=Cp4Wfo4rRHBuZQ4FiYrvy0dKdeYg1nBB4d/HA9zeksdX/p3m8VPvDXKx4RxX+PUQXXr0+w8W876oQNBwnJkpK2KAArO5blGIZOnqlmw0PFD+nSE5pnN0XDf9jztvzo/5mKoHb5m2q6ApOl9P5qj4bkPAX4vip+rCsYqcqi6JxDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745532391; c=relaxed/simple;
	bh=TnuUr1ED+BYMeYw1qYEj/B7iPXWy3qS5JD4ftIhr2MY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c9XVZbaj9qRDTboXtHC/vfQQXd691818VHpgY6j4JT6uJyx3FaS4nARtvzClqIj8HJyONmRk8RqV4hve5BvJDMs03vOQK5nbnMPAAdmgtqaG2TOEze9zS8Nzs+N9VhWPRXFUUHWHSMnJcqi1NfG7JDRbLFQj9wvVw9YlEhVBw0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSy+o7lE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F87C4CEE3;
	Thu, 24 Apr 2025 22:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745532390;
	bh=TnuUr1ED+BYMeYw1qYEj/B7iPXWy3qS5JD4ftIhr2MY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NSy+o7lEdRZH88rnaP/Bzq9+t7AswB7MG+ryLBG5e3bffYXKfN2howYgaGjItzL1h
	 h6O68Pgj7TndYfqJ0xHRHgeNEOZdMDV7i5BEeysFCFVwIfLWLXmE3nkfCsu9Aws4dc
	 E70BBTwTe8cXTPc4U99UTun3Z1Mtutsu3D3fTQlX8VPAhbu5vPM2KaimkxFHCS4mP8
	 fMAsCzjV+0uk0eGWaQ3EdgKOP+RMzaNrDFBC9M/d/z0H+zY7KTYUts8iMTfSpJ7jpX
	 9fhodIEN0gzslwP5Z8OGjKLt9HhOxFCdO4k9JvT2PyWwsaNlNBTf+FjtUWaTXtdBv+
	 6i6mBoT7g+tnw==
Date: Thu, 24 Apr 2025 15:06:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, tariqt@nvidia.com, andrew+netdev@lunn.ch,
 horms@kernel.org, donald.hunter@gmail.com,
 kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v3 2/3] devlink: add function unique identifier
 to devlink dev info
Message-ID: <20250424150629.7fbf2d3b@kernel.org>
In-Reply-To: <3kjuqbqtgfvklja3hmz55uh3pmlzruynih3lfainmnwzsog4hz@x7x74s2c36vx>
References: <20250416214133.10582-1-jiri@resnulli.us>
	<20250416214133.10582-3-jiri@resnulli.us>
	<20250417183822.4c72fc8e@kernel.org>
	<o47ap7uhadqrsxpo5uxwv5r2x5uk5zvqrlz36lczake4yvlsat@xx2wmz6rlohi>
	<20250418172015.7176c3c0@kernel.org>
	<5abwoi3oh3jy7y65kybk42stfeu3a7bx4smx4bc5iueivusflj@qkttnjzlqzbl>
	<20250422080238.00cbc3dc@kernel.org>
	<25ibrzwenjiuull524o42b4ch5mg7am2mhw5y2f5gb6d6qp5gt@ghgzmi7pd2rw>
	<20250423151745.0b5a8e77@kernel.org>
	<3kjuqbqtgfvklja3hmz55uh3pmlzruynih3lfainmnwzsog4hz@x7x74s2c36vx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 11:42:09 +0200 Jiri Pirko wrote:
> This you see on the PF that is managing the eswitch. This devlink port
> is a representor of another PF, let's call it PFx. PFx may or may not be
> on a different host. It's a link from PF managed eswitch to PFx.
> 
> So you have 2 PFs that are in hierarchy (one is on downlink of another),
> each on different host.
> 
> To find out how these 2 are connected together, you need to know some
> identification, on both sides. On PF side, that is port.function.uid the
> patchset mentioned above introduces. On PFx, the same value is listed
> under devlink info, which is what my patch we are discussing here is
> adding.

Still not clear, sorry, can you show a diagram?
"Downsteam" makes me think the NIC device itself is a PCIe switch?

