Return-Path: <netdev+bounces-12827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FA77390A4
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 22:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D841D1C20F8B
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 20:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAF71C758;
	Wed, 21 Jun 2023 20:18:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8B317724
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 20:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A538AC433C8;
	Wed, 21 Jun 2023 20:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687378715;
	bh=nDCuc1Tzhj989VtfEcRlK59hU83nRPYqZYuVIQidi88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P7g1VRHTSqHtfap83WSvbzHEd3c3pdt8/9RjqN2WnYVKpqatDpo/05hTEFeZAluAK
	 xXlcoPMoA9fag+CYH3bXNRDoH1kDplFjGr+j9BAYKKZbBR4Luw1W07rWvT7P6nwRUi
	 7dWsES4DU966cIrKenDElY08vAYJK9oygIuutFGO/zPOvi3UYGwpW6JOdJE4d/EIsY
	 lzczF7jQNpCshp2J4+sK9vPMnBHeVUz58KoXe/nIWBgTKc2bhqe3VFpeg8/1gpo1rT
	 rvSWx1JuPtSroJaDqnEtNx5bAHbGBNmmD1F+o/PjaB6CqbhuL7F6roBGdaBOgQ5Fr8
	 EHbnyFnj6KgGg==
Date: Wed, 21 Jun 2023 13:18:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, simon.horman@corigine.com
Subject: Re: [PATCH net-next v2] netdevsim: add dummy macsec offload
Message-ID: <20230621131834.345f4f60@kernel.org>
In-Reply-To: <d6841a34b9d69af9ad5a652d5cabe3927868d3c6.1686920069.git.sd@queasysnail.net>
References: <d6841a34b9d69af9ad5a652d5cabe3927868d3c6.1686920069.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 15:14:46 +0200 Sabrina Dubroca wrote:
> When the kernel is compiled with MACsec support, add the
> NETIF_F_HW_MACSEC feature to netdevsim devices and implement
> macsec_ops.
> 
> To allow easy testing of failure from the device, support is limited
> to 3 SecY's per netdevsim device, and 1 RXSC per SecY.

Quoting documentation:

  netdevsim
  ~~~~~~~~~
  
  [...]
  
  ``netdevsim`` is reserved for use by upstream tests only, so any
  new ``netdevsim`` features must be accompanied by selftests under
  ``tools/testing/selftests/``.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#netdevsim
-- 
pw-bot: cr

