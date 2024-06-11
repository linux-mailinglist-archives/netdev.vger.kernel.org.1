Return-Path: <netdev+bounces-102428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8703902E84
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 04:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9421C214C4
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D7116F851;
	Tue, 11 Jun 2024 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfv6epNU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30DD15B0E2
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073623; cv=none; b=NiUMAGVqdUVMgg6ZTv3cJwY7AG32MQaysaTv9nHtV0UZQlCjD3RWLy5FwOBfwZP+HLx/fUJdCBTEDBe2yeZHf2iQSU8Rf9bFow944BYuEjh2LAf+6jLg0ro+2Jr0rSevr2qQab6moKa6MTApxl46HXkRD+TSMQb/SO2O/mhP6iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073623; c=relaxed/simple;
	bh=+ixkNcnnLiL7Y/7zHd/QgiMB4jGXEiiaajDFdPUs1XA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjDDrCXq2D0nb6nhs0Y/53/LVojT+eXTQAC4hKItVY3Gp0YDV6gA/TYZ7NQbEw/opXjDH90vdlmfNkDANisp5lc4/lnQz5eoO/aUSPZhhSYs6Q3xObYCnI5hez1VZms91H/YhmUJTGCv38MQknd4HmMPSCGVqSx5+lkPx5Z9c9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfv6epNU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5BEC2BBFC;
	Tue, 11 Jun 2024 02:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718073623;
	bh=+ixkNcnnLiL7Y/7zHd/QgiMB4jGXEiiaajDFdPUs1XA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dfv6epNUllUN47+Fx8s7UxNEq749QJSkqAsXCElSPj/sWKonwq3FWF3nq2inGdShy
	 zLiX9oufMOdvIdALGr28z57UXI+B748fMqtPHvmK0vGx9/K6SC+Zb71zRxSmpcvfQV
	 A2P+yp2xiEaVq9I60Ht6+2eYD8OkGelXI8nP5UpaY+3M1tCZBnuTfOJDeiNwVotFUr
	 pXfCuNx9FtDvPY222Gu23GpnOmUUeIoTRVJHENqQaR0Cr/CRF7cSzf8jfoUQnoIzIy
	 eR6FLhTk+PATFI76ApxnnMPQ6110f57oXVcTe1woo++XiEj+kWsVWgj4JA7Kexwscv
	 PTsNXsGLujNNQ==
Message-ID: <e6617dc1-6b34-49f7-8637-f3b150318ae3@kernel.org>
Date: Mon, 10 Jun 2024 20:40:21 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 0/3] bnxt_en: implement netdev_queue_mgmt_ops
Content-Language: en-US
To: David Wei <dw@davidwei.uk>, Michael Chan <michael.chan@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Adrian Alvarado <adrian.alvarado@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>, netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240611023324.1485426-1-dw@davidwei.uk>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240611023324.1485426-1-dw@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/24 8:33 PM, David Wei wrote:
> Implement netdev_queue_mgmt_ops for bnxt added in [1]. This will be used
> in the io_uring ZC Rx patchset to configure queues with a custom page
> pool w/ a special memory provider for zero copy support.
> 


I do not see it explicitly called out, so asking here: does this change
enable / require header split if using memory from this "special memory
provider"?

