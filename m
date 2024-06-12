Return-Path: <netdev+bounces-102927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DC9905774
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3AC2B21BC2
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 15:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251BF180A63;
	Wed, 12 Jun 2024 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+Y0NTe3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0188917F505
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718207575; cv=none; b=tcObx/JYZE4wK8Vv1yV8dhRM2fQppdetUW3k9RojHGVJ0vUp79ZikEXngI6zVJQKxWksO0+BAtEpCWtUtznWSRKVz2+f2MzE6Q2TPl6ThCWke4Txt6H838JVkIm/SbHd9nbkQ29kC50bce0bFRWcXuQ4aTVMmyrKv1EsTIu3tvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718207575; c=relaxed/simple;
	bh=rkhvsS6jkLIz0UqbXprv+wPxQe5g8UnrNYfvoW9Db4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S74psl3daA5Sfh318Fcq5jErVsN6awQSbXjRQzlKiD4yoNu4oh28KSId31z6hJY760PH8q9qCZyHfR8PS8K3QsWfb2iy7hvKK0Gqhr105FLNLhFOn+xBRfKI9sML8dIYSAFxIy2v1KrcaPM2BHSwI7gmaVBh9dbuEOHim7Il6v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+Y0NTe3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4132C116B1;
	Wed, 12 Jun 2024 15:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718207574;
	bh=rkhvsS6jkLIz0UqbXprv+wPxQe5g8UnrNYfvoW9Db4Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=H+Y0NTe3yU2BsQWK3HC2HoTV7/8meYvxVgoCVwIGYBLVayKIVridvPCPse8vyVoVu
	 HxVrAfkKbQOvhFI+6dOxD7YsZFAb3qd7EJN/q2f30/h+em8CeaA9e1/unsP+Q4RkVL
	 O1/QrfaDoMfX9lxDNrmvMn2yn+2/dUo3l/Xt/uNWW8G27v+Mvq2xWN8UN6fwn/TNM8
	 7E6wGTJl6tqpmv7JRgLvxYvZSnEgXhqvgIR9UPDBelkKt7Xptjj0QCAbDW+I+f0xNq
	 y8kZu9w/0PbAC57B4uBl2taEI9yYYdwIN/xqFDrwD3aH0MEFsJCPEiB2Mz/vswZ+1b
	 y4FEPfd2Fzorw==
Message-ID: <1b26debd-8f18-46de-ac6e-05bff44a9c52@kernel.org>
Date: Wed, 12 Jun 2024 09:52:53 -0600
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
 <e6617dc1-6b34-49f7-8637-f3b150318ae3@kernel.org>
 <b2dadafd-48c3-4598-bee5-a088ae5a4bc7@davidwei.uk>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <b2dadafd-48c3-4598-bee5-a088ae5a4bc7@davidwei.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/10/24 9:41 PM, David Wei wrote:
> 
> This patchset is orthogonal to header split and page pool memory
> providers. It implements netdev_queue_mgmt_ops which enables dynamically

Ok, where is the validation that these queues must be configured for
header-data split to use non-kernel memory?

