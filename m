Return-Path: <netdev+bounces-28130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B212A77E528
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 17:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E354D1C210B7
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 15:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924D1156EF;
	Wed, 16 Aug 2023 15:31:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645710946
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 15:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7701AC433C7;
	Wed, 16 Aug 2023 15:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692199868;
	bh=xSUdEwDHmtt6X2IeU+QIEDoT7uyMmmI80HF6ze8EQKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZMYCQG+ni+RC1vpjMoMFXh7IUed5fLKVgyDqYiPCQTVV76sKQMmruYx23xlJGkEY6
	 LHJgntXcJJRYk3njWJ1shjlHL448A24d/3fKfAaLGUtTXlbqvH4BXhUCXM/yrWkMG2
	 IjioPxXWb7QRxi5ppr2gkPqmETwYXYucKZP+v1wZ/ualx3EdMjC+Sts1QGpADuR2BH
	 usLtv9alydt4EpLGY93haQYpDBCk/phbdiD6W1jo6gJGDRMY1fPFyRkRyxeLVIHI0c
	 e9XXa0dmw7UZWlFx76aiko38GRMgMZW4U4ptU0c6rRGxsZXsIBJsmeo4qRf6jiYouq
	 tjNA/NkwFYa9A==
Date: Wed, 16 Aug 2023 08:31:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Stanislav Fomichev
 <sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 07/10] tools/net/ynl: Implement nlattr
 array-nest decoding in ynl
Message-ID: <20230816083107.488282c9@kernel.org>
In-Reply-To: <20230815194254.89570-8-donald.hunter@gmail.com>
References: <20230815194254.89570-1-donald.hunter@gmail.com>
	<20230815194254.89570-8-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 20:42:51 +0100 Donald Hunter wrote:
> Add support for the 'array-nest' attribute type that is used by several
> netlink-raw families.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

