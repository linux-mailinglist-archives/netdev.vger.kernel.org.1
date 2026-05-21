Return-Path: <netdev+bounces-290526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP+MGok2D2qSHgYAu9opvQ
	(envelope-from <netdev+bounces-290526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:44:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B820C5A988C
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBA99317B10B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811B83314D0;
	Thu, 21 May 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="JJcVC9WG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06453191F91
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376608; cv=pass; b=rI+0qxqkZDktZH7KdWgZHzdtX2ssuC2UBV/O/BX3V2kary1Hdshl4Iqd9arSReHbA6cpwMD/DXLuj0IDvxn9flBu4wHX3/u/2gUnEK4mUiDHYygab3VOLBjz1n7kORxWQ5VwnOoDUYd/cADmWRXNjfoSMPsVeB8Z4IAgcDuQ4Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376608; c=relaxed/simple;
	bh=26j+zFQVnL9+xDmG+F3PK2BE27i4TrDMe2F4EC2sDzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwl2J6T535Rqtaq4Tp133CYWlGmH+594OUqXuFsoaLgZqHR5yOmUcvKiNWFtceTNzzm7YoW8ViLx32XoArSpPZwBW/e79Cs5ENESusFawBtwXZ6brxL/SGsNtFW/grulOmDJyv0e3ptc5wFBNttrdMYt8hEGYYOIZ4eJb2hrLaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=JJcVC9WG; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8353fd1cb5fso3036422b3a.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 08:16:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779376606; cv=none;
        d=google.com; s=arc-20240605;
        b=EC+ZD4Tp+i9OzoehtS2sXs9jjzPOQoYQzoCgMGBQjm0NcALjXnkGv2QtxwKfM6v/+Y
         0JyyyigGbLuq9ZxMoFml7B6PHpbqES1UVUQ0jW/r0zGJZSAq7EEyw9bbV+TLX7sVq9tK
         LjWO2376xDpxNyWNgnNsecQ8rroO4j0cJm0WA2w3xz6adgBfM/cAReG2HOqFE79TZMsC
         1dVXvDr4E6gOqJ33qjVpJKMVa2VG2wZJSmLCmcVD4j3ve1qjQDyAE9jyFdZRuESDfjF4
         IpWf3fnzQ1HCYCpbefmwqBG5D2odwE4/lJVaMebNHvCLhzW9g+iYzx3T2ZidLLFRfUJ3
         +GCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=icBe/mRBJL90b84KD9w53p860R+PnSIkYSsQ1G+ra8I=;
        fh=45dIX9qzksWR6O4ObbdofEnc+x3kVhuZPx9BXlo2ROw=;
        b=IfNiwc5Jn6CFsS98ZXSMRSXPBeMmTsfHHsDPffpMY9QqdA8uB2H/h4Km0x9P4UWoFB
         3IROpQgi0FU74nKWtrdVaaoJN9nOG6WXmelSgvwG9RN2Qc8vIzk9422xvilNL9NZQMvI
         iXppOMnGrGKmq+MECY2B322DEzaMeXAliFmOkKrhq3aNttLqnDiq/uRKLKSpcveLx61D
         Mkk8Po5aeUtDzjPnzeZ2o5H+W6MTTmzh9XKw1d6A4AZg/KQYIHTqASdgeRFJHSWf8DC6
         3T919tAwjDSH2FCPoq5fBrIBkWEXhWB+kqs8RTQLsHku6c5SP6gHyeMNLgJ+iPcBF8IV
         VRUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779376606; x=1779981406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icBe/mRBJL90b84KD9w53p860R+PnSIkYSsQ1G+ra8I=;
        b=JJcVC9WGeI4qzbnZa1MJ2O0B0GSFOTIzR5ZTUf9zkJc3wH38o3MtGqmFR5SV+k17bh
         F8EBWRN+nZaK6UXVGlBdlijTmis6xtW8FDniZ7zkEykEnMVDuDWcA+1t/vSX/xq5NUMq
         sUdzz1UqOji9+74MEqQn8wDKmOABJLIZ2lV0KhaRdyEZsJfNFMR3k+6nHUXOvHmoMKs7
         yQN/74+DGPYRRH0isnz8m/EFz8FQdbmVd8VfzI/kZ68KY+nE6nzHCD8qVbSbkExe/3Qd
         RWLAOJ9TR0dAlcK/UO7Yw3siMJhxIxjmNz3/4MwIi/B3ZZT4bM+wckqReSQflAiMTBgp
         E/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779376606; x=1779981406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=icBe/mRBJL90b84KD9w53p860R+PnSIkYSsQ1G+ra8I=;
        b=Etm9LTbZP0l2gigR8ZekuB2hzOhx1B4xLmtqpHH788+NqS4/O1SRCApUb1M9mhPA0B
         FTqfq928j0u7lwtSUeHHUrChAqa+2lFMTGMMwAAW1U/SD3FzE31X0gFJ6f8uZLXt3DLc
         MYxN62OtKBGBzi0tvT73Gtrg/rQ1sqBIUXfp3Yg+3Q3QUiES+MN8evzzmKkCb20mXEee
         4stcJN38SxZ+FuesJKw1OwxDeiDYvkEgDdoQlkzmhdiz6neov0G8kLHz0mY/aD8lIr2I
         vtGWHGXr7jAca8ugxYFrQztPHysno+xKnK8l1AY0aWNUYUVXpQbTG7XyH9wedUyA4LNn
         XAOg==
X-Forwarded-Encrypted: i=1; AFNElJ+2h9imE+XuSEETRSlDr+GtRNXPTn+D0gvwwSaFQ+Rn9tD2HT4yLEoEgAVeGilj73TilSbFeoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy46AL64kWfzwp7Jp0HREMmuDVyfau+he9vCOP6QlS2fl0VagSq
	6gpJNSl9LS4dEm+XlJ7rqM5mORPkzIA6s2EYVvjR6/qw9yqHCnxwixqxGqEOceTKk0FiKMWCtPP
	FieaNMdA520JU5ckJUNTuqTZAh+eqwwM/bS5+sQ94
X-Gm-Gg: Acq92OHP3+bigXqxpIMtaPoF6bpHhUEMijsfHPsjJogut6QMEExdh98f951w/+c7kAx
	IrxCxVSmKL7H2lJKCHHy4I2emXOGDEde7O17EdwPlqxz1l57EzaC13bZT9DJn56qKFKpBv/0eTF
	QX6SBlu218ao8WOaCDjHIhJUCdujfN4FhazGWNZW8ZWMEr2Jm7g1rlPdD5b2/fzYtBy/sKYbVrt
	JVDEdhMisI4jkrAzwBMY/eMGiI9bUlJHqS4bRRah4at7dEGHnG8nWFLf7HR3CuGBc/hg86tfJBw
	Xre/CdWaR+WbnrRLf4Q=
X-Received: by 2002:a05:6a00:4193:b0:829:8083:472b with SMTP id
 d2e1a72fcca58-8414b796061mr2737736b3a.4.1779376606383; Thu, 21 May 2026
 08:16:46 -0700 (PDT)
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
 <CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com> <20260521073526.793d30c3@kernel.org>
In-Reply-To: <20260521073526.793d30c3@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 21 May 2026 11:16:35 -0400
X-Gm-Features: AVHnY4I-VBQLJykZjVTvnzase5CZXKjTIbxVTlMEx3FuXa4FI9vYKbRQIGm3jfo
Message-ID: <CAM0EoMnvrAxGC=bty=ZUXG6XDN_hTNZiy9LSZhNicEdbe8DghQ@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-290526-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B820C5A988C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 10:35=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 21 May 2026 06:15:17 -0400 Jamal Hadi Salim wrote:
> > > This is the same claim as sashiko1 but sashiko2 gave a much more
> > > convincing description ;->
> > > skb_has_shared_frag() is only true if the frags are flagged as
> > > SKBFL_SHARED_FRAG (which is what the repro did); however, if we get
> > > frags from eg a driver on ingress and that skb gets cloned with frags
> > > we won't catch it.
> > > One approach is to do an if (skb_has_any_shared_frags(skb)) and then
> > > do a skb_linearize_cow() but that sounds like overkill.
> >
> > Yeah, this would be overkill - imagine running tcpdump 100% will be clo=
ned
> >
> > > Another which will make the patch even uglier (but less expensive) is
> > > to add an extra check insde the patch's "if (write_offset < 0)"
> > > to do:  if (write_offset + (int)sizeof(hdata) > 0) { skb_ensure_writa=
ble()}
> > >
> >
> > To be precise, something like attached (untested, uncompiled)
>
> Can we not pull the headers? Do you know of anyone modifying payloads
> with pedit?
>

not sure - but it is not unreasonable if someone used it for such a case.

> The concept of "shared frags" is silly IMHO, if I'm checking right only
> rxrpc and xfrm think that it's a thing. I'm hoping to delete that and
> reclaim the flag id in net-next...

All these issues stem from the shared frags point, but the patchlet i
showed is unrelated to SKBFL_SHARED_FRAG, it is more related to
cloned+frags.
If you remove it in net-next - does that necessitate removing all
"fixes" that tried to address that issue? It seems like that would be
sensible, but it makes me wonder why the shared frags concept exists
in the first place.

cheers,
jamal

