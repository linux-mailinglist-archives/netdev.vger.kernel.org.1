Return-Path: <netdev+bounces-101193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5D38FDB65
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 02:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C49CB23EAD
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 00:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECD833C8;
	Thu,  6 Jun 2024 00:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ss0RJ9/3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB97139D
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717633405; cv=none; b=T85sL+375HAzq11PGVsF/t89RHAvnicd7QjuJNs8UcXkkYCO3ScZaxzfyzP5Kn0ibHPOBghM+ESgsqMyxrGlVX52Vi2PFvV1MqXP56nfKSbUVcHz5E8TO70e2Xfll5pen74mrXPREPokJqqZ6yKwYCvyITT+QWvIQc4KD1aSFwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717633405; c=relaxed/simple;
	bh=XB74n0X0ZhSwoBDR+FjpjHYo9cPdAmhHVYqa0DSgOV0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWOW4sVBfSmbIP5S5WX1KXI32H4aoKvIb1+aEe3PXfH4SOu2e0WIFjBAd3MCWImw6/8Zh2eZsR83EmQFUX2MXV5YJ6zBZM4EkUrabuuksPG4uPINHuyG20N9wvaCac71wP8sQAOHw1pNYqFj8ph1V98CqHsq5BGOUrgZbM8y0PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ss0RJ9/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8CDC2BD11;
	Thu,  6 Jun 2024 00:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717633403;
	bh=XB74n0X0ZhSwoBDR+FjpjHYo9cPdAmhHVYqa0DSgOV0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ss0RJ9/3BiKFg6yBIL5jCHsAqZN/IXMbzVfpJFkH5cMhrqNagAcgLgLsGW4CHn6Jm
	 SQsL3sMpHuC0Xiikm1j5Oi8gcd28+RLIDb5dObNRH8Bulqh95BwKBqKFmHRIpG/1aJ
	 qcLQu/rKwsyHxyZLqYCuF3F2ok6FjZ28pUTV0aQfQ1rCeMQZPfiDNfiedHg6ulTIEh
	 chxmrPZLKAyboJZ+6XPkqsDjM46MlDlT0heGADRpCqRv7D8uVwF70Ehzjpe0Vzgdkg
	 OnO0WRGKiRYJWFz10zZatifG88B13FBFUEr4ZJ02sQWewk8GLHXqZnX4SRYXGUBHTH
	 ZZ327gp7KPaAA==
Date: Wed, 5 Jun 2024 17:23:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrey Tumashinov <atumashinov@gmail.com>
Cc: netdev@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: RTL8125B on r8169 no traffic
Message-ID: <20240605172317.5a37cd2f@kernel.org>
In-Reply-To: <b448d9ac-53ab-4a87-99ea-2f0d081c896c@gmail.com>
References: <b448d9ac-53ab-4a87-99ea-2f0d081c896c@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 17:38:30 +0500 Andrey Tumashinov wrote:
> Hello,
> 
> I'm having some strange connect-reconnect problems with my built-in NIC 
> on RTL8125, Gigabyte Z690 Gaming X DDR4 running Manjaro, 6.9.2 kernel.
> 
> 1. I have to plug the cable in several random times in order to NIC get 
> it's IP address via DHCP. Manual IP doesn't help either. The cable is 
> Cat 5e, verified with several other laptops.
> 
> 2. When the NIC is linked and then link is downed and then upped on the 
> other side, it won't get IP address, too. I have to use the following 
> commands in order to get IP address and start traffic:
> 
> ip link set enp3s0 down
> ip link set enp3s0 up
> 
> 
> 3. Other than that, there are no problems at all - connection speed is 
> stable 1 Gbit, after PC reboot connection is always on, IP address ok, 
> traffic flows as it should.
> 
> 4. Recently, I've stumbled upon this thread which I think is similar to 
> my problem but It should have been resolved in my kernel version:
> 
> https://lore.kernel.org/netdev/97ec2232-3257-316c-c3e7-a08192ce16a6@gmail.com/T/
> 
> Do you have any ideas what's wrong?

Shot in the dark - could you check / disable EEE 
(ethtool --show-eee $ifc) ?

