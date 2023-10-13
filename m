Return-Path: <netdev+bounces-40865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 391AF7C8EF2
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 23:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2681F215B8
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 21:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5402628E;
	Fri, 13 Oct 2023 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lypgz7v7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4A525113
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 21:23:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA13C433C8;
	Fri, 13 Oct 2023 21:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697232188;
	bh=UasAX67RgbU+zYwQ4JKxcxlh9as+dDoHvrORQcLNTEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lypgz7v7ipALziFsstmwzfsCm52uU5ufrWtsIU11+FefJ6xEBTNVaXDAeagbq7vA+
	 6eaLPDQXBTYRFpwtWQqRVC1CK+XEqUMYjDW3aaEAOy+CgZKmN1jbnFjdLt85ZeXGrW
	 y8/63BKpWQ1lzBJppxXNd4fjR3Cu4Ke2Tb1HzEpM17wD51IJAVSR9m+5AzCOuX1QoL
	 GrBl2zKPdc/O5t7zHbjubx7IxJw6KstzECOLg1B2aWU1cn0kyTqv/XYLLwFMz/hlTU
	 uW4a4fiFZ9D+HdCiFFgAgYz8nBfThgbW6rSyusq1ECU6HBoLNf2lS9AjxbVxHCCVtV
	 tLUD4kheBiKJQ==
Date: Fri, 13 Oct 2023 14:23:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com
Subject: Re: [PATCH net-next 08/14] tls: also use init_prot_info in
 tls_set_device_offload
Message-ID: <20231013142307.70af75d6@kernel.org>
In-Reply-To: <6da95c0d469415ee62cc23ce72227f8d058400bc.1696596130.git.sd@queasysnail.net>
References: <cover.1696596130.git.sd@queasysnail.net>
	<6da95c0d469415ee62cc23ce72227f8d058400bc.1696596130.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Oct 2023 22:50:48 +0200 Sabrina Dubroca wrote:
> +	if (mode == TLS_HW) {
> +		prot->aad_size = 0;
> +		prot->tail_size = 0;
> +	}

Strange, tail_size doesn't matter because HW doesn't support TLS 1.3
but aad_size?  Is it overwritten by SW init or something?

