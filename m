Return-Path: <netdev+bounces-18821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31230758BF6
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 05:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFD92817F6
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 03:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D224187F;
	Wed, 19 Jul 2023 03:19:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A61617D5
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 03:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9407CC433C8;
	Wed, 19 Jul 2023 03:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689736754;
	bh=GnR07wMqsrVaA89GG4qIhsc+HR+D0gk1Mbi/tqe3bjU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o9y4vXhc1UTU+hHFxOKLE8EWBnUHKnF4Xzyl3vZ/ftCTcj3l10qLchIMnw8ROyc2m
	 KTYWibIlvcv5Ca2skgd21omxCA/vSzKXdxd3z/bxPi1J7BXA7IOCKm8P7oU8P90YLI
	 UjrH2/y673jGoW7/VS2mwy7Q1EgfQcPeZt4pxM8cDf+IWLVMHjj7Vlaf+jK7ATNkFs
	 G1V2lRrMZAoXBx0A63CcCXcgHzckmRQUhnab37+33l/Wi3JGIcsuEEYV/QCQ7dyNFy
	 u6ZGdorTClCtvX4YmrI5A+31w/T2ZDB73pltiNxiuMH9/Fu0RRJ8LNF8Pn+VlFr2Tv
	 lvsDcR/t+gpyQ==
Date: Tue, 18 Jul 2023 20:19:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH net-next v3 2/2] tools: ynl-gen: fix parse multi-attr
 enum attribute
Message-ID: <20230718201913.632b6936@kernel.org>
In-Reply-To: <20230718162225.231775-3-arkadiusz.kubalewski@intel.com>
References: <20230718162225.231775-1-arkadiusz.kubalewski@intel.com>
	<20230718162225.231775-3-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jul 2023 18:22:25 +0200 Arkadiusz Kubalewski wrote:
> +            if 'enum' in attr_spec:
> +                decoded = self._decode_enum(int.from_bytes(attr.raw, "big"), attr_spec)

why int.from_bytes(attr.raw, "big")?
'decoded' already holds the integer at this point

