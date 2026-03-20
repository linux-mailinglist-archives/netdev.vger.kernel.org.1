Return-Path: <netdev+bounces-270075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOEAJnK8vWnyAwMAu9opvQ
	(envelope-from <netdev+bounces-270075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:30:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDDA2E166E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 22:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99D8930398BF
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 21:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3184D309DDB;
	Fri, 20 Mar 2026 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MeL+smRv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A229F199D8
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774042045; cv=pass; b=u4nr+wciyGNqxXmpcUwzHg9jYh9R2iS8tFuHun1F5w3H7BFKiijtOrurmj0cBfra7IlM0csJOGCI1IOxja4aKaGutRbd+G65sYKgnr4tM1h3tmfRYKxbCjXEH+gFdM1nzVEGsAUQZIizFwgM7ndgjAtnQOCVr6HjVh4Wxw9gaxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774042045; c=relaxed/simple;
	bh=YlnU79Hq9OwTdK3vTK96Bxt2NZXEdAi8/p58mZnRPwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJWibdOI2NFlDSZ4x40cfEP9/SGR7KAsJx2yygKbmUMTEcMiq7pFGDbytJXD0wgzFNW729rQWTwKbsmt77QYymDLo9QaH4Z4Ssimo3AI03aEFYHw4djZaUPzYKEfDBrIOAg+7e611rEZD5LDkBhh06bJdklYc43R8oxYPP/Wn5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MeL+smRv; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56a8fdaddebso407305e0c.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 14:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774042042; cv=none;
        d=google.com; s=arc-20240605;
        b=NU2aFlcSZGnLT4tlKnfEJzI911BGdx7rp22B9lovCTa0XH4eX6KmWiepPr/QOGEglA
         WH5L0t2k/F0qwYuFoh+EtclJ0nwxD73CeqQCHytsIfevLljpE9jzyr8W955y6rIMSmVq
         SAB/O/rMhBYUIWYEnqtWYgMl90asqLJyCR07gH/CrK6+4xjy8nmoa6/hZBpTEeMP03gA
         iT3vUPwf4hPvNK9cvwAsYOC3QsVyDSA+gm8hJXawEG0ZyaN2IJjARtRwRvSzScrKq+1B
         Cl8H05fheIKTQjYwSqcEq6M14exP5wIYvqdU7NynZTBJoHOs/ZWQZ7at+JJoZlouTm7S
         VxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gfjbuzHMZlM6OP0oO61ZlxLsLnXoNPK/lO7unH+P/CA=;
        fh=hH3zo00A9U/ftP0aQx4LywtbZtVVbYHGET7/XIpAfss=;
        b=h4s7T3ySukVxFlF8Py7k45YYm7fhUOr16DKlNGWDbziCEU2OXL1xKlZTs/GytavhHG
         zuZx39gNcn9lTizO/LjK5XkJwAsKu+1KN/9fhSa15NRnSHrNnLHb3sc5DZqchUpvqNQw
         GckcP+1LTmJzUyqWgSFrDNACSTHWfgZi1QnJb1waH7dGxGN1BMqRJcqIhV0Q7WWX0keP
         tOGIeflkId2wFj16JQZdSTTDuZTLydl0vu6Z8rdjY6Q7c846xvUY7WL1IQm0GHRZOleL
         LV2OLuK4H5YQeE3uSvE9woAETiRKCusZJz2OdRzs6PwVq9ESYjUs0golB6LGLEdPLkR0
         NDqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774042042; x=1774646842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfjbuzHMZlM6OP0oO61ZlxLsLnXoNPK/lO7unH+P/CA=;
        b=MeL+smRvNO+mNRBAixuf+xQoIxD/T+TDOjWoTDsVnNDiahYyTtS7DZySPbg6+2Te+i
         QlRFuNdCKwkiYhu1Gdz/8TX40EJxNaYNw0JZGcm8mWTLy0CXU8sZ3NxWC3UOxrXsB0VE
         RnDkhO6Ato00q4E+HK7h69g6hwy4vOevbiBmU2/kJ7T0JFk1lkxnfz4I1+RAfvI8SOb5
         4ePmwybVedoMqIOWULfYoudiyK1/3/gnPpEZcB7KH7pXrRY45kgFcsz/zykCKSPyjTwU
         6zCyo8ujH7GFPb6AUtW/69/55MU6pc8dpDRzJsCzu7hSofhAKJnNnFbbK0VPAVUa4seW
         6iXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774042042; x=1774646842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gfjbuzHMZlM6OP0oO61ZlxLsLnXoNPK/lO7unH+P/CA=;
        b=gLDjeYxC1f/pzvwP8K+yw/jTTFBAqTKyyxzr8539QzUA76RhZlZMlgcksTEkBFggW1
         E8Q3MaHknPFQRGjrHa7Iv1X3prLyK9+CPGjaR9bPgp55BfkLpdaCra0ugjBOn9Fj+3ow
         YEOx+FQ1W9l/ZsAZ8Az9ynih11/YcYvXicJOUIbMswmHYnRQv9Ang4auQWrD1w4MbFBw
         qBRrpXhjiZ90ENlkSKONN9LKINp5ebTEUtc+Ms9fkUzvtd5sCQCrca0/bBS4THMSwDXU
         ZInYyJCNDcuc/kbkyH9dL6RgQH5Ql9S2QHkVEWsM43OB2gJU3Oz4SRuwafHYasfi0NgU
         WICg==
X-Gm-Message-State: AOJu0Yyq0KsOgB3/E3hjaQQQqRHqMKVERR3HK15InQej48NI3SLmrzRY
	ZjaUphbBGHOaHeorg4/hL2CLWcZ4nWqGpqYIjygw85vAz+p55IUEnsfzPeCLyeVs4CI+BUIRLQX
	o0EnNwThgxsmjKpcWTn4WXN9lASef51l0gYAGuKWFUA==
X-Gm-Gg: ATEYQzyhwJw5+Ul9EZCskgpbpgg4KWKhp9bE8yrJKEbsivGMhi9sdQ+T28EW6vGXHjo
	gDFFe2Bc7/78u5kvD05LwBJc/NLcakfT9WQ/yHMG+O3/XJx1wIcGYdo6v5elJeDdXaTvSUKD5zq
	+cOpQ/iGWG7x9Fs1rXSXLa7gZxwUz92T8S9HST5zVihEZoMShAGaEnfJAXV/ShkgYZi/+7Agtjk
	khPP7DVq+DxYhAlaGNuUsIiw71Exmf0YQHuR8FjEdyQX31DG51ZWwpp3Jd5QUgeW2wJ5k8REe9D
	S/fcan/t
X-Received: by 2002:a05:6102:5125:b0:5ff:d192:ff2f with SMTP id
 ada2fe7eead31-602aed0dddemr1905062137.26.1774042042429; Fri, 20 Mar 2026
 14:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319213323.235559-1-rjethwani@purestorage.com>
 <20260319213323.235559-7-rjethwani@purestorage.com> <20260320194002.GI74886@horms.kernel.org>
In-Reply-To: <20260320194002.GI74886@horms.kernel.org>
From: Rishikesh Jethwani <rjethwani@purestorage.com>
Date: Fri, 20 Mar 2026 14:27:11 -0700
X-Gm-Features: AaiRm51exJFWB2Czeg8wIK1ixReMSPA005dvh4Ayv2VcZ8HQqmKcm3NBc7V3SEw
Message-ID: <CAKaoeS0tOCAFWjLHwDezYb9KLCEDrxaLxWUUXQXG+A9siHmN3w@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] selftests: net: add TLS hardware offload test
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270075-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0DDDA2E166E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Simon,

Good catch, I missed that. I will add tls_hw_offload to the gitignore
file in the next version.

Regards,
Rishi

On Fri, Mar 20, 2026 at 12:40=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Thu, Mar 19, 2026 at 03:33:23PM -0600, Rishikesh Jethwani wrote:
> > Two-node kTLS hardware offload test using NetDrvEpEnv. Tests TLS
> > 1.2/1.3 with AES-GCM-128/256, rekey operations, and various buffer
> > sizes.
> >
> > Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
> > ---
> >  .../testing/selftests/drivers/net/hw/Makefile |   2 +
> >  .../selftests/drivers/net/hw/tls_hw_offload.c | 902 ++++++++++++++++++
> >  .../drivers/net/hw/tls_hw_offload.py          | 281 ++++++
> >  3 files changed, 1185 insertions(+)
> >  create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offlo=
ad.c
> >  create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offlo=
ad.py
> >
> > diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/te=
sting/selftests/drivers/net/hw/Makefile
> > index a64140333a46..6b12b0920cae 100644
> > --- a/tools/testing/selftests/drivers/net/hw/Makefile
> > +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> > @@ -15,6 +15,7 @@ endif
> >
> >  TEST_GEN_FILES :=3D \
> >       $(COND_GEN_FILES) \
> > +     tls_hw_offload \
> >  # end of TEST_GEN_FILES
>
> Hi Rishikesh,
>
> I think you need to add tls_hw_offload to
> tools/testing/selftests/drivers/net/hw/.gitignore
>
> ...

