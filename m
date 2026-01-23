Return-Path: <netdev+bounces-252678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMtjEu4qc2kAswAAu9opvQ
	(envelope-from <netdev+bounces-252678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:01:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C74572202
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9BA7300293F
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 08:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6E2318BAE;
	Fri, 23 Jan 2026 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HhoEeZVP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D47E2DB7A5
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 08:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155303; cv=pass; b=SNcUOrOKZi4D9D0keTjGP9HYMZ/ZxciOHPLZQnrkitOpPmVchD2tI1NyLjGM9ubXmFnc8NA5bsPA0Be7lt408SXq5qw+N22CAzUO+8hg4nuDK4YH27c2WKpvJeSt5myVv7cgnapI/zLNxRlSFpkGBb4R5WDBHZBTFGIlyMPCwEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155303; c=relaxed/simple;
	bh=GJkK3rUKMUOTZKWSY5hlnWXIlF/ou14SoMrd2p7HLp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lAmDiGimZ7b+k0qdDYwwluLbZefVPsCyItKak8GEmlfGGPty8/7WUtbf1AGK9jNLoEHWpT9GLp0g6U4TI33s9LJevLN0Pu0bZaI/RwAA5ClZWWsTmZt+UO/y3s1pMnviwbvcAU/LZpb6I82nk6FiEKr0iLdHhphYT6a8H7L4fNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HhoEeZVP; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79407df9391so20314287b3.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 00:01:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769155301; cv=none;
        d=google.com; s=arc-20240605;
        b=TIVdEDqCV58DO8d4BtYfDnz7axNhZAuAiBcrVk0YXHBFXcIWItZXzx6kKBVEwlyFSc
         +fvbkSq31RzsWInhXzmVI7mQw/CW2CmV7y0eezNjhTmS+4lIq+OAGgr/C9mUxpOCHeI5
         m8zsuI1PZ4UfulXTroc1oxsrdCdXppCq9nNlPyy+TzX/8WilFCyODEHhzM7qk1xfPyu8
         vx5FAB2ppJmQornmoeYXD2BLmQ/3U6gPclQL374zg/WPBmhrxwzavKzWz/Y1JKbELPOO
         7W3njkwK/m1QW3nc44/SnSkgZ0IGxSrqq5eX+8Ib4YHQCXRRchNfIlwfE8TlUOKVqTFD
         hbuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XxEzPXEdWw77sDxj6DEsi0W7qZPCnpvTxUBQhuSSYH0=;
        fh=57GRB7DlKF4Rm68qZvs52iV4FlQ6vqLzxMkrIOWLfh0=;
        b=Et8Ib+/PtOmBXBMcGwvczzvek/kUeNzXOrZ1/x2jqhNLOCbbQqFqZG3iHRWpIBVh2K
         dMqwUqjA7POoFNuPH+MT4g3vOrQMJb74Aoi+JPinayKZ4oGfbq7G2hU+54sRmYBO86Xd
         Y0AYaZMsCQ9c8Ev6cPUt5SD1QhUI27/2IN1SVTXW0ooJupvgbaTMViQldGXsMQUGfX1F
         nlGiZ97NFjig2zL2yboWxycRSHQn4V2+8rNjjjz8tvWt8beltD5TDoc3hZhEecsny3l9
         KvdMV8oqLc9VvRPIZEKPdeHR7PCjkeIUttbIeKimztkeJVWZFzlPNRSrHxc6Z8ukPpWO
         sI3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769155301; x=1769760101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxEzPXEdWw77sDxj6DEsi0W7qZPCnpvTxUBQhuSSYH0=;
        b=HhoEeZVP4lZYI1kRiLWCMCQ9wlya1AYKQOu6ieGxms5aAveWOJvafAvaQBWzuHB6Jt
         ylvTzrTvtMskwf3C1GleWo4YkEZHUPE2dRvMRen5Zq2vCrN3WTmLPG0tyA9cSG004rR0
         z+WLoCet9nu8J+uUnTorjlRkEpKZV27wz7NeFQoAnFFvswBeUYhVznnyLn5rq6vL1Dk9
         S2prHNWl50fAvscmEV7HMhvBbBmUMEkTdJnhER3i+2SJcTLdmj1yuRrRoYCaslIKPDj/
         /vxrl+PeOUrRFKEd2wizAcDtAjkhru6Y4g8I4f01DCnv7Laf6H8lPxTkXwmkZfsM9lIe
         1RDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769155301; x=1769760101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XxEzPXEdWw77sDxj6DEsi0W7qZPCnpvTxUBQhuSSYH0=;
        b=d8OAnaQ9el7gYUlh2JUaPwRtcJ3vMZay0ZVBaO5urewNgL3G/FPO6WvrWhM3u5eUx1
         y9HEZZrRn50eaQ4dGlkCoyjulp4EjtvA9E0TnsbIwd2LF+1O5/mOGtv/9WsvGqlKFh6E
         ocTfa4JS+Eg9DRmROQVekaHaNMfu06vxzTZg3EW8GCamvm8Y0s4mmtuxkoj2UoKAluM/
         NioAAuVPqCZm2awposZ3AZu7SweiRXUEqHzUPvaIV0B19r4/9z1exaDXvullOH3ZgsEC
         LdH3Tnh9MRPMR37ozERSn4RdG5NwzeBPPmH1mGqf/t8zu5Br/gY21UePldfzgPWRY3O1
         QSbA==
X-Forwarded-Encrypted: i=1; AJvYcCUHgN7QHfDUHthjoE8nX0r4HFVWlz3JyzKsGDvW13K0Qxv4T8WbR4PZXMXO4H18HGAx2Y/ktP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT+as/PyMcy6Ig/2Jx75cnVviWC/Pihs8j/4FbIsPLY97c6BGr
	qjBh+ZWKsVNbZxD8jwcBqDhEwI6cqG90bLV0QyT34HKMVWSdQtjPktrVssv9ETTocH+W7SWkXSc
	hTqxANcPhl++K0p5zF1Ul5frsJ8X6b6nbsvPDTsUh
X-Gm-Gg: AZuq6aKhpmjl4gEdFkQn69zZSEI5IE52eDWJpCfatNmSKVa4hsmWSdKcBGOUPJsOvDR
	V62DhFEVzT5Kmv0KAbPeD8mgUTqRc0bhvQ6U994KFCvkAFvvbBxbIyL6dNCVwgmE/Vls4flCJ8g
	R7wVd1dAtBc077Csl4Y4P3vm/GWackzUCpQMGvzQI3OJCmbKuBziqvn4Mv3j+RwVhGc0VViWdU8
	OLkO481rUMkfgEsnrhDodlDiUXfsVW9iUDjEGBZE19ofeZQpHPgxqz/pXEYmRZavXMxQHdf
X-Received: by 2002:a05:690c:22c7:b0:794:35b:af4e with SMTP id
 00721157ae682-794398bd2a7mr19001717b3.1.1769155301214; Fri, 23 Jan 2026
 00:01:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123065806.3858623-1-boolli@google.com> <IA3PR11MB8986E9CEBE2CEC78B194DF40E594A@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986E9CEBE2CEC78B194DF40E594A@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Li Li <boolli@google.com>
Date: Fri, 23 Jan 2026 00:01:28 -0800
X-Gm-Features: AZwV_Qgew1aO4BNhErlckVjIeXAZaN1uh0mrYp1eWCPHnncTX6MKyTxTP1SLhAY
Message-ID: <CAODvEq7yoXMvhkZhzcF4rgaceCnxCfzgKbSa5+SMVMO1X+XgdQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v2] idpf: nullify pointers after they
 are freed
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252678-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[osuosl.org:email,mail.gmail.com:mid,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C74572202
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 11:15=E2=80=AFPM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Li Li via Intel-wired-lan
> > Sent: Friday, January 23, 2026 7:58 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; David S. Miller
> > <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Eric Dumazet
> > <edumazet@google.com>; intel-wired-lan@lists.osuosl.org
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; David
> > Decotigny <decot@google.com>; Singhai, Anjali
> > <anjali.singhai@intel.com>; Samudrala, Sridhar
> > <sridhar.samudrala@intel.com>; Brian Vazquez <brianvv@google.com>; Li
> > Li <boolli@google.com>; Tantilov, Emil S <emil.s.tantilov@intel.com>
> > Subject: [Intel-wired-lan] [PATCH v2] idpf: nullify pointers after
> > they are freed
> >
> > rss_data->rss_key needs to be nullified after it is freed.
> > Checks like "if (!rss_data->rss_key)" in the code could fail if it is
> > not nullified.
> >
> > Tested: built and booted the kernel.
> >
> Good day ,Li Li
>
> Can you re-spin v3 and mention the reproduction steps (exact bash command=
s)?
> The CALL trace from dmesg also is needed for users/admins to find the fix=
.

Thank you for the review. This patch isn't to fix any kernel panics we
encountered. It is
just to address a discrepancy I observed between the Google idpf and
the upstream idpf
as I was preparing for another patch about to be sent out. So far we
haven't seen this
particular dangling pointer cause any issues yet, but it's still a
good practice to set it to
NULL because there are other places guarded by this pointer being
NULL, and it'd be
great to avoid any race conditions.

>
> Otherwise, fine
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>
> > Fixes: 83f38f210b85 ("idpf: Fix RSS LUT NULL pointer crash on early
> > ethtool operations")
> > Signed-off-by: Li Li <boolli@google.com>
> > ---
> > Changes in v2:
> >  - Remove the line to nullify vport->q_vector_idxs as it is not
> >    necessary.
> >
> >  drivers/net/ethernet/intel/idpf/idpf_lib.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > index 131a8121839bd..f63ab58428d2e 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > @@ -1308,6 +1308,7 @@ static struct idpf_vport
> > *idpf_vport_alloc(struct idpf_adapter *adapter,
> >
> >  free_rss_key:
> >       kfree(rss_data->rss_key);
> > +     rss_data->rss_key =3D NULL;
> >  free_vector_idxs:
> >       kfree(vport->q_vector_idxs);
> >  free_vport:
> > --
> > 2.52.0.457.g6b5491de43-goog
>

