Return-Path: <netdev+bounces-283052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MJhIZD+82n99QEAu9opvQ
	(envelope-from <netdev+bounces-283052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:14:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 079FA4A9816
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDE5C30387E0
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB46B2D47F1;
	Fri,  1 May 2026 01:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t1igKKZ6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB542C21F2
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 01:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598076; cv=pass; b=thEFLYkU8WJuGhrv3h/YZ/Wzw0baTTYsheOodBgO66SMLaRu8Gy1qlwIgx2CRBEvsTMFNXD+iQt/8ut743u3pdAtp75CSKtx+OesfHwx4wILtGdYY3EleSBYk8w9pfey9QAJfmOVbu90ooSVQMQlhBCKCa6+Zdac0ymh+iDYhtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598076; c=relaxed/simple;
	bh=PxA4O5b3HlPuK6DlNhQIIiB7d9oEdMoi/b6jA358CFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WX7j0ifyv2lfZE1S4yVGB841AQU+tAvEUeuP+4/8o+poQ3IQP4gbnEMN0IFSEmALM6OzLPIc5E3FgL5LRYXnVAZ4rLWWjsfwad+I9AEiL6PayO/X+14qcQoUPnGjm2wqF/lvpWD8MKFMMX4iw3TbjYwPSjXtGB7rmEARLu2YM1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t1igKKZ6; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38dd9f11a09so12715761fa.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 18:14:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777598073; cv=none;
        d=google.com; s=arc-20240605;
        b=fe5vl3ommeUbnrpKsyvCO5dyDl7q23zEHrWKcqvljO3RhfWwh7M0Op7MJWfI1/slyr
         2J4zSm6Z0CaFv1rhYaQ9Sh3qfrcDYeLFtwjiVHzwg9i2PuqeED46gCKiwVmX2VNZlo4j
         SMBzKvFmKzOZDtivhStyiZYtr3MxVwTXShyXYo7DE6YQPnaxoxEPqdpSr62DEdcFhMnA
         bg/qHEPyLe0w6HhlAA/CEaZguRT0Qftc5d9x+F5zzla2h42ufjLxXj5jI1nffGHeQdZP
         /k/Ej4wT3xkck4W+nJlB7TcX88NOkRj3b/wYgGw/iWqtPPPJf5Il+3I2aem3ptJ042o4
         rnmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nSQkpXPvbzNQeoub82VoqlOWrgCeyn6/Q35lCNTDSoo=;
        fh=lsijaURVwGctBikN4FnjDFOO46SkWKavLG73BiAQAhA=;
        b=KCSQB6zF8wXTjEZlOaSdrlKhOAT0blFUKWRCQFdGnmHQ5PBDpBYWn8uWjxbgoFieGJ
         ZjTTxA4wWENYPhdKiwljO8lDuvzW6rWlOnWXmvvpH4sof46+xyoL5WR/avQ5HO/5Qttw
         D4mQF3jU+1eFmG2werCKKHiSp+WQljpKAk3dzXIFEYg9BxsOLK3AT7am1uH572MyJKqf
         vQyKimfLUxdW2UuQ84KiEaWTywF90DNafm5nBMbm6yCDl1MGqqUsg+z9tsKxTD9CH2QJ
         CxyZbUINTf3B9rDyrbInosxP/8VAr+Tk/kBKdkA1A0j8m2LA8dxm2Ju6N/tJYqM3/amd
         512w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777598073; x=1778202873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSQkpXPvbzNQeoub82VoqlOWrgCeyn6/Q35lCNTDSoo=;
        b=t1igKKZ64GH3V6YHO8UNCwHdh8bkrzDmfwz9KIT/G2/I4wAvnHenwLcc9dxIOVeFhm
         5YAirzBCe6/zYbnEJEqUBooHg//ZtDZny4gKOKivCpQ8+AweXg0vHkPzqbxCvPNiazLq
         CmOtUliSQ85Gh62eXhZquPhtOeMY5CxZFq17G5qe4sIOVJUIY7Pc+Ok+QyDpJX6Lp/6i
         5Eyy83kjiEIF5Bvb5gI0+GYlWqm8iQqW5KkTJ4pNWF3nNKZg3sNpEAYLjty9awh6Ro9U
         L6C2JCl7d0Dr2rGf/gsW4mBCMaX9ZdN6Jxk3eiYyAJDSILy5Hy66Q9xxWL31mv3XIWon
         MclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777598073; x=1778202873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nSQkpXPvbzNQeoub82VoqlOWrgCeyn6/Q35lCNTDSoo=;
        b=cFioTZj8eF8xB2JbkkSzl2zzxA0vHiTXQV/bQ9DVPE3yRIdgUhmXdLtPz33Lu3YAQG
         tben5+jV0SrBm8oCp8i2HxGiaNFbsc1q2ogntFuCjZTvKIq7Jo60QXImsHnkkWbbZCPc
         ONtWpEnMRPQ+0+hnVNGQMGNKMz9p3/FmkD9DwkEYLS3javBAnIcDsRB5CObP7l0+vLz8
         cPDqAtbDzDhGN1SxaX0/1Q853CizMoaYWWgpNCQelRLsaRJMDjMzdJhBwAvqQ02zmiog
         BXbrBCkOdV5QCA2rIIYRg70y1WTAoqSQOyutVTQlCs994vxL720VtgAe6CzuOIQ79czg
         M4Jw==
X-Forwarded-Encrypted: i=1; AFNElJ9PKELfCe8Z4JEi45uP01dJwGR+XdhC6bWPqS8rHNuakoRHU+KYaDL2rVnwVAgfrsxyGruIHm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP6OyRYIC6iiMr/QpCbuSmcKWDFxLfgDPa7kL1Uo++GEm3Tc+H
	FuOGGT46KAPkFeHk6aUU3COTMP1AihZjYAklbXohr85IQBRsWvqFuSi3wNS+PLD4sy4C406LAKh
	CjAV7KjhRsnqYWJEivJ1Uuosx09Bmx2owQmJw9Rdj
X-Gm-Gg: AeBDietBt2buJ1T9HyjXNtc1JAirNRAUxgfY9iJKuouzFLRFTEdyl+Nh8oWXPubXsqt
	9u4P9VcIGpEaQmoEcDjceGJyjp+8pK0HAqUkgPEghdbQemAaOYSBDA0wwLMhzxQMojY+lIb+5wJ
	z6jI1FDQJYkGxB+AdDIJicRswCbrVabEwcD/x9J50LnsbgNYZeGyt3+izTex+zn6q9eQ84bFRAb
	sCz3OBLmKmipEnQEVuFiNJpBD39LcFwbsU8oke9jKLvwYKBpNg0BGIoHBv27gxK3ewHbxtLTGwr
	BRFbZ6Q3PanBOORr9n4EvKe259N5SpZuYEuGi/qy4I2vMQXRZNfGZTFwU98=
X-Received: by 2002:a05:651c:502:b0:38a:902:dcd with SMTP id
 38308e7fff4ca-3934e204d45mr18166231fa.20.1777598072804; Thu, 30 Apr 2026
 18:14:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429204128.2865817-1-boolli@google.com> <IA3PR11MB8986449FB3714E23C389F6D1E5352@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986449FB3714E23C389F6D1E5352@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Li Li <boolli@google.com>
Date: Thu, 30 Apr 2026 18:14:18 -0700
X-Gm-Features: AVHnY4J_plv41lTEdTL-vvxKy5_2KloHTpmwjewmh1NkxAdrXpoon5Ni15mn_Pw
Message-ID: <CAODvEq4bfK70wx4TX+6ZoYpj=3FBY6fR6LJFpPdR-u3H6kJn1w@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] libie: log more info when
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
X-Rspamd-Queue-Id: 079FA4A9816
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283052-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boolli@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,davemloft.net:email,osuosl.org:email,intel.com:email]

On Thu, Apr 30, 2026 at 1:36=E2=80=AFAM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Li Li via Intel-wired-lan
> > Sent: Wednesday, April 29, 2026 10:41 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; David S. Miller
> > <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Eric Dumazet
> > <edumazet@google.com>; intel-wired-lan@lists.osuosl.org
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; David
> > Decotigny <decot@google.com>; Singhai, Anjali
> > <anjali.singhai@intel.com>; Samudrala, Sridhar
> > <sridhar.samudrala@intel.com>; Brian Vazquez <brianvv@google.com>; Li
> > Li <boolli@google.com>; Tantilov, Emil S <emil.s.tantilov@intel.com>
> > Subject: [Intel-wired-lan] [PATCH iwl-next v3] libie: log more info
> > when virtchnl fails
> >
> > Virtchnl failures can be hard to debug without logs. Logging the
> > details of virtchnl transactions can be useful for debugging virtchnl-
> > related issues.
> >
> > Tested: Built & booted on a test machine and synthetically produced a
> > virtual failure to produce the following log:
> >
> > idpf 0000:01:00.0: Non-zero virtchnl ret val (msg op: 1, ret val: 6,
> > data_len: 8); xn id: 0, cookie: 0
> > idpf 0000:01:00.0: Transaction failed (op 1, xn state:
> > 3, id: 0, cookie: 0, size: 8)
> >
> > Signed-off-by: Li Li <boolli@google.com>
> > ---
> > v3:
> >  - Use dev_err_ratelimited in both logs.
> >  - Move log placement to after virtchnl field validation.
> >  - Remove redundant op/cookie fields since they were validated.
> > v2:
> >  - Use dev_warn_ratelimited instead of dev_notice_ratelimited based on
> >    reviewer feedback.
> >
> >  drivers/net/ethernet/intel/libie/controlq.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/libie/controlq.c
> > b/drivers/net/ethernet/intel/libie/controlq.c
> > index ebc05355e39d..ceca8a076d79 100644
> > --- a/drivers/net/ethernet/intel/libie/controlq.c
> > +++ b/drivers/net/ethernet/intel/libie/controlq.c
> > @@ -766,6 +766,14 @@ libie_ctlq_xn_process_recv(struct
> > libie_ctlq_xn_recv_params *params,
> >           msg_cookie !=3D xn->cookie)
> >               return false;
> >
> > +     if (ctlq_msg->chnl_retval) {
> > +             dev_err_ratelimited(
> > +                     params->ctlq->dev,
> > +                     "Non-zero virtchnl ret val (msg op: %u, ret val:
> > %u, data_len: %u); xn id: %u, cookie: %u\n",
> > +                     ctlq_msg->chnl_opcode, ctlq_msg->chnl_retval,
> > +                     ctlq_msg->data_len, xn->index, xn->cookie);
> 'virtchnl ret val' 'ret val:' looks like a duplication in dmesg.

Let me send out v4 to simplify it.

>
>
> > +     }
> > +
> >       spin_lock(&xn->xn_lock);
> >       if (xn->state !=3D LIBIE_CTLQ_XN_ASYNC &&
> >           xn->state !=3D LIBIE_CTLQ_XN_WAITING) { @@ -1011,6 +1019,11
> > @@ int libie_ctlq_xn_send(struct libie_ctlq_xn_send_params *params)
> >               params->recv_mem =3D xn->recv_mem;
> >               break;
> >       default:
> > +             dev_err_ratelimited(
> > +                     params->ctlq->dev,
> > +                     "Transaction failed (op %u, xn state: %d, id: %u,
> > cookie: %u, size: %zu)\n",
> > +                     params->chnl_opcode, xn->state, xn->index, xn-
> > >cookie,
> > +                     xn->recv_mem.iov_len);
> Probably %u fits better for enums than %d, what do you think?

Sure, let me use %u in v4.

>
> >               ret =3D -EBADMSG;
> >               break;
> >       }
> > --
> > 2.54.0.545.g6539524ca2-goog
>

