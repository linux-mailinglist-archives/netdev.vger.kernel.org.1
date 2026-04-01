Return-Path: <netdev+bounces-274256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0sojNjyFzWkregYAu9opvQ
	(envelope-from <netdev+bounces-274256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 22:51:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 363D238061C
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 22:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B031D30A1111
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 20:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0523793DD;
	Wed,  1 Apr 2026 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="CR2tPumz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5F535B138
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076069; cv=pass; b=ZSpvC4avB7fTAZh+0LhJ9eE/sGDBn4gBD4UDq01NKNC2eOeitWaGnMXLtlAOkgE0RtBjhypq0N1qbrha4o62HjPV+4br8BEh0ZjuXBG1pNuFyZdGGhEEYjdKoxLYHJRRqzOa+TP4VPC6gd9wJjS+R+tBKYcVP/Ow/hvQjkGxGps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076069; c=relaxed/simple;
	bh=z94+ohkVsVxUyep1qRj19M46dqyZ6y+PuOLQwmnDEDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rE/5I9f33OkHSFTV1C6M3dN/FIk6NGWC+mdc+pkHSPBxU9+xvydG9lONn8w+l50AkgEZCt2LpmlDbv9UjyafgftoRxklWJnsiQBLRNh+K8IZnEgsPaOXJqqIGZ4yhNHdXYWRgbkjued9pzTyxkm+vvCvOlSxvZRFLZcJpjoAZ3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=CR2tPumz; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-35dac556bb2so73670a91.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 13:41:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775076067; cv=none;
        d=google.com; s=arc-20240605;
        b=StHpb8zZL8t91uBZ5oFu7QPgdfQ+3ZZQmScDHrEbRJmq0GW/HBKlFtVQ8mg+LSwjO4
         yn02qJD3MhDd+oBukx1UrU8V15lPWtttu5TpvShV7Fr6bE8jtPvznVeC7KDl9kUiJ8sc
         OB2g9C8sYLM4C85qZy7Db6XSIl/1doCAh7vtyfzwt1Y5in9Pkb+rLnGhvXTaY9KHeveA
         QUspVQxNFbO2UxuY3TuR6F6jrEUqTysN1qr7B/MEnqM0V6z5dkR1VaTMZ+4emTZE3oHV
         XqBLyzTt50lOqofqQMMSuOGgD3P0/sCZuZix7wZVXCxJOC+Iy8fwaF8X6XR4GNVEkM13
         tGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KijIFQe0NqqeKl69HCXypV3vUYAKuByHe78TDARydIY=;
        fh=1ykmmKcHSinBwwhKuCGHhyrhKm/8a9YlZHIdS5MayoY=;
        b=I82hlv16r0GMbRxjS2MbNFnEySSr99QnWiutVJ9UFi/cysM6w6hXfVRp7FYAS0A4TS
         VKiImf7t4uKACUmeQmWz0ifXYU6c0jyg84z9jzgH2vI1/hYULV6bnBdBtpRPFr7K0GOS
         ZTMFVMlanSRO8I3s0FeDoft/pAjHsFIbRnUWH+d1UHqOT8DCTy2qebp1kgI6Ym1nr28b
         4jMUKTt2dz3rz6Am9XWkCqYqh4m/OuGynOzY9LfGjgYwQzB4eoWcd+3n0URVY1DU/vNf
         pl9IcCDLG6dsGI5MnMCwyG0URRw6dO8Ifto4/BBhQ+TFvo5ReHS3vd+3zqVyi73Eh7lW
         pcAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1775076067; x=1775680867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KijIFQe0NqqeKl69HCXypV3vUYAKuByHe78TDARydIY=;
        b=CR2tPumzdkXJ16Ay4LC8b6tb+kofbtVpbJGZ957Ivlg9ei7WwcRIYiQZxSRI2DeYKV
         85wSUemEBYfi6kahngaNtoLKHsjIUJ25jFBWWPU23Ux/wvzjm2uNtMZoBY7+GCDzheaX
         Rk0R4VUBTc63DrSB50iaBWvdzVVtPSg8e67Umgn4oik4SKnTbnSjiv0cV4K6YogGLBQ3
         vJCYSc2p0j/2NdYNq3I1KY8OSDfQz8lrqYIf/i3J8NKGdXJtgl9buhIqTrkSC1qY2jVx
         OBi4KjQYPf8N5BNJbGjAURKyrRT8Hq9fSlqHkUEWe4OAQQPt9AmPuFt17c5pnvpsMSwP
         TqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775076067; x=1775680867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KijIFQe0NqqeKl69HCXypV3vUYAKuByHe78TDARydIY=;
        b=c5z86NEXPpwYO2LvuWDw5yVBG/wMaf0AeNgWCfCU9u8EjrD11lKO3K3q7avV1ebTaK
         DkZLh6l3DzEDbEkXJ5XfZSOir07dAr5Wie6KWvYLG0RpfI/ie+37OLNWy5853Fdd5kqm
         mJivMdbNjdzuRio2CY3B0e4ssRBiqh1TpA0aBOysBtF6emSd2Jl5fvJRxYlEb1I/MJMh
         HwGH2lkLYFnOuYBZSSAcQVmf+voyB7I6pVSNAxxxRVPfwCoioyKL9RhkbO4K7m55GaSN
         c3eMPNgwcBrrwU3sMb3awNolSUsCMVBhO8NwEIL51AJWNRqVtZbpX5KKeyjJOCNN7iX1
         rS7g==
X-Forwarded-Encrypted: i=1; AJvYcCUY6ZVYgNWyQIMptvxYTqjPgJEdvx3BJxX9+AZHYzmPAjG+mMAaZ07InodqML1Z0CIDJqAA8dU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz28TSKdDfY66vclYF9YKFgOeHKC60APAQCKVQItZl5RuFRbpgD
	E2qdlMw9kXyMjDl5Z/OphhhnxwgN0YBWDhNRlBc9+u0XFo3QxY+EHVGHASdkqG18sr7bQbZvkuT
	+hzzOdlIleesbaUkVS7OQ9si0cU0g01/aMtrxzGUm
X-Gm-Gg: ATEYQzygNqD4nM8I6w5BpcWoRldJOmjxhKYDpqxWLxP0JmPtvNsAyILwV66EULdraFk
	hp6at8hHfnvKUF0lIH7snrzy/LuqA7N/lVPrfB8cEyTq1WGQn3WlKxxoS/e2SoIc7T7w5o90zlw
	f1JcKj146h3y/CZzNX4NnGaPUcwSGOv+f7YuX/n3r15Xiym6fbTU+x9l0IXpTKQpZ1NUPqTy18g
	4LKfRSrbP79+2LtdbR4dZKRGG9YzOaX3g3HfBqlbj1HKxcXFr2lSeO07Tm3DzB38c5DEDNdISwi
	PE/OWI6V
X-Received: by 2002:a17:90b:3f90:b0:35b:9ab6:1d4a with SMTP id
 98e67ed59e1d1-35dc6edc398mr4533888a91.18.1775076067232; Wed, 01 Apr 2026
 13:41:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401195735.564488-1-xmei5@asu.edu> <ac2Ce-hHidTY8Z6V@strlen.de>
In-Reply-To: <ac2Ce-hHidTY8Z6V@strlen.de>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 1 Apr 2026 13:40:56 -0700
X-Gm-Features: AQROBzCEzF8ToAv3_cJAUvbyWqTP6wVFWJTiej9ApJ7ZMVfa7_KDYNu0viJXQsg
Message-ID: <CAPpSM+StQs6poh21nz5qTG0-QpRHi0S5RO=AM5gQOfd8rOAVWQ@mail.gmail.com>
Subject: Re: [PATCH net] netfilter: nfnetlink_log: initialize nfgenmsg in
 NLMSG_DONE terminator
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org, phil@nwl.cc, 
	davem@davemloft.net, eric@inl.fr, coreteam@netfilter.org, 
	netdev@vger.kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,nwl.cc,davemloft.net,inl.fr,gmail.com];
	TAGGED_FROM(0.00)[bounces-274256-lists,netdev=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,asu.edu:dkim,asu.edu:email,strlen.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 363D238061C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for the suggestion. I'll send a v2 with nfnl_msg_put.

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

