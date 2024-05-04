Return-Path: <netdev+bounces-93442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D478BBC90
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 16:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568D81C20DA2
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 14:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070BD3C097;
	Sat,  4 May 2024 14:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3IUiQLl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AC0381AF;
	Sat,  4 May 2024 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714834773; cv=none; b=Q7nXydWBf2G8lA9J0XFkRbtE6WHRJX/KYT++kEI7wt8Jjply9auctj/+kQImLst++VZ9z636IV1CWco/Ow/V4W1YD28rCSoRKHYjWZLbBPtaetYYxrNLb5OALPAozc/wtZw6burxH1m13ZIgyWUb4ggMO9yZnPF5XULhH+mscmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714834773; c=relaxed/simple;
	bh=2dsLdcGt/zs/RhGCyAQGW6z+7TcIKUtA+vo28uYkge8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L27uDHO/MvPtETGYiTfmGl/Y/P7zN+JOaOZql2H1ztNGYD6O2wcPkjpEZCfSE30jCXCWWlnlEa2t9KumxtJ3C673kLb8oPP6FhkcZirWE1F+86vgLXTXsrEAxhvZzemXqJ+a/Ln1Cm5NAQ2X7Hc7z0jADwdHICDz+zcqoXRsR7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3IUiQLl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB708C072AA;
	Sat,  4 May 2024 14:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714834773;
	bh=2dsLdcGt/zs/RhGCyAQGW6z+7TcIKUtA+vo28uYkge8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R3IUiQLlDCIu6uRA6q2zcDBhthWAWSRQxyOw2yPHkw+UH5XWyYnmux5a/1MEBmguR
	 ZbhzifTNoNWEiWsoUMGzI/l48IL+frmwhDE6I72dm7AMK/aCa6iFE7OFRhzk/ER5Iy
	 ZlxQ53qE+3gtTVnxnBeZ3McFghXdSzARVYce+lTncdhuslcg/ZG46iPYmVUAXVMsSL
	 GY/0eyHa0lDKaOVQwTaYDjFVJthoFnBntOOjt9TN2jkh7b87FFvf4faJPWqDpecCEj
	 STR8YklFfJJFVjbEbgLhCRX0NSRQ1W/Nf4AjYPW/LHSX8KJwGgBxOini3x2Sd3rxWv
	 WNmQZubnGAXYg==
Date: Sat, 4 May 2024 15:59:29 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Manish Chopra <manishc@marvell.com>
Subject: Re: [PATCH net-next 2/3] net: qede: use return from
 qede_flow_spec_validate_unused()
Message-ID: <20240504145929.GE2279@kernel.org>
References: <20240503105505.839342-1-ast@fiberby.net>
 <20240503105505.839342-3-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240503105505.839342-3-ast@fiberby.net>

On Fri, May 03, 2024 at 10:55:02AM +0000, Asbjørn Sloth Tønnesen wrote:
> When calling qede_flow_spec_validate_unused() then
> the return code was only used for a non-zero check,
> and then -EOPNOTSUPP was returned.
> 
> qede_flow_spec_validate_unused() can currently fail with:
> * -EOPNOTSUPP
> 
> This patch changes qede_flow_spec_to_rule() to use the
> actual return code from qede_flow_spec_validate_unused(),
> so it's no longer assumed that all errors are -EOPNOTSUPP.
> 
> Only compile tested.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


