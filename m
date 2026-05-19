Return-Path: <netdev+bounces-289456-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG4uLwleDGq5gQUAu9opvQ
	(envelope-from <netdev+bounces-289456-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:56:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6444557F22E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A016F30B6259
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6784EA362;
	Tue, 19 May 2026 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9jLI4eo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com [209.85.208.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B78E4A13B4
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194985; cv=pass; b=hGrFyuTmupe9m1jIhpu9Tw7fvA4vBaGEeRfGmp9RvQzP+fG0pQmh0V0tYI9WqXPMGArs9eh3si4IZjOUTl5E7ukC26kGKY5rRPYkoG82Zar492i4Pj5oHawIR32OKEGARysF4HDF5VLaNyZu8GZc1oMs0X69GxOTbNjuw2wS/+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194985; c=relaxed/simple;
	bh=jfPV2780Bs9BUkpIrmBKLD8IB9nmDhWvo+NzhoVNkFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNdZEWKqD7HNyyHQCMaVh2PbmKCCP71P7ORm6Gb4pAUACknq+kWDlF1n9g50k7A6mLJ5x6JHiZV+n34fpRkDw1/x6Dg92VHrkNi+XkwcR7tTweGqZybpiMHmFlC88Vjue8DMJlvZHZ0BbIr75slakHCF9vB0cga6SiCh/WkGsls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9jLI4eo; arc=pass smtp.client-ip=209.85.208.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f193.google.com with SMTP id 38308e7fff4ca-393c40246afso42654991fa.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 05:49:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779194982; cv=none;
        d=google.com; s=arc-20240605;
        b=GL8ortpei0q1ygz7MpQKuY0+Yol0W6f6riVNGgTNjzAkieA9EjekfA1unNBsTcmvQ7
         iLfoFSViHncKdIqezx6RMv5b2fhAkd3bi5PL02hjDiN6HSGzqRSC3oIHW3WRq6G/1VCK
         wlDi8def/5jWKWdOlJrLhk+FRyvsQK7iKFgjKfU3AlYI608pluM91JIWUXx92GnrNf2Q
         U09+Q1rn2uhVZVBpZlNshRV3O/GvqBc7aVT4jpwuOSZMiL4yaxU9/zxkRQQ0stz9mMT1
         e4tubxvqlEJlehGg/kYb4hwxkD2/HslSoApEdDPQ08BK75WJJFOqRiJ0J47ye41tyBo5
         Wl9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TptvFrw7YTp9kcu5BiXjspbxBVKusRMLEntVA9ShJ50=;
        fh=/Z81PkbWfONHCk/l4apgZYpysXRIevr//oJ8aqSU2qk=;
        b=AW+h6RLwusWf4BxZOakRWmlBZ5rsK17mqHuzzNgr9qzzESIog3/3D7nM3DnYjP+NvD
         L1h9eJfF/L5UvQFeu4ilgjOsjruy/2wgmMvGMobE9IdJ1iyiRRduKnb5y+O/fS/6wcOj
         SvxPgR4ztDH7J/LYZ9M1M8bQrdqAJUYXPJaKR5fKLFrDUNIwok03CB1Z4mDvdSHUfy7u
         MqBpg7VJ4PDTMOiK8tLN+OmIj8QMF80s6WEtOvBDP/JD+PONQ9OvSoST7sMBIUaR1aKA
         QURb0F1qpn1JDEPzAGL4N/Fg7kGgZeMDuj58RT1+9bmnQ4891jVAxmSgqx10aoNMWkSn
         NhZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779194982; x=1779799782; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TptvFrw7YTp9kcu5BiXjspbxBVKusRMLEntVA9ShJ50=;
        b=N9jLI4eo2vECRRoJjR0+xJiwcHFgpCD7gK2ufIuWiULajhYT4zFgikiZ0qzUnJ17mw
         3Kcg8i7wI9c5VBuSiN13PdFTM4OlmVcglvFiJZSd28HuGe6xrMTMr9pl9kQ5/SPnaffr
         a8SOdSzCsVdWgs8ex8529WHQ/kQdCL1L+/Ty98iNgH1fsWoIjObCZ+XqZEaMExjNQnt/
         iwH23AHFfK9+jPKVT4CxT5P2yM64PidlPio0Jw2Kti+1koR3PHhJLYhnEBMm9RstNcn3
         9KzoOKg2BFohCnmcPUt4wnVQz3HH+OmEo2t9JTOATgKfNantgdqs/O2JevFPqbl6NlGj
         pLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779194982; x=1779799782;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TptvFrw7YTp9kcu5BiXjspbxBVKusRMLEntVA9ShJ50=;
        b=q8VKYHv6c52puIYaYMThxZBKojNd78/VxhMftwOCBPVoVKBvqDMEaYrvSUKpWNra0o
         OFBkA0GwO5fzT4Cn37Q5+U4t2MAdshDfXKsJJtu5nx+J4bfOyBjhFvCnu9HT2LzLPP9Y
         RhiTr9Lcn6vw3vQDDOJFAXKtg9XDX/0DTdEWI02PkTwKlxvsdYkWkerhHz5tnPdagKCV
         0i2pKmFq/Awh9khQc74nMF34B1xEmMcUfm0IEAEsiI7BOorSnu0gSJvFe6AOtZAGw6pQ
         gogJd8a+b2A2pczHM/Gc7NkmXHloKDPay9tZOpOOFzbfeQjONWXaWzswJD+ybxZuim+7
         ADbw==
X-Forwarded-Encrypted: i=1; AFNElJ9iqjwL74uL20GUEAFFbTnPdcUz44ZTlP0BWebOxuU+y76u8PQl00V4ycqXNCOfJI/TdC1+ZaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWwrtxEhjP7HpWdxTX8nEupJpIvp4sH9Zq44lFs8ngugwQkKH0
	De1t82fqQqKueiG0vu8KttXLVqFeaH7+ehUJ1rqjpr+CsODCzy2O+pJYWnTs6v5EOehTN6f13l7
	wN8ESkv7JIayJvWlwTcOrckVo11StElQ=
X-Gm-Gg: Acq92OHhasQM9bcGYoGyZUV6hhgbAzQE2NEgHDuBHtRZB4AECppsKdPARAVPkv3yyVq
	LXyOYGLqKK9JxBnjrbMONfYyb3WhKZ5Ydf0BWmlt+1kMlQRxzSzuzUHhC5Poy3b1A2UQhYy4XwU
	dBXUTOdDsZb0c3BSToEWFDc5eFunQfz+qXegVagESiucZDuQc7MfYDwNIpoIHaUnGiIq1hPt5jf
	ZHkMso9tB8uY1rhYqhKUaiW/yFFxCWxcNHH3cxaGMXE+djOfRU3toJ3dFOcir4GE9cDKNvRAksa
	WZXwLdvpyvZO5mUepLEgqTXb+Y6G8g==
X-Received: by 2002:a05:651c:515:b0:393:cb61:1808 with SMTP id
 38308e7fff4ca-39561d2b1a2mr54005981fa.24.1779194982145; Tue, 19 May 2026
 05:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517121626.406516-1-rollkingzzc@gmail.com> <rclmtymkiaor247n7gwi6ggmpwi2hyu5hicggroopeohspfnyv@7ryrgezzs63q>
In-Reply-To: <rclmtymkiaor247n7gwi6ggmpwi2hyu5hicggroopeohspfnyv@7ryrgezzs63q>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Tue, 19 May 2026 20:49:30 +0800
X-Gm-Features: AVHnY4KBYOwaqhirihEC-ocC8POXVpSAtu8Xd7aeNb3NGD8F1HYlRbpjjVodKoI
Message-ID: <CAB7XQsGe8ZA_WRYcGgkOa--f+XdB6d98_g4VedbFPK01eH0rBw@mail.gmail.com>
Subject: Re: [PATCH v2] bpf, sockmap: keep sk_msg copy state in sync
To: John Fastabend <john.fastabend@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zerocling0077@gmail.com, 2045gemini@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289456-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rollkingzzc@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,cloudflare.com,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6444557F22E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi John,

Thanks a lot for the review.

On Tue, May 19, 2026 at 05:32:00AM +0000, John Fastabend wrote:

> Important note here on where this actually happens. It will only
> effect users of BPF programs that are making the push/pop/..
> calls. So most/all users should not be impacted. Agree though lets
> fix this.

Thanks, that makes sense. We will make the impact scope clearer in the
next version.

> To make this easier to read I think having a,
>
> static void sk_msg_clear_elem_copy(struct sk_msg *msg, u32 i, bool copy)
> {
> __clear_bit(i, msg->sg.copy);
> }
>
> is nice to have. Otherwise we get lots of
>
> ```
> sk_msg_clear_elem_copy(..., false)
> ```
>
> Or just direclty call __clear_bit() is also cleaner.
> This is sk_msg_sg_move()?

Agreed. We will clean this up in v3, either by directly clearing the bit
where appropriate or by using a small helper if that makes the move logic
clearer.

> I think we need another fix here,
>
> ```
>            rsge.offset += start - offset;
> ```
>
> Probably carry in another patch. I can do it if you want?
> sk_msg_sg_move()?
>
> I think this is good with small cleanup. The bot report (need to check
> again), but I think it was calling out another issue with a different
> fix/patch needed.
>
> Do you want to follow up with the other couple addons or should I?
>
> Also please add a test for this so we capture it in selftests.

We would like to follow up with a patch series to address this and the
related fixes. We will also do our best to add a selftest for this. We are
not very familiar with the BPF selftest infrastructure yet, but we will
do our best to follow the existing tests.

Thanks again for the guidance.

Thanks,
Zhang Cen

