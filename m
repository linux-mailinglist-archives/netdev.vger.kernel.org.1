Return-Path: <netdev+bounces-17034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832C874FDD8
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 05:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3BB1C20EC4
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 03:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199C810E8;
	Wed, 12 Jul 2023 03:34:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE05639
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 03:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562A3C433C7;
	Wed, 12 Jul 2023 03:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689132871;
	bh=Bfdpy0REyIMivQ3MTx5pFL7twh+rSmHjMWaiG3EiDck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JY5zYbY6J/cBUFCX+XH84xowjs+97tPdzJCHDTB/gQuBaiBYj/GWgvv3A2LDvdigJ
	 RHazPnBGBXuFbJQQv/47+Vfdts8rSL4L9PbMcfRAKMBFPRujzWuP9/u/EseZKNa8E4
	 1YdNFsQ6qVIrwwj9qSEDy36xRqTmgqo2sdq0EoUkFbPTPc5UrSmtLwL4EmacBKRSlG
	 0MX09OUoVeYrcGmf1PcPS6pzoE80P5VHP+pzKG501N43kA+K/+z1uR4GXO4M3wvKr3
	 d4wkWOWIqQSv4WPoILErfDqTC9PqMZVLrrWWa7jsK0TBmEf2Uwu4u8Bb+utOpiJAnW
	 +unZmKr1UcmBw==
Date: Tue, 11 Jul 2023 20:34:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nikolay
 Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH net 07/12] inet: frags: remove kernel-doc comment marker
Message-ID: <20230711203430.3c9e9ad2@kernel.org>
In-Reply-To: <20230710230312.31197-8-rdunlap@infradead.org>
References: <20230710230312.31197-1-rdunlap@infradead.org>
	<20230710230312.31197-8-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jul 2023 16:03:07 -0700 Randy Dunlap wrote:
> -/**
> +/*
>   * fragment queue flags

Can we do:

	enum: fragment queue flags

instead? This seems to get accepted by ./scripts/kernel-doc and it's
nice to keep the "syntax" highlight of the comment, IMHO.

