Return-Path: <netdev+bounces-92985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BC38B9870
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 12:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E384A1C20B2C
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 10:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D072456773;
	Thu,  2 May 2024 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OK4/Ri2R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA7355C3A
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714644296; cv=none; b=F/hdTjuFt/da6Pa7WZ0zBqdyZq5VX0E7sPX6TgDXLpaJxxrb38KhRKi5Hj60NkyQ/Jn9c10oK/Zt8WRagt/4O4SA3DB8DDjOXw+wG9qv2AEKyMlBAkqLKRl0TzfyzaS3zfVRfJ9JrEnXeEyKLeEWsns5Al9D//VO3aPeBjyO41c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714644296; c=relaxed/simple;
	bh=ASN9+jcJA5lN7EQmgA+SabbE+dLr1fJojBrDWbiJgPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPdm6VjOzUYkc9jBT8/l9q9kyuL084h+c2ueynDzQfgoUdwWQ+N+akftFVHyEhx0JSnizB1KgMWVhq7QXlfDt9WmWsgJnby6nxo4loeC0M4hKs50BtCnPVsHDoZK538DKQJ4XN0S5IzU8fqhvjMFYUQBLGKZMWO/4jrrJrnmMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OK4/Ri2R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E161EC113CC;
	Thu,  2 May 2024 10:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714644296;
	bh=ASN9+jcJA5lN7EQmgA+SabbE+dLr1fJojBrDWbiJgPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OK4/Ri2RQZNdVmunOtD5FUa3g1G9MjyQvqvkNEDKGM+MHhw9oC9QR1P7oPQ/1aWpd
	 Hjd5qrCabAhU52C6DWMhIqvA+tdkPBpKD1zQ5xVoM/7vceTTgnn+I+Iley+pHYI7o+
	 qHU59+9T2dnhOBMvSUUS4+PNhz8UP/Pq5M5bRUXW3Bl+skvfRYLtlCTSuEmkHSYN0U
	 LfTi8kDAJUfLMMfgZjZvXQPsw4Jl52c5+DM52SS/+wUaVKlVKcagmoXYmixnQpe8vQ
	 7H5kxv2jawupGflT6dKaQwod9k2XHE3s7EZOMCuiHKjGQzMmWFKjcQ0PvnuvHko+2s
	 AJE9AQlayqTIQ==
Date: Thu, 2 May 2024 11:04:51 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: Re: [PATCH net-next v2 2/6] bnxt_en: Don't support offline self test
 when RoCE driver is loaded
Message-ID: <20240502100451.GF2821784@kernel.org>
References: <20240501003056.100607-1-michael.chan@broadcom.com>
 <20240501003056.100607-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501003056.100607-3-michael.chan@broadcom.com>

On Tue, Apr 30, 2024 at 05:30:52PM -0700, Michael Chan wrote:
> From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> 
> Offline self test is a very disruptive operation for RoCE and requires
> all active QPs to be destroyed.  With a large number of QPs, it can
> take a long time to destroy all the QPs and can timeout.  Do not allow
> ethtool offline self test if the RoCE driver is registered on the
> device.
> 
> Reviewed-by: Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>
> Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>



