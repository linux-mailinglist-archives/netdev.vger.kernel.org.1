Return-Path: <netdev+bounces-78161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F95C87439C
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3201B21949
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9991C69A;
	Wed,  6 Mar 2024 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Urqo3xJH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AAE1C2A1
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766921; cv=none; b=ryNL8oiSJZHkXjr9vYc2bRCccILoJM0EjeI85Kbgr/8WxxdhEyWcXQ7r+V8pZ5Al/qc2Dqnk8AwuaWM9qw7uzNef1jiRq9jrp7Qi/6rIjg12Ea2V8/OzaokcJ0w42veUsFNFG2E5CLFQj/oeRqhQhjjDWmiVvB+0uamJ0K33uCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766921; c=relaxed/simple;
	bh=6XH6cYTm8FuFdceO5emvTfn73LPBy8xch0Zz/xWXHCA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LczdJByUToP0ZxjsThRbXg54PHLaHOZaZ85s8/tjptDpYAPb2MRwBbTe8vhPJw4i1dnwf9JXPBh2gWdZWSObQlhr/99AjPdvLoHO7JbQV5odDeXj7wWUl5lkXMVS/TbScPVqZNBoHIQQv/4yhFMSKHc/nBOldgHs8mK5wW7ZenA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Urqo3xJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC72C433F1;
	Wed,  6 Mar 2024 23:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709766920;
	bh=6XH6cYTm8FuFdceO5emvTfn73LPBy8xch0Zz/xWXHCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Urqo3xJH7drgVjvd8paUSycjD7iLX+IlzADgOv8vRcCNNEQi5FzlU4RCI/4aZvX15
	 EhvgzggLJlmLYAPlUIRAyBA6B3INfPHth6AszYfZrw2SuUrK4OntCQtZsEczkfJSzv
	 jBMgS34ysXG3n2XVsoGI7y2CZQ8sEkl64tQO2utisasz1TLsMZAarmRxi9vbFOHHGB
	 IGDOD4kTczzF8rEAHWoXxjOXHnri5RB89UC/XA2NaN8Vk4cnSRx3N14T2ownvyol68
	 O+rFaY5/bTsfL0nghkLPYxl8W1ubjH3kosTQ6JHAdDxPOUlXbw7KoN5DsTYfsWRRTK
	 GPobCkWXF4TdQ==
Date: Wed, 6 Mar 2024 17:15:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	horms@kernel.org, pmenzel@molgen.mpg.de,
	Alan Brady <alan.brady@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH iwl-next v2 1/2] igb: simplify pci ops declaration
Message-ID: <20240306231518.GA589712@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306231410.GA589078@bhelgaas>

On Wed, Mar 06, 2024 at 05:14:12PM -0600, Bjorn Helgaas wrote:
> [+cc Paul for __maybe_unused cleanup]
> 
> On Tue, Mar 05, 2024 at 06:50:21PM -0800, Jesse Brandeburg wrote:
> > The igb driver was pre-declaring tons of functions just so that it could
> > have an early declaration of the pci_driver struct.
> > 
> > Delete a bunch of the declarations and move the struct to the bottom of the
> > file, after all the functions are declared.
> 
> Nice fix, that was always annoying.
> 
> Seems like there's an opportunity to drop some of the __maybe_unused
> annotations:
> 
>   static int __maybe_unused igb_suspend(struct device *dev)
> 
> after 1a3c7bb08826 ("PM: core: Add new *_PM_OPS macros, deprecate old ones").
> 
> I don't know if SET_RUNTIME_PM_OPS() makes __maybe_unused unnecessary
> or not.

Sorry, should have read 2/2 first ;)

