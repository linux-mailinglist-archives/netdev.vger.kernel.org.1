Return-Path: <netdev+bounces-279956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cISWHxq85mkW0QEAu9opvQ
	(envelope-from <netdev+bounces-279956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 01:51:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B64E4434FBC
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 01:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ADBD7300D73B
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 23:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75ADE39EF2A;
	Mon, 20 Apr 2026 23:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa2fjAQ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C9C30FC36
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776729110; cv=pass; b=ReIOCnYgu2mx4uhI9XNfxie8SjyZ077L2kz6otbUyZoJ7mQ1BSBrgkeTbjNFGloVpiTMfMKLHIirFk8pQMT42OcW9iyBsvoElhaqc0l+Guu5V+mFGyf3HEUXXT9H65w4LL6pvSdsTyU2ll36GHkFd4DNg/NRV7agBTBVP6HLFuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776729110; c=relaxed/simple;
	bh=s9fEB4HcPUF02NL65VFRpx5OJumcFk5Y0bPMUsQ9WUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQmSqlAaKX3ya8L3nxNMnSs8A7elUU214NAOuWHGrZlLGN/L1vNB6P+hKrOUTCjm7LP4JgFmgukm+UZDzEH7soYT7TnbIqYTUyat5QvmFCC1S91q4XasyGo74b2aR1KZGHuZHI7rvy7H6x9UNzpjZv9tdgoMDnKSAfZdWCxr2jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa2fjAQ+; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a415fd6bceso4007221e87.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 16:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776729107; cv=none;
        d=google.com; s=arc-20240605;
        b=ca2VKV5VUkl8gJ+H4oo0GLdoM2ftguAF8GS5VpGzeR9zQUYk0z0KVqr3ejmzmXGiH8
         IfO/Al2imwvfYyjro7U/ToQklt+eG0BN3dG1DhMIGzQafadvO2bymNlEURftDA68HHBw
         OQApdDN/LqdcETWQW9jINxqH5DQQa8AD1iQfN7BonJsrd3IzgbOlVjZ5ypsB2Y/wkIP2
         YEr8q+YB91fYLnOeW9NoYvXwRnxI0heq+PF8CQjYvI9dgxBqSNQ15LFYuK21Bj6mdMlW
         CYgtgkfjqDj2Cq/RL9Mpx6bWFFXMgMXoxfJ4Urp6rMGTKImtBx+UHshtAXFEel0fL+FH
         cggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oDo36uCMCaHt5ZmgnJMJ4TzVZMj5UW2xL0ZAxqW8dlY=;
        fh=IGjsuWx3DRM/2T/F0pdhlbAmS5LIDatknvV+p/muxVI=;
        b=XELenV6Vh5rkldiKGZEydEjJF1ME4lCuFcv5+Aap5aLGRqg3Q5C4bmXIHNQ9vr6yYr
         0OLrst87Uvt3lsh8Rs6Htjbe4MRyt1ZiDo3GEYzdILAy/f2dj4dk/HQMmsSBrZv2Y0Eu
         XWApGkvCOPZhZaQZ8R0SSOkSOpHT9+5JtXiViR8+BiRoTrGeZq70VtVLMSQpQTqIXi/3
         3VCn1b0q07jGee75K9QIMytyHmXVfWGsvISYBgiWDRB9HvHBOlh1ghSpQhkKuRqPzyNU
         GaSv3SYptwQWh4MssKcVWX5CSto25KNmNaxtCts84bz05jGc+JFJlInFc1ekGqFZ13qT
         M32A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776729107; x=1777333907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDo36uCMCaHt5ZmgnJMJ4TzVZMj5UW2xL0ZAxqW8dlY=;
        b=Aa2fjAQ+F2vq0LLiojaiMi/J4n62t2MjPZFtYkAxZpwkONbqnjH8KzgIn6WBkJBayW
         CkoHP2ASmQILpL1vtkmh+Hr7IX1Ao+Ak+omfyK42smPoCK71Z1M/axWD0c8fOVyN1kVW
         ZSWJXBm8juWnjfT7kpwxZ4P4RIQDGLEhvkYDkN99yHCWN278+626CHklTRsRs7PG+ecj
         f7/77nZeVm6qxtwvdOBXngXbTpM7UN7eq5rXjQCpTd7rhKxH9V/uuRI2xp+9apaJ5w98
         cWUBNpc07nwXvZktctLxPhyp71YZmLfZSNrxLs1Qp6eLtc+XH0Nm5eY3U6lzS6lCP/7c
         AH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776729107; x=1777333907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDo36uCMCaHt5ZmgnJMJ4TzVZMj5UW2xL0ZAxqW8dlY=;
        b=FQKCoCyGKlQKj70+72x8FEIi+YhrKkAHxiEMAOdwBaTtrl3hgECmaHmPWExSRnrVtj
         yERmfNiydF7kk/ZRkEbHza3dat4YmK7PLpWvIX7GjFpav6O1zZUIGOiIC38FculFfW5t
         xwExLySVGg0reXdHLpOt8voxRKQTA6FTcgwcg+whwG/jplttyJdjc7fgrT98bppOmp++
         KoN0XKr6MlHnQipq7Tty5+qPdciyH8eY6iQh+lJhCaWa6j51KgsATqAPO8uTSW8axLMI
         eY59b7E+P13f+cmlMd1rwAGRE4JYJ7g6XaZmox5EJFRzfBgQAdvac18EIy1nKNbLAfQM
         ER7A==
X-Forwarded-Encrypted: i=1; AFNElJ/uodJl1zp8oHBYUYHH7dRYCWIbVRvU7yGUVPKg3HGrOaJVG58oHMV3ceQ3z5vUqUmnofItRfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvB9nL5qpMWPO7Xq8HKLIdC+ItKnV1EBMlp7bjclsl4EfRrTST
	iS0ULTgm2GZfZBx1BeZuq0U+hiQDjDMdhcyiKj4fA92LThhqq/v6/GYfbdhrsOF5Rt8CczHvlch
	rq4qsFLNPohYTMeUzLydoFM7Sz+WcpSs=
X-Gm-Gg: AeBDiesvBbZFZJGxpFDd76DkTvRJ8YgDdqcKCb8o3hZeQ2QpV3dX4dwfc74le1S0MaJ
	yQLnr3rS44CwcRzSKqhWj+7BvPOTR3rNbRuJHNuw5KAQWvVezVr5BzEeUceJBCdXKRtHpOToOnR
	7KBylzSdEhRIQ/XCHzbNytXRdj6u+LWgLH40zPa9VCUju/oqNgFYgtEqkQDN47knUCwmXuBacFe
	7xWARQ58NMsNbNsZ5WV/TkwXXiDMgakAu3GQ1qJpKGVRsazPBKWzR8kiMKJVivobPm5f1qGCeN2
	N6fu4lrBoCp05SqR9A==
X-Received: by 2002:a05:6512:39c8:b0:5a2:b259:5569 with SMTP id
 2adb3069b0e04-5a4172a2e01mr4324041e87.15.1776729106838; Mon, 20 Apr 2026
 16:51:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420082805.14844-2-kerneljasonxing@gmail.com> <e4a22d20c77e94657d63243af39a0667.sdf.kernel@gmail.com>
In-Reply-To: <e4a22d20c77e94657d63243af39a0667.sdf.kernel@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Apr 2026 07:51:08 +0800
X-Gm-Features: AQROBzDt6xk7X7rL1lu7M5J437t_MiicWLglq5dSczkZIyjL9h6pxEYDUZ4AwYg
Message-ID: <CAL+tcoCwEeOriG3y-EZm6TfDenr3uCEDXUJ8MtrW9x=Jx40ohQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/8] xsk: reject sw-csum UMEM binding to
 IFF_TX_SKB_NO_LINEAR devices
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279956-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: B64E4434FBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 3:34=E2=80=AFAM Stanislav Fomichev <sdf.kernel@gmai=
l.com> wrote:
>
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > skb_checksum_help() is a common helper that writes the folded
> > 16-bit checksum back via skb->data + csum_start + csum_offset,
> > i.e. it relies on the skb's linear head and fails (with WARN_ONCE
> > and -EINVAL) when skb_headlen() is 0.
> >
> > AF_XDP generic xmit takes two very different paths depending on the
> > netdev. Drivers that advertise IFF_TX_SKB_NO_LINEAR (e.g. virtio_net)
> > skip the "copy payload into a linear head" step on purpose as a
> > performance optimisation: xsk_build_skb_zerocopy() only attaches UMEM
> > pages as frags and never calls skb_put(), so skb_headlen() stays 0
> > for the whole skb. For these skbs there is simply no linear area for
> > skb_checksum_help() to write the csum into - the sw-csum fallback is
> > structurally inapplicable.
> >
> > The patch tries to catch this and reject the combination with error at
> > setup time. Rejecting at bind() converts this silent per-packet failure
> > into a synchronous, actionable -EOPNOTSUPP at setup time. HW csum and
> > launch_time metadata on IFF_TX_SKB_NO_LINEAR drivers are unaffected
> > because they do not call skb_checksum_help().
> >
> > Without the patch, every descriptor carrying 'XDP_TX_METADATA |
> > XDP_TXMD_FLAGS_CHECKSUM' produces:
> > 1) a WARN_ONCE "offset (N) >=3D skb_headlen() (0)" from skb_checksum_he=
lp(),
> > 2) sendmsg() returning -EINVAL without consuming the descriptor
> >    (invalid_descs is not incremented),
> > 3) a wedged TX ring: __xsk_generic_xmit() does not advance the
> >     consumer on non-EOVERFLOW errors, so the next sendmsg() re-reads
> >     the same descriptor and re-hits the same WARN until the socket
> >     is closed.
> >
> > Closes: https://lore.kernel.org/all/20260419045822.843BFC2BCAF@smtp.ker=
nel.org/#t
> > Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate=
 function")
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/xdp/xsk_buff_pool.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > index 37b7a68b89b3..c2521b6547e3 100644
> > --- a/net/xdp/xsk_buff_pool.c
> > +++ b/net/xdp/xsk_buff_pool.c
> > @@ -169,6 +169,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> >       if (force_zc && force_copy)
> >               return -EINVAL;
> >
> > +     if (pool->tx_sw_csum && (netdev->priv_flags & IFF_TX_SKB_NO_LINEA=
R))
> > +             return -EOPNOTSUPP;
> > +
> >       if (xsk_get_pool_from_qid(netdev, queue_id))
> >               return -EBUSY;
> >
> > --
> > 2.41.3
> >
>
> Wondering whether a better fixes tag is commit 11614723af26 ("xsk: Add op=
tion
> to calculate TX checksum in SW")?
>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Thanks for the check. But not really. It is the commit 30c3055f9c0d
that brings the csum support of IFF_TX_SKB_NO_LINEAR case where this
issue can be triggered (because this mode no longer puts data into skb
linear area).

Thanks,
Jason

