Return-Path: <netdev+bounces-196690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EF4AD5EFD
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 240BB189F2CD
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 19:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E995B2BD58C;
	Wed, 11 Jun 2025 19:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="B+qiX3gY"
X-Original-To: netdev@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71341225413;
	Wed, 11 Jun 2025 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749669926; cv=none; b=qIflX7OiUjR8qzv1K6ToxCEGQ0swxHAn0802oW7o1TF+Eu2wZL6MP8emSpFmnXzJOlWufMa9EH2sMZNPtYmxJPKP+ms52EhfckxZRQo8ffCwI6Kj9J5mJsrebYKY9SmdW+H2wqWriKQF65hDTWjDWK/duDbMwU6YQTZNbpxRYuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749669926; c=relaxed/simple;
	bh=eKDVnxG3E/blRCYO5ls5suxXi9vDUdZMPz72lIAk2Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=momNKekLk6rO+6AxMzkBCNZOHLuSNDxmHcv0Pz3MP5r2Tk22Yb26XT7tZmOcU6RMKLrxKPQ16QTlOUgdo4gU07uZwoKnFUVdHYy+y8T9d70RZv4a9f5NXSqtBTXZAgaTtDmUQs1hPF7LnyWpRb5f18ypJvLR46a3AVm8TIQSJeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=B+qiX3gY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AWz/6xHsZld+TcrIo3vA7x/JVCIMknVrwxwjNiRLZaA=; b=B+qiX3gYW6ScfiYm1I+7Tl5dKT
	j8tr4vzPtqByvw3heukk7BmS3imXnZu3HLFEt/yXsBG2A6URzWx5FOaMv2DVnZrB2a2ADrKaBczhR
	shEPrglMy3b3OmwXoSjPMQU+Ap8oKAASWnWupFm32zmjoTwrhbSM3sb6S7rR9lgtRqp4gfCFp3Wrh
	5pGtH/fIZhzu+rfHeeCuOc81GzB2izsBBHqRfuqtYn8s1PnTobtvMbnj1vKMKQ+bnqr3NM72lagRH
	lPDen7TqYywD3g4oajnWDSYGNmpNl5j8oZOr5Rj4FraUL6A2WBtolOxIWvxcH+Z0uGQo2ga4rE/ry
	aekrejPA==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uPR4F-002Kw8-2w; Wed, 11 Jun 2025 21:24:59 +0200
Message-ID: <ee678dee-e003-41dc-86fe-c35c18a6171d@igalia.com>
Date: Wed, 11 Jun 2025 16:24:53 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] af_unix: Introduce SO_PASSRIGHTS - break OpenGL
To: Kuniyuki Iwashima <kuni1840@gmail.com>, christian@heusel.eu
Cc: davem@davemloft.net, difrost.kernel@gmail.com, dnaim@cachyos.org,
 edumazet@google.com, horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
 netdev@vger.kernel.org, pabeni@redhat.com, regressions@lists.linux.dev,
 Tvrtko Ursulin <tursulin@igalia.com>
References: <58be003a-c956-494b-be04-09a5d2c411b9@heusel.eu>
 <20250611164339.2828069-1-kuni1840@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20250611164339.2828069-1-kuni1840@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kuniyuki,

Em 11/06/2025 13:42, Kuniyuki Iwashima escreveu:
> From: Christian Heusel <christian@heusel.eu>
> Date: Wed, 11 Jun 2025 13:46:01 +0200
>> On 25/06/10 09:22PM, Jacek Łuczak wrote:

[...]

>>> Reverting entire SO_PASSRIGHTS fixes the issue.
> 
> Thanks for the report.
> 
> Could you test the diff below ?
> 
> look like some programs start listen()ing before setting
> SO_PASSCRED or SO_PASSPIDFD and there's a small race window.
> 
> ---8<---
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index fd6b5e17f6c4..87439d7f965d 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1971,7 +1971,8 @@ static void unix_maybe_add_creds(struct sk_buff *skb, const struct sock *sk,
>   	if (UNIXCB(skb).pid)
>   		return;
>   
> -	if (unix_may_passcred(sk) || unix_may_passcred(other)) {
> +	if (unix_may_passcred(sk) || unix_may_passcred(other) ||
> +	    !other->sk_socket) {
>   		UNIXCB(skb).pid = get_pid(task_tgid(current));
>   		current_uid_gid(&UNIXCB(skb).uid, &UNIXCB(skb).gid);
>   	}
> ---8<---
> 

I confirm that this fixes 6.16-rc1 for me as well. Whenever you send the 
proper patch please CC me so I can give a Tested-by tag.

Thanks!
	André

