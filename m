Return-Path: <netdev+bounces-233767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFCEC18067
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 734D01A60414
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07C22EA17E;
	Wed, 29 Oct 2025 02:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQilL4Y8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2432E9EB5
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 02:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761704058; cv=none; b=KP3pNDfc0U59YB+CZXluzXIShF81xm1H0px7w+uWPCkssBxHfQrQncbvwkUBIHO3BAH7Fl2x+nxfGdykd5s56k932OWXqNRXq3+83DGekTDxiu7Be907ZbvFzIyNOiLTFXDJ9rWPMEtEpXuEJEIchkU4jaB7d8AdWHTJT25naLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761704058; c=relaxed/simple;
	bh=ZZs5A8zSwRdMCQqEtcKlclb9H2qXuaiodNOXE4S+CDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gR1qhAjRxRQOhfDPnQh+koKdYYCXVC8lAGL4R5gGDtW82Xbwxq2d84WH3u3Z2qPlZWxosJbEiY3/TPsEgYseA2hkQuEIb2cjtFhfmIozSAn1V9T1MhrKWSEg6m/qnCqum4AazXH7f8BFPsOwlUV/nOPWvxCeR9A2rm49qhKWtxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQilL4Y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D249C4CEE7;
	Wed, 29 Oct 2025 02:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761704057;
	bh=ZZs5A8zSwRdMCQqEtcKlclb9H2qXuaiodNOXE4S+CDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pQilL4Y8X+EaWjLdNR59tvNDTg2C2X+e5BEK33KR9K4PH/8Mqz+tLftrKn7YHNJK9
	 3pYSovj1o6HesJX+wqbeY3SmueycvFDzkUdHUtcJjTHEZAwxwhVYaDPa96Dx/UaF6Y
	 Pqiwm1ndpEAwt7oYHZYAYSJU1eIWVzlSjWu/Meh2alAYY+ZYZnQBKfrc9p4j/5DMoI
	 YjGrI3Ti60fpw4cltXMZ4GWQLei0pUoE4H2K3v80RmdeNvPtlAEAQOo3mRhsO01qjg
	 VIQcwK1Hv6a9Y1grWMSSKyRWUtlzTO/nYB8NMPD1kv+gbugA5nPN+SNo7n3YNbOrgZ
	 Ma3daooSMZu4g==
Date: Tue, 28 Oct 2025 19:14:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
 <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <maxime.chevallier@bootlin.com>, <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH net-next v4 5/5] amd-xgbe: add ethtool jumbo frame
 selftest
Message-ID: <20251028191416.78de3614@kernel.org>
In-Reply-To: <20251028084923.1047010-4-Raju.Rangoju@amd.com>
References: <20251028084923.1047010-1-Raju.Rangoju@amd.com>
	<20251028084923.1047010-4-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 14:19:23 +0530 Raju Rangoju wrote:
>  	skb = skb_unshare(skb, GFP_ATOMIC);
>  	if (!skb)
> -		goto out;
> +		goto out;;

double semicolon
-- 
pw-bot: cr

