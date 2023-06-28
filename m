Return-Path: <netdev+bounces-14443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4787417EE
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 20:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AE11C20847
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 18:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA29D52D;
	Wed, 28 Jun 2023 18:22:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D188DD513
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 18:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554C4C433C0;
	Wed, 28 Jun 2023 18:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687976523;
	bh=VyBVKpq4YuIxabR3LJTi8n36Ku8qxu2TBWpXoGYgRj0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H+n3rycCC/RCm2dFrXiCDRDCQIgparymMWqvXoUL42KLp5Fq8GbsxGayVfePTpt8J
	 KLPM/v9EFs/eZNrV7Row6YHsrmtFewoncSBCC+X94erNQwTH5HP5ELlRZKaAjYqZKr
	 AvVe9P/suKTU2oNfJCg5ftQjTSlVLejOOa9psqIvvIb9WFO7/NC2EkZfPDj2BRM3Ev
	 pjDFH35xjkHgfZzwa3cl63E6LfQjgkcuK+5VaoFmkoRy+LE66ZmZ3P/fJjWH+xlGFi
	 h2HWLpw47oUInyNNfJngkSI0mXNqWrNN4S7mCFW/AUSHN2ujWK4yjxcWxrLPXHDS2k
	 PP+r5cLk6x8kQ==
Message-ID: <9e9d932b-79df-e67c-abeb-b50bbb81b95a@kernel.org>
Date: Wed, 28 Jun 2023 12:22:02 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: tc.8: some remarks and a patch for the manual
Content-Language: en-US
To: Bjarni Ingi Gislason <bjarniig@simnet.is>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
References: <168764283038.2838.1146738227989939935.reportbug@kassi.invalid.is.lan>
 <20230627103849.7bce7b54@hermes.local> <ZJuChT7GPgEpORaQ@localhost>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <ZJuChT7GPgEpORaQ@localhost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/23 6:44 PM, Bjarni Ingi Gislason wrote:
>> Running checkpatch on this patch will show these things.
> 
>   Here is a simplified patch based on the latest "iproute2" repository.
> 
>   Output from "checkpatch.pl" when run in the "git/iproute2" directory
> with the patch:
> 
> Must be run from the top-level dir. of a kernel tree
> 

Add '--root /path/to/kernel/tree' to checkpatch.pl


