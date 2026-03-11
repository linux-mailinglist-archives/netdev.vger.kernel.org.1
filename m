Return-Path: <netdev+bounces-266642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NA6EPNnsWnsugIAu9opvQ
	(envelope-from <netdev+bounces-266642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:02:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D687926411B
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8ACC3055D71
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ABB27B327;
	Wed, 11 Mar 2026 13:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKZaLX77"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C16D199EAD
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 13:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234029; cv=pass; b=tP757clDuiARa4Tffv4cOdZ/OWKL1qluuPbaCqNuUTzfbS4e0C1gUW2rnBEF/Ifs8ZyIGkKpWMaWxTnK/ueWcwwShuFE4Vsj2RpallZ9+8kHUsN4L9rfS07WXF7Q5NyqigFSVH8L1qFgIw87qnyf1DXTARpKaoVvU922FvqOcBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234029; c=relaxed/simple;
	bh=x5fYuVrFCWzV3d6HjuByboQ/atvlRXnSwvWp5vMfFAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRrr5El7VPJYV7ENzoVzhPSohaBVbeIEpRJguJad79wg2H167XeddwDCk3dtDpnErIr1Nt8PH30PhNrsgq7mr6Dewh+4QQFd4mcDHATS74nmBLPZk6muLEAP62mKgoeuiwCjQlvhMSz+ddh8y1SGLY6NWaGQ2gKl61Q/3e9Gpio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKZaLX77; arc=pass smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4138136f02eso6338045fac.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 06:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773234027; cv=none;
        d=google.com; s=arc-20240605;
        b=U4w7GacfSApZCFCXoo0Yw2zTk5m4JJz9v0QJdsDt8jfVp0ZIL69B0LLxtABaCklXMe
         uQaAUAIQd2/9IwcBM0kr1VH7lCv4UAKRdBFN9/V4ZaK9JLZ+rmcsid4uoNGPWPPrVIdB
         zi3hnj0PFmPBrfi5rZ+atKotzqAdcXoqug4Q+KZnrhAN6S7y6f8sPLfoIK4o5E6MVmI+
         r60iMy25NuBVblONpM3Emc8Ec38OsxQIWNvlo1tD5OFN68l8K8k+ETksTNQOsRJYLRV2
         7YQ93+0c89D3Tn2LxFuzZ7FPTgJjB08AOQJR96Svdc4eNmC9tTE9XAwoyIPAVvWownFo
         vKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BiFPSY0MwaRM9PDsTve+EOXAvGOndFJpmS9alfnw+5I=;
        fh=QA0GSQOrDdY40RzrFQ6mDLssX7yPmZAeXnJCWDFTy4w=;
        b=HFPJi6Mu1xoukL4KlK0ej8Gm9chUrd4YR6SvVWr6Ge6YS6Fnh8btUZrvP3gn5NaGtm
         HZgtLvcG4cvdqNIYvWDsRqUNf2qoORmCH72nfKk4i62fJnBt6nL0T1KY+GFWV37SFY1E
         VNZsxH+c/HOz662fOivxBLAtXUalzJ1HDP/Zgoe8/NxCbziStDv0sT216jXFnCIu6wtc
         yTwQnrU83O/QFJYNa7Rqs7IBpPNIzMyybLmbQ+eZHrd+J5gWQhfJq41w2sRzLpimNogC
         Y0TYhZTAwATmcITFB+gzoqTN0SKnFoNqQ8htiV755sqPeh8pXRMolRWGXdtu4GF7mYZ/
         LdrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773234027; x=1773838827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiFPSY0MwaRM9PDsTve+EOXAvGOndFJpmS9alfnw+5I=;
        b=TKZaLX77hX3qjB34BlC7XzJ/yyTbBFT8OAlOXlW1wHTd08MRv+mMBiK9noKyM/vI1y
         6KUj5BGnroGc+pfRiaNcPfwoNfIf3VGnjU+iaLPK4dj2p0dEY7FCo0HZwI0ue07UqZg5
         vNgWdmGeXWwyxmmX4ja4QhzSZvcep+Et4/fjdDHC+qa+nJ6VjqeZk/o6EdmnT2iz4Oh+
         GQX/LzbR3QXsJlx6RJTgiCfAUSDxvijPyd64b0Ks89F9qo7hOwXnjHyo8rHifaeotsI9
         PApZEYV14e3kf8QiD4aPXXBMi7I4FonO6b/vuQYXQD6II9p+WvAEglMTnKGh88CAv6jz
         Nohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773234027; x=1773838827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BiFPSY0MwaRM9PDsTve+EOXAvGOndFJpmS9alfnw+5I=;
        b=V0zLGc9Ho6OTMJ6MgooyVD5DWgdDzA2zXbmQ2BglT9yCRceNyV3BL9D/MZ4VmJdJYc
         bo60enZf4v4d4P5bPUBaBHV82y3vH+uoBtllPuR9g25PNd/AwJLjK3OL5vLpdApXYCud
         ExuwNIF32bmv1AgFmyfZe5QC/BYbEOEdBWwG77iHQGZ4Itj6edH4IPYfE9Uqy36mHJ50
         JmlXlesA9FWYfwuCAG72q+CMp5Yq6RsJf16VsUbp9hBatpWBpSE+UNqqXaR6+rD7LDwn
         KVOBj5c2o+OwQxPE461LJUCeJ5YXqRJF+ye5oC0mjZ4ipMjK2Z/BNRS3jjWTuqlKiWck
         vNbg==
X-Forwarded-Encrypted: i=1; AJvYcCVH90vz6EGEfjPB5naCOe4XGSNJEm6xC1vBIfBmbluUVlujfiNUJoXvH48pSMfSUk3mdNtJ5m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiSxP0v2fLNo4T4aiHbgv2ZevX/u+Oa8ruIoZWjaQDRYEZBBor
	6PEtIA4xIFygD8CzCskUjCDRqW8N35iHSKLraheSO9apBgKJLXGvkVGr81cJKt0EIAIDmzbgwCq
	3ozbZHpAmOGEzqllfxv0fdMz3LoyM8w8=
X-Gm-Gg: ATEYQzycjV3hNGRZAZidMrz2vBqNC6qMvbvfojjPcAkA++iEATVHVF4M/zk3bZ+KXeC
	6Hv7XcKga3tW/9lw1VhO9h42UiK2E44wgGCQpzg8bctWFMHt6uT2ksQ0U6RVF++o7VVa5PLVmJ6
	PzRmZxQf1VdXa5WVTo8dQ3kJv2hNbN68BN1fXLzxNNbq0XAXByrlmShNf9YWF34Aevxibfwxtdg
	xyE8J7Xb1IhlM66FWhM0tACZkXj7KrnXjKjYZI7MaL3kedmD84zOTaz0jiAneSQWHoqpI4MTEBU
	NhcyrSs=
X-Received: by 2002:a05:6871:781d:b0:417:3936:1c7a with SMTP id
 586e51a60fabf-4177c8e55d3mr1395705fac.24.1773234026286; Wed, 11 Mar 2026
 06:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abBf_R81PYmafhWv@v4bel> <abCh2CgVS3Uw7W-_@krikkit>
 <CAHsH6GtYpoowPJe5VWMcm=CCdUernc1q-Sk6HznXxMy7LDAmrQ@mail.gmail.com> <abE1Q7BMvZ1l14jF@krikkit>
In-Reply-To: <abE1Q7BMvZ1l14jF@krikkit>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Wed, 11 Mar 2026 06:00:03 -0700
X-Gm-Features: AaiRm509HKdYoezU2sDItTzS5hdmqG5TzfdjeI7mBNdwUnxIl7v71IYwvIthlqM
Message-ID: <CAHsH6GtCAqJf1PTGjQppScME6h-dXCUFJMeJvmJsrSDkhSJa8g@mail.gmail.com>
Subject: Re: [PATCH net] xfrm: Fix work re-schedule after cancel in xfrm_nat_keepalive_net_fini()
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Hyunwoo Kim <imv4bel@gmail.com>, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D687926411B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266642-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eyalbirger@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,queasysnail.net:email]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 2:26=E2=80=AFAM Sabrina Dubroca <sd@queasysnail.net=
> wrote:
>
> 2026-03-10, 17:14:19 -0700, Eyal Birger wrote:
> > Hi,
> >
> > On Tue, Mar 10, 2026 at 3:57=E2=80=AFPM Sabrina Dubroca <sd@queasysnail=
.net> wrote:
> > >
> > > Please also CC the author, and maybe additional contributors, of the
> > > patch that introduced the problem you're fixing.
> > >
> > > 2026-03-11, 03:16:29 +0900, Hyunwoo Kim wrote:
> > > > After cancel_delayed_work_sync() is called from
> > > > xfrm_nat_keepalive_net_fini(), xfrm_state_fini() flushes remaining
> > > > states via __xfrm_state_delete(), which calls
> > > > xfrm_nat_keepalive_state_updated() to re-schedule nat_keepalive_wor=
k.
> > >
> > > Eyal, I'm wondering why __xfrm_state_delete() calls
> > > xfrm_nat_keepalive_state_updated(). At this point the state has been
> > > removed from the walk list so nat_keepalive_work() won't do
> > > anything. Am I missing something?
> >
> > I don't remember for sure, but I think the idea was to have the work
> > run "now" so that when deleting the last nat-keepalive state it
> > won't run in the future, and in general to refresh the interval and
> > not wait for the next iteration.
> >
> > Eyal.
>
> Ok. I thought about this, but I'm not seeing the benefit of doing
> that. Assuming we're deleting just this one state, the next run will
> process all the remaining states in the same way, whether it happens
> right now or at the previously scheduled time:
>
>  - if the next run was needed by the peer we're deleting, not much
>    changes except that we're recomputing the delay earlier than
>    otherwise (right now instead of when deleted_state's interval runs
>    out)
>
>  - if some other state was the first to need a keepalive, we do a run
>    for nothing
>
> So I think we could drop the xfrm_nat_keepalive_state_updated call
> from __xfrm_state_delete.

Right. I think at the time I didn't think it was "nice" to have the
work running long after all states have been deleted, and also it
decoupled the implementation a little - i.e. if instead of a global
work we had per-state timers (which one of the original versions had).

>
>
> @Hyunwoo here again I'm not opposed to s/cancel/disable/, it makes
> sense to use disable_ in a "destruct" operation where we don't plan to
> need the work again. But AFAICT this schedule_delayed_work isn't
> really useful.

I'm fine with both approaches.

Eyal.

