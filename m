Return-Path: <netdev+bounces-290337-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEzcI2ThDmqKCwYAu9opvQ
	(envelope-from <netdev+bounces-290337-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:41:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B99DD5A379C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1311B3018D40
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 10:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463B5399352;
	Thu, 21 May 2026 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="0whObq8f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38DC399D0B
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358531; cv=pass; b=oZO1kqHru6N1eLIhrWms4+Dk8c+iCJL2SLSUfZP5VMaaKoBHgt8KZPQPglH994iAqsf6JlwIfLQ3/aIij7lw78OFBCxNl0dWNDqFNEFFRaVJHkCCuLBT7TU/kxa3aVriz8wBTODMgTDsKHdBEU58MiIGzxRhTTfVJUFBBYaYUSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358531; c=relaxed/simple;
	bh=RzpanP6A36PQuXMnqKsVz0ARhkfq4GTv5HQcJgLtaYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACKg1J4vaLKdC+7LjNNkLS485faXrrg4p+IrSPyaSTxp3luONORPYAElGY/RKW49odZpsdzm/wdB6sTOLNtfbJQNn33Kaaz0pVLhylT8l98O7f1ydDze8scZJK4ufhzgy4j+JJqBedHvhQFIlsc5dd964GlzMymJA4fSpQ12tZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=0whObq8f; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c82471904fcso2590882a12.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 03:15:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779358529; cv=none;
        d=google.com; s=arc-20240605;
        b=ToRek/mIIvftZBq71nG2NBKjIVW8IQX5ogvOzFZ7lfTrvn5x4xgBoBg2nwM5vGcMhy
         cSWNIXL0PdyfVUgo21zcgACDDIAmaw+TASryVBkRvysUkr3NvhyEgokJ7KOAkYjCX5TO
         xPWjf6TWcy9IURINpo/BcylCZujKCyhuNrO05PO2DvEcFw/cDgw49GoMElsI/e7R7EwF
         Tec0FeGEyKSs8iz1nwFx2dVYmEpbEKJXO5diSdJ4qAzx4PdZLHjeoD9hwF+bLbPOsSF8
         n0ltR952yZOTdTofKFak/p+veyK9fdQdShuscD4BGXf+AwVlh9VdRfp4Y0wcBgVjTpHl
         yp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xeBWKFtUail1QyrnJU197FgFPLlQwCTkTXhMbQahvEw=;
        fh=9OV2Fj+jq0UvwwDq3/PSsLPxDD9s9tw3U/HVq1Z658k=;
        b=lX3g5HXixitGI3QNICp0AAecg7sjFPnbvRN1e1FR0+1hVnP0cOWNB/DU457qL1t8JA
         gvO0Q/jcFMWZfYqqVC2GMfZ4ipgn1ZdoQ8cK5/fsWmFfuMcbtePU4IJvgmUb2Qz8dcTb
         HPfyOZ7PB1LZCVapPo7bMYOsqeXOtcOnm1gz+um1XbNmGH6KcRrY1j1ZNJzVPRRreAml
         1opQZtksEjN0VrGN0t1REOv2uZvWUsYqZvbml8XhtLGRCSHGS4dDQ2DcHubCbQquggM3
         McfZHLV1dhwsllWXhgA3tKCFEuhybt+uSRRxXL5ZZivqv5peFwJh6D7oZ7+wRRp0F1LS
         VjjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779358529; x=1779963329; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xeBWKFtUail1QyrnJU197FgFPLlQwCTkTXhMbQahvEw=;
        b=0whObq8f+vflG70xA1zWuT9Ba0ETHTZPss73dIXtf5pg3zSoBXgZf7abJ5xKp1Znek
         uIBJHUBUu+foxhnGDGO1cuD4irrU2oNSgfLfXIA85GKyoRLqvOm1ZgyytxtcQP9+aeM7
         +4woroXx933Xx2XSJtj8hJTBLmNlAfz5/zm0u/T3wawQfceZQdbPwJxoKZIS24uk3TEP
         drxqeGhSNkkmieqmOdCceuvAF3qNAz9KxsRYYzNuBfRx/DPiU9NPQHVOariYIYo161Ak
         Ae7waTtkGSjzVH20tnOynrbpBiHtYrFLSZvmD0kg0J4vGvddW21ZzKoYL1HpGp3vqN73
         1yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779358529; x=1779963329;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeBWKFtUail1QyrnJU197FgFPLlQwCTkTXhMbQahvEw=;
        b=ROSqjXIJCzCNOOj51shUm9GUx7dhojrTsSbs7K8AFwEn6E6n1XiXxyWAK5MGPGsD58
         bH2woq+Zvf6uPWOb2Tj8J5Agv7yn0h9lNuOzd05u9EDYwhra/9fNbs4ApLQPfotD34Fd
         +zQXrmy/l4EvIkPSKR8smCNJezVjMELyTvhv9R0HuQAj0KBJo5TWHrEd3ANor4mcAUf+
         TCTMlRYzc9YbA2NT33t1nWnOlzQXMzSfnRi175Rv5gA7CBntT4YXAQArQb/cdOupbcfo
         U+PUgLQXu3GncTibSq289yBIMsNkirwjfzt+0ndlUa8erhlNsiEYKgbku0cakUNC6t1z
         mmbg==
X-Gm-Message-State: AOJu0Yzu5RMj4GJKV9l8wNhXtX1l/qSH4ieJ/y3ocCO5nF4AJD/xy+2x
	HwZjNi2LMVucCZnPDeEe7qpuEDPNszkH4idmZ4kbdaoMXk2y1KXskEHqOpp9K5GhyrkkQ0DMVEE
	pGE+NWETKY4WxOwE6Ml7LX0m0ZqgtBHOPzCwUaXAo
X-Gm-Gg: Acq92OEhbB8q2Y0zFGWC8tb/yuDZ0ZMYv5b4n3M2uqoqADV9l+7nVf5ESrcAxg0meiy
	V9H8n8EsbfPed3c5RwxxmZpqjuWB0w56gGIwxD7uObtXTgpcqlzSznK0M0OG26eqk3r3Z8k15kM
	4O8m1B787AgvmuhU4DgFCOGJt1kaPYuBovB0e9K3rSZYioyP3+6qr6/JSzKiEht42qUr/JFvo4G
	ks/pQHg9MazMki9t4TiBzQhmEymwlPikyeoO+01aeIIEivh2Yn1gfOXf4LdWS4vaqJU9kPKXk7D
	A4zGgGS5eD0iFOErEIM=
X-Received: by 2002:a05:6a20:4310:b0:3aa:f9cb:d435 with SMTP id
 adf61e73a8af0-3b30853c8b2mr2796724637.11.1779358529309; Thu, 21 May 2026
 03:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com> <CAM0EoMmj-9uDpKBN4vjJqzaLQL=OZ-sdFO_pHPFp6kL6hSVeRA@mail.gmail.com>
 <CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com> <CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
In-Reply-To: <CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 21 May 2026 06:15:17 -0400
X-Gm-Features: AVHnY4ItL-MRUPilAR42Z3y0B8WETkCUR3Pc5PQ-tlh8DyhdY8BhGWN_SmqJXz4
Message-ID: <CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
To: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, 
	yimingqian591@gmail.com, keenanat2000@gmail.com, 2045gemini@gmail.com, 
	rollkingzzc@gmail.com
Content-Type: multipart/mixed; boundary="0000000000001174f50652513139"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290337-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,mail.gmail.com:mid,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mojatatu.com:email]
X-Rspamd-Queue-Id: B99DD5A379C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000001174f50652513139
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 5:53=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> ::
>
> On Wed, May 20, 2026 at 4:00=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > On Wed, May 20, 2026 at 5:23=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > On Mon, May 18, 2026 at 11:42=E2=80=AFPM Rajat Gupta
> > > <rajat.gupta@oss.qualcomm.com> wrote:
> > > >
> > > > tcf_pedit_act() computes the COW range for skb_ensure_writable()
> > > > once before the key loop using tcfp_off_max_hint, but the hint does
> > > > not account for the runtime header offset added by typed keys. This
> > > > can leave part of the write region un-COW'd.
> > > >
> > > > Fix by moving skb_ensure_writable() inside the per-key loop where
> > > > the actual write offset is known, and add overflow checking on the
> > > > offset arithmetic. For negative offsets (e.g. Ethernet header edits
> > > > at ingress), use skb_cow() to COW the headroom instead. Guard
> > > > offset_valid() against INT_MIN, where negation is undefined.
> > > >
> > > > Additionally, linearize skbs with shared frags upfront to prevent
> > > > silent data corruption when pedit operates on zero-copy pages
> > > > (e.g. from sendfile).
> > > >
> > >
> > > Sashiko makes the claim that:
> > > "
> > > ....
> > > .....
> > > If the payload part extending past offset 0 resides in a shared
> > > fragment for a cloned skb, wouldn't skb_store_bits() write the
> > > positive offset  portion directly into the shared page, causing a dat=
a
> > > corruption regression?
> > > "
> > >
> > > It missed the earlier code (before the quoted code is hit) which is
> > > very well documented!
> > > /*
> > >  * If the skb has shared frags the user is likely using zero-copy
> > >  * (e.g. sendfile).  Those page frags may point to page-cache pages;
> > >  * writing into them would silently corrupt the page cache.
> > >  * Linearize so pedit operates on a private copy.
> > >  * TL;DR: if you want zero-copy, don't use pedit.
> > >  */
> > >  if (skb_has_shared_frag(skb)) {
> > >         if (__skb_linearize(skb))
> > >              goto bad;
> > >  }
> > >
> > > TLDR:
> > > If the  skb  has shared frags, it is linearized upfront using
> > > __skb_linearize() which means any risk of modifying a shared fragment
> > > is non-existent.
> >
> > It seems there's a second sashiko ive been made aware of - these
> > things are just multiplying ;->
> > https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260519033950.2037=
-1-rajat.gupta%40oss.qualcomm.com
> >
> > Both points it makes are valid. Dont have time right now.
> > And infact looking at the second point sashiko 2 made I realize I was
> > only paying attention to externally shared fragments which the poc
> > used.
> > So probably the sashiko1 had a point as well. Anyways i dont have time
> > - will respond by am tommorow.
> >
>
> Sashiko2, claim 1 (rephrased for brevity):
> "With the pre-loop skb_ensure_writable() removed, tcfp_off_max_hint
> and related use is no longer needed.
>
> I was going to say "separate patch" but since the cause is this patch
> that removed the use, at the expense of a much bigger patch we should
> remove it (delete it from include/net/tc_act/tc_pedit.h::struct
> tcf_pedit_parms and net/sched/act_pedit.c - as described in sashiko2
> claim.
>
> Sashiko2, claim 2 (summarized):
> "..skb_store_bits() will memcpy() the tail bytes of that 4-byte write
> onto frag pages that are still referenced by the original clone, so a
> clone held by a tap, AF_PACKET listener, or mirroring path would see
> the modified bytes on its shared pages."
>
> This is the same claim as sashiko1 but sashiko2 gave a much more
> convincing description ;->
> skb_has_shared_frag() is only true if the frags are flagged as
> SKBFL_SHARED_FRAG (which is what the repro did); however, if we get
> frags from eg a driver on ingress and that skb gets cloned with frags
> we won't catch it.
> One approach is to do an if (skb_has_any_shared_frags(skb)) and then
> do a skb_linearize_cow() but that sounds like overkill.

Yeah, this would be overkill - imagine running tcpdump 100% will be cloned

> Another which will make the patch even uglier (but less expensive) is
> to add an extra check insde the patch's "if (write_offset < 0)"
> to do:  if (write_offset + (int)sizeof(hdata) > 0) { skb_ensure_writable(=
)}
>

To be precise, something like attached (untested, uncompiled)

cheers,
jamal

--0000000000001174f50652513139
Content-Type: application/octet-stream; name=patchlet-rajat
Content-Disposition: attachment; filename=patchlet-rajat
Content-Transfer-Encoding: base64
Content-ID: <f_mpfc3kzq0>
X-Attachment-Id: f_mpfc3kzq0

ZGlmZiAtLWdpdCBhL25ldC9zY2hlZC9hY3RfcGVkaXQuYyBiL25ldC9zY2hlZC9hY3RfcGVkaXQu
YwppbmRleCA3OTkyMWI4ZDg5YmEuLjhmMGY4NGI1MGM4NSAxMDA2NDQKLS0tIGEvbmV0L3NjaGVk
L2FjdF9wZWRpdC5jCisrKyBiL25ldC9zY2hlZC9hY3RfcGVkaXQuYwpAQCAtNDc0LDYgKzQ3NCwx
MiBAQCBUQ19JTkRJUkVDVF9TQ09QRSBpbnQgdGNmX3BlZGl0X2FjdChzdHJ1Y3Qgc2tfYnVmZiAq
c2tiLAogCQlpZiAod3JpdGVfb2Zmc2V0IDwgMCkgewogCQkJaWYgKHNrYl9jb3coc2tiLCAtd3Jp
dGVfb2Zmc2V0KSkKIAkJCQlnb3RvIGJhZDsKKwkJCWlmICh3cml0ZV9vZmZzZXQgKyAoaW50KXNp
emVvZihoZGF0YSkgPiAwKSB7CisJCQkJaWYgKHNrYl9lbnN1cmVfd3JpdGFibGUoc2tiLAorCQkJ
CQkJbWluX3QoaW50LCBza2ItPmxlbiwKKwkJCQkJCSAgICAgIHdyaXRlX29mZnNldCArIChpbnQp
c2l6ZW9mKGhkYXRhKSkpKQorCQkJCQlnb3RvIGJhZDsKKwkJCX0KIAkJfSBlbHNlIHsKIAkJCWlm
ICh1bmxpa2VseShjaGVja19hZGRfb3ZlcmZsb3cod3JpdGVfb2Zmc2V0LAogCQkJCQkJCShpbnQp
c2l6ZW9mKGhkYXRhKSwK
--0000000000001174f50652513139--

