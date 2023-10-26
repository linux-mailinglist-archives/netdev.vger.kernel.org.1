Return-Path: <netdev+bounces-44347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1C07D79D9
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 02:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8760B20A0C
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 00:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13BD17D2;
	Thu, 26 Oct 2023 00:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qfD9VUD6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DADEBE
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 00:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA175C433C8;
	Thu, 26 Oct 2023 00:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698281797;
	bh=PwQRKjTjxhQwL80+3ov7UrMVxi77/CKVZSFO8s+sH9A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qfD9VUD6rSij6cFpAYb0USvqstnz+vVWW+TevFJfLugQzmT2L2NZaxN9SQU93Qnih
	 c5nWfNfYzGJz2xE7P5FlgMoWBYLlwZdv6IwyUuEJYgMb3jFDVcnhL9RmM2tlbmsf9N
	 +XYATaRqm6r2DI8swDRX8Oa6wHeQkxMnjVqsUPY7cGjKevJTUjO2O8Jz2S2mQJ7tqt
	 XQeijQ68n1jT2yMBaP7EvQwI52yoH+cS5w5zIzAsUVQfNiaJ9fFaUxKKYach/8IIHz
	 Yiza+KmFl1h8Bg7vByBkOGWuKVys03FV+Sayps9mu/1C8r3nLDHtnHMd7zwJBh2uqi
	 uer66J5jGO/KA==
Date: Wed, 25 Oct 2023 17:56:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com
Subject: Re: [patch net-next v3] tools: ynl: introduce option to process
 unknown attributes or types
Message-ID: <20231025175636.2a7858a6@kernel.org>
In-Reply-To: <20231025095736.801231-1-jiri@resnulli.us>
References: <20231025095736.801231-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Oct 2023 11:57:36 +0200 Jiri Pirko wrote:
> {'129': {'0': b'\x00\x00\x00\x00\x00\x00\x00\x00',
>          '1': b'\x00\x00\x00\x00\x00\x00\x00\x00',
>          '2': b'(\x00\x00\x00\x00\x00\x00\x00'},
>  '132': b'\x00',
>  '133': b'',
>  '134': {'0': b''},

I'm not convinced, and still prefer leaving NlAttr objects in place.
-- 
pw-bot: reject

