Return-Path: <netdev+bounces-107383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BADD791ABD3
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 17:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A7E0B2096E
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48E91991AD;
	Thu, 27 Jun 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKE8XTSy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D7814EC40;
	Thu, 27 Jun 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719503061; cv=none; b=rPnL+VxS/CPQdVIwpXl+fu0Ih5+sLk9TSYOMG4O6CNYhKVwxtGYc4lpyn+oOocjJDaVWz7vdypf6n+ap5arbT0xMTkocvz8t0jlNsAPlcLgr3TF96PQudjwR3T4ZfRqpNNFGfR9TBlkr8KcQZdNbw1SCH2BTxaLQpJxF+nH1xJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719503061; c=relaxed/simple;
	bh=44QTkuqqMo5CcFcIhnkykddrBuRQgTixooInaW7qoQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exd7c9A/2n9l6T/RI1Iln5joGvuP6makyNjGGspNHwKXvJZDTYMPQWk6weH4r2FU1Gz3Bef3psMZK78EJiMtycp9/uqGBiQ86tS3ai3sxFUHKE38Z9OlKg+qi1O+0yzGMtSPmnlc9sbakn2Nc1OCFgadT+MUfrasUjVqXqYi2Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKE8XTSy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6350C2BBFC;
	Thu, 27 Jun 2024 15:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719503061;
	bh=44QTkuqqMo5CcFcIhnkykddrBuRQgTixooInaW7qoQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKE8XTSyxXYbryGI2PlrC2M295lHjhQWiG/C3Ru5X7eFkCqLXd4y2+V+XLRAelouB
	 i6NaHrWkocinSgx9xBHx/LudO410JqMVuKnpv1cyP1z6pThTsAkW1QkG8WNujH5QCX
	 xgwKbCfMmRVOO7MA6JUjLPY6iEjhVI+7cgMZ1H9VDyrG+su+lBviXDuLpngZGGvr9o
	 jLV35SmKP+gyh4TqrjYOueyyH8P/b4gVKKvqjpCo55tJFNI/ZssQ4+N3MPj32GwU37
	 KmACyd2Q6JvoYwCsHWqsZ0BTVabG6Zi2QGQmR6e5bnu37LaDFDDsHRKILDQ+biHLCp
	 CGa5HTW6gvLYw==
Date: Thu, 27 Jun 2024 09:44:19 -0600
From: Rob Herring <robh@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, krzk@kernel.org, conor+dt@kernel.org,
	davem@davemloft.net, devicetree@vger.kernel.org,
	edumazet@google.com, imx@lists.linux.dev, krzk+dt@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH v2 1/1] dt-bindings: net: convert enetc to yaml
Message-ID: <20240627154419.GA3480309-robh@kernel.org>
References: <20240626162307.1748759-1-Frank.Li@nxp.com>
 <CAOMZO5CQHMzhvP9KqPahWdeVjBvqk758uY6wMzVO4oPrt=pECQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5CQHMzhvP9KqPahWdeVjBvqk758uY6wMzVO4oPrt=pECQ@mail.gmail.com>

On Wed, Jun 26, 2024 at 03:38:48PM -0300, Fabio Estevam wrote:
> On Wed, Jun 26, 2024 at 1:25 PM Frank Li <Frank.Li@nxp.com> wrote:
> 
> > +examples:
> > +  - |
> > +    ierb@1f0800000 {
> 
> Node names should be generic.

Yes, but what would that be for this block? Unless we have (or add) a 
documented name, then it doesn't matter too much.

Rob

