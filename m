Return-Path: <netdev+bounces-23655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1561476CF4A
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28EA21C212C6
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 13:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD5F79EC;
	Wed,  2 Aug 2023 13:56:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40A77488
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 13:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97436C433C8;
	Wed,  2 Aug 2023 13:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690984569;
	bh=yazmUit565hUeHAtinXm9td8iAqacyHbn0It+r4iReA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WBrNvdlSvI0RZYhXvNe737obQUaTAslGfSsNrj8jlkkBdnfchImM9Ku3gJmK5/M1/
	 xsLkffTf5rSWFH5DsaBWJh16L+AAjcgqbukl7rWf+cYoLDWW+ongELmSAhCnEa45hJ
	 ZlNaYfc4RmCnrnV0kRMANvaLmv1ka//qxqk6WaJPD8DKRUXUj04BfKvOIruQhyLB7J
	 hJt2nqkTvrypasF41m1EjKiGGFNgE6WOfUSczT7nRvxR67qUifvs34L3C6rauRnPIU
	 aAJu7WS4A/9LokqKh9Lm0jAPvhzAEqGWdf1bVS10cMnj7Gdgokml005NRuEtqgik1b
	 pF+ilz7BINo9w==
Date: Wed, 2 Aug 2023 15:56:04 +0200
From: Simon Horman <horms@kernel.org>
To: Frank Jungclaus <frank.jungclaus@esd.eu>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] can: esd_usb: Add support for esd CAN-USB/3
Message-ID: <ZMpgdM4mindkDys0@kernel.org>
References: <20230728150857.2374886-1-frank.jungclaus@esd.eu>
 <20230728150857.2374886-2-frank.jungclaus@esd.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728150857.2374886-2-frank.jungclaus@esd.eu>

On Fri, Jul 28, 2023 at 05:08:57PM +0200, Frank Jungclaus wrote:
> Add support for esd CAN-USB/3 and CAN FD to esd_usb.c.
> 
> Signed-off-by: Frank Jungclaus <frank.jungclaus@esd.eu>

Reviewed-by: Simon Horman <horms@kernel.org>


