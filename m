Return-Path: <netdev+bounces-79693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C4587A967
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 15:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C341C20B25
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 14:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE4644369;
	Wed, 13 Mar 2024 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1P986zY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097D935894
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710339971; cv=none; b=jCYXwSg1BDyLY1QB8IguPvKJRT5j0B63bXS4ygXfTHYLuq3zBMWpqe7IoaSpQ+w2O0CkK4+HT+uC2W7EAGRlWyi6vul3RW5raK4J8qBImS12V6Chp7/JU5u/rcQTB3A5T971WQChSkdfwNOeMVD+nUIlhzHel9S93wElCHhPHbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710339971; c=relaxed/simple;
	bh=gXxkvmi4YHpbKVknq6Jqb+OVcO3QQCyk8qnXk4mMWcY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hx/EPVoOr96+no3LWaFHe80ozjIokuS0GHtgXF/h/IzsDGXt+xiPSIW7iR3ohc4nPyMcD8BzDsifrTJSAeNc6s+FlTrLJcwMvG/dJcvg0cgY+nxdPKA91tFY7v5BKT+yzJCUuOAi13D8jNhf/4RdfDKGHNoxSBL6rw5UcckGAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1P986zY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36241C433F1;
	Wed, 13 Mar 2024 14:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710339970;
	bh=gXxkvmi4YHpbKVknq6Jqb+OVcO3QQCyk8qnXk4mMWcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l1P986zY8tWjLxbmJTxLcAjHRsgPztskKRnk8HvYZCoPDvuZuakztzu3fi+fpoFDI
	 lc4OlEmwNQj8IthNKK/jv7RYQrD6X9vrJCQFl9LY6Wun6Ru4zl2LoH59Gncb+2LXNb
	 ybFner/w92LYbYgI4q4/Zgf2yeQSZE6xiBPT8NDgwbALFvCMK6h5VP5HbS0sv+djJ3
	 BPVPYoSQdSSzaLbIvnf3226Neq7zwkzdcwSlS22Yt83pebf/gatkgL/64pd7i4sKDQ
	 ogLPx38o2l7AzpRG9AD22fVn+IVVevvpoF3zoviB5mcsbPxLKDTW/aFOLVpYEcnorj
	 DAV7fY46IBH+w==
Date: Wed, 13 Mar 2024 07:26:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, arkadiusz.kubalewski@intel.com,
 vadim.fedorenko@linux.dev
Subject: Re: [patch net-next] dpll: spec: use proper enum for pin
 capabilities attribute
Message-ID: <20240313072608.1dc45382@kernel.org>
In-Reply-To: <20240306073419.4557bd37@kernel.org>
References: <20240306120739.1447621-1-jiri@resnulli.us>
	<ZeiK7gDRUZYA8378@nanopsycho>
	<20240306073419.4557bd37@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 07:34:19 -0800 Jakub Kicinski wrote:
> > Note that netdev/cc_maintainers fails as I didn't cc michal.michalik@intel.com
> > on purpose, as the address bounces.
> > 
> > Btw, do we have a way to ignore such ccs? .get_maintainer.ignore looks
> > like a good candidate, but is it okay to put closed emails there?  
> 
> Oh, great, I wasn't aware of this.
> 
> I think I have his private email, let me follow up off list and either
> put his @intel.com address in the mailmap or the ignore list.

Hi Jiri! Do you still want to add him to the ignore list?

