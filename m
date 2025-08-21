Return-Path: <netdev+bounces-215650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB82B2FC66
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 112FF7B96B7
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306772EDD77;
	Thu, 21 Aug 2025 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtyIWBF5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AABC2EDD6E
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786108; cv=none; b=GZAObRRfuY4fHKajrKVWW+JE/YtZzhywCZzeokpuimGBAILrCkC2M6+ybULmxvLCizZffHV6XB3laQMtRaQCl6dK1QFmG698JACYWSY2firJJqShqbxOu062oFE1M5V8Op/MyQKLq4HIglf2EdUwFFvtF/jiltIFI6VphI3HxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786108; c=relaxed/simple;
	bh=mn+3JdjqYVuQ42AEXu9cfJXsjcT0sp0KFcE1RlWN/Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZnEkZNiq9JcGV6OBG0T9uPi6jP8ChS+xvp3UZoJuALEi50dkdBi2x/7/Oe4qU+dLUqyd5sDGGpC35F5STAQanr4FeGgyPwSZHqFPYLeeC7sn1Cw6GhZb9JQfAIOOP1SYeI2BS9Fd22eLoxCpl7DzFF8BFUM8ynN7zls1GTXMWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtyIWBF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73574C4CEED;
	Thu, 21 Aug 2025 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786107;
	bh=mn+3JdjqYVuQ42AEXu9cfJXsjcT0sp0KFcE1RlWN/Wo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VtyIWBF5qpA+Nk1wz8JYRGJ5nYMqXKSJezOekjH8ZvaJMHHkRZQgLGQt5n3I/uI5A
	 PnNdVezjYVI/FcQDX7+zGW6M/Z/qI6+eoJJ9uTAkUfA595IOvfO5lbVeNrwgbCMIPT
	 7/UqEsQlIMHPjaA2+y4TDlNyuDTvssfQOgDC8MoQMm+/wRSij4G8wYjPCIV93qAX54
	 trKIJ/VCKwOMf8p46lMZ0mSPm2ATJl/7FKXSNDioWN2WziT8NR9OmlncCaMKSexaoI
	 aPuDw5lhPHeYlBIV5yYbfrGuNQ4caD+NkMlVIbrWAJR2hYfDZ5/C/6hQ2p3B4wquKM
	 dFyK7kMERKEUA==
Date: Thu, 21 Aug 2025 07:21:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Sridhar
 Samudrala <sridhar.samudrala@intel.com>, "Hay, Joshua A"
 <joshua.a.hay@intel.com>
Subject: Re: [PATCH net-next v1] iou-zcrx: update documentation
Message-ID: <20250821072146.4c06e82b@kernel.org>
In-Reply-To: <CAM0EoMm06em6GKDyDP94oQ_RPHv4PQ3dK19YZU9jxCiNh2S8rg@mail.gmail.com>
References: <20250819205632.1368993-1-dw@davidwei.uk>
	<CAM0EoMm06em6GKDyDP94oQ_RPHv4PQ3dK19YZU9jxCiNh2S8rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 00:34:34 -0400 Jamal Hadi Salim wrote:
> > +Zero copy Rx currently support two NIC families:
> > +
> > +* Broadcom Thor (BCM95750x) family
> > +  * Minimum FW is 232
> > +* Mellanox ConnectX-7 (MT2910) family
> > +  * Minimum FW is 28.42
> > +  
> 
> you missed the intel dpu/idpf 

I think you were using an out of tree driver?

But keep an eye out for GVE, there's a patch to support ZC there.

