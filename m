Return-Path: <netdev+bounces-73520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C08885CE08
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 03:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D4AFB23B88
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 02:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E1D18643;
	Wed, 21 Feb 2024 02:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXSPAA8P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C668715AB
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708482662; cv=none; b=gbefaRME6qubFHUNS2FeCCMOZ+hsG4RA3V5q7dXrcXtnXC23Sh8R4lEzeRPGhpC0pUmk71vxngsfBRqDI6n1aD19ew/4SsIVMWqG+fe2I0Ap9qsR/u4Nij5WNXwmPLIiKpHbpSojlJCEhBBJxH0gTAd/nFDRAYassgaQoREtECY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708482662; c=relaxed/simple;
	bh=aoaCiqX4/ybuMfhEQgs0qWynPAEH3EKIKFDwSVUT1E4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SEBLwR+hfYFRdJxOEAYvsuoIHCJfV8CQH3vOwd1CPU+GYeqRvQ5QP0mvG5/eb8h2ldb7/VQCaGtklqhk2X6HG8DKQjfZmvVi0V4dyjKqoqBWlp1kxMR1OmliY8415LBIpRy28BormlDN+J/wgrhOOAsFnsNO1vKHh0FmcOSCZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXSPAA8P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EACAC433F1;
	Wed, 21 Feb 2024 02:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708482662;
	bh=aoaCiqX4/ybuMfhEQgs0qWynPAEH3EKIKFDwSVUT1E4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kXSPAA8Phvq9N/9kGu2K5jwDPHiEB67PVmRCVmYihJoeq3InWsjSeolpk0r+qKKWu
	 DhN8DtXlV34QKobx9qoSVZmSyMpePiBU8Vq/xHw5BvtXE7xxDBf0XKr/Mudu3MeNVl
	 EMOyp6Z7O2AKNLS9wA9gbFW5pPDf8YaiIxnO73m3ujSY9Vgix3n8QMRf1MHyMj+4j+
	 oSVJ5cT3k6+qJxt6MR6RPjXJrFoPrH+eCsoP8fnIpmikGcUY0Uye0B/StBW8oyaPOM
	 lm2xbaYj4Y/bIQ8rejNhrIJofQ4D4u4N0mMZ5ZJ1hJF4QSBJgqPgc92SQ/1fmJMITW
	 e72rBNLYHlHVw==
Date: Tue, 20 Feb 2024 18:31:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>, Realtek linux nic maintainers
 <nic_swsd@realtek.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] r8169: add MODULE_FIRMWARE entry for RTL8126A
Message-ID: <20240220183101.0da15db0@kernel.org>
In-Reply-To: <47ef79d2-59c4-4d44-9595-366c70c4ad87@gmail.com>
References: <47ef79d2-59c4-4d44-9595-366c70c4ad87@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Feb 2024 15:48:23 +0100 Heiner Kallweit wrote:
> Add the missing MODULE_FIRMWARE entry for RTL8126A.

No need for a Fixes tag, but if you remember, please do mention 
the commit which added support, so I don't have to replicate the
research you already correctly concluded :)

