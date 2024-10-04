Return-Path: <netdev+bounces-132034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 358419902E6
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 14:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBB51C213D4
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 12:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299081586F2;
	Fri,  4 Oct 2024 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKjoWHbs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED325156872;
	Fri,  4 Oct 2024 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728044967; cv=none; b=C3im0s7N7mhfMfdWDv4owPlLGdkjyRQUISt9MoDPLTO6XnLihbBiiyCQucmOT+BuatrSBfGYYIJ8wHlc+FXsSlMnFPOMsVFUvh/kZLrQhfW0qQLSvmM9KiEBxma8wO3ijEc6LXcWtKPc8fa/j4dWOmH/MeSxq5nbQFDrueGqOVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728044967; c=relaxed/simple;
	bh=Khyuh+Z6dyHCTy5zlITc/pY4AR8Xgi1Ht+khCh4+P/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXnyZOtGh4P7IlP4m3ae2iDyMtrXy9IMDAWHgJCkdZhcwMjYRDChvyE5U4FPs6qCeaNbv9HHPk0YmBmb0tdCcy/+37/ceMIhYc+t9bU0bVcQQllRB1Njfn63MBlH05VTUuxvyGs2RjPeVZOMiaARbzVLeSiBk5NqMtFaSvty+/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKjoWHbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8167BC4CEC6;
	Fri,  4 Oct 2024 12:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728044966;
	bh=Khyuh+Z6dyHCTy5zlITc/pY4AR8Xgi1Ht+khCh4+P/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iKjoWHbsHb1Zg51w3REmGFwS6o+q5WOoK7viRny7hbODf6TFOtO+Pw3bmWUyQc3PY
	 vYMjLuNW4DyOwp+xI7MrlGM5FvMXu0H6HZ+qOjaX71swNsTQ8lGrBR5nJp1jP+VJ5r
	 c+3q+/JPhL1MLq7yEe80ORPO3pYIGmd0QTM7GM9wLUDvglEKEfekdiciUjxsPpmvmY
	 JWHzJ/04aqHNBQaG5E/x2BrnOEJgkNAbKH2ymNTACQR+2HsYAf1Mo0MAzIA5b5thN9
	 bnl/NtiMOBDiFI+9JY4Y2x009PkpI47hYQb86jlJOCJGRh8yE66NWZJzoHIbHjUP6r
	 G7U0K90V0jI+w==
Date: Fri, 4 Oct 2024 13:29:22 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] mlxsw: spectrum_acl_flex_keys: Constify struct
 mlxsw_afk_element_inst
Message-ID: <20241004122922.GG1310185@kernel.org>
References: <8ccfc7bfb2365dcee5b03c81ebe061a927d6da2e.1727541677.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ccfc7bfb2365dcee5b03c81ebe061a927d6da2e.1727541677.git.christophe.jaillet@wanadoo.fr>

On Fri, Oct 04, 2024 at 07:26:05AM +0200, Christophe JAILLET wrote:
> 'struct mlxsw_afk_element_inst' are not modified in these drivers.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security.
> 
> Update a few functions and struct mlxsw_afk_block accordingly.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>    4278	   4032	      0	   8310	   2076	drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>    7934	    352	      0	   8286	   205e	drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_flex_keys.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only

Reviewed-by: Simon Horman <horms@kernel.org>


