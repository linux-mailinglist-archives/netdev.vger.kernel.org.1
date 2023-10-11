Return-Path: <netdev+bounces-39772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 406087C46E4
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 02:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE5A280FC4
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 00:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C1239A;
	Wed, 11 Oct 2023 00:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvUFTAbx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1109388;
	Wed, 11 Oct 2023 00:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058DCC433C8;
	Wed, 11 Oct 2023 00:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696985683;
	bh=0H4iRVCJQWGz61Tmn2yBFyuOebfIUuGff1Pt5wvl8yQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cvUFTAbx2/KN98oDPIvh9DGkRgRIbMXADOBHzGo+2U3qjgAozV7EpZSxuBtsc5jZ7
	 cSqIONfcgAzTs85Ws4XS7bchxVLjz704w0sCbiqMoMSGrlb7Q16kRN2xnWWL3F28a9
	 fAUwCILxx/NfB0JaudWnkpxCyVITNWn+o2RuBHb9rfc6pqcIGl3LhcFsbUjswN2t+z
	 eiIIGp1pD6KLueDKpP1iOUT1XMKMHb2sdJN6kd/jWlDCojSfA8ev/KatXJJw4Bkl2S
	 +iZeldSxJSaIDdZXw1izRBoYF3t4mcoZuy4pMXjAidbrQ3+6sN1Pi563lNPNIV1qNy
	 jc3OCKhj1svaQ==
Date: Tue, 10 Oct 2023 17:54:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Kees Cook
 <keescook@chromium.org>
Subject: Re: [PATCH] igbvf: replace deprecated strncpy with strscpy
Message-ID: <20231010175441.755cb82a@kernel.org>
In-Reply-To: <20231010174731.3a1d454e@kernel.org>
References: <20231010-strncpy-drivers-net-ethernet-intel-igbvf-netdev-c-v1-1-69ccfb2c2aa5@google.com>
	<5dc78e2f-62c1-083a-387f-9afabac02007@intel.com>
	<CAFhGd8ppobxMnvrMT4HrRkf0LvHE1P-utErp8Tk22Fb9OO=8Rw@mail.gmail.com>
	<20231010174731.3a1d454e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Oct 2023 17:47:31 -0700 Jakub Kicinski wrote:
> Please do read the netdev rules Jesse pointed you at.
> Maybe it's the combined flow of strncpy and __counted_by patches
> but managing the state of the "hardening" patches is getting 
> a bit tedious :(
> 
> Please group them into reasonable series. Do not repost withing 24h.
> Do not have more than 15 patches for networking pending at any given
> time. That's basically the gist of our "good citizen" rules.

FWIW you can see how many pending patches you have pending in netdev
using this here link:

https://patchwork.kernel.org/project/netdevbpf/list/?submitter=206354

