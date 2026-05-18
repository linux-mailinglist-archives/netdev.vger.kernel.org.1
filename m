Return-Path: <netdev+bounces-289017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGgVE0D9CmqA+wQAu9opvQ
	(envelope-from <netdev+bounces-289017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:51:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F127E56BF93
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73AE33020FFA
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E333F6C4C;
	Mon, 18 May 2026 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAQsjz5M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40252302756;
	Mon, 18 May 2026 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104783; cv=none; b=R6p5l5h/Du+IvG8pdPd3YHho+niyZNxqzDiPVmqbgIwtKbXhUoqz2BkDDsoXJKCB475eeXo6AEluuE9T4LG0s52ZNcwlN6AkwSHO6x2FFFBrLnsAQJsDAlVy0xEyGEJtc/r0Zz0wQzkCntGVnN1NgcHgCn+m/x6CrPiRvZ3bKcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104783; c=relaxed/simple;
	bh=XqZni0xuqOWv6atxkSxgH5JoYFF8z41zXXsop3zKZfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LRPWwGW4bRt2UWtdxZUy3xa2h7TuHSrSS4Bljcizie3MVmq5KU80y0OG5XAdyrE8cS2vYRs5dRny1Bv0mWUay5lA2bUXXa+2a5ytaDPioCUF1/Uy7XMasyM9FgGMSXFRj8UI+s7qA8CyBsn6cCPpyyArTadMwCahjeR+f9cujVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAQsjz5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4BBC2BCF6;
	Mon, 18 May 2026 11:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104782;
	bh=XqZni0xuqOWv6atxkSxgH5JoYFF8z41zXXsop3zKZfI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CAQsjz5MR5HfrsRXegE6dNHqFlSV0vf4Te6NzEK3APu/K5S3I8tas2Nm8WVsbtlgl
	 RnEsZ/Wl7AjzlJ75EQ6BBo6WW196SMgCpcvyF0SZNMIcdzyf+V4o3wVMNVjjwoWKz2
	 eMQbqmJTHD/TcD0fXOQfMTNu0g/GhBAiE23pWIT1P/Yrpt8Czl6MsndH6L4cQBDokp
	 lKftBHqW9BgOXoUI3y+cRGovEyQgIBSkDd31Vrwi+uamgQrAlMeJYttBeKFGRo9AYQ
	 Rj4JP1NIPU4c2TdyabqAdaDypocx4oPqjVqvfmuvhr7oFWNHWQ0RIpuUZmdVbNrMhu
	 yBoRF5fNCYW1g==
Message-ID: <928e935a-b7a2-4cab-bb1b-49c88f8dd612@kernel.org>
Date: Mon, 18 May 2026 13:46:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/6] bpf-timetamp: support rx side
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, kuniyu@google.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260518082344.96647-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F127E56BF93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289017-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 18/05/2026 10.23, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 

You have a spelling mistake in the subject/title.

  timetamp -> timestamp

--Jesper

