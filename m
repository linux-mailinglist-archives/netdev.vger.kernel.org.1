Return-Path: <netdev+bounces-26444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4182F777C98
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFA75282226
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C96020CA6;
	Thu, 10 Aug 2023 15:48:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B22E20C94
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5220BC433C7;
	Thu, 10 Aug 2023 15:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691682495;
	bh=JWz1DomHoZKbZEibsziLlWqGUZWofNJixTXuEz29wQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ueBGHMco+f133FQT/k7O391CkwQe4jmbdYJE3f89Vjgfi4AfWXcI7YBRdNB18ymZ2
	 Vu+32x4fQAtI4SRF5YfzaI117mm1EvTMU+AN/ZHpk1z3EPCvBuPmX5PyUhmNDRBTGd
	 SfKU4B48u9JoYErxp04DUKwt8u5WCnH0m2VYfzKA0NQ4SRwYxUdcqAlv2rjF7sc9SJ
	 ZadfeacDjRYwfwqKugpC9xVnlfm2lHfsk1QXnpoQWeXah9Lj5D8mXv7FB/mVoEHK8w
	 /GyBUH+PeexVzeb1DeG2EPyHkuVfKSpPvedTycLj+8Rd0IWQs6T9DtHYNwhEp7JJut
	 Ujx0CLdzH2FVg==
Date: Thu, 10 Aug 2023 17:48:11 +0200
From: Simon Horman <horms@kernel.org>
To: Michal Schmidt <mschmidt@redhat.com>
Cc: netdev@vger.kernel.org, Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Abhijit Ayarekar <aayarekar@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Vimlesh Kumar <vimleshk@marvell.com>
Subject: Re: [PATCH net 2/4] octeon_ep: cancel tx_timeout_task later in
 remove sequence
Message-ID: <ZNUGu74owyfsAbEW@vergenet.net>
References: <20230810150114.107765-1-mschmidt@redhat.com>
 <20230810150114.107765-3-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810150114.107765-3-mschmidt@redhat.com>

On Thu, Aug 10, 2023 at 05:01:12PM +0200, Michal Schmidt wrote:
> tx_timeout_task is canceled too early when removing the driver. Nothing

nit: canceled -> cancelled

     also elsewhere in this patchset

     ./checkpatch.pl --codespell is your friend here

...

