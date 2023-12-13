Return-Path: <netdev+bounces-56658-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0258580FC08
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A14671F21254
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466D438B;
	Wed, 13 Dec 2023 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mW95xSkT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BCA1C2F
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 247D7C433C9;
	Wed, 13 Dec 2023 00:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702426231;
	bh=MQxulmHpNRv6UmRfBV673M+2mklcfKpulEm24fODeAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mW95xSkTLWdzImHwfbSbNlwL8EfiL6cKUDEovZjzIZh94Xbugiz926H7cUTZWPTws
	 ynuM1cd44ywq76oxQtqdAnenR/765o336QfeldTg16L/cw/ylmNKRrxiMizN9JV1xA
	 xLljND/CxoICnuOb3AdQtiOJiLC/zkZEzg6jW8BpYYqEAc6ldr84dqHbu1EQIzWnXa
	 WATO1GK4VJXAHdN17wOn0Nwroj60VOr5kcTl+CmXikkxRHjBU+a4yVB2qp+Ry5rz+e
	 E5gsT14lUfu8fjU383ip3EY7MDm7c8+u7/1deuVfdAQHH5Q7OfdC7W4e3lUGK8kn6s
	 onVotf/BOpUrQ==
Date: Tue, 12 Dec 2023 16:10:30 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <vimleshk@marvell.com>, <egallen@redhat.com>,
 <mschmidt@redhat.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <davem@davemloft.net>, <wizhao@redhat.com>, <kheib@redhat.com>,
 <konguyen@redhat.com>, Veerasenareddy Burru <vburru@marvell.com>, "Sathesh
 Edara" <sedara@marvell.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v3] octeon_ep: add PF-VF mailbox communication
Message-ID: <20231212161030.5eb7b84e@kernel.org>
In-Reply-To: <20231211063355.2630028-2-srasheed@marvell.com>
References: <20231211063355.2630028-1-srasheed@marvell.com>
	<20231211063355.2630028-2-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 10 Dec 2023 22:33:52 -0800 Shinas Rasheed wrote:
> Implement mailbox communication between PF and VFs.
> PF-VF mailbox is used for all control commands from VF to PF and
> asynchronous notification messages from PF to VF.

This patch was not designated as 1/4 in the subject so patchwork
thought it's a separate posting, and the series lacks patch 1/4.
You gotta repost so that patchwork can ingest this properly.
-- 
pw-bot: cr

