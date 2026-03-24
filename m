Return-Path: <netdev+bounces-271211-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEObLVvQwmnRmQQAu9opvQ
	(envelope-from <netdev+bounces-271211-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:56:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FB631A5FF
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E946301C117
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823033AB276;
	Tue, 24 Mar 2026 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krXNFSqo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F05B3988E6
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375000; cv=none; b=XlKiokdEHvOc6f0MyqsQ2RczcsSTSGFvponSN0ctCVnCIAoTM8/VgRe3dh1Oz2nnSNUYr5c4cs8lr7DngXMMF8zoTctJSYsAhMsjm0o7OWxJuqa4Sv6gw3y9hoCIBKoJu1mguLIXnZWhDnahP/OjDl52OmfN5g1riPjXlQKKY7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375000; c=relaxed/simple;
	bh=1WtuQk33e+bA6YeIjHut9a7Frg9N+0g9/sJdCnxK5Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r77x+CWswMlIk9y1e/PYsC9fx8qQIWWLTEkgf1VrUXMcIAscb+MduaI7R2U97UyL1PWFmJ2XS/YwaOE0zvYneMqpUdDWdZxcK9SKbHtGDeFZO8+6aTCt/3NhKsis6dv7MyXfbWyOt6SVNU5rS8MR1O2fLCWdIWWejR6rCHXnvg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krXNFSqo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B11C19424;
	Tue, 24 Mar 2026 17:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774374999;
	bh=1WtuQk33e+bA6YeIjHut9a7Frg9N+0g9/sJdCnxK5Fk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=krXNFSqo15X+wr3/FzLyPphjZTTl1KZzOFJSzstKCCR1B0rHUEPuBmsBec9yJoQ1o
	 /i6hIDsIcpyxjzyk/pmhUrYaMu5daz3PohNCBLtXbGKsIQGz4rSCgPB4YOzC9MjmPk
	 yKnW9ioQtMcfk/6HOYa1YtFmKRAu94GIgig1NzTeocl5DTR7DwBBRWdtOqbPCw1chk
	 2bej8Kjmg3Z5PbW2q3/9JisDQIxAbp2vPIAzS+9Ac3tA3g+QvCazb4Wk2GsKLbfAVD
	 VwZIt9V4PK29KRtWxhVC6x3MBuEt4Lb2kTg+sHeK+Zw/2RrFf0mNmYR6b3sudPNE2+
	 w8h0o5XAiXmNw==
Message-ID: <a0123c98-62d8-4bc7-965c-063524562481@kernel.org>
Date: Tue, 24 Mar 2026 18:56:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] veth: add Byte Queue Limits (BQL) support
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com,
 jiri@resnulli.us, j.koeppeler@tu-berlin.de, kernel-team@cloudflare.com
References: <20260324174719.1224337-1-hawk@kernel.org>
 <20260324174719.1224337-2-hawk@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260324174719.1224337-2-hawk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271211-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 57FB631A5FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Sorry for sending cover-letter two times
- I'm using a newer version of stgit that I'm not familiar with.

On 24/03/2026 18.46, hawk@kernel.org wrote:
> From: Jesper Dangaard Brouer <hawk@kernel.org>
> 
> This series adds BQL (Byte Queue Limits) to the veth driver, reducing
> latency by dynamically limiting in-flight bytes in the ptr_ring and
> moving buffering into the qdisc where AQM algorithms can act on it.

