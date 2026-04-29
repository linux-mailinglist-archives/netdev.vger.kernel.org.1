Return-Path: <netdev+bounces-282470-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAYNJ4BV8mnGpgEAu9opvQ
	(envelope-from <netdev+bounces-282470-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:01:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 000C349970C
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 425993016252
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BFE423179;
	Wed, 29 Apr 2026 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HvfXKzO8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A44423165
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777489233; cv=pass; b=HAFbGjwUVvI2s4THEZZWOMzGdQhZPEVaBIAxNx/xVjlOXRUkSJtj8gy8kJMlyLhvyy4ky2VX6wLdhTj1VqEgVZSVh+/GXWvpw1mECYLBD84NzIBdHqvlj37ylRiQalME1s55i+Wm3ekTDBQOnOWo4xU4r+l8E6VDx967lUlLkM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777489233; c=relaxed/simple;
	bh=iM7lX1LAH/LhGb9GXspkizRvzdSlbuCnGRy3iAnrBy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrTlATEoegO7TxPAxebEFVJAwWqPVAtyfo0U0vgsLSv6O6dVyXXWYf5iH0UKNdoDnjuS701kPLSgi4siEPvfgy/5yD497hdoH9aNDPxxEdwSaIGu/idr+lRJvbfrMEAwusuIowWw2+M9qkxfIyckIMYgOwt9x7C4umz5H6YwQGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HvfXKzO8; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79ea87af213so20204267b3.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 12:00:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777489223; cv=none;
        d=google.com; s=arc-20240605;
        b=j5gFa8/lEFw4tu+88XEZuYK3Ak4sBT/QccdUHtLXi7lQAq4YbXx5dbMlGQc8FQH8A9
         H0BJZhbrhIy73imFO5uzQkdtY09kDTrU5Ox5Hl30T9dJxkEcs1mVRWHY4MQmFldcXJk5
         PGVbr9A3IIMfubBUCVbnD39l8xOGlE3c0/5twbTF/S4daJOcjLTXfjnSCfxtSi9q9lTD
         BsARQCK4LXEXF3NIlFHISUeq0YfTlzzE4LLbwG8Q5woyxP6P22ScypkW2YtY61nhfgQi
         57ksL6oqgjt66JBpkTqzeXbhIa4jild47xXaF+k+6fDbKDzZt+PuTZa5+SRC9miciHug
         xk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GmsyAk+1K4Zh4JpsAlzbO2xUG7nOG4rp6/xwDZcjDBE=;
        fh=4aHnWlzNeoC2q++JxWYI7caY3Cbeg4AMZBp4Bh3oGcQ=;
        b=NV3nRrarxSBLto+4QaZ726B4O2kPx43XPiMWUWi28ChVV9wVftiv/M6pyh7fKr+bhd
         Kh3wJ7kh+avFRLU5hE0FmSlZ8TQt1crA7qw4nxZK/jj03DMUcH/5eSKBaFHggM3osn/Q
         guHBkbIhsfgfDBNNk337CX2OmSlKuxl/oXD75sQiUKdivaOCrhufQ46lWb4oTo1UjctY
         iJVWnGpR8rDjLKkr1fGwUvjsURYMtaVVNeeEMbXOFM++gqn8gmFbK3Yi4m4hYh/RQn3g
         mluEASO/UGZ8VD1lgC8afhJtYSmvMblNBcW2n5GCf/czBNWYBM1Zo+1LkZBTk1mPznYO
         2I1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777489223; x=1778094023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmsyAk+1K4Zh4JpsAlzbO2xUG7nOG4rp6/xwDZcjDBE=;
        b=HvfXKzO87AmQihl7D4FPfiB4sGCopMnLRKufTkmhPXdImBCD2NmNTbxPfkhNK8g+6Z
         bcUvnXk2OJ+3fMnmsvMt8EODtwYnumQkDL+oOn0Jjblo1cQtcYvMI3vSJMq3eG7K5z+l
         ARvHUUm0AwLsnlO7JeMPLN4jeaWb/RoFHdNWUO3VOGtPHpKyd7TWL3AiusKQiKT6FT1t
         epQfNkzjHsst+2Nlm7hh8viwgYadjKb1lqWPpbA07224OaMLlAN1RlsKlvmGvSxcmhxN
         2obfxtRil9+XUHu+nQRRqaZES543fBDg1vYgZAgrqn1/NzB/F7mxlS/Spsc5bxVO9o+A
         EYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777489223; x=1778094023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GmsyAk+1K4Zh4JpsAlzbO2xUG7nOG4rp6/xwDZcjDBE=;
        b=ktkhzGWFK/EN1nmBsldYtOB+DEsI8pws+tQiTLzY3KLq5foFTNqzgo8RPbujdqqiid
         ExxxTUS9XEv9FnyK3MfTFSSoBv8Mc8QYBMzqvKO1X+vO5m07xugkU1BZNf9iCCTSyesK
         H9P9KN0AXwJ6R8JiuifeVmDkpvswHK+0lN9AHfOg5/JHWALaJ/U/nXjM0xr8VUWX+KQ5
         w5TxITcyhH9M2o39f0yF6eW60btMlpiKvZ5aE26cCDusjK8l1p06uk8B8XOOiOr8zv/X
         qA5Zm7GtEDYWh9FE6fSp5GKGhTpScELi0Q9NoX0LRkSiLmFiut1wCB8c92hFbhzPGGdf
         Wrpg==
X-Forwarded-Encrypted: i=1; AFNElJ9ruF6IruH0wQe9M5faVnwiFa8kQoVHhY9rf2WAd6tjUIn7N0QjzknfBzgvsls6zUl9+x/6iCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDGvtjUUL2gWd11+K3agc6M+oF0kXl4Tw1GRRrqX1LZOKiXjC4
	VyxkBreCHhbTkElylmWEU3GD1jRUsabMOWg9MaVjfRTwRlRnZk/RrqGkfuGoPJFeZYkzEosZRGU
	CJ5MoC27MLq4/earcBlPm0k+8u9UenL4hrkqWOFPQ
X-Gm-Gg: AeBDieulz+fi/LAQ3eHmm89H7QlMa9AWpjw9nIQzDciEbgof4sjb+InzgO1+NXn/Il+
	TMgxNUJ7ElxLuDDd5NFkLN3zxfgF5NPajFreTek/dX7hDBekI28MxzD7+36mY728chwqfWtdhRx
	YfwV0Ey3nfW+Y8RFTRIMMSF6gfwhS4oAFWUohjOYycZbZkI3r3hNqV7g46A/ctX0IvJXn4yFIZt
	9I7cYtSpY1qLtWwGbJzzpn/KAAXqSUtrX27bsNFhKnmzuf0LllnhOIdgjjFQsQAIB8PLk7ZWO3D
	QjqVplfVHZujHYrA5i5NklkhGbor1RDVRAh8F65wj/Z9WGWMOwRVVqkJTR4=
X-Received: by 2002:a05:690e:1445:b0:64a:d7e6:a1e4 with SMTP id
 956f58d0204a3-65bff459cbfmr3311716d50.38.1777489222600; Wed, 29 Apr 2026
 12:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424031545.3777023-1-boolli@google.com> <2d8bd703-f368-4405-9266-d0d8824455aa@molgen.mpg.de>
In-Reply-To: <2d8bd703-f368-4405-9266-d0d8824455aa@molgen.mpg.de>
From: Li Li <boolli@google.com>
Date: Wed, 29 Apr 2026 12:00:10 -0700
X-Gm-Features: AVHnY4K-GqWrj9dfjsEYCEiuG9ysJ5WntmXLLc6b-8jqsGSXaVn7-1bjI0Zpo_c
Message-ID: <CAODvEq5xMxsn+N0VV=CEGfGQO7rxAc8UR=LBU6NHPAydPy9+kA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] libie: log more info when
 virtchnl fails
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 000C349970C
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282470-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boolli@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mpg.de:email]

On Mon, Apr 27, 2026 at 3:40=E2=80=AFAM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Li,
>
>
> Thank you for your patch.
>
> Am 24.04.26 um 05:15 schrieb Li Li via Intel-wired-lan:
> > Virtchnl failures can be hard to debug without logs. Logging the detail=
s
> > of virtchnl transactions can be useful for debugging virtchnl-related
> > issues.
>
> Why is the first added one added as error, and the second as info?

Originally I was thinking the second log doesn't warrant an err level
log, but on second thought, I think it makes more sense to use
dev_err_ratelimited() in both places. I will send out a v3 patch to
update it.

>
>
> Do you have a reproducer to get each of the new log messages?

We recently had an IOMMU subsystem bug in our internal kernel that
caused virtchnl failures, and this patch helped root cause the IOMMU
subsystem issue. However, the patch we used internally was applied to
the OOT driver, which is implemented slightly differently than the
upstream driver. Example log we saw in our OOT driver, with the patch
applied:

idpf 0000:43:00.0: Non-zero virtchnl ret val (msg: 523, ret val: 6,
data_len: 0) (xn 523, id: 254, salt: 40, iov len: 128)

The message looks slightly different from the log added in this patch
because the OOT driver uses different terminology.

>
> > Tested: Built and booted on a test machine.
>
> Please paste the new messages.

As mentioned above, I don't have a reproducer for a real virtchnl
error in the upstream kernel, but I synthetically produced an error by
changing ctlq_msg->chnl_retval, and the following message appeared:

[  309.891790] idpf 0000:01:00.0: Non-zero virtchnl ret val (msg op:
1, ret val: 6, msg_cookie: 0, data_len: 8); xn op: 1, id: 0, cookie: 0
[  309.892357] idpf 0000:01:00.0: Transaction failed (op 1, xn state:
3, id: 0, cookie: 0, size: 8)

I will mention it in the v3 patch as well.



>
> > Signed-off-by: Li Li <boolli@google.com>
> > ---
> >   drivers/net/ethernet/intel/libie/controlq.c | 15 +++++++++++++++
> >   1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/=
ethernet/intel/libie/controlq.c
> > index ebc05355e39d..7eaa77413621 100644
> > --- a/drivers/net/ethernet/intel/libie/controlq.c
> > +++ b/drivers/net/ethernet/intel/libie/controlq.c
> > @@ -762,6 +762,16 @@ libie_ctlq_xn_process_recv(struct libie_ctlq_xn_re=
cv_params *params,
> >       status =3D ctlq_msg->chnl_retval ? -EFAULT : 0;
> >
> >       xn =3D &xnm->ring[xn_index];
> > +
> > +     if (ctlq_msg->chnl_retval) {
> > +             dev_err_ratelimited(
> > +                     params->ctlq->dev,
> > +                     "Non-zero virtchnl ret val (msg op: %u, ret val: =
%u, msg_cookie: %u, data_len: %u); xn op: %u, id: %u, cookie: %u\n",
> > +                     ctlq_msg->chnl_opcode, ctlq_msg->chnl_retval,
> > +                     msg_cookie, ctlq_msg->data_len, xn->virtchnl_opco=
de,
> > +                     xn->index, xn->cookie);
> > +     }
> > +
> >       if (ctlq_msg->chnl_opcode !=3D xn->virtchnl_opcode ||
> >           msg_cookie !=3D xn->cookie)
> >               return false;
> > @@ -1011,6 +1021,11 @@ int libie_ctlq_xn_send(struct libie_ctlq_xn_send=
_params *params)
> >               params->recv_mem =3D xn->recv_mem;
> >               break;
> >       default:
> > +             dev_notice_ratelimited(
> > +                     params->ctlq->dev,
> > +                     "Transaction failed (op %u, xn state: %d, id: %u,=
 cookie: %u, size: %zu)\n",
> > +                     params->chnl_opcode, xn->state, xn->index, xn->co=
okie,
> > +                     xn->recv_mem.iov_len);
> >               ret =3D -EBADMSG;
> >               break;
> >       }
>
>
> Kind regards,
>
> Paul

