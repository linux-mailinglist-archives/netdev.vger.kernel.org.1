Return-Path: <netdev+bounces-276362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH5fNrwU1mnwAwgAu9opvQ
	(envelope-from <netdev+bounces-276362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:41:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 437B63B939C
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E0063007AEA
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CE23A6B8A;
	Wed,  8 Apr 2026 08:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvT7FfhK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1F63A63EF
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637617; cv=pass; b=mWYRgSMHE+Q6Y1lqdID8wTRbn/YPhT+YjRy5T3IudCrpJH8aYqGq+azIYlBEtDa41VZyBp84SQGXn72bqF3uwU/eXFOvhbcK/srme75G2VVrFT3oJ9r4fO+Vq2EfNTmEdC9SL4/OUOSacb5WiA2o1xTNPI5/fFaSmcUObRHF5LE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637617; c=relaxed/simple;
	bh=/oD7sNLw++PyOPjwBDzev2T60ObmXLeUS/U/thICqBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDaQbutwzrxkLpUrkR5goEmm+ry9kloVolpPtVIwbNSEi3Zyjaz8xcG8d9yD2bBjQBmbI0/JjyYpMruYo9mu7Ckx+9wD3OAZYGsFjXSC1IgS3zRA9eID0kJSD+S+ltTVTWR0pLkFDtvRLonzXG3CRlQBnCWlmJSKnbFYwfFP310=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JvT7FfhK; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8d428da4300so480112585a.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 01:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775637615; cv=none;
        d=google.com; s=arc-20240605;
        b=h1WMGe0EbvIOCK4oWg35t9agRNbUrq6hFprOFePHIblbPBOLlXgoP6m2BFehJUmt25
         fUF1x1JvjWCIoE0SoQeVZGkp4uuzLcUFfkQO6XiiPDuOa95qmBcT/wklSS4CYnz1WwFZ
         ES46KOhiwaIp+bLsc05egCxCS3XZQKgy8h8pMfwt63yFndwd1KgI9ePcIcr4L8omIpvn
         mc++oy7qJyklsJkZ+7Zbb0D9lzZ3A3Ei3+3PkiS7jGkYhoHUPbAiIi7soBvltAiqqzcV
         Ly8JWaBiyyr+IqV9g/0zj05HkBAFJAvQwBkIZ+UWjFUxGA5K0Dm+RWmOCeNpiS2Vb0JQ
         YBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/oD7sNLw++PyOPjwBDzev2T60ObmXLeUS/U/thICqBw=;
        fh=zGaQWk2s/IYrjhzyJR0Dgq9xk/PH5/e0l2mnbTnAmSo=;
        b=lmGr7zurwf9lLvNu/jSftd8Xml3lAm0qvACIt0bzhJ5vBrzu3BVlVGr6JPumfcc5jW
         GwlbPaVbVWj/ZdR3y3P9HrAl+dJuExp9uNpT60+j9lKQphF3d94gIbJgE2HGjNM+HUoN
         /JRJqeMsPsvxowABLhudBe5Hbv827Uda+/rOsOcrpWXb8MDPfIMJgoMmu2YTT0ecfIgw
         FjqyhbziZ2wJEwfheWvBdO2s804PPXS879mYFPwiZ6XsEAE4eLv7uhCOdZiH0EJynVHW
         sZTK+1Uc0C4wJxtKZNK1NnXhM+er13qwB7VqPhsfQpICQ7sMEV1ixds7VIwW+SIv1rY+
         HRJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775637615; x=1776242415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oD7sNLw++PyOPjwBDzev2T60ObmXLeUS/U/thICqBw=;
        b=JvT7FfhK/aUOILRg2JRPc6y323Qf3IHDmqA0HYAHJUEed3Q/CXtJ81VdsLEs/WIO5V
         mLmskt9t8LBXWrMYLLz0fzjPP1ilPOX085s3kg8e7GU64W88UlatkIcm5qlbbMZEWBoG
         8d0gR2IGyYKSLkFXLW7WngcD/HCm5w+JsuwrsbxEFOUhpfc4Na+osGTP4b2b72rOlicI
         +f//lVp63r28SgnDAb2zNkU4uO+yp2ghb7/EOinBkTSLqTt6o34v1ZUFujR9o8o5+aKh
         o8X57ZPWge2T1GyFEdg11htFGxfI8WjuFloCqCMtfqqdx7tAdOnygRcCCsnunV9p2kd4
         jGLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775637615; x=1776242415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/oD7sNLw++PyOPjwBDzev2T60ObmXLeUS/U/thICqBw=;
        b=QTg6JOfHsQFf+qtU9S+yz9I1/9jw4X+ynI/VmlO4BsiqYZ5yKzio8IO6yZARvOeKXc
         6pbBuirSAaRqhZ8Hcy/SFbRPZjnYFP2g2yQlPZ+Lnj3d0dhboG+0Mlpb2MlroR6rKn+w
         minScAbRUTzkTJKzuL8Wo3l7aSVoBgbTQw5VP2VX1csa94QvKDeKpjn2TLQpMxINdtx7
         fvBVXAbAf6KXOdtEuR2mlsTdLpkQQ/+gnon6Lh2jTQbZPaq4Eab4xP/p4NJvwHcYNFrS
         2+K0b1kB8SktYUA997tc0lHe7cnJGqNz9Mswim8X7ooVqHB8KfRoPjaVL2qC2DA5gwfl
         K6/w==
X-Gm-Message-State: AOJu0YyLuDoHJqEMf3+qYS7vgLe1gRaVaUhLMBygxYVCkSeqget5o2w8
	untCAyL6IbRA2JCDCjVk4oV8me0lTFzl6NLX2G259+iwsmfTQMbnoewq1rbbIE86OhqqwxYVu4+
	yimCVjh6pLXzNKtATPZR+cA7YyieEhto27Ydt1aiq
X-Gm-Gg: AeBDievrfFce627Dvm9cnf8QlwPp7Tn6Bm7EnxLD4VuJhiXPIrjalA2ACZ6ST+v3gnP
	QBHcRlksHrkG71hdv3Gta63JvoRilXl8gasn1HYzydpPx1bL7zliTXw3pQ3cFabUiSjQ1EjyH/I
	6MQ/vdklOlrCqg2dj+qZ2D6SV5Hzd6aPUfqUQOTuY7SlkIDt0u7wBc72JlG780n3/F9Gsau3Qyc
	waCKUe/N8TTbMHO0mNeDTq4DgNQl1hhiBxg9NJecNoSF9WISQdZFC+ehjfyNILwJN+incpEJR/L
	9QmB8A==
X-Received: by 2002:a05:622a:481a:b0:50b:3804:edca with SMTP id
 d75a77b69052e-50d62c7077amr309886861cf.46.1775637614911; Wed, 08 Apr 2026
 01:40:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408081006.3723-1-qjx1298677004@gmail.com>
In-Reply-To: <20260408081006.3723-1-qjx1298677004@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 8 Apr 2026 01:40:03 -0700
X-Gm-Features: AQROBzB98zSqwugSNY3-JAA2xFwm45djxafm428HAaUVyGLssyhqTS6toBW6J5M
Message-ID: <CANn89i+FRk3C3e9909pnk6Lf4FiwxHhzLM45tuei+Y02hp4d2A@mail.gmail.com>
Subject: Re: [PATCH net] nfc: llcp: add missing return after LLCP_CLOSED checks
To: Junxi Qian <qjx1298677004@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276362-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 437B63B939C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 1:10=E2=80=AFAM Junxi Qian <qjx1298677004@gmail.com>=
 wrote:
>
> In nfc_llcp_recv_hdlc() and nfc_llcp_recv_disc(), when the socket
> state is LLCP_CLOSED, the code correctly calls release_sock() and
> nfc_llcp_sock_put() but fails to return. Execution falls through to
> the remainder of the function, which calls release_sock() and
> nfc_llcp_sock_put() again. This results in a double release_sock()
> and a refcount underflow via double nfc_llcp_sock_put(), leading to
> a use-after-free.
>
> Add the missing return statements after the LLCP_CLOSED branches
> in both functions to prevent the fall-through.
>
> Fixes: d646960f7986 ("NFC: Initial LLCP support")
> Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!

