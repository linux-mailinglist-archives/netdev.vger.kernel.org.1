Return-Path: <netdev+bounces-68751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CBA847E55
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02081F267C8
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 02:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15E5522C;
	Sat,  3 Feb 2024 02:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdmQg5uY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38E75C9A
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 02:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706926678; cv=none; b=QM0FJfNwhBio/1Dt4AuU25Mk/M4/KBpjPf1pyBb7XDnWI1gFo+ICho2DV3Z4SVHCFsuNhnOPUtyOgHLiQ8dKrWI+qrSY4KjaeaAETCfT+5mPqfTDp/XhOJgrPQdxgW1yg2bzCSJiFzpSBALg4SYE7x2r5apWpRiE+lCbZNzX22g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706926678; c=relaxed/simple;
	bh=R2jr22DM0dtoXPq7bzzkVVkCUdrAXD9fogEq886Tu9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVb/0P8v+I07/vGOxCYtxzyqNYa1YC5sC1uCNgRDf3A/cwEKs+pD4eOdYKOKaN0yzqPDceEH7HPDNJEVbH80ZYKV9GdbXtNnUoNEuC/Xjb+2ZvC6hKG11QVG9m24fdEChtheRIA1yVJVbK3MAPCR8C/QpbF2gSSJ7z7EjvVfYSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdmQg5uY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90FEC433F1;
	Sat,  3 Feb 2024 02:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706926677;
	bh=R2jr22DM0dtoXPq7bzzkVVkCUdrAXD9fogEq886Tu9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VdmQg5uYDoiMCAxzN+yaqmW4Ey9sy0R+3ZmbkvR17DGlD6H9Oi/FSVqHsmsI5xdJ1
	 eu3SKt77XznGXESPs1h+gMrI23uy2sne+Bm5ZB1IrgSHZIxxPnaWNA9z+9Fh59hDts
	 7uMrHKej/xWh0P2ycVC7ktadvLzgHnZkUuVK4a7dgYEPBSN6DPFJ6Xas0ZRl8on8nV
	 DNoOf4hojSsIGgBPi903giBAEczbN2+lofMvHrizbO8RiksQfyTy0LJV4XwotwXmXy
	 Jbu8eXMTIVUrGlpWvxVNFVj2QMDke2QQBIyDngPc2rP+if+yj0Dyvor+D8mDLNvaqN
	 Pum1BkGZE6eRQ==
Date: Fri, 2 Feb 2024 18:17:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 donald.hunter@gmail.com, sdf@google.com, chuck.lever@oracle.com,
 lorenzo@kernel.org, jacob.e.keller@intel.com, jiri@resnulli.us,
 netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 3/3] tools: ynl: add support for encoding
 multi-attr
Message-ID: <20240202181755.292c165c@kernel.org>
In-Reply-To: <9399f6f7bda6c845194419952dfbcf0d42142652.1706882196.git.alessandromarcolini99@gmail.com>
References: <cover.1706882196.git.alessandromarcolini99@gmail.com>
	<9399f6f7bda6c845194419952dfbcf0d42142652.1706882196.git.alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Feb 2024 15:00:05 +0100 Alessandro Marcolini wrote:
>          nl_type = attr.value
> +        if attr.is_multi and isinstance(value, list):
> +            attr_payload = b''
> +            for subvalue in value:
> +                attr_payload += self._add_attr(space, name, subvalue, search_attrs)
> +            return attr_payload
>          if attr["type"] == 'nest':

nit: would you mind adding an empty line before and after the new
block? It's logically separate from the other code, sort of an
alternative to the "actual" handling, as well as finding the attr set.

Also agreed on adding an example to the cover letter (either one or
both).

With that feel free to add:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

on all 3 patches in v4.

