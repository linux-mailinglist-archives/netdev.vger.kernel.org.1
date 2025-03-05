Return-Path: <netdev+bounces-171912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36714A4F4E2
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 03:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E61516ED45
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 02:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8AA1519A7;
	Wed,  5 Mar 2025 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5GNMIx5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625B8BA27;
	Wed,  5 Mar 2025 02:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741143050; cv=none; b=rBX12V7p1irdts1o9EiTs49guQLCGYGbbgyMb4gShQT/WNMvgw5xxh8ujPx2k6h7l+Ciq6ofC9/KNrqS91Z3ukfZmEW46l43cPA05l26uI96rOzkkqqHXaw/s9EaW21FHQ+/YNoDXXHUzE4GZZKjA5gdSqeJwxMA/VhfQVLInJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741143050; c=relaxed/simple;
	bh=d08L1n45lGJ86q4foagFIWH0DMeqTEth7D7kIf/witE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlVp1A4P/QkpG4hp/8mmk7pp1igrTbO5g2g2ziLpUxPuxT6ez4nPZsCd0ZHi+kbqyFpPY80zgjZXyCi7263ujitkGPz/YSni/wlvz4BnqrpYUQrDxLebOmoyq0EXmcTqMADTZSWDvYB/NcpLku1wsmcLhEEwUrtjIKLWMIJOPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5GNMIx5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2A9C4CEE5;
	Wed,  5 Mar 2025 02:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741143049;
	bh=d08L1n45lGJ86q4foagFIWH0DMeqTEth7D7kIf/witE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e5GNMIx5NJBZdgFpcVBIBuj6dm9AIa5uQnWooKb/SHp+/KL/O7z18QovGWiUvslAX
	 2nfrx8QDc1tDkzBXZ/Z4aDjN8aZIbj3pfs+58HL4Y20yACtiR8XF7phsyAs3LJz6UM
	 r1P48wVq8xAPWpV8JwSzkWBKO8+YGkyD2+JHpg3vMj2HpY63wjTnOTFwGpTZz0vpfw
	 wYzcIhl9UsABMHmsWoTejJY3i1ob9snTFH830XQPxg7XQgafvjcQkbSJbexaIisHdQ
	 qoiOFLBTJ7onNtb4XMXfRc1LrFLBV5AkyNpI7PixibBLMDaPgHTqdxruyeOXuXLGWm
	 p/cGTYsZPjcEw==
Date: Tue, 4 Mar 2025 18:50:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jon Maloy <jmaloy@redhat.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Tuong Lien
 <tuong.t.lien@dektech.com.au>, Ying Xue <ying.xue@windriver.com>,
 cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] tipc: Reduce scope for the variable
 =?UTF-8?B?4oCcZmRlZnHigJ0=?= in tipc_link_tnl_prepare()
Message-ID: <20250304185048.3db84306@kernel.org>
In-Reply-To: <08fe8fc3-19c3-4324-8719-0ee74b0f32c9@web.de>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
	<1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
	<624fb730-d9de-ba92-1641-f21260b65283@web.de>
	<08fe8fc3-19c3-4324-8719-0ee74b0f32c9@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 2 Mar 2025 21:30:27 +0100 Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 13 Apr 2023 17:00:11 +0200
>=20
> The address of a data structure member was determined before
> a corresponding null pointer check in the implementation of
> the function =E2=80=9Ctipc_link_tnl_prepare=E2=80=9D.
>=20
> Thus avoid the risk for undefined behaviour by moving the definition
> for the local variable =E2=80=9Cfdefq=E2=80=9D into an if branch at the e=
nd.
>=20
> This issue was detected by using the Coccinelle software.
>=20
> Fixes: 58ee86b8c775 ("tipc: adapt link failover for new Gap-ACK algorithm=
")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied without the Fixes tag, thanks.

