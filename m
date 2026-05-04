Return-Path: <netdev+bounces-283785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCy9D/py+GlCvAIAu9opvQ
	(envelope-from <netdev+bounces-283785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:20:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE714BB9F5
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 12:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35C0B3006152
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 10:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3983932E7;
	Mon,  4 May 2026 10:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6u1ClQq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD3637CD5A
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890040; cv=pass; b=Q6XcOwnhAFSyVcxpI7MiCMLnrA2+WmQUj8WR8u7lOf6cYV5xoCEE4ruNNV/zTk3g3JOOkHZr86nG3frU/gt8poRPCzz07PQzZ9FjAjSX+nFu/K+j4dnb20pDwxrJIZ9oQx9QJ/wRezWLkScDYPPjBDGIuRKWyMina96OL8rztsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890040; c=relaxed/simple;
	bh=MfUx8O+UJU7H19a1M/0pbiTS+C2mFZM6eyviGGoR26Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mny6Y3xrBwB944O6ae6APsU4t+W8TqZE9nl/eX0NKAM7BwLgcmVtj8hB966xP5pusWDPwOf9w3p5gtJdlTL8trCS06baEDGvAn2sb0G/Q/PCHmSCmdIoX3KiNAxtgaFjMBc+hpNQF3kJa0PNKuyH105o0rIINipx6BqEvd3/TDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C6u1ClQq; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50e614fdb42so34795021cf.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 03:20:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777890038; cv=none;
        d=google.com; s=arc-20240605;
        b=Y72/aVe+bLVoKjzPNby/gtPHhwMptUy3nqJmPwGD6AzAuX08qQC1RnIimJPnC1kk8h
         zZNSQjSPj3bso0xd9rUu7+4sZPh3tostpV+ckJB2XFp/HhBAC+HiIPAqMEulppU4m3FL
         Dn0VXcTXqYUKE49NKGJZoew/40/xxn9ZvwBlYSDTmyvZYai1EnTItd4TIEtKI9Q1YMp+
         cFifJFpIzyuJgefLtJ+XSltfefZ5eJDvEG5riuQLc1MnJNVmbu/IIwYTYZfk85IzVqX6
         TYKPDrDSqqz0sTv5jlNOa6reI5BB2jCrs+K6LSGf/mNXLPARL9P6Bpm3tovTfsig87rr
         FK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MfUx8O+UJU7H19a1M/0pbiTS+C2mFZM6eyviGGoR26Q=;
        fh=OxtIPfYs1vWr2Kcb5E8wKDJmvS4cW0F02czbkOdG3s8=;
        b=hoad9t86gPMeL8fmZu4oRg44qMDj170dPF8+W2mwSqx8LIwhYCrEgWiY252n5XTLdI
         +RYtY+SS8P91e9XKowEpyGAsWHUA8YvTHgPk8Qi9beZUg5bH5gKU7Lw5l5YIycyip1le
         F6ETlk5W3qoN0ejHE2hnrIznxC8Yko8wyFApFRxVq+R25P7mSW4Te0vfud3Ai5rd9xU1
         fWQB47eo2s5gOPAAWjo8y4Qm/L1ElNf2xqp9KjiXF/s4/QClEMGsfF9l3BjLC66/o5DF
         NoLR74KKJ0HHZzGxKMixTZg27/JzHk204x0MLJlVzbr4FMpHBMbCYTgJXJH9bioAGo6x
         mZ+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777890038; x=1778494838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfUx8O+UJU7H19a1M/0pbiTS+C2mFZM6eyviGGoR26Q=;
        b=C6u1ClQqyKv05dFhh5slg9kpX4YmrF4wzhw6BlU74r24USXlbFof92KplX43kMyuGO
         i+bLr3BSM6LoZFua6tVTwFYqFMzDD6MiuDUoprlqjHQyuoBIEBATV0BgwTH3TMtFKR21
         XPobpZdYiihbbYDLxbkwj+jBWwxDOQxYYjcv1iuK3rc6W9Gou4sk2p5sh/62/dBS7gWM
         IoDvvKIqA4wz46oM9NjW9glkSDGw3L269ypPV0UdamxaJS4gldvxV1Vd6KP2tr4x43vZ
         dM6V8XSFy9wVF1lrohUTgPkoXuA8b9ffOigpOtl5bsfw08SBmIWKpulMHXG+Bg9zZHbS
         /mPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777890038; x=1778494838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MfUx8O+UJU7H19a1M/0pbiTS+C2mFZM6eyviGGoR26Q=;
        b=WzmmmZoZ/1JlG6T/XfaLiRZVFSNX8oL3MqVwf6DudQoR7vyqlIyT2uYZb+6+Bs80ZA
         fHRIVhjpnPCZGGIUXKfiGo7Q00Tz2AieVUg16qf14IoY2cjfE/IVPXbOCLC0V5Kh7ZIc
         W5ItC5MKebhPNa7EGjqu/f09Rbuc1Dhp5JVq43Qpkkc9VDRIhqp7iMlGcmU/1q5tSLtI
         dJgkgMhXl3QJPYB5K9LwX4+1LzfYngz8lMu6QPyKbHFAblRsEgcsbzDUmT2QZmAvbYPp
         VgyofsAnJ1BTGkndTR7OctqZsLfeZ8+oBCep4Nij0zbTSTke8TfB61C1nw719xbB57EI
         1Vfg==
X-Forwarded-Encrypted: i=1; AFNElJ92sszcrrmKmMTJ7Xm9r4UvS0M6S/5MognOQj8uKfvsOe5rO7o8lioLMgZP7tpPHHd1pz37OMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRCiKc6YLN0tuzjnlqFNeb73sAcdChvvF2dizjrfyt8/kKo8ER
	QAo3wCqQiiTWVPtp9Ny0k0XirblXbQ26cNWt4cZ8vPhUhXRbuRkO8Nn+kV0k+IUfSe7z8x2jInw
	1O4eicpyd2v0ISGDbtQ/CiZ2+Yq2NEdNHDFf/Dl1Z
X-Gm-Gg: AeBDieuAjHUlL9bQU0egM2vPB4yFE+qSK4Z4Y5DwMpGS/XevO11r3QOT+bXEtVsa/24
	90tpBC5R5uDLq2kPMWhrIgni3YBIsyla8BDOe2nei0sxuO/nKjdI91sAHQmo52smGE6uNZBF2zz
	jQ3uODdwdN6dNTTxuyN93KQLsUVwVDp4u4LvDIH9TQaWwqucgmXdsQrtyE1DwthLLugbH6bylGi
	1YUhkg0tw7nfrnKgUtv2MmQoHmqW7EUAiVPfJbieTkHJmwhnSMLfgQaF93Mwzik8uMC0QDSkrkt
	12mTwafdhrZ8ov2Im47UoG/87HanNf85k49m0jm+MfAEygwcpYpHqUrcSm/lGxLzsQS54J2vqqd
	2RFWEVILXpHG5LoCLqKgzSvVrPCJ/SoQNa9LdKt4=
X-Received: by 2002:a05:622a:48a:b0:50d:9e8d:9837 with SMTP id
 d75a77b69052e-5104bde3d42mr132449261cf.11.1777890037093; Mon, 04 May 2026
 03:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-genlmsg-return-v1-1-093f3ba970af@google.com>
In-Reply-To: <20260504-genlmsg-return-v1-1-093f3ba970af@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 May 2026 03:20:25 -0700
X-Gm-Features: AVHnY4JAqJHgutygXt3jiWcIeaRCpoC_qoJeF5LM3Qr0Iq7cpk6l20wDwt9cLCQ
Message-ID: <CANn89iLkG7EMgmixYtOCBEFQQiBXy+-CdvTHx+EfpXF96GXyNQ@mail.gmail.com>
Subject: Re: [PATCH] genetlink: free the skb on 'group >= family->n_mcgrps'
To: Alice Ryhl <aliceryhl@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Matthew Maurer <mmaurer@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CDE714BB9F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283785-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:email]

On Mon, May 4, 2026 at 2:17=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> These methods generally consume ownership of the provided skb, so even
> if an error path is encountered, the skb is freed. This is because the
> very first thing they do after some initial setup is to unconditionally
> consume the skb via consume_skb(skb). Any subsequent errors lead to the
> core netlink layer freeing the skb.
>
> However, there is one check that occurs before ownership is passed,
> which is the check for the group index. So if this error condition is
> encountered, then the skb is leaked. This error condition is generally
> considered a violation of the netlink API, so it's not expected to occur
> under normal circumstances. For the same reason, no callers check for
> this error condition, and no callers need to be adjusted. However, we
> should still follow the same ownership semantics of the rest of the
> function. Thus, free the skb in this codepath.
>
> Assisted-by: Antigravity:gemini
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Suggested-by: Matthew Maurer <mmaurer@google.com>
> Link: https://lore.kernel.org/r/845b36ba-7b3a-41f2-acb2-b284f253e2ca@lunn=
.ch
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

1) This looks like a fix meant for net tree ?

2) We require a Fixes: tag for bug fixes.

For more details I highly recommend reading at least the tl;dr part of:

Documentation/process/maintainer-netdev.rst

Thank you.

