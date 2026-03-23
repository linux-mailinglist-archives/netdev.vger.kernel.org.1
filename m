Return-Path: <netdev+bounces-270733-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHXnBV+lwWknUQQAu9opvQ
	(envelope-from <netdev+bounces-270733-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:41:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 860732FD62B
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 21:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6197430027E3
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12E33D6465;
	Mon, 23 Mar 2026 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BizCNGN/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE53355F5C
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774298460; cv=pass; b=pxb5YUY4JMXpXKtiiY9bOSZaFH4noKy3VGaeg4ngRuunG/9Mq3k3oW7D8IqOeFZLW6qrViXnAY81ksIiQo2FYeTojB/xqVkJtInkKYSGzsBHvU4E1zyzI5F9acIJ/v9MJ0hz1tpl23Uh2PrgGstxxa3cRFK70KR2tH4KfK756xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774298460; c=relaxed/simple;
	bh=eZBXwrQRSic3gHDb4GCR7X+5H5R6pY/Nrn0M3MGc0T0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCLNZIaDgyEq07135PuRQUESvTEBaci6uqo4/jTDHKwgZkzmbP6w7G0vg/sbrj8Hhrk1Iy6jfqRVAfp8Nc8njcczyHRYh7lm5oss4prqQ2zkjhMpHLGx4o0tk5Po/fhqHG0P5oMRZtOvlLTDj1oJsdX943/DzCjVi2JRTDl3VPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BizCNGN/; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-509101189f4so4485991cf.1
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 13:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774298458; cv=none;
        d=google.com; s=arc-20240605;
        b=FDYieBSRgZ4muoGQxt2cXw46qDgtOcFa2ttlxRELj8f595J8xBfOI+cIgBKBjmIdBU
         rFTjWgNjHmv2pInYRgJjrAv3Z5EYVTJvIzVLRy5+VEUSZQwlfnledXe0a0PoSDyPOjKr
         THKQtx93qbeslwuHNyiGZosG/zShZYNOnS5zTk2PQ2Ex977zAHN+2R/PYqKdaPKorvZ3
         ah0j4EaGnaftUp3ric5cBqce6M+0wp3uxjLpj7DMs6RLOBJy8PJp0Sr2v6+4vTQNO5p6
         QampQxDWZjT8Fh1LHzEtADNN3qX/Go8WcdtvGldghqdAoUPUX5tYUwyYnsFAniOSdTUn
         GaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kSNotWZ+SwkuTuuXHPMhvObPWvQG0c+zHdDutLUptaM=;
        fh=p6Xg26wUB16j2GFsP6lWBi8cyS76IyCq84fyUjyGloU=;
        b=Yq0TPPkCQAiPFNU0kBxL+c9IWcTiJOrT2cqG88BTyXJrQeJlV9uHiTpF9oT3uh5Oz1
         f6I7Y0FLJiawmMSa9IdWpAqeTUY2idUtCWHFShwoZfZh+GsWSZPCol08BdDMWzqaq/OC
         BgcpfG4gXHcR7mmZmcf3HChJSz2x7NvC3SrQKaNXcSdXlvE9Qowrc3psK4aBRql1g6GD
         gcPpI5YhHOvyAktCwI2NXLj/DSyd9cV4K1BT6BxhAX646an+Gq9PYueYIen4VEPj/UIh
         hwHrcr6R91mcEcEwS7oGhioUaoI4AQ6NS0c5Y3e4x7bAEtNLrMTGwj0QnUSZVRfPmP60
         HTsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774298458; x=1774903258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSNotWZ+SwkuTuuXHPMhvObPWvQG0c+zHdDutLUptaM=;
        b=BizCNGN/mT6FannUqLWPjY3Y2BufsWAa2CDiOp7vo++cPg8ZqbU6pxTCwbXNG9MXKr
         Nemb4pOWth4MmK6gKL0Jta6kJjc2oACKXV+xBAMnxUAqFqpCQ6e9lfZxcdHFsS/aBnCx
         NBzyQmUKTZhAHPiO6CRTKckQY0TRVsQF9yV5BK/FhnhWLTEfMH/I/GfyTnNElrcz+fYN
         Gb6ZK1ABIzNmN82wcIzzVoV5I3+ng9/CxBYWQuolr6xtdUCbRRMgYhVL5jhOIf8m/YFm
         GsRomtdf+0lED2xwElQ6GlZfY2maYmcpMpMgBS6x6DmjpmH6B5URyvrn1IjR/icizUHV
         GgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774298458; x=1774903258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kSNotWZ+SwkuTuuXHPMhvObPWvQG0c+zHdDutLUptaM=;
        b=Q/4uzy+Mpg19csP5ATtaKRCrOZBy2a8zZ79wapd4P50t4LuDQ5YsRqR0jTw4B/KUP6
         wOd5blY2r2OMHdA+hOzEmgki7qpx87SAsqKADBEnkdICC/sLgknRUrUcHUHB2i7pTQTf
         NB6LEAPNYAC4EjYbj+JeGibN085EiYqtSVFjvMXVNcJrCDNtSGYv0FNL8X6LaJBlbmfF
         0f+h9V3Gi/nnFzXfEPL17dvAs8r/Du2Baadp5dYq7OrUxPAI0cp2mhVBOLgcPqHO12Zh
         LeK8256YDbApzE48JhcpqLSVSuoufkhSsiC/FUAVABwOd+UvIlHARk24tHCbMGff07eR
         tknA==
X-Forwarded-Encrypted: i=1; AJvYcCWh4KNzoq5JbBjoWHq5G7C1YO80Vhb2PgdP1kF6j9ove4/hEE3dJsRY5vZ5SgHU1ne5d9uDBSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylGSQvboLP/BCB2exiZk76n1wNJn8d1c7P+ixoszcwBYI5Zl5g
	61ybyoamZBz5ratG8Gj+D3BDSv6eojz6K8gQ7N0BrbrLg3Xba7s2z+Fy1AUOoC50FjXR2Rr6Zjf
	wetVFVpVa2X9q0mr6rafPUR4DnjBztxpSbEFjDgva
X-Gm-Gg: ATEYQzyMp+kSUIS4OCvZS1xz4XxQJkxAJsd0s7kKUvilZzEJFUWYr1wdHiiQWSvVXm1
	tJZy0zot5XAVnPS3AbXerGrlVmZl51qre7ZEmsZlMY2swm2kaKe54drUCIAl1N8r8cv9az3xrOX
	JjmPOsw8PnKPSozBNIIRROV9nf8EsBfdxU7ZiH8obZCnrhIA3A3+w/70XDbYchzLzehKQgRoNIT
	vK6QaedS9/mFDe1XeRzrzOb0LWhPUi9RrfSSHxxfAfFzGU6rc5dtqN4I+zrUCZlKWXuY7Y+Pu7U
	RlZZqdXXZqSQBaBr0csfu7cG4syrJHg/0Qs8wh93CL2Lwhf5
X-Received: by 2002:a05:622a:d5:b0:50b:4c03:7b88 with SMTP id
 d75a77b69052e-50b4c039511mr135028821cf.67.1774298457799; Mon, 23 Mar 2026
 13:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321105951.8314-1-kexinsun@smail.nju.edu.cn> <20260322052417.1216-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260322052417.1216-1-kexinsun@smail.nju.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Mar 2026 13:40:45 -0700
X-Gm-Features: AaiRm51mwvtVJjT5nWJqMVR2AKZID4_9qNCbvUT_vKgc0hEyC0F4skN_09AEos4
Message-ID: <CANn89i+6u4QS4CZjky2Dh3m9qN=AgraNf0M-qB0DXsem0Gvfkg@mail.gmail.com>
Subject: Re: [PATCH v2] tcp: update outdated comment for removed _decode_session6()
To: Kexin Sun <kexinsun@smail.nju.edu.cn>, Florian Westphal <fw@strlen.de>
Cc: ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@inria.fr, 
	xutong.ma@inria.fr, yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270733-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,nju.edu.cn:email]
X-Rspamd-Queue-Id: 860732FD62B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 10:24=E2=80=AFPM Kexin Sun <kexinsun@smail.nju.edu.=
cn> wrote:
>
> The comment in tcp_v6_fill_cb() states that the memmove of
> IP6CB into TCP_SKB_CB must be done after xfrm6_policy_check()
> because _decode_session6() uses IP6CB().
>
> This ordering constraint was introduced by commit 2dc49d1680b5
> ("tcp6: don't move IP6CB before xfrm6_policy_check()") and was
> valid at the time.  However, commit 7a0207094f1b ("xfrm: policy:
> replace session decode with flow dissector") replaced the
> per-family decode_session callbacks with the flow dissector,
> which parses packet headers directly without accessing IP6CB().
>
> Since xfrm6_policy_check() no longer reads IP6CB() anywhere in
> its call chain, the ordering constraint no longer applies.
> Simplify the comment to describe only what the memmove and
> barrier() actually do.

Adding Florian to this thread.

So... the real question is :

Do we still need to call tcp_v6_fill_cb() from 4 different points,
and having this dance with tcp_v6_restore_cb() ?

Otherwise I see no real value in rephrasing a comment...

