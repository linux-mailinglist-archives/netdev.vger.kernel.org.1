Return-Path: <netdev+bounces-176525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02952A6AA73
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB0E18971FF
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6811E3DC4;
	Thu, 20 Mar 2025 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2CJf+U+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A1C14B08A
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486323; cv=none; b=ddKhHo42HE0+UrCeFg5oAkji7s0ZtnJp5Gx7doJfGdqpytpELkow6VOzYXCO6v+QjwwB4TDR3gYDMet4l/zS7ZjRpmd+AoGuwkheOj4I9HnKYzfXtTehwdMko7HysH4vNwMquT6ruqfy+t8q8jaL1gdbp8t107a1TmM56NdovNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486323; c=relaxed/simple;
	bh=aV7ECwMSGxlmZxmcmWdLFUnGXWKasDTW/EsnjTOOTtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwfXhH6NSg524hamPc9ZEr1DJC5W+on7q8wfcmgUNRPIwmbCY2RL48xSiUpr07KQV1CbLm8AWCP4VSj4ix8F8mLjKiXn5K0QLuMTFg/Kc3YiWJORe6uxYT/6PjaBPc7rW3mFUv06d9sJWANUmvioIK7nsn0VOq0e6QAW5TpY/aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2CJf+U+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27E6C4CEE7;
	Thu, 20 Mar 2025 15:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742486323;
	bh=aV7ECwMSGxlmZxmcmWdLFUnGXWKasDTW/EsnjTOOTtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U2CJf+U+3z3J2IfeF67HfqdqqeaaKPac9FIYu0JjH/1snRQAWMoVabRAhCp5LD6WW
	 cR8tD6UyAIiEf35cC4VWfIdP1F7PqgfW972v+TXzfxvO/tjl35N0hjrt5PKS8SUsdg
	 xcAhPSnCxERW4tfZIdRtzRCtPBliW5nSmzegjSUbdX+Z6FdlYcZwexMUASpJEuFS59
	 wjMt54DgKtPh+PhSnqZhA/2iDCPn5CSiaI/4TcRC0nm/+iu+yetojxoUAJeBN0hSLD
	 td9YD6b4T988SDFvV0fsDVajTBStY8dyIrJ/YhxI10TN0Qdufk/gh2dmRq5eUb0b+z
	 mX/6ntm+LYEZw==
Date: Thu, 20 Mar 2025 15:58:39 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>, Amit Cohen <amcohen@nvidia.com>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 4/6] mlxsw: spectrum_switchdev: Move
 mlxsw_sp_bridge_vxlan_join()
Message-ID: <20250320155839.GG889584@horms.kernel.org>
References: <cover.1742224300.git.petrm@nvidia.com>
 <64750a0965536530482318578bada30fac372b8a.1742224300.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64750a0965536530482318578bada30fac372b8a.1742224300.git.petrm@nvidia.com>

On Mon, Mar 17, 2025 at 06:37:29PM +0100, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> Next patch will call __mlxsw_sp_bridge_vxlan_leave() from
> mlxsw_sp_bridge_vxlan_join() as part of error flow, move the function to
> be able to call the second one.
> 
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


