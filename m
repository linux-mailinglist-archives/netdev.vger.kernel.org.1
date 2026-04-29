Return-Path: <netdev+bounces-282475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULkGImpm8mkBqwEAu9opvQ
	(envelope-from <netdev+bounces-282475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:13:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8979B49A023
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 22:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B0A93010752
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ED8383C95;
	Wed, 29 Apr 2026 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uIwsJXG5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2E43806D6
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 20:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777493603; cv=pass; b=rpzYP/TykVzS3+QdhMKZGXbQaYLBHgZcMTpVr3/SQB/yJHz7drbmyo+/kHoA+5criA2orVwyfL7Bg5/sAE4ysDTkMVIfv0M/n463pJWaz8Sm5YpXcojz2c4OzJwID976jY1Ld8KQ6xuoHbRUbX/sLLhnmbxJr3Kbs99hLJoeWZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777493603; c=relaxed/simple;
	bh=DgWmlhFDeoYKsDHkxPltw/rRajokF52EOWSxWdgpKOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLM18stQLvAkkQw2wDECDFhMQBYZtKU06gqJrphWn95vEcca0qRYTsjdKV9TwDTnC2m2Fvk3bKPrAR6iuaYj4/cP9ezl5DouccFWKd1nlZB9eOlN5WgU/K+dIBaN6sRUnoqqAhD3o5OAYv1HeYwfHjHwKbBYutzmEMW0CqgKuaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uIwsJXG5; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64eaf8aa893so118706d50.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 13:13:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777493601; cv=none;
        d=google.com; s=arc-20240605;
        b=eOhCBQERrvLNdv8Vb0FpcWihtv1yQY3X74RF9JjhLSapD8iDxxtIX3mSm3ch2wNwib
         bPxlwX/ubQW61YofCKqxB3jZtzo5UfX2gfOsmJtmj/S35vHKhBLQGBeXxviAB0e5W7qz
         oyLTH3YmF1Zem/T1dhaSp6qIUckL2BnCBXVkNVr772RJx5mrVPqtaA+qD3Rc0bHV/Jjf
         dB5WcWEN5sNErh9Q0UJqylso4RPrIAVfELxaIA7OjyEXzFJJaClDxYGahxn9i5iYKVIf
         i/vpDbORHt2h50rskklAykCG3HIYMVKmrqv3EUKMRqcJujK9yn0IFE9s8fzu2sk6h4Ge
         /kyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9jvyc7f7PRAOiwTjwKhbnQrjsI3mybG0X85iNl/kJTM=;
        fh=oiTxyG6i/nSjWV7gChOLBdavsrs4WwbZ8nhGbxICSQM=;
        b=OhOjXcw+VzKs2UJoobMGoxPA5rYeqPKiNp2cumG/4DH0FZdlx4d9AMh9hDU3X17Kc1
         TWtg2ac99Xd0Tys6AMlLwsIw2mfpCmacLZNiVXTmQOU/5GeKD4ubnyRR29Uszvb4y4Iz
         4ExF3yfruuYlzaPxplOjD0nZTLRy6g1nhOwYFd35yxQatIeX6kKZ9udD++gAcKvPzeky
         CnCbNb+oMiuf5Uggo3MsiKbyb2xCP3K67+8VbTiGHNfeiSywvWTCXxKqdTSbQAyZCBSS
         3vSYQPFXqwfUtsmirIkOIdp1t3NIc6g7AAjNw/xZkV405Bsxd2TnhjW9gJuEc2Y5t8O8
         ZpFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777493601; x=1778098401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jvyc7f7PRAOiwTjwKhbnQrjsI3mybG0X85iNl/kJTM=;
        b=uIwsJXG5lDbK7VSrssez5pjA468gkZjWuB59Ic1sC1A/UXBGw7dsnYcIDB1NgM4n7N
         mIlcfsCjZFjja/be9r2vO5V/ObbwXTnCHmmVdRZMvFHQkvRlt5wrC4PX3u2BDSggu7VA
         KMT23Q7uV9+QPslqS6W2J9337N1SqhUod/5/JJQCa99aDqWoYu0xd4ksK9SJAlcAjEOe
         YevVcW68Fqv/to4tIriBovUcyP2zMXZW5QNE8N/siigjpVWmXswzfWJutrypXKJ3nk4k
         ZvftJtaPYCYRuWQOasARXS391JaeWWbKxp1hZnT9MEyQQMwR/hZqltReODpVOu+O6KKT
         x+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777493601; x=1778098401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9jvyc7f7PRAOiwTjwKhbnQrjsI3mybG0X85iNl/kJTM=;
        b=JvkkjN7Wr57Y/SMtMJXbYn6r4mCOgKffEuLUfxFCmx3p0fVaeW6HhF7QH8OrUMK79+
         WGk8ZIRlklk9z0l++BDbN+NNgn78W71V0acYYgrc6fQXyc6zg01x8mCeUTCUVjm8gvyv
         5Ao8Ddmc/qNalGt0AUcJxSTk89CU452V0DArr33rpb697wgaXjQ/XubfYx6ulvqikENB
         vG9vlVQazB5u3WHP0K2fynCHslRebPGxlkU1vNTX6qfPQf7itJAz5LPX74H91hexz6Or
         L9nL9ysl2tnUK9vd7K5SVOyzJ/gUGZN0K1+/M/X/C/rLnTHJ/2uS4vCnzImbpEUDZKCD
         h4qA==
X-Forwarded-Encrypted: i=1; AFNElJ9bXUy6PzMqxP3ykxZ9fs7rCpUm+Em/WnUFeVe1WG8gWqF/pXvdOKfh4m6IKcs/bI3lMHtPo44=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDW7hpguTf3NnRd8O+7sxq7onIwc9yeqddqRPNTTXv4E+VCBDA
	58i5il2p2i/jNpTUy8h9D62esAxg5Sl6JUDhJruSP5bINb6gDwKwtz7Pz7IsS8m+6X1pLtVIbpQ
	4QK3LQPFFl5JgvqEty0JggMOb90jeLpb5JNgoY1EV
X-Gm-Gg: AeBDiet7uZnDux5Bnynk0W2kxxKaUJt527CSSNgQbMyuBrp83pjCTxjXAuTWPFgOK9c
	n6ofL11FWMcqPMnTWw8ZgtKYa72vHag7S0g3/RKm81HLLznK9faepchgEUESskERi3VFSU3VoRx
	hzGpRTcvY/Y+EaLizCz/48f4XDS6Df0RF5iHFbke3dhfewIA6adlyQz1YiQs0DPGs5wsFh+gvRY
	78h+IsVQk0V71BUrT0BzbvxftLDVao8WWPjkSu5+NRkc7j2f7dgRI1RKSFGieKZDy374KUJVsug
	kUNgw5SZEQvF96bgfGBMYmJGrPu1mrTsrcAT0CHPtNzLi6moBxr8sB0txFA=
X-Received: by 2002:a05:690e:1916:b0:656:30a1:70f3 with SMTP id
 956f58d0204a3-65beed92f14mr8048708d50.14.1777493600534; Wed, 29 Apr 2026
 13:13:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425014842.1036981-1-boolli@google.com> <IA3PR11MB8986566C5F04D57DEC8DE45AE5362@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986566C5F04D57DEC8DE45AE5362@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Li Li <boolli@google.com>
Date: Wed, 29 Apr 2026 13:13:07 -0700
X-Gm-Features: AVHnY4KRKw4LoyS3xC6Qv4GwmQjPl1AbHgwZ3PdkQOrkri_GO4mhq3Yme5RvCb8
Message-ID: <CAODvEq5WZNP7sp+Kym9-pmUQrpsJv_sW=zz82f8EARZh1ceYsg@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] libie: log more info when
 virtchnl fails
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Decotigny <decot@google.com>, 
	"Singhai, Anjali" <anjali.singhai@intel.com>, 
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	"Tantilov, Emil S" <emil.s.tantilov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8979B49A023
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-282475-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boolli@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]

On Mon, Apr 27, 2026 at 2:06=E2=80=AFAM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Li Li via Intel-wired-lan
> > Sent: Saturday, April 25, 2026 3:49 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; David S. Miller
> > <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Eric Dumazet
> > <edumazet@google.com>; intel-wired-lan@lists.osuosl.org
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; David
> > Decotigny <decot@google.com>; Singhai, Anjali
> > <anjali.singhai@intel.com>; Samudrala, Sridhar
> > <sridhar.samudrala@intel.com>; Brian Vazquez <brianvv@google.com>; Li
> > Li <boolli@google.com>; Tantilov, Emil S <emil.s.tantilov@intel.com>
> > Subject: [Intel-wired-lan] [PATCH iwl-next v2] libie: log more info
> > when virtchnl fails
> >
> > Virtchnl failures can be hard to debug without logs. Logging the
> > details of virtchnl transactions can be useful for debugging virtchnl-
> > related issues.
> >
> > Tested: Built and booted on a test machine.
> >
> > Signed-off-by: Li Li <boolli@google.com>
> > ---
> > v2:
> >  - Use dev_warn_ratelimited instead of dev_notice_ratelimited based on
> >    reviewer feedback.
> >
> >  drivers/net/ethernet/intel/libie/controlq.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/libie/controlq.c
> > b/drivers/net/ethernet/intel/libie/controlq.c
> > index ebc05355e39d..bf200fea1e12 100644
> > --- a/drivers/net/ethernet/intel/libie/controlq.c
> > +++ b/drivers/net/ethernet/intel/libie/controlq.c
> > @@ -762,6 +762,16 @@ libie_ctlq_xn_process_recv(struct
> > libie_ctlq_xn_recv_params *params,
> >       status =3D ctlq_msg->chnl_retval ? -EFAULT : 0;
> >
> >       xn =3D &xnm->ring[xn_index];
> > +
> > +     if (ctlq_msg->chnl_retval) {
> > +             dev_err_ratelimited(
> > +                     params->ctlq->dev,
> > +                     "Non-zero virtchnl ret val (msg op: %u, ret val:
> > %u, msg_cookie: %u, data_len: %u); xn op: %u, id: %u, cookie: %u\n",
> > +                     ctlq_msg->chnl_opcode, ctlq_msg->chnl_retval,
> > +                     msg_cookie, ctlq_msg->data_len, xn-
> > >virtchnl_opcode,
> > +                     xn->index, xn->cookie);
> Dangerous! You add xn logging before it's fields validation.

I intentionally added the log before the field validation because I
wanted to surface corrupted or timed out virtchnl replies. If we log
it only after the field validation, we won't have the visibility into
the corrupted / timed-out virtchnl replies.

But so far the bugs we have seen in our internal OOT driver all
appeared after the field validation, so I'm fine with moving the log
to after the validation as well. I will do it in the v3 patch.

>
>
> > +     }
> > +
> >       if (ctlq_msg->chnl_opcode !=3D xn->virtchnl_opcode ||
> >           msg_cookie !=3D xn->cookie)
> >               return false;
> > @@ -1011,6 +1021,11 @@ int libie_ctlq_xn_send(struct
> > libie_ctlq_xn_send_params *params)
> >               params->recv_mem =3D xn->recv_mem;
> >               break;
> >       default:
> > +             dev_warn_ratelimited(
> > +                     params->ctlq->dev,
> > +                     "Transaction failed (op %u, xn state: %d, id: %u,
> > cookie: %u, size: %zu)\n",
> > +                     params->chnl_opcode, xn->state, xn->index, xn-
> > >cookie,
> > +                     xn->recv_mem.iov_len);
> >               ret =3D -EBADMSG;
> >               break;
> >       }
> > --
> > 2.54.0.rc2.544.gc7ae2d5bb8-goog
>

