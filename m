Return-Path: <netdev+bounces-224927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 399A7B8BA4C
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 01:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EDA43ACA26
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 23:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918042D540B;
	Fri, 19 Sep 2025 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbwqs7Be"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9C12D3ED1
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758325809; cv=none; b=o7PfKpnCjx11GryadyuiuTrJ+S/F9Pp1FSzbH3wKf9ZgIOsVoag/dRQVGgNDZcGlbKlnR38PY4yiWYaMnvtlFaNj1ZorEfsMpshvTOJaZU6Lk8j8ZczP0ZM20lCI2+G/BzwFPR5Zt7O9SOF2ZRM8lWtXiRHI691snoldYK+qi+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758325809; c=relaxed/simple;
	bh=I83TfBf/tW4mCHvDXGsKp2aciMMKl7qZ2dgeSmZkp3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d0cuE2PjouAwFNkI+RzmuD/nBM/aITO/s/yQGeScvTplsEZg8hick+1GQ5JzPVKzTy63gM8UfQPjE6/Ftvbqy1aKNEODIgDiMoord4YQaQdid6XIX3Kiz0e+qjhahb8bcAW6m+AyAfZb9XgYVpL90mS+5ezcuTTNp4utJ6BTHN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbwqs7Be; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB951C4CEF5;
	Fri, 19 Sep 2025 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758325809;
	bh=I83TfBf/tW4mCHvDXGsKp2aciMMKl7qZ2dgeSmZkp3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mbwqs7BesJsC7igYkY882RlXmmK7AnAApI3D9Vii771nNe1RKheHtr1YYIJKl8Ash
	 T0Vr6ecEk299zHol/wRNgCknYAqEZCBweCPuKLimna0Q1ok0SYagF5OMA3Q7FZC6zi
	 2bnOqm4QfqcHMscdTCEkHxKj89lWhUonQYyVA9V4djJQaxypnUFxU2JzJf12gdVI6U
	 rJSFrQ61pPvZCpQ2Hlr76t1Ig9AbtN88JIeAec9pcuQZvcXX1DEy44kjB/0YcddZmf
	 ZGjULw7taKik+bFebnxKnN2ktQ3/WsfQfLMZ7yqhx2vgaay3i5UF3V20Ez7e3Bbs0Y
	 2PplEHRFSMKvA==
Date: Fri, 19 Sep 2025 16:50:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, Hauke
 Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 0/2] lantiq_gswip fixes
Message-ID: <20250919165008.247549ab@kernel.org>
In-Reply-To: <20250918072142.894692-1-vladimir.oltean@nxp.com>
References: <20250918072142.894692-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 10:21:40 +0300 Vladimir Oltean wrote:
> This is a small set of fixes which I believe should be backported for
> the lantiq_gswip driver. Daniel Golle asked me to submit them here:
> https://lore.kernel.org/netdev/aLiDfrXUbw1O5Vdi@pidgin.makrotopia.org/
> 
> As mentioned there, a merge conflict with net-next is expected, due to
> the movement of the driver to the 'drivers/net/dsa/lantiq' folder there.
> Good luck :-/
> 
> Patch 2/2 fixes an old regression and is the minimal fix for that, as
> discussed here:
> https://lore.kernel.org/netdev/aJfNMLNoi1VOsPrN@pidgin.makrotopia.org/
> 
> Patch 1/2 was identified by me through static analysis, and I consider
> it to be a serious deficiency. It needs a test tag.

Daniel, can we count on your for that?

