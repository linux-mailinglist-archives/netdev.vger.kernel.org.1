Return-Path: <netdev+bounces-38284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E047B9F4F
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id CC5BBB209C5
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 14:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5275928E0C;
	Thu,  5 Oct 2023 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hwrl5O7p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B9728DC2
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 14:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F2CC43395;
	Thu,  5 Oct 2023 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696515712;
	bh=4MJvhEH/iNXEJvA2gWT/VXvE+rFZvLlK2LYQST5L0Zo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hwrl5O7p6B/uzpPA5HsmE8mGr+YMhc7x9fL/z/YDwfPGUDZwtNHVBrzZnboWc/nbR
	 JDS1YWvlnEyqx+8Foy6LmqB1kHHG6PrN95w0nYSgX42SSXR4TYdENK+r7DVmVyiEgX
	 /uX2LlccKur5+2FBug+lpB7ZD6OZ45vBRmfSXIFA4zHIJ9Z5eR9dAnArmkMK3mMsAi
	 ENbzzN1jjcJldDsKwHIgrSl8hNa/o0OkGtFwI9EKMSQ9rdP8WlzcOEySg7MDdhDy5R
	 IkEfKEr4isjhnl1/4nBX85XDn1/IsEGvAMVsAdvBn/Br7fDlyjUkJJFoEjQgNzpaUQ
	 SvqHa1zbn1J0g==
Date: Thu, 5 Oct 2023 07:21:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, donald.hunter@gmail.com
Subject: Re: [patch net-next v2 3/3] tools: ynl-gen: raise exception when
 subset attribute contains more than "name" key
Message-ID: <20231005072151.2a71ec59@kernel.org>
In-Reply-To: <ZR5lA7SwQr3ecUp9@nanopsycho>
References: <20230929134742.1292632-1-jiri@resnulli.us>
	<20230929134742.1292632-4-jiri@resnulli.us>
	<20231004171350.1f59cd1d@kernel.org>
	<ZR5lA7SwQr3ecUp9@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Oct 2023 09:25:55 +0200 Jiri Pirko wrote:
> >> The only key used in the elem dictionary is "name" to lookup the real
> >> attribute of a set. Raise exception in case there are other keys
> >> present.  
> >
> >Mm, there are definitely other things that can be set. I'm not fully  
> 
> Which ones? The name is used, the rest is ignored in the existing code.
> I just make this obvious to the user. If future show other keys are
> needed here, the patch adding that would just adjust the exception
> condition. Do you see any problem in that?

Just don't want to give people the impression that this is what's
intended, rather than it was simply not implemented yet.
If you want to keep the exception please update the message
(and the if, no outer brackets necessary in Python ;)).

