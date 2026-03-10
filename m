Return-Path: <netdev+bounces-265887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFC+GsOSr2kragIAu9opvQ
	(envelope-from <netdev+bounces-265887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:40:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFDD244ECA
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 04:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 73FB83028E9B
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 03:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C9D3BA243;
	Tue, 10 Mar 2026 03:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xPZaCJTb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2D028468E
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773114047; cv=pass; b=GroTYSlb3s5ZKIRuhD7lYMxgR2FLLWGkfCWz8qz5xa8q5wNbQKUrvZx96PCk0Oi6sHNQUVqkDs+FN8er63PEzYhowducgtTJIpslvGUR95ztiP2f4KHr++/re5IT+IfWrplycwb6ZnV+lV48PYBcJvg+6zC24QKr87T8MWfSggQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773114047; c=relaxed/simple;
	bh=q3GLmGFiEnoiLMQqthpZyHVNEeXRy1ezR9xFUHto+h8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJTvqmGCeUkaOoiJ8cVOiY0aRnqYjEGMdjc4jkJit9D19Y75iVX7j65/oZ8OGPNHfyiOtDqYKFQ4dM7M2luqc78Q9nRwzm5LAfPCwJDOzGGiyIwAxVI1vdkq0jqb7Sc4lUTNg35RS0F3Dp29jyv02pYYnQGTXHtV9LB3cGmUwSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xPZaCJTb; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506a6cf8242so92076081cf.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 20:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773114046; cv=none;
        d=google.com; s=arc-20240605;
        b=F1EXwyi5wM18PZKqe3GSXpKZ0uN1UAvQ2DzcxUnPi9vqtyOMydYdnpP2+rJSvB+Rv9
         VeTfIseq8ZcfJ6LHDLqruRWI7xNh/BbHk1R08BrhpzsQ41XzncxxXS44OFCGPJ63JpIl
         tqfwSKcbv4DRBoZMjlz6oCHfRKLOPF27ZP0VyYO+0i5+b7Zc0sD+DgOZVLaaELe94Ez7
         5p/h5/bE2/xXbZg+Bpz7o4DlIpxUTX8dSMqjq/yLpR7O2uv7DNnO0ui3D2wF5+8HufY5
         HFHXLAYuF6IeKqBYNh4G4xxKau+N2FwQZbAvhty+FtcMstWSQgYz2i4UhjnfKH9OHU4l
         vtuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aq+74U2aKSX5+7csFtq9apolsu5h7SkJnqBW1PWfM7E=;
        fh=viqldx6YNyTi1IMhIp8ZqCGfGHLa7Iutr8B4/6ccfw0=;
        b=LMsp7b3qTgBEDFybECRcOOgdckU8zuwxK40PiMXtlBj3YrT8FClUDJd+QYf7EvFjyi
         DRUTiVO24tU6YEVDvmXMSmOS6B7mIYNv6fklizxD6PsSHsixqX2o9nYNZpwYE7loCFzd
         3ZA48VZgS7ZKO8ZqpsXu2HBZjBZbXmXx0UoygUzXNwLnq48ti/5tP8zfXilZ5z6FiVh3
         LCvZ92lG5BRJ3XOXPNNSFOMZLu+uoF0AXI5GHyvYeQMvmP3r1wrcltXo8HLqd15EdMhY
         sZT0lBUwH+2Y2k57Q+8Q5gWl90M3cE1a1eFVtRGJFZl1c+Rj6EBJZZsxgnF4Z2064Yy+
         QVsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773114046; x=1773718846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aq+74U2aKSX5+7csFtq9apolsu5h7SkJnqBW1PWfM7E=;
        b=xPZaCJTb6Cd/BaK0mUQYwASaK/29NvMTWBhe06VgREkJXzPD1auUx5OijH4aQL5nO6
         HXjPxLAWnKbSAK/sgx1rb7fto3Aaets8/Wrjqr2xy3D+yXZpRhmtW/ybbZgbOdNj8e9l
         EYAIP6cRkHRdU/mk0oZe88qLTITbwvdZ8pO9rZXXi0OoYWz002g4EB73sWRCdWlFoyt0
         j3sBPfdGe6zwLRCjLi1MduM2MZVPNmb3o5iMoJy4cPLXmf6jvz7k+fuQeF6SlSbup8kv
         pP4OCIybkD7BYaaaQpqDiwZbwQl1ye/JiWDtg+bUKluPwKhzpR5qNFgwMEoHZgkMM7qp
         /I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773114046; x=1773718846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aq+74U2aKSX5+7csFtq9apolsu5h7SkJnqBW1PWfM7E=;
        b=PUKKSEuD+kbqto85M5jtaSpq16UF9PX+GVOxn//MdZCLnQCnieadc6YAMP8qIcumxP
         m+U9W7HBoldUWHGkLQKeI2LeZpmSbtoZtfFxhZRvXL2VqfKzCgF8iJCHd8CUZcFhmd6p
         VF9j2VEtZ2qKKCViYylZw52+YeMtzDtP1AuYL2bxUJgWrlfqwOT/XFw3QgbkaZvaM2rW
         LDmFsdqpmmTcDudQ/wVzM3edGHhZK5TgUgcfVvu9T6sASJaFXn7kGBvaOCmr7v+NIJC8
         A3FOtVBsLh04NNswXshtrOSsDGlqDYgjFBcmljjPLWPsUSE96QIdbt/+I3wwppOkGYYE
         dfDg==
X-Forwarded-Encrypted: i=1; AJvYcCWGU5r3Pkehtl6Zm9zAOra0tzeN59XyLyJp8e5i/zSQDnaArtYDA0LXVgK3P8vhvnKqLtmjRQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YytS8txBm80hvYRq6UjMX2/WSY4UPGldYAjPPhg1stGtRgys07k
	q3uru/Nm2ULNt3Oq0CojS5kk1s/oZog5w790A2LTL5pKdxrn4ZNh/on6sV5TxiagbSKAtwwi6yN
	LzRItHSy7tSecxzmJkyymizfnbqI2At4++99192yj
X-Gm-Gg: ATEYQzyZMvyc0ef3vhdrjmh3Wb2OEyvPjSkwzQhIwykjNhhgmEBgX+8QOOp/opThOui
	exIp4//xGOL3XZyPlzC3+kN7iFXkDcrmENSnPzAugJ3EFeaeONdRmgqLVqSmpwYXqBpgflr/W4g
	UDaLaqGhTrLpV0c/PODuLm5vzkO9RSp78/WUZML5PhF7ecSLuCZmovKJ2Rbgr6yRxHiiWFfM9Li
	Beex/w+G1suWXgAJKxcZ1AATBR9yt/yvOM9PBNd8FPxJe18wtgFnvmzAFLgOFEXmM2ThoyRcOef
	ndWHE4AS
X-Received: by 2002:ac8:5845:0:b0:509:1c90:e186 with SMTP id
 d75a77b69052e-5091c90e8acmr60689611cf.73.1773114045191; Mon, 09 Mar 2026
 20:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310012604.145661-1-atwellwea@gmail.com> <sdyelt66tgfd55anansdmp3argjouxtpqlzumlwgcxher4i5ym@5z552zecejtz>
In-Reply-To: <sdyelt66tgfd55anansdmp3argjouxtpqlzumlwgcxher4i5ym@5z552zecejtz>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Mar 2026 04:40:34 +0100
X-Gm-Features: AaiRm51ZvLNjq2CnjyclwRmG8WS5KKT4ks1ZUODq11o18fczZuvUD7Mvz503Q88
Message-ID: <CANn89iKZ0Pw95W6V=DK8od-3gpO580yDvf7W5pUE9Gr6KWvVTA@mail.gmail.com>
Subject: Re: [PATCH] tcp: use WRITE_ONCE() for tsoffset in tcp_v6_connect()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Wesley Atwell <atwellwea@gmail.com>, ncardwell@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0BFDD244ECA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,davemloft.net,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-265887-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 4:20=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> On Mon, Mar 09, 2026 at 07:26:04PM +0800, Wesley Atwell wrote:
>
> You should use [PATCH net] instead of [PATCH] to indicate which tree
> this patch is intended for.
>

I saw the discrepancy while cooking

commit 165573e41f2f66ef98940cf65f838b2cb575d9d1    tcp: secure_seq:
add back ports to TS offset

For this reason, it is better to use net-next tree and avoid merge conflict=
s.

Note that TCP_TIMESTAMP getsockopt() is probably not used while
another thread is doing a connect(),
it is mostly used for TCP_REPAIR. No need for stable backports.

Reviewed-by: Eric Dumazet <edumazet@google.com>

