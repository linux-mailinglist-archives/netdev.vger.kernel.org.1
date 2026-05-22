Return-Path: <netdev+bounces-290880-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E4xOgqHEGriYwYAu9opvQ
	(envelope-from <netdev+bounces-290880-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 18:40:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 472B35B7AB5
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 18:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21BFE300F1B8
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 16:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38896466B4C;
	Fri, 22 May 2026 16:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="YXbqv0UI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AC0370AF3
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779467834; cv=pass; b=AtvHDHwydLaA3pekC42d20a0vUGew8UpyxPGGWHjvTX5sUxVjJBiB/yXe4sgHHUcg6qIB9eHBApD3EXd0qrph16mxKAqIMQB79QS5Rv8nP5NlsKUpp7LDsABEq1L80zRaBWx7Z0297KU8eyN9UbLkQg5xbbIQZoYwULTx3hU0TQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779467834; c=relaxed/simple;
	bh=76y8Gg521Gq4z/pQqwzT21k8ukCgNqmRgtiEt803BD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dra4uu9EBPH1+KoMUS8I2kCCa/7uGegkxSW65H6B5ef0aZaa+/JTiIlL894qC06tsJC6V1SQM3YkcntGeP9B63DbEyF8Ae+1+UC3aczs4MtAxNQc1KTJZzBEy4A/dwL120E3W+fhNTz7XTQc8GRr4lOrrp+GecFIvE/827gk6JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=YXbqv0UI; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-83659d38e38so3070599b3a.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 09:37:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779467832; cv=none;
        d=google.com; s=arc-20240605;
        b=E6b4VddOtWZxw5iZ9oAYrYm1VNIsRh0qASwVP0eI+svCiwWGZcX5zjO6eLrJknR2YG
         Px0C9LqBDHqG47hgc7fWUPolvubizb0M+P5yOYSFraUGzMSslpXBQ+Laiszs984tr3eC
         aGiqUr0RLm4maVakv4eZSQQeRpSCDyjLtJn3laIXyhAukHNyxyvoHqlmmxb742e+z3ZP
         WJHfUmmgcAbWGrLwBEkMrwahHPkiid0ixs+6ppF3D1RV0JnxEahZSl56FfvfYDF38f03
         rOzkbQqQvo8CAbrlWccSe6tmmIrjZ9z2LIGQbbI9GrH5xtgc1nEEpVByy8iqojX9oiVL
         vCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jwLIPPDok5YoxtNbyIvqQLDNvm2H7QwxxOk2Al5XXBU=;
        fh=ed0wsgbXVW8OiKNOgefYn4X1VCp+4L4hv+If89R9SrQ=;
        b=GNzvtqb5JQTjREzTx2Y5WoxTIwtOHWL0y+LjQiJuOZkftRT8gT06BDKfNo1LMIuFpN
         Kwa5FKwJyPjJzbLW6i/WDtevF0495wuApApCTWm6PqnWmPQrjbe5jgJOk+cKArejG+EB
         f77pxxNhAOeTpFObBzlLXVo2PPM1pMT0iHlmSRApdqZPaGrJ6IVnJqAsYpsBbaunJFaS
         oUlCceBBlvC5oNMOVY6vV/Ls22gUBPWo+0KJ66rHpNA/VU5jIamQ7F8iISVYaEjrLYEC
         1KtgfoL0v3alGnf8WLqdns7NxrJpwKCwOL0+2EDsBCflfbB5mKPcfbT1lOCbVOt/TnwF
         9aew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779467832; x=1780072632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwLIPPDok5YoxtNbyIvqQLDNvm2H7QwxxOk2Al5XXBU=;
        b=YXbqv0UIrL29rYc604zhUm4i/eajo1YEOQg9LViN2nIR51ypalfQ4/wn5asfjrhXHV
         VcP+XLscL0Jnhxh/FGZYZ6eJSOV+h6y0MVKFn7YoCiSjWqoJOcSfD2OV9+tCFovnWn4t
         HnAmgWtYIDFa+T3McFAMvWLGz3WYPDXDQY045QsLthKmztG40Cu4RwQcQY1QlPSqstYE
         rkIclQncz3DFwJ5OWBGFpjIkSIohdAM0SBbQB9goj1+0KWNdJMn/3SAvcnO25wJaOVeK
         jMgoeMMsMXHLxoLPb2lxTiFlgof2eGeGRuu5yEZ+L1oXbt8a180CBVOj82LErdaTlxFd
         wAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779467832; x=1780072632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jwLIPPDok5YoxtNbyIvqQLDNvm2H7QwxxOk2Al5XXBU=;
        b=Es8H1V+T/IHKMOezJqZQjJXdblC+ULGTWBu5m5Ft93VbNxdkDY71MFgH2DdSFyB4Z1
         59qSgni1uUSXV6PJJYyxwQpDpM3O+8RWPFZvNx8kndZD2vIxFRvbnV9iA/3fCvpHNB7z
         KLjfIA0gKvNrLGbXPkzEjzPiqvj1Mg9YyWCzej+Qfu4KFKAguxlBIp5kbVcbDRs++JhR
         RLe2TK7sOP2lhUGM1rzZ3E5EndGwnpEwKSmZQ20rKjwLuxF2dX0FSnMwb2Kxzc+QDUEJ
         /M5STL+RILMZe6hmnswuzhLXD5+YHkXuBZB7DqqJJd+LVLQz/vLWjqhLp/yDszXJqHGV
         bT+A==
X-Forwarded-Encrypted: i=1; AFNElJ/vonixw2bTCWlZvxK0kOqtF2SDWOTyVdwMPs82sMSL3g7Bccu9hzL8d4RO1P0I9YVYOTIQwAU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2SDvlglRuljGWtOcH8LYZ+j3b/2HhIYuXSSikjSOq33j0WAly
	2NsTF3bC3aE0/K/3swuizX9uM1/EmZulzZAWUR6lCICFYeLIKNsHa6bbEAyDCQbkv6KvtJtgN2o
	gTAiXuGw51L40aukO6YHn64A9Z8Zft1Q1ZwtvcJZw
X-Gm-Gg: Acq92OGeGFyoPVWYY6CoLSv0BIBXfljlO6zGZ/R9JVuA+Y41xZVmiDNYcWBzEdKk1sL
	jU07rZBRVGq9LY2WoouR98Vi9QPtzypN5bKigPDEiEX0sC0IB8G2XkXuKsoYPp9OMfnUaPGdOVI
	D9xy943ykvCIYrdmGxOwPMHKYzGRz7vRYIuEOvzd4ODDCPoFuqzriLmUkzr3mP3gECMNyvNPzaV
	84jLtsVcUl/zW4D2ePPLtGCX+ITfsU8yLzkkPuoAbZbd34CLBSFk9yOb1sb1zjk+zNXeg+a0+cJ
	IWNaDZWTOQDEHxbof3eJ/kdskr8GtA==
X-Received: by 2002:a05:6a00:887:b0:83f:2568:d45f with SMTP id
 d2e1a72fcca58-8415f407d26mr4734837b3a.23.1779467832184; Fri, 22 May 2026
 09:37:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
 <20260519033950.2037-1-rajat.gupta@oss.qualcomm.com> <CAM0EoMmj-9uDpKBN4vjJqzaLQL=OZ-sdFO_pHPFp6kL6hSVeRA@mail.gmail.com>
 <CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
 <CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
 <CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
 <20260521073526.793d30c3@kernel.org> <CAM0EoMnvrAxGC=bty=ZUXG6XDN_hTNZiy9LSZhNicEdbe8DghQ@mail.gmail.com>
 <20260521084640.683c1ee6@kernel.org> <CAM0EoMmNWYzryfc5=4R0SkW+wfVhBxO3tAH+KeoMP3sPr6yrFA@mail.gmail.com>
 <20260522084611.390fd0a6@kernel.org>
In-Reply-To: <20260522084611.390fd0a6@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 22 May 2026 12:37:00 -0400
X-Gm-Features: AVHnY4KAo5hFde_m4mScZOCqbjPlKZRdY7HOliphM0iIVgMFDfRe1wYNpEJRGR4
Message-ID: <CAM0EoMmKQc3oqDDiz5jGmwc8D3eTWd2wgst0MWEvXpPZHn-C7A@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
To: Jakub Kicinski <kuba@kernel.org>
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	jiri@resnulli.us, yimingqian591@gmail.com, keenanat2000@gmail.com, 
	2045gemini@gmail.com, rollkingzzc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290880-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,resnulli.us,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 472B35B7AB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 11:46=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Fri, 22 May 2026 07:47:32 -0400 Jamal Hadi Salim wrote:
> > > > All these issues stem from the shared frags point, but the patchlet=
 i
> > > > showed is unrelated to SKBFL_SHARED_FRAG, it is more related to
> > > > cloned+frags.
> > >
> > > Right, right. Just pointing it out cause Rajat's patch adds another
> > > skb_has_shared_frag(). Which we'll then have to delete in net-next :\
> >
> > With a note that the exploits currently take advantage of that
> > specific cache issue. How about we allow it for net now and then
> > schedule a follow-up phase to remove it when you get rid of "shared
> > frags"?
>
> I must be missing something. What's the problem with changing the patch
> to pull headers instead? I mean - if we agree that this is where we'll
> end up - we should just do it now. It's the long standing kernel policy
> to "fix things right" instead of creating temporary fixes which then
> have to be reworked in -next

I may be the one missing things. You main concern is with this:
+       /*
+        * If the skb has shared frags the user is likely using zero-copy
+        * (e.g. sendfile).  Those page frags may point to page-cache pages=
;
+        * writing into them would silently corrupt the page cache.
+        * Linearize so pedit operates on a private copy.
+        * TL;DR: if you want zero-copy, don't use pedit.
+        */
+       if (skb_has_shared_frag(skb)) {
+               if (__skb_linearize(skb))
+                       goto bad;
+       }
+

i.e you want that gone, correct?
And my concern was whether removing this still exposes things to
exploit even if temporarily.
Likely it wont. I have time, let me test the exploit with that code
ifdef'ed out.
I didnt get the "pull headers instead" part.

cheers,
jamal

