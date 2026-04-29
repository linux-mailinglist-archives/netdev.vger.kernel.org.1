Return-Path: <netdev+bounces-282168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CwPNT5d8WlrgQEAu9opvQ
	(envelope-from <netdev+bounces-282168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:22:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 602AC48DEF3
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 03:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8DA5B3012B7E
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 054D5192B75;
	Wed, 29 Apr 2026 01:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eJYcP4Xw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D9C22301
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777425722; cv=pass; b=sOmD7X9pxQZcaqXCZtK1RvakbCPYor/k/nwPQ1JBwap9trvWHi6IOVXnG32+6/+Yh3bMBvRhS1TEptJFFHtv7+tbN7u0ke4urhz9nf+RlWuJ2kcK8c2M78jUZbFJTyaYX+bpmAj16uJ5GDRwHGtLV/VLo82iMp2T/bXFhLfJQwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777425722; c=relaxed/simple;
	bh=U8KzlrzlJEsgqTs9SFEVRR/SDO6JzbWDt0mzXXMsstM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyGRp1S7pAKDUHnD6Ie6WafezWRsFcDxrDeGFgOkuX5aN5A09wems9+IDeTIwcC2r1U9cc0WjZJzimib6RG2oTq9zuBCLWuL+BcfZg1gEYBEAaJISm/68tn/rMi/8MK0MUw/PP648UAa2U/A/zv6ex7iMbDfSBKezke7woefd+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=eJYcP4Xw; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4648447e29bso3613622b6e.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 18:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777425720; cv=none;
        d=google.com; s=arc-20240605;
        b=Z7rK7PIzgFiWvsKjfMlQ2IiIvIfpTn4mVvurZT8YZwrQaQYKDKYKkDAtLO/sOG+qT5
         UbRlXha+LLHc9SLbmk8zogngUPAzvrtkOq5+HyflrkNosNjoirLJs3IIgGZW1C6pJ+nk
         igORjEnbszIU++VOqkjV7kr+7O0EG8mSZcxhgEqAKGnHEY6QIEHMmEAFcw+pwjT4rCfA
         3tE8sPKOyQsEJeh1hZCx9G41y6sldOnmtHchchkIzdj+S3RKGeW9ToQJTh+cJaeZ34rE
         VLNH8pYQaVu9vShAviF/fwDqDFeqwSVzGkw+CaxWFmVTKc1HvlqdskC8tL9HSoZPtb2b
         HSUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6f4tckrLY3J7+4J32u1EKG+jNDMEtwYZPpMg9Iuh0zQ=;
        fh=httzaqpObjgLPh44MqqrDpROWq2sUlnbmFm7co5PEHg=;
        b=Wu0v94YmmOIk06Hj99xAmCq1JQipdCk4mdNw2Nz1K/NyvxJV1OTRKRggoazL4UVhtg
         vrxbnVVXO1QXxNu8fSsft8ZOpISUB03Xg2cuF4gUchBO+MLdFlHD3HZEQe+WUvu6/KiI
         AaSxcVIJkvpve/9txb558FL7n6U31OEHr96eAGvf9Q2V1Tl3174anZSDAF+oBtquWiIv
         mysdvtzR4h6e8LyrWyimm6fyTJda3owu5AVHYQiMtYvfaXSBHS9wDzNwyrFCxmWm7HuF
         ksCyIKnIEqorBKZV9ajAevp4ci2yhgqNNyRPzq/n/lxmxWQ5HRF1ZL63GOLTkR47jrBG
         mdng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1777425720; x=1778030520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6f4tckrLY3J7+4J32u1EKG+jNDMEtwYZPpMg9Iuh0zQ=;
        b=eJYcP4XwaB9ic/KGQqsxByuRg5ycByJlhQU7urJCIOTGZS08ijpMYPr63ZWLDgu3zD
         IG1ICxAE8hbTRERN0dq+JwX2OgYTPQunQFKtp/qU+wHRAJXiy17swaUs7B2TKI3X0QIT
         I45v9GUyVIu504QqcxKyW8h4wx8wTcaUszmOC4D1dbLy8LevpYuGnPycQ0FOeJHZ6Ska
         Pc6JqH2TZ6kPBonbp8nsYRa/UoprWub1Cx4nKd1sux+6NCqgjMUVFGOAStQ42Z/zg69Y
         D+E0EryHWPHXvynEfGmPkfDSAwb+71sUHwunN/VVjK28qhLNjlGdNpXHDWzFM5d7QfW1
         zypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777425720; x=1778030520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6f4tckrLY3J7+4J32u1EKG+jNDMEtwYZPpMg9Iuh0zQ=;
        b=FJOyQchEw1AqafHi7NbYKEdoOS9G236mqrIHfXt14FSq7FBVjXtTSA4K/f3XXgY5J9
         BD+5vS9/S5pzi/AhTtQuuZhvdsT/TWJFqbOdyiKRAdCk9l61M3Qvz9lBfQIn/G2/9zPD
         NDEO1hd5M1KntbJCN46BTa5Ha39wA6DpB2yHdix002zxsnjOFxZuDGZe99Aahuwu4Kji
         UVCF4g6OdT/W5Y6ge8ECW48K+WVZpAHxJpiu1M9W1GQn3QVZ6pMuOXQmCpNq9pskzB+1
         CxQYqOTALAChz+JoVCbn41OjUL0YcRrJSvwC+JoRMPl8UXZkIj6CaFlQatl1JZ0VXksX
         EpIw==
X-Forwarded-Encrypted: i=1; AFNElJ/dL8foatl2SiYZfUlYcvGSfPtGKVlH67SvlCjhIJ2MA9R8ALvF1STA98mEOMuMfCvXpAx4CWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ZbRI3TDlTcd2hJH4dKYKK7z/u8OZrd9ITUfUNP6NqQgU2y5i
	SKHmECHaBg6/DM+AoSKpglon39+VswV0Gd+08UbfQXVf7oONlu1jQnvdGEpuECEkrG0MZYr6vxH
	n89kM292uLSeoxTYOUFdqRZMaIc5mqyuMckazxP4YYg==
X-Gm-Gg: AeBDiesEDwFLTz8ucE2eoPgPb1QMYL8yQrTL7rANjaFa+/4dkO34rK7tFu17bQfEo3I
	U0c8K30/WIAxNA/NwfMat6cHzxXaIwFZU+cBgWbldNl4rkt2myW2wcc3tB54NeYXzxpZUTs2OsR
	hXeGh9vB1S/gKuD2hLICk97gu+Eofk4fbfqANulSHTKewRilpr7RJG1Qnp5btcm5TRJg3Fv/DU4
	26m83XfwiICj6CMl6MpN0mqJBlA6x8m+gADD/hWnFt/7mwrqFXBF5Btg4dAPOqMhdytdx/IzMtv
	1oScaHGfvjeOQ//GwmE7
X-Received: by 2002:a05:6808:1929:b0:450:bbed:7a75 with SMTP id
 5614622812f47-47c28f816bcmr3004473b6e.28.1777425720132; Tue, 28 Apr 2026
 18:22:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427031158.2665916-1-vincent.chen@sifive.com> <f9fbc8c3-3b1d-456c-a389-4f95bf07822a@molgen.mpg.de>
In-Reply-To: <f9fbc8c3-3b1d-456c-a389-4f95bf07822a@molgen.mpg.de>
From: Vincent Chen <vincent.chen@sifive.com>
Date: Wed, 29 Apr 2026 09:21:49 +0800
X-Gm-Features: AVHnY4Ldv6uyCJi_ZE8aGxC2v2tla6lK0w3XQ3_fjdXzKK6Ue5badKUDFLkz3tE
Message-ID: <CABvJ_xhLj+GKpsT2wDNXoS_oWJoydR0h0qxa3BSxSTCvC2-bVA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [RFC PATCH] ice: allow creating VFs when !CONFIG_ICE_SWITCHDEV
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 602AC48DEF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[sifive.com,reject];
	R_DKIM_ALLOW(-0.20)[sifive.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282168-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vincent.chen@sifive.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[sifive.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mpg.de:email]

On Tue, Apr 28, 2026 at 5:45=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Vincent,
>
>
> Thank you for your patch.
>
> Am 27.04.26 um 05:11 schrieb Vincent Chen via Intel-wired-lan:
> > Currently ice_eswitch_attach_vf() is called unconditionally in
> > ice_start_vfs() and ice_reset_all_vfs(), which causes VF creation
> > to fail when CONFIG_ICE_SWITCHDEV is not defined or switchdev mode
> > is not enabled at runtime.
>
> I=E2=80=99d add a blank line between paragraphs.

This is a good suggestion. I will modify it in my next version patch.

>
> > Fix this by adding switchdev mode checks at the call sites before
> > calling ice_eswitch_attach_vf(), consistent with how
> > ice_eswitch_attach_sf() is already handled in ice_devlink_port_new().
> > Also remove the redundant check inside ice_eswitch_attach_vf() itself.
>
> *Also* is a good indicator to make it a separate patch. I=E2=80=99d favor=
 this
> in this case.
>
OK, I will move the code snippet used to remove the redundant check
inside ice_eswitch_attach_vf() to a separate patch in my next version
patch.

> > This is similar to commit aacca7a83b97 ("ice: allow creating VFs for
> > !CONFIG_NET_SWITCHDEV") which fixed the same issue for the previous
> > ice_eswitch_configure() API.
> >
> > Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_eswitch.c |  3 ---
> >   drivers/net/ethernet/intel/ice/ice_sriov.c   | 14 ++++++++------
> >   drivers/net/ethernet/intel/ice/ice_vf_lib.c  |  3 ++-
> >   3 files changed, 10 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net=
/ethernet/intel/ice/ice_eswitch.c
> > index 2e4f0969035f..c709decb26d5 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
> > @@ -512,9 +512,6 @@ int ice_eswitch_attach_vf(struct ice_pf *pf, struct=
 ice_vf *vf)
> >       struct ice_repr *repr;
> >       int err;
> >
> > -     if (!ice_is_eswitch_mode_switchdev(pf))
> > -             return 0;
> > -
> >       repr =3D ice_repr_create_vf(vf);
> >       if (IS_ERR(repr))
> >               return PTR_ERR(repr);
> > diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/e=
thernet/intel/ice/ice_sriov.c
> > index 843e82fd3bf9..6a0b724e46f9 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> > @@ -484,12 +484,14 @@ static int ice_start_vfs(struct ice_pf *pf)
> >                       goto teardown;
> >               }
> >
> > -             retval =3D ice_eswitch_attach_vf(pf, vf);
> > -             if (retval) {
> > -                     dev_err(ice_pf_to_dev(pf), "Failed to attach VF %=
d to eswitch, error %d",
> > -                             vf->vf_id, retval);
> > -                     ice_vf_vsi_release(vf);
> > -                     goto teardown;
> > +             if (ice_is_eswitch_mode_switchdev(pf)) {
> > +                     retval =3D ice_eswitch_attach_vf(pf, vf);
> > +                     if (retval) {
> > +                             dev_err(ice_pf_to_dev(pf), "Failed to att=
ach VF %d to eswitch, error %d",
> > +                                     vf->vf_id, retval);
> > +                             ice_vf_vsi_release(vf);
> > +                             goto teardown;
> > +                     }
> >               }
> >
> >               set_bit(ICE_VF_STATE_INIT, vf->vf_states);
> > diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/=
ethernet/intel/ice/ice_vf_lib.c
> > index de9e81ccee66..71595410174c 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> > @@ -807,7 +807,8 @@ void ice_reset_all_vfs(struct ice_pf *pf)
> >               ice_vf_rebuild_vsi(vf);
> >               ice_vf_post_vsi_rebuild(vf);
> >
> > -             ice_eswitch_attach_vf(pf, vf);
> > +             if (ice_is_eswitch_mode_switchdev(pf))
> > +                     ice_eswitch_attach_vf(pf, vf);
> >
> >               mutex_unlock(&vf->cfg_lock);
> >       }
>
> The diff looks good.
>
>
> Kind regards,
>
> Paul

