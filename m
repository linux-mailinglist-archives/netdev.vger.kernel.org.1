Return-Path: <netdev+bounces-185777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A1EA9BB38
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C2611716B8
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 23:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2E42253EE;
	Thu, 24 Apr 2025 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7VTZGLT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77814A93D
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745537067; cv=none; b=JSkGDeYnAqYGBC+k+3+AoVRv6D9siiRfZeJCg8EQ8Uoenpf2aLz4DCrcMQlXHW1lslXX0HO5SYP0suBWxfplQhE68dB33noYWdGAeO0Ujr/gXEKSUZktTKht2R4Cp/RcNEpvNgn5lE8sSo6WZ5EZIBvrgEPcRX8qe3Ydv8AM+A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745537067; c=relaxed/simple;
	bh=pK0wLhP8ZyLfNW4FV/7ualfAvEz8cXn1jh58QTIgfPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHLeCbvo+2myBw9bTRgtumzQv2NzM6qBrZTvqZCSVOOXivD9uYzj3cg2YHWBjuJ8aCPzy4sa+40gkDHWo5djY8TTXLC3qyVYDeNtkXOgh7r9DFmRzVdUWq747mnZv8ZHVVWP3OqDO/zl0IQAvoGrNgAUhyfCcCBCXfol6jzwjXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7VTZGLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4913AC4CEEA;
	Thu, 24 Apr 2025 23:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745537066;
	bh=pK0wLhP8ZyLfNW4FV/7ualfAvEz8cXn1jh58QTIgfPQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n7VTZGLTV3cpbEprg2Crqgis7qm38x+HQOeZPhZhPMmjC09i1YUUvdHyeyqNzbPrF
	 Wh3yP7PXtby8a7WHoPJH4hfklgIpYGOKUmLXhOt5teba+aIV31LP3S0o0rWrbIswnV
	 72sF0UfTxu8m8VRmZGRbMINN2UUzE0NCLUDCklnN1F6wkGQxPJOhSPNLX7fBfYWio0
	 kmrPgALgJxz/jdUsUANX3Eid2y+9rCG98ufC6ud3SV4lbWeScxR1O5f/SU4Si3+j+X
	 f6ndJNTdGsQLkye2RV1YebSS2WxlMYoLec+TdKtvb9NH91AVPrHlTyIaO8FykaLUIW
	 Q9sc8cz74xPYQ==
Date: Thu, 24 Apr 2025 16:24:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Jiri
 Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed
 <saeedm@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>
Subject: Re: [RFC net-next 0/5] devlink: Add unique identifier to devlink
 port function
Message-ID: <20250424162425.1c0b46d1@kernel.org>
In-Reply-To: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 16:50:37 +0300 Moshe Shemesh wrote:
> A function unique identifier (UID) is a vendor defined string of
> arbitrary length that universally identifies a function. The function
> UID can be reported by device drivers via devlink dev info command.
> 
> This patch set adds UID attribute to devlink port function that reports
> the UID of the function that pertains to the devlink port. Code is also
> added to mlx5 as the first user to implement this attribute.
> 
> The main purpose of adding this attribute is to allow users to
> unambiguously map between a function and the devlink port that manages
> it, which might be on another host.
> 
> For example, one can retrieve the UID of a function using the "devlink
> dev info" command and then search for the same UID in the output of
> "devlink port show" command.
> 
> The "devlink dev info" support for UID of a function is added by a
> separate patchset [1]. This patchset is submitted as an RFC to
> illustrate the other side of the solution.
> 
> Other existing identifiers such as serial_number or board.serial_number
> are not good enough as they don't guarantee uniqueness per function. For
> example, in a multi-host NIC all PFs report the same value.

Makes sense, tho, could you please use UUID?
Let's use industry standards when possible, not "arbitrary strings".

