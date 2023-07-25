Return-Path: <netdev+bounces-21002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 172C87621E6
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CE0281955
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA18E263B4;
	Tue, 25 Jul 2023 18:59:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE20C1D2FD
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 18:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F373C433C8;
	Tue, 25 Jul 2023 18:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690311574;
	bh=DNpYQhEvR282yr7e7CV1N5ZNRljAYJBp8d0kr5e4+qg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GsfXAfglz6jaXlqWizeww5rPxcJkcUy09NUSQaORukUd8pxPHOp2T1vpV9F9hIviD
	 FummqGyPfC9Cyt47DU3LRDhVyEhYx0wQHktCMe8/mp2rI5fQMACk9BDbDD5yh7aqm3
	 mScGDNke9hCOT0egYP+JyoWbFI/wxaVTqYbElmOyENLdvHZVnwAv/04vOsb77Qk099
	 4vwU4vYI5SISzE3nbrkmGdWi6V1+Ek8/pOE64oM5q21oKy6h9ouEs6bfkx32TLN7ts
	 A0s5WaCycKTPB3u8T3kQMW2FL3zCe5DtCol+tAcmnGjOVDgaUHhL/yJxdKp/hRkGBw
	 FqWmPcHo3lGHQ==
Date: Tue, 25 Jul 2023 11:59:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yinjun Zhang <yinjun.zhang@corigine.com>
Cc: Louis Peens <louis.peens@corigine.com>, David Miller
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <simon.horman@corigine.com>, Tianyu Yuan <tianyu.yuan@nephogine.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, oss-drivers
 <oss-drivers@corigine.com>
Subject: Re: [PATCH net-next 00/12] nfp: add support for multi-pf
 configuration
Message-ID: <20230725115933.29171e72@kernel.org>
In-Reply-To: <DM6PR13MB3705B9BEEEE2FF99A57F8559FC03A@DM6PR13MB3705.namprd13.prod.outlook.com>
References: <20230724094821.14295-1-louis.peens@corigine.com>
	<20230724170100.14c6493a@kernel.org>
	<DM6PR13MB3705B9BEEEE2FF99A57F8559FC03A@DM6PR13MB3705.namprd13.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 01:28:34 +0000 Yinjun Zhang wrote:
> On Tuesday, July 25, 2023 8:01 AM, Jakub Kicinski wrote:
> > On Mon, 24 Jul 2023 11:48:09 +0200 Louis Peens wrote:  
> > > This patch series is introducing multiple PFs for multiple ports NIC
> > > assembled with NFP3800 chip. This is done since the NFP3800 can
> > > support up to 4 PFs, and is more in-line with the modern expectation
> > > that each port/netdev is associated with a unique PF.
> > >
> > > For compatibility concern with NFP4000/6000 cards, and older management
> > > firmware on NFP3800, multiple ports sharing single PF is still supported
> > > with this change. Whether it's multi-PF setup or single-PF setup is
> > > determined by management firmware, and driver will notify the
> > > application firmware of the setup so that both are well handled.  
> > 
> > So every PF will have its own devlink instance?
> > Can you show devlink dev info output?  
> 
> Yes, here it is:

>   serial_number UKAAMDA2000-100122190023

>   serial_number UKAAMDA2000-100122190023

Since it's clearly a single ASIC shouldn't it have a single devlink
instance?

