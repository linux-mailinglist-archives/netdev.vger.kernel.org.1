Return-Path: <netdev+bounces-101041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAC28FD02E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 15:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7E61F2186E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7D4193062;
	Wed,  5 Jun 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDwLJO7P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431B618C34D;
	Wed,  5 Jun 2024 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717595564; cv=none; b=QOijpdNFr7BsnlHQ0ozX6qCXKHUe5LSq9bt+mXzy5msQWsRYVvUOUN2upstaDm5xYV0Hu7Klwcn0TVBzBNlBfH4Qp0+Pmm2IwHrw4HQpy+fBKJWPzOeXx+TaK51E8P6wXdWDeExM0lzAkkKGmLTUFx4+gciTrWtXazftZWNR1Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717595564; c=relaxed/simple;
	bh=OTskwsaVfSl7c/j/KBPXwnX+xcgS7fLVWMlC9hUJudw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRF18KV0X9y/DAl3Qss5Nq10qjCSsVd+d702TO+rE6d9Iof+qlKrBFIA2ttm5K804s2Tsgh+E/MYNkRuQyf33jboJOhtL2p3HK7ywnIcCeGqabPfPDwVVDTWH5z6MkRzFszq3sZnZtY2xsBf3UNl5rbmNe17CplVqeN7rP/i5tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDwLJO7P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC283C2BD11;
	Wed,  5 Jun 2024 13:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717595563;
	bh=OTskwsaVfSl7c/j/KBPXwnX+xcgS7fLVWMlC9hUJudw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDwLJO7PNkkGw6pbqx+AciVyC9xTN2UcStd+X2QoFG/XrxZehPtwZ77T79uY4ridj
	 6G+os6YVb2Q1M0MYJ/dwuGK8Gu43iNrmsjgHjulDOT5C+JbYt2e06mGM0aNhKQu50U
	 U6CzE2EttK1sd02GJ8oQ8y+sB+F4SwqWuQO9e4lLyS1zkaxVx+3XFqCpotDR5cI/o1
	 G+e6mdlIuzuoD3S/0lCm3LAVeRPmPUQ2QVl+B2NOPAewjkdfj1cLT2Av9mQ+olJ09W
	 IAcwfGRhL15RhriJ6/URS8+IPCpJPVjU9BcSSBAQICdCBn4gXmxzlz8I3wkR6+6lvR
	 XE/9lQSCdjpxg==
Date: Wed, 5 Jun 2024 14:52:39 +0100
From: Simon Horman <horms@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 4/4] vmxnet3: update to version 9
Message-ID: <20240605135239.GO791188@kernel.org>
References: <20240531193050.4132-1-ronak.doshi@broadcom.com>
 <20240531193050.4132-5-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531193050.4132-5-ronak.doshi@broadcom.com>

On Fri, May 31, 2024 at 12:30:49PM -0700, Ronak Doshi wrote:
> With all vmxnet3 version 9 changes incorporated in the vmxnet3 driver,
> the driver can configure emulation to run at vmxnet3 version 9, provided
> the emulation advertises support for version 9.
> 
> Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
> Acked-by: Guolin Yang <guolin.yang@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


