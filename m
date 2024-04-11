Return-Path: <netdev+bounces-86791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8B88A04E6
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 02:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CDCAB237E2
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 00:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F100A1C01;
	Thu, 11 Apr 2024 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3JuuYOl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1CA2C80
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 00:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712796581; cv=none; b=P+k+2p1X15i/uD34GbDWb4fkRAd1ZkfQ59u/8tqJ95Pe/cEGeD9pcmgC95KxwyiW/u26JJQjVLBAw5eHtpUxTWo5nip9aCOaF8qJesbqSVjs4G8WBmsSKH0N4BRNLY/4XMcK2IyD179YHHpJ0VPEVF99eTCV0YX9nz5Df6n5yyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712796581; c=relaxed/simple;
	bh=uBvl+V48Ip1bx6RPlfDKU6fhpzEDYqZ+Px/zO5ASnWM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fdV1F6RfdUZV4kAaCjo1KLtCtJwwlNcK7XKDrjg1uenoTLAixmdkSNkbcaB8/UsGRSMDqB6cFLE0e92auTGTrMvVutNOkPPmyk8ZNgrPaSsvJkLysLsSZdlabLzwNMqsdqMgNjuwueIZ4giY2SidBIj9lQ5Zc0D4pT5uipzZrlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3JuuYOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4803C433F1;
	Thu, 11 Apr 2024 00:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712796581;
	bh=uBvl+V48Ip1bx6RPlfDKU6fhpzEDYqZ+Px/zO5ASnWM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t3JuuYOl8dKciiSv/7r8AzmyfNRBiVVtFg385l1za40aXoqT/1w5p9phBPBsanl8l
	 8yhF1pSYrwoUeicP3NXbUqGDZKNNCuDR1K8VsC7jh9wEb4Lzd7PQHoj1Bsg9Z+PMlr
	 NvZEjlsUKTs0VhfcWCRmSf43fo0k9xPnnuGbjDgNir7s0Wqx+ivAgc3E/uuTMZVR1y
	 3imx9NQr9owFronxClMTSim8xR8sEa76/E8LlYtnV11SrlNg3SdYDuunwkw9d3uROT
	 dTPuxRlMTrqVhxSWE9PnTbRFH46eDOCnVUwgBY17tme1M2+5ulLQB4l4mO2xvQtQN8
	 umosOJKawU1ZQ==
Date: Wed, 10 Apr 2024 17:49:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
 <devel@linux-ipsec.org>, Tobias Brunner <tobias@strongswan.org>
Subject: Re: 14141
Message-ID: <20240410174940.14739138@kernel.org>
In-Reply-To: <ZhbQ/qteBv7Up1lE@moon.secunet.de>
References: <cover.1712226175.git.antony.antony@secunet.com>
	<20ea2ab0472ecf2d1625dadb7ca0df39cf4fe0f5.1712226175.git.antony.antony@secunet.com>
	<20240408191534.2dd7892d@kernel.org>
	<ZhbQ/qteBv7Up1lE@moon.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 19:48:46 +0200 Antony Antony wrote:
> > Could you turn this into a selftest?  
> 
> I thought about it, and I didn't find any selftest file that match this
> test. This test need a topology with 4, ideally 5, namespaces connected in a line, and ip xfrm.
> 
> git/linux/tools/testing/selftests/net/pmtu.sh  is probably the easiest I
> can think off.
> 
> git/linux/tools/testing/selftests/net/xfrm_policy.sh seems to be a bit
> more complex to a extra tests to.
> 
> Do you have any preference? which file to add?

Whatever's easiest, I don't have much experience with either of those.
You can also create a new file, it's perfectly fine, just make sure
you add it to the makefile so kselftest knows about it

