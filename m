Return-Path: <netdev+bounces-246786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5229ECF12C0
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 18:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 729CE30081BC
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 17:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D398E2BE7CB;
	Sun,  4 Jan 2026 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVSZHVQC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECDF126F0A
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767549163; cv=none; b=PW0UFjD4d0PPtFvNsFx7zt1tWAnzi91IfEDV0EHCTooIym6DLeaebm4gK7y2dZSHt2gG3blTWE4mstzNLN+FerJtKHCaEimuwcbonBnurkpdaYE3sFWbidBOcEh453ywwUDKWuIkogpk5jGqskYW/Ya1ewzvOnEuGFbQZcXzg5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767549163; c=relaxed/simple;
	bh=Jtr7/YkBWihsBTHdvh91SQ5PxGPS+8ySsRwtEDqgaao=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9n91HrrGMQL2WlQ5idMOKwj0dl3GzeNkQS/dQhHPdL9eHKWJgyBwQp8EFGqKCXSSqegTfMpUxGwJlqJ1iQeR3PwAa4Q0A4hLfjUu1btErMUNTmL2VUlNxI4k6p/PdkpsLWE7gXu046q8Hj8DOPm/hmAZYur+ksLqRMj/8Ta5LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVSZHVQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDD8C4CEF7;
	Sun,  4 Jan 2026 17:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767549163;
	bh=Jtr7/YkBWihsBTHdvh91SQ5PxGPS+8ySsRwtEDqgaao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WVSZHVQCjWh4/FnltdAJMTqbwi1aKflyhGkv1qTCrRsJZiWkDlU/FTVRFO/6y1aQo
	 5gHUEeTaPMhHhICncBvtUiwaZkXWegjhlwCo98hZvrSkgPtX29ybDYpY2BWSMfg3z8
	 EOzJuPnSRACFpf5h5GfAMKWUiZKDqa1YYA6L2OH0QMPS9WydhdB1sHGN4h9bXCZgma
	 JJ5Pu842IFEthl8ahNLiFFTUqy6WZhuYvvNxhNOUM+9/Ta+JPsZsTW0um9cLs4HGxQ
	 bgrSJaLZHhPtIE1hdJJQ0TDLv2ZIQpc911vJQ3FlRx1PULHdfaINckWG54B5GMCMgS
	 YC57O5cAlUYmw==
Date: Sun, 4 Jan 2026 09:52:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: "alsi@bang-olufsen.dk" <alsi@bang-olufsen.dk>, "olteanv@gmail.com"
 <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, "davem@davemloft.net"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH v5] net: dsa: realtek: rtl8365mb: remove ifOutDiscards
 from rx_packets
Message-ID: <20260104095242.3b82b332@kernel.org>
In-Reply-To: <09c19b60-a795-4640-90b8-656b3bb3c161@yahoo.com>
References: <2114795695.8721689.1763312184906.ref@mail.yahoo.com>
	<2114795695.8721689.1763312184906@mail.yahoo.com>
	<234545199.8734622.1763313511799@mail.yahoo.com>
	<d2339247-19a6-4614-a91c-86d79c2b4d00@yahoo.com>
	<20260104073101.2b3a0baa@kernel.org>
	<1bc5c4f0-5cec-4fab-b5ad-5c0ab213ce37@yahoo.com>
	<20260104090132.5b1e676e@kernel.org>
	<09c19b60-a795-4640-90b8-656b3bb3c161@yahoo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 4 Jan 2026 18:39:50 +0100 Mieczyslaw Nalewaj wrote:
> Fixes: 4af2950c50c8 ("net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC")
> 
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

 - no empty lines between tags
 - don't send patches in reply to existing threads
 - don't send new versions less than 24h after previous version

