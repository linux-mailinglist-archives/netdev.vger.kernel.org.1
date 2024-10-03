Return-Path: <netdev+bounces-131803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56D898F9C2
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D9EB2176C
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 22:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6840C1C7B6C;
	Thu,  3 Oct 2024 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEBnNL+l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B2824BD;
	Thu,  3 Oct 2024 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993932; cv=none; b=IqaT3JfQOBUG8ZJFp30TuhYPjjklzkaUO5JYCpbNma31bzQL3MtCi4/OgYNcmGEzkM/8h0JQ2UmN+tUjcBMA2nTS6Gpa046H4furd/cDKZlU9od2mCVJve7/K4laEgkd+751FXOcCd8KkDkyxW0zkjZS6+irTznSHwyqSXEhRjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993932; c=relaxed/simple;
	bh=X6bRa4YftH+pNr8zwab+8NBtUgS3nTFmWQ1Bw4aZmYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zc67BqNOijwqbumbJq2UxoBgQlrw7xGuO672ycCRaarb9WWAqnppzMkR6suV7W48F3nqLbB7tEm/L3Z7fIbRPFeWVlRn3XMoQcWFWqMsSaeHYEIfvuM7e+kKVkMz7Z5im/wwW6nIixJLy2sSaBkMvOJBDD3Qpngwfq9c96OcGr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEBnNL+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E47EC4CEC5;
	Thu,  3 Oct 2024 22:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727993931;
	bh=X6bRa4YftH+pNr8zwab+8NBtUgS3nTFmWQ1Bw4aZmYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fEBnNL+lRmlhyNL7Mlov+tUbxMc5orhx370DWTHC07dSJ8NNxRXaIJs39R5LZSdk3
	 uSzCGHVX9qPNDf0Wz59mAr0KLQBR/YSWTNqHcluYgeYy6Qq1Yif8Rm3K3RzpQuIYoL
	 PpKWJp7EBlSuyvfooDe/K8gcxtP1DBvv4DRMqshmZmbZWtAHuwSWIqRglQXFFizFsQ
	 5fMqEurB/kxfOpZjhCjgXuZcafDWulEn6Z6yyilIhSiJ2v+5v2sgrTAAFxSpZoWTfa
	 ZLh62qG1+csGlmeL9uhQDbgOrq0/OmP2hhWDfD4xHrK1zayiYc3rPzcBA+iN5+mwkT
	 xEQ3HoON1HR/w==
Date: Thu, 3 Oct 2024 15:18:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: martin.lau@linux.dev, razor@blackwall.org, jrife@google.com,
 tangchen.1@bytedance.com, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/4] netkit: Add add netkit scrub support to
 rt_link.yaml
Message-ID: <20241003151850.11e04ba3@kernel.org>
In-Reply-To: <20241003180320.113002-2-daniel@iogearbox.net>
References: <20241003180320.113002-1-daniel@iogearbox.net>
	<20241003180320.113002-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Oct 2024 20:03:18 +0200 Daniel Borkmann wrote:
> +  -
> +    name: netkit-scrub
> +    type: enum
> +    entries:
> +      - name: none
> +      - name: default

The behavior of the scrub should probably be documented somewhere
(either here or in the if_link.h header?)
What the "default" is may not be obvious to a newcomer?
Perhaps you plan to document it in the man page, but dunno if
programmers using netlink directly will check there.

