Return-Path: <netdev+bounces-104894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D2890F061
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9C83B22292
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359EF18029;
	Wed, 19 Jun 2024 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DMiDZzF/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24A014A82;
	Wed, 19 Jun 2024 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807101; cv=none; b=DaUHUP/qTygKfJbWbP0rs43/d4OS2AUCpsafvSgtJCFu7XNXIyCs9vrOUIuuELluT2sV6LndMwKuq87nlIpOVUX11tWOWUhIM8If4yey0J29ck9pPCVaz+QoPLjvnzJw492k4i1VNWntI7R7KFuV+F1k5M3H26ngBnG0vFuFWZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807101; c=relaxed/simple;
	bh=WvkEG/uPe0jWysivwqJcl5qLrdxOusJbcy3THLjtZ8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSyGBKZv4OlXX+UwPtwrPH1miDSoq49MWrqGngsasGkESAjhk2B1vDfYAyNi4kKuuTKYGyDoIvinCtJo34GC/40c+8SLTMEVjuQ5R/M/npUWvfZu+pv800X3GVcYGs24TP4nvzi6hARi3bQaAVzirckRb/M7puRrqHFR7UMtdHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DMiDZzF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C69C2BBFC;
	Wed, 19 Jun 2024 14:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718807100;
	bh=WvkEG/uPe0jWysivwqJcl5qLrdxOusJbcy3THLjtZ8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DMiDZzF/cHbKXI3Ymep+KbekpwAYyrbTph4jFMxkDcz8D47mNcQyPxQY9WCL7+Fst
	 NaldX5rc2LaS3u4oHx0L6FDIeJ9/2MALougQTCrHXP3fERP08BVmK4n3I1AjN/uTDT
	 Ltw6HtsUTCGJ5RnfNLpRz3fgqBSzj33rLaSpTBhs=
Date: Wed, 19 Jun 2024 10:24:59 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: [PATCH 2/2] Documentation: best practices for using Link trailers
Message-ID: <20240619-nostalgic-collie-of-glory-d7eb6e@lemur>
References: <20240618-docs-patch-msgid-link-v1-0-30555f3f5ad4@linuxfoundation.org>
 <20240618-docs-patch-msgid-link-v1-2-30555f3f5ad4@linuxfoundation.org>
 <20240619071251.GI4025@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240619071251.GI4025@unreal>

On Wed, Jun 19, 2024 at 10:12:51AM GMT, Leon Romanovsky wrote:
> Default b4.linkmask points to https://msgid.link/ and not to https://patch.msgid.link/

That's the default for the b4 project itself, though, not the global default.

> https://git.kernel.org/pub/scm/utils/b4/b4.git/tree/.b4-config#n3
> https://git.kernel.org/pub/scm/utils/b4/b4.git/tree/docs/config.rst#n46
> 
> It will be good to update the default value in b4 to point to the correct domain.

Once the series is accepted and becomes the official documentation, I will be
happy to change the global default.

-K

