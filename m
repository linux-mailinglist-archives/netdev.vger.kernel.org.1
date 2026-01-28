Return-Path: <netdev+bounces-254272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPyrH7wWemlS2QEAu9opvQ
	(envelope-from <netdev+bounces-254272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:01:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D10A26A3
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4675C3004939
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B4C219303;
	Wed, 28 Jan 2026 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OXv8lvup"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B540221F06
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608889; cv=pass; b=rJEg6XyctYkaG7bswSIVcFZcd/A+fCY/wn+d8WLUSUiGRNUVv5S6lY/ebfEqL6s8kMwzTkcqu7NfgA5bTSSMBF6NNhqXUJs3dP/cvDI3lwopHN4iCd6BHE9xsz8qkvNRFrp5ecZTpi+2f5kiyl+DMa1qeODZi8LdEBTGUEKO70w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608889; c=relaxed/simple;
	bh=H7z8j6o5Nmr2FL63yiXwxYVIrezSwaaMXJMmSAwN0+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scPaZYcyJ55naUPwPNv7DCH+9gqbrx/Em7s9LENS53IPHCUCnKbvE+uKXj7v95i52HM1ZpM1TUBLqfZRt0pGOzyEUCDMKnRIC+Y5+vSt+LFDwV5UTL7nc0cHlA8O7/04XngHOIPTUDuyFNq83LREpqar/8jvZ8r+h05TxTak/Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OXv8lvup; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-89461ccc46eso117690096d6.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 06:01:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769608887; cv=none;
        d=google.com; s=arc-20240605;
        b=Aqowv1qHgp6mXyGA7JpDbPh83J5hL3K99Pt495dyb+GVjxpPGsiDujclvE3QpNKlxE
         88tLmh5Cyfzvcq/UpwBDl01+JJJKy9nJ2S15/YjYnSOtCOTe8XXM8ZMaIVznz1xBZn1Q
         zxUJGFYbuOaH/YO/w7sfVBD+AJHLqj5KJHlXGKuGoH6fu2f6fsJcoEwKi4C2wT4F4LEt
         6rnoEGIOssvHqkLXU7lNmq6yTkPbb20Dg9Ia9cNRouP+qZdT28wDGN6TTTMC2+fsCsKN
         TaHFzpJ9zwFtDrA5F65z7DYXxRGsNcwLDYLkY9msNkGwzEAphzVHIy34tK+kjz9htI/G
         1NDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N6L5hcSI3XBBd6lYV7gjsb5kWjjN9hWWalHKMad3KQ0=;
        fh=zQLqiYioY5Onrrih7g6byyrI9W3EO2sqXBvND63vsS0=;
        b=heYBIocyShWKe+2zvmfVgptvxsHMPJOjfRMlxlpmEDfqb+ms+3iT3I0aDUYyz6W9A7
         0xhGO2OmBF+ZxkBaiCOM1j/khDiQGZK7FilXaPVejJ1yZhIJj3BXb2cFwUzYH20MfXi3
         VfqekPCJZ0tYnpo7phEzFeCa6P/oH9ovw69EMW82qzrxpK726vlNIocbfIp9ZpIz4chK
         NSZL1+E2tjGGZJ14raebWJJixe/PdtKO32pWBfbtBoG2/ymKy/Zypxt3XJehr9Zh2a5c
         /oMyQ4MUaQ0VRJET/Ov363TQJzkpHrP3YaoeqLpsWaMcrIl1IJjTp3l/Fh1c74NHYZP+
         oUNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769608887; x=1770213687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6L5hcSI3XBBd6lYV7gjsb5kWjjN9hWWalHKMad3KQ0=;
        b=OXv8lvupnRDbDQzJuuYblMFAsTH+GVva4JCDdQgvLev4akxLG8nqJ+ei4/GEGnqpVq
         zqJsswv+R2V5EsUPa+Kbw3HQg/oq1JyMcLWEkXWZRN5IHlUn/uT9mEdd+AM52BUY3uKx
         fJCSCBBveVCy+RO2nRfItdGo9OBwgdpCnaMQKd3dz+LZOxS3RGCkEwGIazUuJ8xgWSvi
         UVbDewFmpUIql4eG90zP7dkfEexEt0zXaFuJ0rmb0i7ilNMMaSiom7Zi6ZUj6uJhIPb2
         R8LFn6r94pM8pWcop1Huc7OovQlonC9n+KDYmB4VTSPhpRFrw0Sb0ee0vlbkqWxnM2eG
         Awmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769608887; x=1770213687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N6L5hcSI3XBBd6lYV7gjsb5kWjjN9hWWalHKMad3KQ0=;
        b=WYY5U/8vkOaH0DDwK2XopCLqFf0A5VC44Y0RkVwREpMkDmntuIU7YCvuBK0lgiNTxp
         9rbN/f7wsOu5CBS700uSAMqpwFtn0ppIb+ZgPzicC5ZpBMPWCiqcTrgdO2Y6SEyNmQST
         iu1ZvZo75EiHkN1NR4gdgLa1ha2P0syNiJ7koidRK05UQdpZKxYqxavAqLU+2g/jAs+f
         uL4qzq9Fp/QG9OSk0ns4LP5LbZzjH1QkW9hMlO16g8o4D/k2ZLIw068zJ+IWQReqSPQZ
         EWh6mKD8fp2WmMzW0q1TDmud8QEEZa07If0Lm6oww6SkcsOSp5e36lQUTnCmoMsOZsDv
         kDeA==
X-Forwarded-Encrypted: i=1; AJvYcCX56pEC2CsHSS9TvM6eWiH+Dt1A56Qkn9RGzvPNiIie8DEgG85OB/DBCU0u7BaomWeNqsAzqtU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtcd7Po4EsCWXG9OTabVoi7ZyqdqJG29Z5Z6IMc+WArAgolo3b
	v9C0EpRSg6d188jNMThN35WxjnRIH+YFKD7UxhqHhWoXlt4/cdlTY7mLtvy+SFn3His4MuQh1pa
	VOJBZditOeJaKZg9Z7wt6vixtT/DEQsb2VR+R2nfV
X-Gm-Gg: AZuq6aKR/gSKfI+pnXQ5fm8fNRlPrlnJJKDx0Ra91c7bVVEx7uMmoVHrO+NgIlDcCbd
	PS00XvRHraBsdnEcPZHsF2YKcG2CUbH6XRJXLjl9qfbArgmd/pY+uMVdRCakfWC2vS0KpD/Ptz5
	/kjf8/lHeXznjpNsQfmPf9IvXVpBHedvFZ3AGYv5N9ZUYV9bp7iMOLJ16erIF6s4u3/ttBURuTZ
	sD535Eyxe7vTFKYsQMf/DLvq4yR59Os6Ifj2mUlTRyLBfdA4JfF5vP/QZ/7lghMcpoi7w==
X-Received: by 2002:ac8:7f55:0:b0:501:4cd0:a486 with SMTP id
 d75a77b69052e-5032f8f3d3amr69727581cf.54.1769608885150; Wed, 28 Jan 2026
 06:01:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127144433.196836-2-edumazet@google.com> <20260128025556.4169217-1-kuba@kernel.org>
In-Reply-To: <20260128025556.4169217-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 28 Jan 2026 15:01:13 +0100
X-Gm-Features: AZwV_QgoUUMQuMFp5Jt_bp1NYh-ndfG06OmuabUin03w1gYxrWHzNEWp5QjGRVk
Message-ID: <CANn89i+W13kkNwpW6YPeZswf_WJR4g_TMGS_27cU2fHS8KKG-w@mail.gmail.com>
Subject: Re: [net,1/2] net: add skb_header_pointer_careful() helper
To: Jakub Kicinski <kuba@kernel.org>
Cc: horms@kernel.org, jhs@mojatatu.com, davem@davemloft.net, jiri@resnulli.us, 
	km.kim1503@gmail.com, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	eric.dumazet@gmail.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,davemloft.net,resnulli.us,gmail.com,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-254272-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 83D10A26A3
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 3:56=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> net: add skb_header_pointer_careful() helper
>
> This patch adds a new helper to validate negative offsets before calling
> skb_header_pointer().  The commit message states that negative offsets
> are supported "as long as the zone starts between skb->head and
> skb->data."
>
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 86737076101d..72679aa7af58 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -4301,6 +4301,18 @@ skb_header_pointer(const struct sk_buff *skb, in=
t offset, int len, void *buffer)
> >                                   skb_headlen(skb), buffer);
> >  }
> >
> > +/* Variant of skb_header_pointer() where @offset is user-controlled
> > + * and potentially negative.
> > + */
> > +static inline void * __must_check
> > +skb_header_pointer_careful(const struct sk_buff *skb, int offset,
> > +                        int len, void *buffer)
> > +{
> > +     if (unlikely(offset < 0 && -offset > skb_headlen(skb)))
> > +             return NULL;
>
> Should this check use skb_headroom() instead of skb_headlen()?
>
> The commit message says negative offsets should be valid when the zone
> is "between skb->head and skb->data" - that describes the headroom, not
> the headlen.  For a negative offset, skb_header_pointer() returns
> skb->data + offset, which points into the headroom area.
>
> skb_headlen() returns the linear data length after skb->data (skb->len
> minus skb->data_len), while skb_headroom() returns the space before
> skb->data (skb->data minus skb->head).
>
> These values are quite different in practice - headroom is typically
> small (2-128 bytes), while headlen can be up to MTU size (~1500 bytes).
> With the current check, an offset like -100 would pass validation when
> skb_headlen is 1500, but could read before skb->head if skb_headroom is
> only 2 bytes.
>
> The existing offset_valid() function in net/sched/act_pedit.c uses
> skb_headroom() for this same type of check:
>
>     if  (offset < 0 && -offset > skb_headroom(skb))
>         return false;
>
> > +     return skb_header_pointer(skb, offset, len, buffer);
> > +}

Yes, of course, silly error on my side.

