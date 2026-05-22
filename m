Return-Path: <netdev+bounces-290662-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKgUE4fSD2o6QAYAu9opvQ
	(envelope-from <netdev+bounces-290662-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:50:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC595AE675
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18CE23024280
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 03:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A72133F385;
	Fri, 22 May 2026 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BvYuDdYf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C774328C84A
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779421828; cv=pass; b=FqR8H4EiJJlbM18w1YzlD6lNhlYlCP8jaBS3IUlwYY3bogGZbOF60YTu4ZaJs381f+VrYEXT4piL2uAdIuLRiPT/Y3uWT9TET5m6h6LJBFGNrPLwIM7bmQXnezLiFzWsbXYbERD7xLSwigqApmNb/AT/HWQYKmme0wR/uv+DA5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779421828; c=relaxed/simple;
	bh=Cj/i9ELpLcaBpb/0YFBTwcsXmhZ4kU5PDvYEIlXh9kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOVhH5vimQ02SSxvrUCFJX3pTU5qdl459f7bg/MYlaPq6wuQlia55Ekk5KCV2EabMYiDEVcyxBFUfdWo8bYgGkMgQVR1G+uGTqp7/ugpavZ36Pm3Ov9zeFUuH49UgWs+ws0CGQG5lgeskfBY2Y6tvxokPihgS5R7DyMqqotncKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BvYuDdYf; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b4583f0a1aso45303945ad.3
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 20:50:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779421826; cv=none;
        d=google.com; s=arc-20240605;
        b=VxYjUk2gguCYj4j39T77wZHZI3uG3Y02xMUlyU2nZ/WVzAHntNvU244RgCtVHl4cI4
         5v3CQB7bTzPp+zVHj2XyJNjcb3UzBYesT3eiPIHKt4RYo3NCQMOatkKQKPawhxiRt8Bc
         628PeLfLu1XjrkM4kqJ3LnzBRXMdBNOm7fHITKxesdpB6iBBvNUCg/t+cpfaiwMsj/vu
         YKZt0v2js54PH+C0Y3G8YOACo+HcnMyKek9OhzQImHeEC6d0Du8lktXkEETUB5pjVh5U
         uMAZ+VYqhMln7HlvyjwjNwTWURRPUUTskzNMx2acsfeIFWRJeaGZ4n+qp65mz2uNVHYs
         Sq+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mJtD4yG4pQtpmZFI4sg7XbvqjUAopoqZlfXkYohTNJg=;
        fh=kfI/FHC53YnwfDzSYoDkH7wY2r5hvrJGAzrR6GTl/Vk=;
        b=DyEoisvh06XGs+AYMMway8SHOqIPTx7kMMLLmChxFdRghLxbMap6WIa/Gzo1pCWXuR
         W20m+M/bcHcfyz8laLF8HyHRQkW9mPIolXxLBHqItm33VvquayQTeYk9Neg4A5iBcJzh
         cN5CdO1nlUWXynSnUA41E9H9JmAFy/6TIRj5R+KxF7GMTIvl4DrlMUGS63qwyeclVH2u
         CHpCPF2u8OvkG1zQ3d8N/odrTEqzRldgJxQBlOXeleisWtIwQRoMlG08K7c5REsv/82o
         vs0YwFsr9dlgcxB3R3JSN/Fc1Sp8WAMEe+jAlNrDpO5KjdG3T8LbYWvmexn4rkmI3cl/
         N0wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1779421826; x=1780026626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJtD4yG4pQtpmZFI4sg7XbvqjUAopoqZlfXkYohTNJg=;
        b=BvYuDdYfGImF7ZvIUY2X/gKGOtrGSw8ruAlrCBdSyQG23Pha8SwK0hATY4inEcpTxC
         WfDUDczbjFyAdrcNovUqWHTyLENcklZHbv2hGwOuHnR/675kGIeNnjsnzNPeyQ97zpTD
         bGYm7ti8oAEcfdOkPG0T63MckBCVTJr7dIELEJI+/VAVXtS2oA7OgGgl+OwERwzZAiIW
         WiCyOFBBXJLcX8bYX8oylykAilS5CrehPtCLR3v/X1BWrDC+EhKC9HTcPl43uHHKKttv
         yBUIxEwgNQHEbG5pAyKqQsQi8WBYhxmW1f6pc/fkt3JWQx1Q4LqZekvKgiBfqhEMd6XG
         YZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779421826; x=1780026626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mJtD4yG4pQtpmZFI4sg7XbvqjUAopoqZlfXkYohTNJg=;
        b=YuRg8onR73JbrQISU70HOIxMniQ5X3FuMDrqUPd1dxhbGtIGZ+hFcefvGvAY9fnKVc
         BxGLW2QFl8wR7Y7Beoljhi5sprXbTqqEGrs+SEJbsghxPy1/5upY1k+NL0G2yndsXEbY
         CUv99VhUI7arlA903lLgTNbG3fQSQycXVHBg9ucuhgyR8iyxMpiBcQf/a8shReD8VwIZ
         ro0gmHMXQPiYqQaRtdBNdX+Qklg+AWIALzUmRnjqAR5IfpZqTmtvtzwzlPW7qrb9MFTF
         drpUbOy4eO7DuvjJwoI3dj6ypRisgZ7tTuqvhtMxLDkWM86eeJGf6zmBq+j0oCi0obGG
         +xXA==
X-Forwarded-Encrypted: i=1; AFNElJ+55aGjnk6okHElnndFc4yRB/1kR76KOUQqPGa3i6w/oSUaw9gTQ5jcalTVBR8AAtJ4NtSeNZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo40MPz8/03wk7leJTYj0zcXuRSCAFHAHptbitigTzdEKfA2Bo
	Zbd4k3qoFUUNT+lz8LEDZTc+gdfWbU8fxS1kLN/kOVwzREeFDymw+a3j0LEjizLVVCWiIxbmmEG
	ahhBBxJ4wotm0+6hr48JaszH4t+zyOokAHbjYtLJu
X-Gm-Gg: Acq92OG8m0cxOy7p9dwpiRg1f2NTnwij0QP0PenZeyxZwBwKXRf53xnoBSRkWqgBt8c
	aBENjqUnNvhQhKLfsbQWnuWqpsdJ4XfGez4tGjtKwFHrqlmimRpRNFaQEkeVs5pg56p2exiE0GG
	qy8ppTMgyXG4CkwK/JdyJQlsx8rBUlnwrBxgm05bIA24wKOlOiFd1CZeMO5UMkqNX5UVyUdRmYN
	NJwj/lmWftqmSG3WayPe+dB2QZD/rqBgrw6lt90xaVToUrHUswgzKH7oi7Wb7vU0dTpENpxJXvr
	Svfh
X-Received: by 2002:a17:903:1247:b0:2bc:8f9a:3642 with SMTP id
 d9443c01a7336-2beb0758d9emr18659005ad.16.1779421825760; Thu, 21 May 2026
 20:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522022910.398416-1-zhaochenguang@kylinos.cn>
In-Reply-To: <20260522022910.398416-1-zhaochenguang@kylinos.cn>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 21 May 2026 23:50:12 -0400
X-Gm-Features: AVHnY4KHmISMm1IYd6RPTq4MlDMEp6cvrOPadkJFFg-dlbft7CyMJhlb9mqPZRA
Message-ID: <CAHC9VhSzAmZKqcOca+6UoTAJ+XrbFC8S18f+iPjL=2bHjz_YTw@mail.gmail.com>
Subject: Re: [net-next] netlabel: fix IPv6 unlabeled address add error handling
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290662-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kylinos.cn:email,paul-moore.com:url,paul-moore.com:email,paul-moore.com:dkim]
X-Rspamd-Queue-Id: 9CC595AE675
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 10:30=E2=80=AFPM Chenguang Zhao
<zhaochenguang@kylinos.cn> wrote:
>
> netlbl_unlhsh_add_addr6() always returned zero after
> netlbl_af6list_add(), masking failures such as duplicate
> IPv6 static label entries.
>
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
> ---
>  net/netlabel/netlabel_unlabeled.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Nice catch, thanks!

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

