Return-Path: <netdev+bounces-105105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD74790FB01
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 03:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 787091C20CB2
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 01:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45E012E48;
	Thu, 20 Jun 2024 01:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNgwAmor"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F74D51A;
	Thu, 20 Jun 2024 01:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718847585; cv=none; b=eryYe+aEZg/U9UF0ozY3UJBZHYIiBNx2qVF3lMFQoiSrT3bmaBW9buQd5YrxykUQW/RiSDpuI6O60/iFUafsg4LasFGPIzvrihdTHpqr2SBpkX9TOWOc+aPrWe8XnV+YgWxKL74E+eTmbjoe0KN+etoEsssdNogmIFpaBJQF82I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718847585; c=relaxed/simple;
	bh=Y16cf8bppWGlJW5soeE5je+uBCreX9gIBX/IOlPwges=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KaOO6HWGVNuR3uq+coJ/6cfsiw54R3rJl/qbE0uNtqIcmVoNp3+70hAg8/KQubiTdpsFLCERBs0gVnPGvQRLAClrwWtkBC9MVY/nfQCCHodEyf95Yd1mSapbDMXdmKSBuXJ/EV/hF4yVBun44EFG7NBH50BzPgh2SFCowuKKtao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNgwAmor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55053C2BBFC;
	Thu, 20 Jun 2024 01:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718847585;
	bh=Y16cf8bppWGlJW5soeE5je+uBCreX9gIBX/IOlPwges=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LNgwAmorZKykbw4+WYpd/8W5FDH4WEbSPcnmzabYgW1YgmCax/v2HQ4IqyyCGZ9m9
	 NnVCvyQXJ5GqO/WkGP8dcmqT7XeJtwawiR/OfJ7JkUkFI0TxLeA0Y4z27MvKPnVdmT
	 2FO4T52Z7+tYh3M2KTh8adOVrCIsN4d68CvnSI+hFTrPhxJm+i635mAB5sEMx0nG6e
	 B4jJD2adFrchM8+5pxQaUXb5ady9BDn/ZXItzcnIY+MQxf9739HUgNDbskvtCfEv7r
	 DnDBwaJfMKGG/ad3HCevKpt64hIzZMfG1TlXLPpZEgTZPEBOXN6hZSeZY7fjx8QORn
	 npMZ8TjiqYMeQ==
Date: Wed, 19 Jun 2024 18:39:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 horms@kernel.org, i.maximets@ovn.org, dev@openvswitch.org, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Pravin B
 Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 05/10] net: openvswitch: add emit_sample
 action
Message-ID: <20240619183943.5a41f009@kernel.org>
In-Reply-To: <20240619210023.982698-6-amorenoz@redhat.com>
References: <20240619210023.982698-1-amorenoz@redhat.com>
	<20240619210023.982698-6-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 23:00:06 +0200 Adrian Moreno wrote:
> +	OVS_EMIT_SAMPLE_ATTR_UNPSEC,

Are you using this one? Looking closely I presume not, since it's
misspelled ;) You can assign = 1 to GROUP, no need to name the value
for 0.

> +	OVS_EMIT_SAMPLE_ATTR_GROUP,	/* u32 number. */
> +	OVS_EMIT_SAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
> +	__OVS_EMIT_SAMPLE_ATTR_MAX

kdoc is complaining that __OVS_EMIT_SAMPLE_ATTR_MAX is not documented.
You can add:

	/* private: */

before, take a look at include/uapi/linux/netdev.h for example.
-- 
pw-bot: cr

