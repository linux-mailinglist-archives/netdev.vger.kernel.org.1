Return-Path: <netdev+bounces-281094-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHi/Eukd7Gl7UgAAu9opvQ
	(envelope-from <netdev+bounces-281094-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 03:50:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D3D4647C9
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 03:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01DC630097EB
	for <lists+netdev@lfdr.de>; Sat, 25 Apr 2026 01:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9082B221FB1;
	Sat, 25 Apr 2026 01:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GBNCB5DV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC4427453
	for <netdev@vger.kernel.org>; Sat, 25 Apr 2026 01:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777081830; cv=pass; b=fXLtNDxGK+7TarDgL4yVU7Dty8aHDMzX1LZHOSbpi8rh3BSRN4Isl52K8bKsKxf39oF21Z5wVm20gejAJlBwO7cXW+sQhfYKqsITa1gHt8BhyUYG9JREqAQklHdK/TpSdWVvrzcHBY5dWMUPbkRFdstNFJbGMRg3qcpI5mMNZ4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777081830; c=relaxed/simple;
	bh=GyjqbMF7EzqFtPypkMO1mPlYWzpM6bZhBaAIWxI+Owg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evLNt5/CyEYyfHGTEjZJEVbDietPMwuF+1tqkMxbQBYgmBsPAtd8MtF28Motg8kjS+BtrFj7n0wktHizCVGSqWDvGvHeXI/RU1OAEts2mDJed38aprzoPmPieXQj8Q7IAlBB4ElJ5cc0sPSdNa7Yv6kZ8lnbXUHky5HJSfJ0TNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GBNCB5DV; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38e7d983f79so64778331fa.0
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 18:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777081827; cv=none;
        d=google.com; s=arc-20240605;
        b=KPkjgiVppqtAXhr5FZ8hnpkILBeTr8rxV+A8BSje5mxT0OeNXLH/PpLvE/d8R8t0OR
         YsAoiM7Q9R+D6dB3J7otYfvpvbB/cRwrGbyvdoQbM8nqtIe6C91/AS2P5k1qwCchLUhB
         DPQ5kXV7vOzxOBGs40HS3ZJEWBC8C6J1XVY8bWmLhjojn68GyM6mxHTlOZyErJSF/bWC
         DJHUzQBpntgg8tyiceseoXLZ/J5arj1Y1yslSxyWAh1JQBvfsGehtZ2sZOc6nqsUe6A0
         Lj93vKeFOHTb7p18SqUfzyAjfALOXnYNa79zlkbGXzLq5QIG9lvhr3o6PSbbFO3FyxTU
         Gr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5yyNxj6NWUM+f89oZJaJqjwJPEfazVPGjbOFd9EG0Bo=;
        fh=RhYjmLYh6b0TcMDg0swPs9h2ibOgxjW+kCeSwNNwKNE=;
        b=XN/+7JzSL4+YnR+WZIBJMJ5M1Y0ojrHi5kx1Pcl/k2EFnCpyC8cME9cI92WiKOYsqO
         8R5HWWyf6ziCZV1xGU9XO0sZa7yPxvv4aOpXjrTkuvqKCeiPEWYRhAICGudQ8Ae7cmcD
         tSZAnozoBfHQRb2w57b9zuM0kJ3xJt0xi+Mllheh7Vz1enFuHmuAY6HEz3H3qE8LFfbS
         4x3QltYaMl2fB4rdK6fm1QAoA2eB5l2dq/u+H82x7+Y+qxdj316WfopKgN9Iiq1JZsXl
         FPpoPiv7GLq36CSlbPfDSZb7410LX8r0ZAulrt5DS5CGSWFDqY/mc5ai/C/QjaEivK+J
         CSeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777081827; x=1777686627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yyNxj6NWUM+f89oZJaJqjwJPEfazVPGjbOFd9EG0Bo=;
        b=GBNCB5DVOO9sUSp84Oo1asjfXpOcm2qLx9kOwDk+0ALParfIYrK3ztoyloJJTrOCpB
         mTY9SIMyP6wQg5xKstaEY9ifw1IafNbajMr+gr7fSS5GwwxxFRs32NOnN6qYcbV/TRNk
         x66fjvAncH1CjzoTilIUkQHgr9gOA3wjsAUlrF7CJWqTtP8bOkQbBtEusGyZyLNuQIRO
         orgHaoqzZo/k2bWPlbY4vOPufWM4LWajtU3G5L4Ajm/53BrO4xV/Ijs+z+87TXezERm0
         +0W5ti/NNL9RYXq7hzGDFS8oOwPaa4xxPos2WtJD2B6EUu85iS43339FbS0WgcrtaKsD
         Q8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777081827; x=1777686627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5yyNxj6NWUM+f89oZJaJqjwJPEfazVPGjbOFd9EG0Bo=;
        b=jyrVSRQeT9tY43RilV/SORIKZmgEI74nVGQvtyap8FsUBZX+3q2tCPsAbnydeJoBFe
         ZQ4yiZwWPkfr1Ml9lbzN65f97Z/JCgL+vuIFs0Cx3HjIYmc103UCw/j7AfSzurLf2iXT
         3c15bI8S247AOJmDZ6MG94tbCXJVmzwSrjn2qJ03DWarljz4NtzrRRKECT9TjdvJsk6r
         vQBGfavKnuXGEdG79+gmbxo8AhyajEMLYbxoHgXAu+3BnV/FbJODnNFuCdGiZv3uFltg
         E65qFkggcPJOowcexciCovOAFzszcRdLBFrZ/vGXAEJUtKwN4kALzdAT3UeVZEMSAh7s
         ZJZA==
X-Forwarded-Encrypted: i=1; AFNElJ8bGIx+O0KkmUxjyxmwccQWpQNzMWN3zkKZ2y1bU6hqj0hPPndLPMOse8miOATOH784SA/DAvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpxcr8LbJoAabec5XnT/y/3Ttr+MSPGfkQDUglGlATN5r5LmHp
	g4bNr/sA+32b/bve2Ym0q5OOxbBqy9dRnrjXOEQXB4diP0iZwUbub1kr3m0waAHhYHXjqN6/1jU
	hypUFlminJuiomnWQx/hQPny2xxEGTf89KcDRp3tQ
X-Gm-Gg: AeBDieuO8EKnqzNPNGB35kVsn1FIjJ9WpU9kTOoS4yti+p0xh/C+1DXhcgnc7X2ac2T
	soBqmvGvOufUSC60+1NjEWwYRalGdopkf7lC40bdOH0hZiCN5K9+RSj9ukJZ6FK+YU7JGrPyfJ1
	/lEJDNEKSJm2aPsVrZ4zOeoZreQ0B68JrODC6zQSH0cKKTH1b23ABhRws1/5FqPHlNDGyQayp+U
	n2eXZqBbA1AploHVVPRzPWk6rL7i7bl6mMjnuc/xWx9U7k2gEDvHhf15+8+HK5LEM8ycu50eUIu
	b471G8pd9VvRcJhZOjP32l+Yf8F0AU82DX43i3eP
X-Received: by 2002:a05:651c:154d:b0:38e:a00e:2bb5 with SMTP id
 38308e7fff4ca-38ec7aa49bcmr112416431fa.19.1777081826490; Fri, 24 Apr 2026
 18:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424031545.3777023-1-boolli@google.com> <IA3PR11MB898659D8A18DF05024CB56BEE52B2@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB898659D8A18DF05024CB56BEE52B2@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Li Li <boolli@google.com>
Date: Fri, 24 Apr 2026 18:50:11 -0700
X-Gm-Features: AQROBzDeobX20L43pWhysvIHG0YsODdmZoEaU8gLVt6v_GL31LiadtmkaQyrvOM
Message-ID: <CAODvEq4Q-4ko=AoaAVaGvFJmk3OvUJKL4ZcQhvYojjqdeGjc3w@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] libie: log more info when
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
X-Rspamd-Queue-Id: 99D3D4647C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281094-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,intel.com:email]

On Fri, Apr 24, 2026 at 9:08=E2=80=AFAM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Li Li via Intel-wired-lan
> > Sent: Friday, April 24, 2026 5:16 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; David S. Miller
> > <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Eric Dumazet
> > <edumazet@google.com>; intel-wired-lan@lists.osuosl.org
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; David
> > Decotigny <decot@google.com>; Singhai, Anjali
> > <anjali.singhai@intel.com>; Samudrala, Sridhar
> > <sridhar.samudrala@intel.com>; Brian Vazquez <brianvv@google.com>; Li
> > Li <boolli@google.com>; Tantilov, Emil S <emil.s.tantilov@intel.com>
> > Subject: [Intel-wired-lan] [PATCH iwl-next] libie: log more info when
> > virtchnl fails
> >
> > Virtchnl failures can be hard to debug without logs. Logging the
> > details of virtchnl transactions can be useful for debugging virtchnl-
> > related issues.
> >
> > Tested: Built and booted on a test machine.
> >
> > Signed-off-by: Li Li <boolli@google.com>
> > ---
> >  drivers/net/ethernet/intel/libie/controlq.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/intel/libie/controlq.c
> > b/drivers/net/ethernet/intel/libie/controlq.c
> > index ebc05355e39d..7eaa77413621 100644
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
> > +             dev_notice_ratelimited(
> > +                     params->ctlq->dev,
> > +                     "Transaction failed (op %u, xn state: %d, id: %u,
> > cookie: %u, size: %zu)\n",
> > +                     params->chnl_opcode, xn->state, xn->index, xn-
> > >cookie,
> > +                     xn->recv_mem.iov_len);
> For me dev_notice_ratelimited() level is low for a failure messages.
> Why not dev_warn_ratelimited() instead?

Good call. Switched to using  dev_warn_ratelimited() in the v2 patch.
Thanks for the suggestion!

>
> >               ret =3D -EBADMSG;
> >               break;
> >       }
> > --
> > 2.54.0.rc2.544.gc7ae2d5bb8-goog
>

