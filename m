Return-Path: <netdev+bounces-155414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9B9A02482
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE3D18852C3
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 11:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E4F1DDA2E;
	Mon,  6 Jan 2025 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmg0XeTr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA56D1DD872;
	Mon,  6 Jan 2025 11:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736163915; cv=none; b=Dn6OEtQturBhnhOwQQYnHr/7JFDrvdGeWIrw0/v1vUveR/ZMb+5g/3dlKfevwoCsmMd1RBQDO7UitWLtjYQAhGCweYIaqDk4FCJv1Uhxk37vD8FsbGF+hBZQWxnZnVLV8yNm4cMLn+77WB/wkb+mWAQplDBHXg+ThUYVQ/RS4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736163915; c=relaxed/simple;
	bh=+UqgieBeJZ/+el25B5lGcvWlVHZV5rYJGEhr/qhW3AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+qHQOOtCJX18aogdnmP8F34qObxANl3CYumwUHLfmFOmrCSU5g+3NlhfSQIwY+QuBnXbdeTGyCww6ulWEoVl+CTSrj/Gc3v7QPUUCKIGSbVL7ZWm053iK4Hg7EqsnjwfO/ky6MEVUcrE5iX8c77r1VnWALAEQJrxKXcNbA55PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmg0XeTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A67C4CED2;
	Mon,  6 Jan 2025 11:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736163915;
	bh=+UqgieBeJZ/+el25B5lGcvWlVHZV5rYJGEhr/qhW3AA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nmg0XeTrj7NKv7WdTDGds1tVnoFraA57z8m/A+MSVpt2/UGuZmJE43ZSMGrHj/B/1
	 9NSz7AOKgNo41T1wtER5/ArqCwMqL7UuHD5Rbiqyu5bXAmi3a/5EtJMmIxT06i3nJV
	 XBVoBCZNcKiD4lVML0KM2lsYQlLOgvfwujq91oHXy2sS6FaiJ3Wi8dk1fXutzfY8iQ
	 gLW9SPduvJA6eYGoUFpTt6uXUfntWFaxVFKEswYJoM/koLZ8RjO5T4Spf/P3WF12v/
	 IH2bnfIMgPt9sQ7MAOgLzicoUHRQVcaFiCnS1Dwjf5pyy35QJrtlIvUOivkEgfdOaR
	 JMRVpnQuBrB0A==
Date: Mon, 6 Jan 2025 11:45:11 +0000
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 8/9] i40e: Remove unused i40e_asq_send_command_v2
Message-ID: <20250106114511.GH4068@kernel.org>
References: <20241221184247.118752-1-linux@treblig.org>
 <20241221184247.118752-9-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241221184247.118752-9-linux@treblig.org>

On Sat, Dec 21, 2024 at 06:42:46PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> i40e_asq_send_command_v2() was added in 2022 by
> commit 74073848b0d7 ("i40e: Add new versions of send ASQ command
> functions")
> but hasn't been used.
> 
> Remove it.
> 
> (The _atomic_v2 version of the function is used, so leave it).
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>


