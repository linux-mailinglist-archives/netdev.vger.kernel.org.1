Return-Path: <netdev+bounces-40133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E79557C5E42
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 22:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C8A11C20A06
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 20:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EEF3AC0F;
	Wed, 11 Oct 2023 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5NlLEBa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C093A26E
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 20:21:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10F1C433C7;
	Wed, 11 Oct 2023 20:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697055669;
	bh=tWfQJ0f6dNsDx6bn9isxxKkK0Sw7sB4OV2lejro9AD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p5NlLEBa7/8yhP29AN/mu7YpxQQzn03lSlEdIz9q6UT6RF7ZJmd+3EKj7RcnjmB5C
	 X0OD8GwHJm4/Eqq1pylzmJPmtuivXlnVhAyxt+X/pomt2p6D4rakuGcf06bCwERAr4
	 liMgFCg+KeS8EcSpCGu7ms34hHYcy/ayaeK5c5Yh2DIf+CRpmh9zq3PW31Tu1Sy4V2
	 0SG8x/VPEqg+Bgc10/01bY9InAFaiaBt9AO5VTFlstkgKXf7WPaVVNtj8LVsherbaO
	 1WO01Acz+e4SENVcUcxoSr6UoTamBD/GhcVYhz6SOklmxoicrDDbR1HWSZJpgFy5fF
	 vVlYWmCVosXDQ==
Date: Wed, 11 Oct 2023 13:21:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
 johannes@sipsolutions.net, fw@strlen.de, pablo@netfilter.org,
 mkubecek@suse.cz, aleksander.lobakin@intel.com
Subject: Re: [RFC] netlink: add variable-length / auto integers
Message-ID: <20231011132107.7eb89258@kernel.org>
In-Reply-To: <ZSbVASHPVoNfWwce@nanopsycho>
References: <20231011003313.105315-1-kuba@kernel.org>
	<ZSanRz7kV1rduMBE@nanopsycho>
	<20231011091624.4057e456@kernel.org>
	<ZSbVASHPVoNfWwce@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 19:01:53 +0200 Jiri Pirko wrote:
> Wed, Oct 11, 2023 at 06:16:24PM CEST, kuba@kernel.org wrote:
> >No, fixed types are still allowed, just discouraged.  
> 
> Why?

The only legit use case that comes to mind is protocol
fields which have strictly-defined size. People like
to mirror their size into netlink, for better or worse.

> Is there goint to be warn in ynl gen?

Just a comment in the docs:

https://lore.kernel.org/all/20231011090859.3fc30812@kernel.org/


