Return-Path: <netdev+bounces-133100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A73E4994A36
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CE0A1F221AC
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991DD1DDA36;
	Tue,  8 Oct 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VH/9Cne5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAA41B81CC;
	Tue,  8 Oct 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390629; cv=none; b=JloORmRr3RtXY1uhe8PTQfCHDxXo1DjMhq1ueQHPzw8FDQc1dXRsS3lIXGbAVCZYIMh0rguKlUnluh6Mj4jbodICBA2IewKfc4mIM4cze0a/FoJonE7mZv7lWW32gToDAH8GR4jvE2v5ue1/uQxZHXc3VcGa62XAoziIa/Z2P7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390629; c=relaxed/simple;
	bh=UBn42Kzmqtwl/Zw+7YmF058K/118U9jbdKDtGk8qNk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgX9Sy4r7w5yV78rdrAN4tgL7D8v5sJWFe2PiDbtc3O0Lutbbun8jaYuvQ8781TnJ0KCteh+dW9L7vTBisvY7w49pVkKttqdp3vPINCnS3xNLm+v7TUZ99qkQse0ZBL4zYAjqe1PLt3Y9wtwrPvk9zPrH8wV/tkzv2VJkrbdmks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH/9Cne5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961B4C4CEC7;
	Tue,  8 Oct 2024 12:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728390629;
	bh=UBn42Kzmqtwl/Zw+7YmF058K/118U9jbdKDtGk8qNk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VH/9Cne5w9ggAdLciDnXCEHB5k6ekrEsyUY9o9pbJ8w1JFgbLF7TD7FkPhvXwR/Xw
	 +Qywf3VJRsX/n1guHLQN4sL88MRG2PZSKHSMDS6afC+d31CO+GqqmZMFcuqpX+MclB
	 fo98CMBmi37ADza2syoaR8vVeaWxF6YmhGUkW0XS54pDlUpFjiCwEt02UoOdhYnKWp
	 SyZky7z4j3Ghvj2E4ms22l2sffb32oJGWn26D6oEATwfY7KHwkobaGAqXpsw762zTf
	 W7HLNCPfYhjqS5p8hXfsLXCMIkOWAiAFaUQbL87mZI+lCwLa9/Qu3IELFj/MDDDAUu
	 cz5fhdRHpZd7A==
Date: Tue, 8 Oct 2024 13:30:25 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC net] docs: netdev: document guidance on cleanup
 patches
Message-ID: <20241008123025.GL32733@kernel.org>
References: <20241004-doc-mc-clean-v1-1-20c28dcb0d52@kernel.org>
 <20241007082430.21de3848@kernel.org>
 <20241007155521.GI32733@kernel.org>
 <20241007090828.05c3f0da@kernel.org>
 <20241007161501.GJ32733@kernel.org>
 <20241007095412.5a2a6e2c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007095412.5a2a6e2c@kernel.org>

On Mon, Oct 07, 2024 at 09:54:12AM -0700, Jakub Kicinski wrote:
> On Mon, 7 Oct 2024 17:15:01 +0100 Simon Horman wrote:
> > > > We could merge or otherwise rearrange that section with the one proposed by
> > > > this patch. But I didn't feel it was necessary last week.  
> > > 
> > > Somewhat, we don't push back on correct use of device-managed APIs.
> > > But converting ancient drivers to be device-managed just to save 
> > > 2 or 3 LoC is pointless churn. Which in my mind falls squarely
> > > under the new section, the new section is intended for people sending
> > > trivial patches.  
> > 
> > Thanks, I can try and work with that. Do you want to call out older drivers
> > too? I was intentionally skipping that for now. But I do agree it should
> > be mentioned at some point.
> 
> What is and isn't considered old may be hard to determine. I hope that
> your existing "not part of other work" phrasing will give us the same
> effect, as there's usually no other work for old drivers.

I agree that would be very subjective. And your point about
the presence of other work is well made.

I'll work on v2 based on this short discussion.

Thanks.

