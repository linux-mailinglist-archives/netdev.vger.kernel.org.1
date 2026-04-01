Return-Path: <netdev+bounces-274262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN1TMs+MzWlfewYAu9opvQ
	(envelope-from <netdev+bounces-274262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 23:23:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA6D380957
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 23:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 098DB3019632
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 21:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57ADB37C101;
	Wed,  1 Apr 2026 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="a7XtP6CY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBCD37C0ED
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775078603; cv=pass; b=Itokm+mePbVztlBR1Z9M+OdGCb4zFcHez0CVXRSHTYbfaL3pJ8ILud9yBoZnQt5WLJQ1/9BBrxM3h0KsfDpftxjjk0ARjleoY5qdvikT3NH8GZkcfZbuvdMK4sR5UqXcwZocPAUtxllb9hAP+hse5WpiGY5sa5CU+/BLFG3OgLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775078603; c=relaxed/simple;
	bh=22PzYe4g+q67LhAXGP8TetwrwN45cW7JKmWdgg88E+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=scFfzMVJM8E03E+4/oG5AoGTTjfPvlGCZJ4XnqqY6Ncpiqqas0dmzUuy3Y8HB45qbXvFVd9RqvDUyuDx/ExZvuZzylRwqEQzoWZkTVtQ7E0aUcjxlmExXZCyTWlUy7HZ03dSXhsELi+9qohwkk1ogwiSpUbC3Y7/2VX30MWi1YY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=a7XtP6CY; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b0afa0210bso720235ad.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 14:23:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775078600; cv=none;
        d=google.com; s=arc-20240605;
        b=cB0IvjxT7To/xKJZpbeqReKwqdE3Yd/9DKPzMSMLWRy3VHx36VBf6z9n2Q4I+l2xTi
         B14DzeQHUdDCzMvLZkIa/pdU4YHTfBtq0RAk5MFwXiPq6On5xMf3qYcvv1T4uU7sH/RG
         x/XBqTC9pQ7gLCjTy1Un45K+d3/Plq4FhaOl4LxCWQmTXlAXH1A8LeeslcPEIEk27cR3
         7pS6LwrJO9vfdUow3PfmHIp5UdutG0ZXt6yQqiqJpSYPRmwCd9wmWv4M8fjAOB071LsA
         PZki/p4ATKOaupJ3USpj1jfH/pkQpLL+Hv1CHVdSXNvJB1IyOX4KljYUXu7nujpf3IFl
         KV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7Om6Yg/2zA/cbTNg7qKf7Hf+m++Wf8FwyUUwYISosbw=;
        fh=q9qRHcF80zCjmzVhPY67N649RHtvcIuOdx0ItB7xLVI=;
        b=MX5WhXwq5vwppl9m0f3AvuiDCWqUz/Y/0ZW9pLyZEKrzphdV3Ma7v0fq0pcXaThNfZ
         Fov+WXWI1KInXvlik+UDlzONuOOzucEVWm3cXt6849Of3vnzgAsRsT1Atn81ni0APF6N
         +hVcOE8USl9TyRw4g4WKizW00o22J8L/5s8oqL/9avZWFsSZPM24tQI/wr5CqJjbitso
         U+AE/769gjg3Kb9P5zlQdFOtpUa79AsjWqM4lDi1xVszmAc+Ww6aGyqwEnVwcDZP6Y27
         BS8hKz1MFUWIb3PYEZJMfucCtg0E3LA2nsczeq9GR1XFX+BjOMKWkmgy2EMYXUy0GxH5
         rRUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1775078600; x=1775683400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Om6Yg/2zA/cbTNg7qKf7Hf+m++Wf8FwyUUwYISosbw=;
        b=a7XtP6CYpk2D1P8nvPBbQN9lYgaqZEi+UvWCVN+6OZCf9TdSywDKXViI0NqSydX12S
         Sv+mHFBRc7XREjuSDG9ugckrJSsfUfD/Efs38xrBwJE51JvOQQkIQIVopyJJFfTYK7I9
         064Ofax+eE4r80zbwpPSI2EwDLWUdBZ8PhT38BMFlB2y9goV9eleMIEGNCZPbANFM4hy
         ep++x1ouoJfdtML9qs8jkSEB2oE/3lZ9Oaea+nQtwK3Xil4xv1alv8cGyeOuzBaBCIRF
         0FhA5LY8gnkU2lr4s/JTGMprn7dm0JFll00eDUR2T9ibdB/9xOJMJwrXt63RQNih4kQ5
         in1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775078600; x=1775683400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Om6Yg/2zA/cbTNg7qKf7Hf+m++Wf8FwyUUwYISosbw=;
        b=BFsIA7zlIxfzTv3nK6WWBmfCNwEfCikjgNaRbPUDlAVVsc5MQalMHNmJw7uoofeaij
         foeYOZDfcX2TtopPDUwZagrYrKPo06ct++x9YqTvcGVaIFv4IPRwfm0m90tkTbicouBo
         GMboZCJaAGXnmDFN8qFT6496MPqiBa4afyd5r9r52hVbqhdPe54ntu41acdbXpSPo5ik
         ppJX0FJO/QVkmQyUpUpfI+Nj+lWONqHAiQ1yHkOJf5HwhySwv/Ww2SZQYQ1ycE7Y9biY
         gRAk+yh/5qhLzP83OZJEfaitAYOR2wDqwXb1rHZ4wXkb2EnY6ATWmWaezvTlgm8pPH2q
         mlHw==
X-Forwarded-Encrypted: i=1; AJvYcCV6N286NxzUks1STt3MKUCyXyhsQ41R5xs8pRuhmWvmFTyApyodZNUaAp4u0Mj1lMdzThpndi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlTEax7i9zpz7zpvk5OP/p9TL/IO1e4Q50Ou2xNu3nHZeQStwe
	XMQSMQPnDPCYC+Irx68IvJUOsOla8kS8F5zQr4mj3c2mQnPO3dVXrlUAMWgmeNFtttHn3bvz8gV
	YM1IRxXx9wSkv5s3mLjL/guJeSf/4mz6iTxvov3Nl
X-Gm-Gg: ATEYQzwLhFJBOv/tvGb5jMHkljbh3p42KVxEqpOY67y45C5ArtEMZtx8Irl9SI4oBPv
	am8D4vIS9vRtm5hq5SYxoNQi6PNJKu+s40p9/rLD7DGQ9xkZBhGT1f3vHzHuuefa/LYVTDVA2Gm
	4ewZkWuPRhHOh81A6TxF9eovUsD1y21eorbJ2bOyM7/gb2knYY1ogoxf57VJrtvnN+rMMxsqBzd
	zEjtOFR7kh0+6vMSi8ERFpqo8/gDq/jjcILE+O8w2vRFHe3zpsGOxC1BhMOEmT+SvJ+nkvSPEtu
	104GCZFC
X-Received: by 2002:a17:903:380e:b0:2b2:45b7:307f with SMTP id
 d9443c01a7336-2b269a9cd8bmr52451315ad.9.1775078600243; Wed, 01 Apr 2026
 14:23:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401195735.564488-1-xmei5@asu.edu> <ac2Ce-hHidTY8Z6V@strlen.de>
In-Reply-To: <ac2Ce-hHidTY8Z6V@strlen.de>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 1 Apr 2026 14:23:09 -0700
X-Gm-Features: AQROBzAuT3Beam5f520OlCmTfwlIezeqz2pdvsn7A46gMGM5WFHjqfS7FU4c3fU
Message-ID: <CAPpSM+QfQxotFf0cBWRQcnZyTZH_6bNtSrK_CBEBaMri6upYbw@mail.gmail.com>
Subject: Re: [PATCH net] netfilter: nfnetlink_log: initialize nfgenmsg in
 NLMSG_DONE terminator
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org, phil@nwl.cc, 
	davem@davemloft.net, coreteam@netfilter.org, netdev@vger.kernel.org, 
	bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,nwl.cc,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-274262-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,asu.edu:dkim,asu.edu:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CFA6D380957
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for the review, v2 is sent. Please let me know if the usage of
`nfnl_msg_put` is incorrect.

On Wed, Apr 1, 2026 at 1:39=E2=80=AFPM Florian Westphal <fw@strlen.de> wrot=
e:
>
> Xiang Mei <xmei5@asu.edu> wrote:
> > When batching multiple NFLOG messages (inst->qlen > 1), __nfulnl_send()
> > appends an NLMSG_DONE terminator with sizeof(struct nfgenmsg) payload v=
ia
> > nlmsg_put(), but never initializes the nfgenmsg bytes. The nlmsg_put()
> > helper only zeroes alignment padding after the payload, not the payload
> > itself, so four bytes of stale kernel heap data are leaked to userspace
> > in the NLMSG_DONE message body.
> >
> > Initialize the nfgenmsg struct after nlmsg_put(), consistent with how
> > __build_packet_message() populates nfgenmsg for regular NFULNL_MSG_PACK=
ET
> > messages, to prevent leaking kernel heap data to userspace.
> >
> > Fixes: 29c5d4afba51 ("[NETFILTER]: nfnetlink_log: fix sending of multip=
art messages")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >  net/netfilter/nfnetlink_log.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_lo=
g.c
> > index fcbe54940b2e..ad4eaf27590e 100644
> > --- a/net/netfilter/nfnetlink_log.c
> > +++ b/net/netfilter/nfnetlink_log.c
> > @@ -361,6 +361,7 @@ static void
> >  __nfulnl_send(struct nfulnl_instance *inst)
> >  {
> >       if (inst->qlen > 1) {
> > +             struct nfgenmsg *nfmsg;
> >               struct nlmsghdr *nlh =3D nlmsg_put(inst->skb, 0, 0,
> >                                                NLMSG_DONE,
> >                                                sizeof(struct nfgenmsg),
>
> Would you mind sending a v2 that replaces nlmsg_put with nfnl_msg_put() ?
>
> We already use this helper in __build_packet_message() and it takes
> care of initialising the nfgenmsg.

