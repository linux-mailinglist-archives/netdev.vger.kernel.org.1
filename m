Return-Path: <netdev+bounces-18820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909E9758BEC
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 05:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77CF281796
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 03:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7376187F;
	Wed, 19 Jul 2023 03:17:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A076517D5
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 03:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A6FC433C8;
	Wed, 19 Jul 2023 03:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689736626;
	bh=hJ61Y83uViUofA0b3FuQ8iN/9fbN1jJPVd2ST/2F9Fc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QRITd7OosrDWuIvs4OfHFOxkI4KvSEPia20GZhl5pD1jW0GkFfYGfWTTgo6kIfNUw
	 VhvF8DCaR06vctj8ftwf+jDa9mrgbY4vUIs0HXQE/z7rQ4CGbiDivD1iK+o7zhA+ZM
	 OERzaC/3k/CsnC66IUduIol+OX4IcC1bVfKTBqs6qTLFXVU4rz1Dk0mYCnS/A/NyUC
	 1BpyLWOd0PpDDMmCalykDMjYn3OI7h3N3ky7wSoaWXRif2H1omK4j0NMyCpFNru+e6
	 +i7nPP4DCYRWbDzff3Ya7qvt3ZRVxyAvQD5+kZeCYCefRiP+niaLQqNvPc05xrDweZ
	 v83HX/pDMsPPA==
Date: Tue, 18 Jul 2023 20:17:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com
Subject: Re: [PATCH net-next v3 1/2] tools: ynl-gen: fix enum index in
 _decode_enum(..)
Message-ID: <20230718201705.06fadcc0@kernel.org>
In-Reply-To: <20230718162225.231775-2-arkadiusz.kubalewski@intel.com>
References: <20230718162225.231775-1-arkadiusz.kubalewski@intel.com>
	<20230718162225.231775-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jul 2023 18:22:24 +0200 Arkadiusz Kubalewski wrote:
> -        i = attr_spec.get('value-start', 0)
>          if 'enum-as-flags' in attr_spec and attr_spec['enum-as-flags']:
> +            i = attr_spec.get('value-start', 0)

Just:
		i = 0
-- 
pw-bot: cr

