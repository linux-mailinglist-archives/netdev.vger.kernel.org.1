Return-Path: <netdev+bounces-38604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DFA7BBA35
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 16:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D53AA2822EE
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 14:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C776266D8;
	Fri,  6 Oct 2023 14:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf0gFn2o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79349250EF;
	Fri,  6 Oct 2023 14:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3C56C433C7;
	Fri,  6 Oct 2023 14:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696602465;
	bh=lPsv0s+7IImsi8Hwkl8O4BUpaBHCF5fezH/OfMPtsag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nf0gFn2olRoJvFSSwnp+Bv0BhFnfzFmQLU6WAU9cddtbmRQzFb0G7nl9EBGZD3ALW
	 JoScSZI9M353+a3KWnG0rC4BMqQYs+RmSbxCHW6NzT7a6ZqGGSxBArqVqJGJ3Oi7Z3
	 O9OnReyHTytvxFMc2chbPXpeyz7vqV/+jg3B/kiJI1KGLzFB/gap8kmGvvQS2G2RG2
	 XW+jP+xIV/ltSxhypYrGt4zid0lJzCGOpsRWvQ7TPuT5ua/yUiNDID3fvzcjJT7M8c
	 ZCokrvWUZq4ThyXRRhXPYJniFkHWq6BkH8YaTziPjC3YgWe63kr631rTxEaukRlxGm
	 eDB6ePFtzOY4w==
Date: Fri, 6 Oct 2023 07:27:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ayush Sawal <ayush.sawal@chelsio.com>
Cc: Kees Cook <keescook@chromium.org>, Raju Rangoju <Raju.Rangoju@amd.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
 sourabh.sagar@chelsio.com, bharat@chelsio.com
Subject: Re: [PATCH 0/5] chelsio: Annotate structs with __counted_by
Message-ID: <20231006072744.66a1b412@kernel.org>
In-Reply-To: <6a750af0-1de2-3bec-3d52-a4007f3afe92@chelsio.com>
References: <20230929181042.work.990-kees@kernel.org>
	<202309291240.BC52203CB@keescook>
	<20231002113148.2d6f578b@kernel.org>
	<6a750af0-1de2-3bec-3d52-a4007f3afe92@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Oct 2023 01:58:54 +0530 Ayush Sawal wrote:
>  =C2=A0The current maintainer for cxgb4 driver is Sourabh Sagar=20
> <sourabh.sagar@chelsio.com>, I have added him in the CC.
>  =C2=A0He will update the MAINTAINERS file for cxgb4 driver.

Thanks & looking forward to the update!

