Return-Path: <netdev+bounces-107480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D9991B274
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 01:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2271C22060
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EB419DF8C;
	Thu, 27 Jun 2024 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qooV9Slk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA4F13A3E8;
	Thu, 27 Jun 2024 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719529453; cv=none; b=PLTxJsKexN2Q76DPrgqmLlLfWdPVX7dkkTyJn/C9HFNvnrXMJqcMSFqRVXvrBC32fGhEzobT+WLf8D1o5n0tLF4j3gRP9Dr31Bhor6CuzCLYlqcPqsyIlwwHVJfxemhuuL5yPte+G1JiXWQFZPOAzu25szk31C+o4evfktyw44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719529453; c=relaxed/simple;
	bh=kDgdG01n/KgfB08cdFfx+JcATSEd5pCxiHkkQqnciD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMjKHyx7c2peleDAtP1SU3X9xJrcseh18JA94t67aDL7FgxbNX8Dgv62b9DhUn0X3Y1ROyqkjMVNKMiv/3mIZYR290oTN3xriuMeNVpBR77MFelWupIx+l8Eb3J3AqwTRGC3Ce1t9tKVlY7lHvNxZGP9+R8XV3SzXpxY6E1yywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qooV9Slk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E6CC2BBFC;
	Thu, 27 Jun 2024 23:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719529453;
	bh=kDgdG01n/KgfB08cdFfx+JcATSEd5pCxiHkkQqnciD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qooV9SlkuCvBmNmYAJMYYZ2KQaLVDWalOi651PbCI1tSU6Nb6/OoG0pgUumr5RrT/
	 fwjao0bl5eCYa2rwm0PY6bLfrNKe2vbcg2Hg0t5gly7LK8NEDhurZVNMGOpRTJ2nR7
	 12s3/I/NbcNICGFWeMPdpTB8w8Zi2qAqyeFiM11KuWHCMiWYYWpQEC8R0YD75r9LDf
	 uiEpXRfp7Th8czvLKqW/6ubxm4aUmRAOE1Mn2/ONbcwYnZqhg2xy3J+/U89gz7DE81
	 UEcRKqY0WiYkMq9eZMPalurrhYVR2p3i+KK+VmQGrPhhlZvO+fqgFeYB9+Vz715EwA
	 KBqjAHWQ/nqvg==
Date: Thu, 27 Jun 2024 16:04:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <sgoutham@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: Re: [net-next PATCH v6 00/10] Introduce RVU representors
Message-ID: <20240627160411.3d7cdbe6@kernel.org>
In-Reply-To: <20240625142503.3293-1-gakula@marvell.com>
References: <20240625142503.3293-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 19:54:53 +0530 Geetha sowjanya wrote:
> This series adds representor support for each rvu devices.
> When switchdev mode is enabled, representor netdev is registered
> for each rvu device. In implementation of representor model, 
> one NIX HW LF with multiple SQ and RQ is reserved, where each
> RQ and SQ of the LF are mapped to a representor. A loopback channel
> is reserved to support packet path between representors and VFs.
> CN10K silicon supports 2 types of MACs, RPM and SDP. This
> patch set adds representor support for both RPM and SDP MAC
> interfaces.

Does not apply please rebase.
-- 
pw-bot: cr

