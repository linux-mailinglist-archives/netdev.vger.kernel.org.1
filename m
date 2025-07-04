Return-Path: <netdev+bounces-204179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B21E8AF9604
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22DF616E771
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 14:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890A11917D6;
	Fri,  4 Jul 2025 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgSkqDYN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E6182C60
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751640729; cv=none; b=udp/+FvKuUM1JR+dpafDdgPPTlVL2muKly4RuaDU6qcnPAyZMQmg8iellyto0JLkW9dq+V8p4ozI2OT6JVlXpYvKMQ3lb07LrQShWxLVy790BzcBkgGf4ZdohbSrGuSCnlFx9/5OMwdTsIbPaq1zr50LovWDEa3bz9shMvATVsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751640729; c=relaxed/simple;
	bh=KYFuRsqR/zu9FKP7GnSfbAmTbkR2pR9lH10PSgYV828=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJMZRycc2FUKDgfFX4CUqkk7rrAkeetNnklIYeyDrjE4Ap9Vnje4lMCTDoa0QZyYBWH0f0THEJCLvTj3trwkWiZ9UbQAHdudTF3ZLO6mzOM5hY3CI2DF3MklwfzyIy06K8nmEX1QMHH9uEZ2I5Ubq1FQvIUe7frlC2o2ueEpEkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgSkqDYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAFEC4CEE3;
	Fri,  4 Jul 2025 14:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751640728;
	bh=KYFuRsqR/zu9FKP7GnSfbAmTbkR2pR9lH10PSgYV828=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UgSkqDYNHPRrNBMyLjRXv6KNc88Uo7f+E64cgYIKYBk+GHqPoAEhzpf7ou0EO7lqL
	 83WYucbPjic+d50gqC6WzcgvliuTcdwRB43sy+DJXRnIIU4gZvI9iUKh9RNOxvr4k8
	 bygqVu9rcHADe/eBZmVFYXzdcBpSX1wpXoV1eJQzE6bdHsSkXiHBIOpt0PJPETnXvn
	 5TxSkZT6wkizA1OVN455wCvarspTCHh5hxW8v5Q0hOUNDAAUsQ8N4VDI70hY5P2Cyv
	 zPHrxfZjQ6kzkwHgs6mIIhxZoSj8iyAzxPyCaAxnteaTkEa0cyTHZ0yFthoh/GkMln
	 a9Z5CZugJDZlw==
Date: Fri, 4 Jul 2025 15:52:04 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/6] net: airoha: npu: Add wlan irq management
 callbacks
Message-ID: <20250704145204.GB41770@horms.kernel.org>
References: <20250702-airoha-en7581-wlan-offlaod-v1-0-803009700b38@kernel.org>
 <20250702-airoha-en7581-wlan-offlaod-v1-3-803009700b38@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-airoha-en7581-wlan-offlaod-v1-3-803009700b38@kernel.org>

On Wed, Jul 02, 2025 at 12:23:32AM +0200, Lorenzo Bianconi wrote:
> Introduce callbacks used by the MT76 driver to configure NPU SoC
> interrupts. This is a preliminary patch to enable wlan flowtable
> offload for EN7581 SoC with MT76 driver.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


