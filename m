Return-Path: <netdev+bounces-13757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4666673CD45
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 00:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3D1280EFE
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 22:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD959EAF7;
	Sat, 24 Jun 2023 22:23:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B072EAF3
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 22:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DD3C433C0;
	Sat, 24 Jun 2023 22:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687645424;
	bh=gUDhl6OZLxYp39Jf11vLoHAb7USqrQ5fveZFU0IXFQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OiY/d87uh/GjrvEy7X3s06YAuSKIaguyQF/EhabTjNy3nwZOFcc7mJKZH57M4tx1r
	 DWYm2iy1brXW4aYkd839mUbM/qp8nHF0BDIDlPTpqBALUK7xtNcTw1DJNVrVPdPZjW
	 CAGtlmwvxWmg+6KDvr2inrPX9g+2tiqZCEMyvuoU8EgsBsgVOYDe4noe1WDHYWM7Yl
	 YAytVuw9KkcEGGN6nMdpfi3zfjn0S6xJofYmxC/+BPwQ/65m3Efc9mQiu9xhrGT32X
	 dFpR/Qtu0eD1zX9NrwxXadc/T32o6hGQXkm7iq/zL5k80ZXsisWET45snEbstMVXn4
	 OIpM9Dc2+j9KA==
Date: Sat, 24 Jun 2023 15:23:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: krzysztof.kozlowski@linaro.org, avem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v3] net: nfc: Fix use-after-free caused by
 nfc_llcp_find_local
Message-ID: <20230624152342.72ae073c@kernel.org>
In-Reply-To: <20230623012030.1532546-1-linma@zju.edu.cn>
References: <20230623012030.1532546-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Jun 2023 09:20:30 +0800 Lin Ma wrote:
> +struct nfc_llcp_local *nfc_llcp_remove_local(struct nfc_dev *dev)

This function needs to be static
-- 
pw-bot: cr

