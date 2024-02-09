Return-Path: <netdev+bounces-70473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 132BB84F244
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 10:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62711F23E05
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 09:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0786966B5D;
	Fri,  9 Feb 2024 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AddPQafS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D224666B57;
	Fri,  9 Feb 2024 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707470746; cv=none; b=AZWn/fkQ41IYet74G3x5PxZhYTzAgYmhpyNvmDoRJlkoBRMsXy+iDwxRg6Rip7WiJ6axMsSFevhHrv5Vu0dZNxOzyTqCdwmKq5Sn8D8sqL53BCdUSSL/mFXN1DNUgs+9/NVvmnjcbHO7AnmM1zd462ZPHjl4AbE46GwCUEFMGVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707470746; c=relaxed/simple;
	bh=6deB4JwIcTB+Wad5HliBhJFeYUzDANClHE3zQ8oM+uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dThEqLRi9e88vy8Ik4QdNtdKaZe+OZF/Sx/IZulYCV9CkG4EjnFz3aByDLVXi+5/ulrjgm28C1R3WjsRIXYiS+/hUsaTIKzewHRXPlexv6Ir4QoxLUpioNI6ikkjoqRVFXKbUa4iKhHtLJh4Q628XhAyxbiqhDryVi6HIubyvMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AddPQafS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78550C433F1;
	Fri,  9 Feb 2024 09:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707470746;
	bh=6deB4JwIcTB+Wad5HliBhJFeYUzDANClHE3zQ8oM+uc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AddPQafSjotARpFsx64RHoaB+Vp8MuQzH3c0OwUvwHBgijKZ5LJsJqjjsUDUdTJsy
	 Q8Gh/qXCel/o3FBSvNcjutgS/yKlgSs6G5M/F8l9kwXPyRkcGWhJJZMrE5ZOe2YHbt
	 qUgqt44AWPHcNMRpnwbYDREnha2DoccmfhQtk60NzkcanDBILwN/rn9utQdB19Zqoi
	 KOyE+4P4K1L9MedVLSzSX+cnW633TVwn/g2eWymJY3OoC0ZGM3eprTnqrbGlTmJ3uE
	 CjgUYJBTwGmtsnuMR2dyRYESHb/v2dOsv5IQ1FOqhoWNgXaJKbnCUZzd84dWLp+Pkh
	 uwB8uBdpQhb8w==
Date: Fri, 9 Feb 2024 09:25:42 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, sd@queasysnail.net, vadim.fedorenko@linux.dev,
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 6/7] selftests: tls: use exact comparison in
 recv_partial
Message-ID: <20240209092542.GS1435458@kernel.org>
References: <20240207011824.2609030-1-kuba@kernel.org>
 <20240207011824.2609030-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207011824.2609030-7-kuba@kernel.org>

On Tue, Feb 06, 2024 at 05:18:23PM -0800, Jakub Kicinski wrote:
> This exact case was fail for async crypto and we weren't
> catching it.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


